<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@page import="java.awt.Image"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="src.util.ImageSizeChange"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%@include file="/service_include.jsp" %>



<%
/*******************************************
* 공연 일정 등록(insert)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String team_no = ParamUtil.getString(request, "team_no", "");
String perform_img = ParamUtil.getString(request, "perform_img", "");
String perform_name = ParamUtil.getString(request, "perform_name", "");
String perform_intro = ParamUtil.getString(request, "perform_intro", "");
String perform_sDate = ParamUtil.getString(request, "perform_sDate", "");
String perform_eDate = ParamUtil.getString(request, "perform_eDate", "");
String perform_sTime = ParamUtil.getString(request, "perform_sTime", "");
String perform_eTime = ParamUtil.getString(request, "perform_eTime", "");
String perform_genre = ParamUtil.getString(request, "perform_genre", "");
String main_genre = ParamUtil.getString(request, "main_genre", "");
String text_genre = ParamUtil.getString(request, "text_genre", "");
String perform_area = ParamUtil.getString(request, "perform_area", "");
String perform_addr = ParamUtil.getString(request, "perform_addr", "");
String perform_place_type = ParamUtil.getString(request, "perform_place_type", "");
String perform_place = ParamUtil.getString(request, "perform_place", "");
String perform_traffic = ParamUtil.getString(request, "perform_traffic", "");
String perform_geocode = ParamUtil.getString(request, "perform_geocode", "");

//현재 날짜 구해서 팀번호 생성
SimpleDateFormat tnoSdf = new SimpleDateFormat("yyMMddkkmmss");
Date nowdate = new Date();

//랜덤함수
int randNum = ((int)(Math.random()*9998)+1);
String pf_no = tnoSdf.format(nowdate) + String.format("%04d", randNum);

//현재 날짜
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String now = sdf2.format(nowdate);
%>


<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		//업로드
		
		String start_date = perform_sDate + " " + perform_sTime;
		String end_date = perform_eDate + " " + perform_eTime;
		
		String sql0 = "SELECT COUNT(*) AS CNT FROM PERFORM" + "\r\n" + 
				"WHERE TEAM_NO = " + team_no + "\r\n" + 
				  "AND DATE_FORMAT('"+ start_date + "', '%Y-%m-%d %H:%i') < DATE_FORMAT(CONCAT(PF_EDATE, ' ' , PF_ETIME), '%Y-%m-%d %H:%i')" + "\r\n" + 
				  "AND DATE_FORMAT('"+ end_date + "', '%Y-%m-%d %H:%i') > DATE_FORMAT(CONCAT(PF_DATE, ' ' , PF_TIME), '%Y-%m-%d %H:%i')" + "\r\n" +
				  "AND PF_CANCLE = 0";
				   
	    rs = pstmt.executeQuery(sql0);
	    
	    if(rs.next()){
	    	int count = rs.getInt("CNT");
	    	
	    	if(count == 0){
	    		sql = "INSERT INTO " + "\r\n" +
	    				"PERFORM(PF_NO, TEAM_NO, PF_IMG, PF_INTRO, PF_DATE, PF_TIME, PF_EDATE, PF_ETIME, CODE_GENRE, CODE_AREA, PF_PLACE, PF_ADDR, PF_PLACE_TYPE, PF_DETAIL_CONTENT, PF_TRAFFIC, PF_LATLNG, MAIN_GENRE, GENRE_GUBUN) " + "\r\n" +
	    				"VALUES({pf_no},{team_no}, '{perform_img}', '{perform_name}', '{perform_date}', '{perform_time}', '{perform_eDate}', '{perform_eTime}', '{text_genre}', '{perform_area}', '{perform_place}', '{perform_addr}', '{perform_place_type}', '{perform_intro}', '{perform_traffic}', '{perform_geocode}', '{main_genre}', '{perform_genre}')";

	    		sql = sql.replace("{pf_no}", pf_no);
	    		sql = sql.replace("{team_no}", String.valueOf(team_no));
	    		sql = sql.replace("{perform_img}", perform_img);
	    		sql = sql.replace("{perform_name}", perform_name);
	    		sql = sql.replace("{perform_date}", perform_sDate);
	    		sql = sql.replace("{perform_time}", perform_sTime);
	    		sql = sql.replace("{perform_eDate}", perform_eDate);
	    		sql = sql.replace("{perform_eTime}", perform_eTime);
	    		sql = sql.replace("{perform_genre}", perform_genre);
	    		sql = sql.replace("{perform_area}", perform_area);
	    		sql = sql.replace("{perform_addr}", perform_addr);
	    		sql = sql.replace("{perform_place_type}", perform_place_type);
	    		sql = sql.replace("{perform_place}", perform_place);
	    		sql = sql.replace("{perform_intro}", perform_intro);
	    		sql = sql.replace("{perform_traffic}", perform_traffic);
	    		sql = sql.replace("{perform_geocode}", perform_geocode);
	    		sql = sql.replace("{main_genre}", main_genre);
	    		sql = sql.replace("{text_genre}", text_genre);
	      			
	    		pstmt.executeUpdate(sql);
	    		
	    		msg = "공연 일정 등록에 성공하였습니다.";
	    		result = true;
	    	}
	    	else{
	    		msg = "이미 등록된 공연과 중복되는 날짜입니다. 날짜를 바꿔주세요.";
	    		result = false;
	    	}
	    }

	}catch(Exception e){
		result = false;
		msg = "공연 일정 등록에 실패하였습니다.";
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
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>