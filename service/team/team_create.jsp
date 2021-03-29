<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%@include file="/service_include.jsp" %>



<%
/*******************************************
* 팀 등록(create)
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement pstmt = null;
Statement pstmt2 = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//현재 날짜 구해서 팀번호 생성
Date nowdate = new Date();

//현재 날짜
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String now = sdf2.format(nowdate);

String team_no = ParamUtil.getString(request, "team_no", "");
String t_type = ParamUtil.getString(request, "t_type", "");
String t_name = ParamUtil.getString(request, "t_name", "");
String t_content = ParamUtil.getString(request, "t_content", "");
String t_genre = ParamUtil.getString(request, "t_genre", "");
String main_genre = ParamUtil.getString(request, "main_genre", "");
String text_genre = ParamUtil.getString(request, "text_genre", "");
String add_genre = ParamUtil.getString(request, "add_genre", "");
String t_area = ParamUtil.getString(request, "t_area", "");
String t_img = ParamUtil.getString(request, "t_img", "");
String t_pay = ParamUtil.getString(request, "t_pay", "");
String team_member = ParamUtil.getString(request, "team_member", "");
String team_ok = "2";

//소개 동영상 URL
String tv_content = ParamUtil.getString(request, "tv_content", "");
String tv_url = ParamUtil.getString(request, "tv_url", "");
String team_video = ParamUtil.getString(request, "team_video", "");

%>


<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		pstmt2 = conn.createStatement();
		
		
		
		sql = "INSERT INTO" + "\r\n" +  
				"TEAM(TEAM_NO, TEAM_TYPE, TEAM_NAME, TEAM_INTRO, CODE_GENRE, CODE_AREA, TINTRO_IMG, TEAM_OK, TEAM_PAY, TINTRO_VIDEO, TVIDEO_CONTENT, TEAM_REGDATE, MAIN_GENRE, GENRE_GUBUN, TEAM_VIDEO)" + "\r\n" + 
				"VALUES('{team_no}', '{t_type}', '{t_name}', '{t_content}', '{text_genre}', '{t_area}', '{t_img}', '{team_ok}', '{t_pay}', '{tv_url}', '{tv_content}', '{team_regdate}', '{main_genre}', '{t_genre}', '{t_video}')" + "\r\n";  

		sql = sql.replace("{team_no}", team_no);
		sql = sql.replace("{t_type}", t_type);
		sql = sql.replace("{t_name}", t_name);
		sql = sql.replace("{t_content}", t_content);
		sql = sql.replace("{t_genre}", t_genre);
		sql = sql.replace("{main_genre}", main_genre);
		sql = sql.replace("{text_genre}", text_genre);
		sql = sql.replace("{t_area}", t_area);
		sql = sql.replace("{t_img}", t_img);
		sql = sql.replace("{t_pay}", t_pay);
		sql = sql.replace("{team_ok}", team_ok);
		
		sql = sql.replace("{tv_url}", tv_url);
		sql = sql.replace("{tv_content}", tv_content);
		
		sql = sql.replace("{team_regdate}", now);
		sql = sql.replace("{t_video}", team_video);
		
		//System.out.println(sql);
		
		pstmt.executeUpdate(sql);
		
		sql2 = "SELECT USE_TOOL" + "\r\n" +
				"FROM ARTIST" + "\r\n" +
				"WHERE USER_NO = '" + USER_NO + "'\r\n";
		
		rs = pstmt2.executeQuery(sql2);
		
		if(rs.next()){
			String part = ConvertUtil.toStr(rs.getString("USE_TOOL"));

			sql = "INSERT INTO" + "\r\n" +
					"TEAM_MEMBER(USER_NO, TEAM_NO, LEADER_CHK, PART, MEMBER_REQ_STATUS)" + "\r\n" +
					"VALUES('{user_no}', '{team_no}', '1', '{part}', '2')";
			
			sql = sql.replace("{user_no}", USER_NO);
			sql = sql.replace("{team_no}", team_no);
			sql = sql.replace("{part}", part);
			
			pstmt.executeUpdate(sql);
		}
		
		if(!team_member.equals("")){
			String[] tm = team_member.split(",");
			
			for(int i = 0; i < tm.length; i++){
				sql2 = "SELECT USE_TOOL" + "\r\n" +
						"FROM ARTIST" + "\r\n" +
						"WHERE USER_NO = '" + tm[i] + "'\r\n";
				
				rs = pstmt2.executeQuery(sql2);
				
				if(rs.next()){
					String part = "";
					
					if(rs.getString("USE_TOOL") != null) part = ConvertUtil.toStr(rs.getString("USE_TOOL"));
					else part = "보컬";

					sql = "INSERT INTO" + "\r\n" +
							"TEAM_MEMBER(USER_NO, TEAM_NO, LEADER_CHK, PART, MEMBER_REQ_STATUS)" + "\r\n" +
							"VALUES('{user_no}', '{team_no}', '2', '{part}', '1')";
					
					sql = sql.replace("{user_no}", tm[i]);
					sql = sql.replace("{team_no}", team_no);
					sql = sql.replace("{part}", part);
					
					pstmt.executeUpdate(sql);
				}
			}
		}
		
		result = true;
		
		if(result == true){
			msg = "팀/솔로 등록이 완료되었습니다.";	
		}

	}catch(Exception e){
		result = false;
		msg = "팀 등록에 실패하였습니다. 잠시후 다시 시도해주세요.\n해당 현상이 지속되면 1:1문의에 문의 부탁드리겠습니다.";
		e.printStackTrace();
	}
%>
 	<ROOT>
		<DATA>
			<RESULT><%=String.valueOf(result)%></RESULT>
			<MESSAGE><%=msg%></MESSAGE>
		</DATA>
	</ROOT> 
<%
try {
	rs.close();
} catch (Exception ex) {}
try {
	pstmt.close();
	pstmt2.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>