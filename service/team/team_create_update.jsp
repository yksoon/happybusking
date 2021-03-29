<?xml version="1.0" encoding="utf-8"?>
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
* 팀신청 정보 수정
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
PreparedStatement pstmt = null;
Statement pstmt2 = null;
ResultSet rs = null;

boolean result = false;
String msg = "";
String team_no = ParamUtil.getString(request, "team_no", "");
String t_type = ParamUtil.getString(request, "t_type", "");
String t_name = ParamUtil.getString(request, "t_name", "");
String t_content = ParamUtil.getString(request, "t_content", "");
String t_genre = ParamUtil.getString(request, "t_genre", "");
String main_genre = ParamUtil.getString(request, "main_genre", "");
String text_genre = ParamUtil.getString(request, "text_genre", "");
String t_area = ParamUtil.getString(request, "t_area", "");
String t_img = ParamUtil.getString(request, "t_img", "0");
String t_pay = ParamUtil.getString(request, "t_pay", "0");
String team_member = ParamUtil.getString(request, "team_member", "");

//소개 동영상 URL
String tv_content = ParamUtil.getString(request, "tv_content", "");
String tv_url = ParamUtil.getString(request, "tv_url", "");
String team_video = ParamUtil.getString(request, "team_video", "");
%>


<%
	try{
		conn = dbconn.dbconnect();
		pstmt2 = conn.createStatement();
		
		/* System.out.println(team_no);
		System.out.println(t_type);
		System.out.println(t_name);
		System.out.println(t_content);
		System.out.println(t_genre);
		System.out.println(t_area);
		System.out.println(t_img);
		System.out.println(t_pay);
		System.out.println(team_member); */
		
		if(t_img.equals("") && team_video.equals("")){
			sql = "update team" + "\r\n" +
					"set team_type=?, team_name=?, team_intro=?, code_genre=?, code_area=?, "+
						"team_pay=?, main_genre=?, genre_gubun=?, tintro_video=?, tvideo_content=?" + "\r\n" +
					"where team_no=?";
			//System.out.println("이미지 동영상 둘다 업뎃 안함");
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, t_type);
			pstmt.setString(2, t_name);
			pstmt.setString(3, t_content);
			pstmt.setString(4, text_genre);
			pstmt.setString(5, t_area);
			pstmt.setString(6, t_pay);
			pstmt.setString(7, main_genre);
			pstmt.setString(8, t_genre);
			pstmt.setString(9, tv_url);
			pstmt.setString(10, tv_content);
			pstmt.setString(11, team_no);
		} else if(t_img.equals("")){
			sql = "update team" + "\r\n" +
					"set team_type=?, team_name=?, team_intro=?, code_genre=?, code_area=?, "+
						"team_pay=?, main_genre=?, genre_gubun=?, tintro_video=?, tvideo_content=?, team_video=?" + "\r\n" +
					"where team_no=?";
			//System.out.println("동영상만 업뎃 함");
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, t_type);
			pstmt.setString(2, t_name);
			pstmt.setString(3, t_content);
			pstmt.setString(4, text_genre);
			pstmt.setString(5, t_area);
			pstmt.setString(6, t_pay);
			pstmt.setString(7, main_genre);
			pstmt.setString(8, t_genre);
			pstmt.setString(9, tv_url);
			pstmt.setString(10, tv_content);
			pstmt.setString(11, team_video);
			pstmt.setString(12, team_no);
		} else if(team_video.equals("")){
			sql = "update team" + "\r\n" +
					"set team_type=?, team_name=?, team_intro=?, code_genre=?, code_area=?, "+
						"team_pay=?, main_genre=?, genre_gubun=?, tintro_video=?, tvideo_content=?, tintro_img=?" + "\r\n" +
					"where team_no=?";
			//System.out.println("이미지만 업뎃 함");
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, t_type);
			pstmt.setString(2, t_name);
			pstmt.setString(3, t_content);
			pstmt.setString(4, text_genre);
			pstmt.setString(5, t_area);
			pstmt.setString(6, t_pay);
			pstmt.setString(7, main_genre);
			pstmt.setString(8, t_genre);
			pstmt.setString(9, tv_url);
			pstmt.setString(10, tv_content);
			pstmt.setString(11, t_img);
			pstmt.setString(12, team_no);
		} else {
			sql = "update team" + "\r\n" +
					"set team_type=?, team_name=?, team_intro=?, code_genre=?, code_area=?, "+
						"team_pay=?, main_genre=?, genre_gubun=?, tintro_video=?, tvideo_content=?, tintro_img=?, team_video=?" + "\r\n" +
					"where team_no=?";
			//System.out.println("둘 다  업뎃 함");
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, t_type);
			pstmt.setString(2, t_name);
			pstmt.setString(3, t_content);
			pstmt.setString(4, text_genre);
			pstmt.setString(5, t_area);
			pstmt.setString(6, t_pay);
			pstmt.setString(7, main_genre);
			pstmt.setString(8, t_genre);
			pstmt.setString(9, tv_url);
			pstmt.setString(10, tv_content);
			pstmt.setString(11, t_img);
			pstmt.setString(12, team_video);
			pstmt.setString(13, team_no);
		}
		
		pstmt.executeUpdate();
		
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
				} else {
					System.out.println("error");
				}
			}
		}

		result = true;
		
		if(result == true){
			msg = "팀 수정이 완료되었습니다.";	
		}

	}catch(Exception e){
		result = false;
		msg = "팀 신청에 실패하였습니다. 잠시후 다시 시도해주세요.\n해당 현상이 지속되면 1:1문의에 문의 부탁드리겠습니다.";
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