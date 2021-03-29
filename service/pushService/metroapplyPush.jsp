<?xml version="1.0" encoding="utf-8"?>
<%@page import="com.mysql.fabric.xmlrpc.base.Param"%>
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
* 메트로 신청자한테 푸시
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String fcm_token = "";

%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		 sql = "select fa.kteamno, tm.user_no, u.fcm_token" + "\r\n" +
				"from festival_apply fa" + "\r\n" +
				"join team_member tm on tm.team_no = fa.kteamno" + "\r\n" +
				"left join user u on u.user_no = tm.user_no" + "\r\n" +
				"where fa.kgubun like '%메트로%'" + "\r\n" +
				"and fa.kteamno != '0'" + "\r\n"; 
				
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		
		String title = "[메트로 아티스트 공지 예정 안내]";
		String body = "06월 05일(금) 17시이후 서울교통공사 홈페이지 또는 공식SNS를 통해 제12기 메트로 아티스트 선발 결과 공지 예정입니다.";
		
		while(rs.next()){
			fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
			
			FirebaseMessagingService.pushFCMNotification(fcm_token, 
					title, body, "danger", body, true);
		}
%>
<%
	}catch(Exception e){
		e.getStackTrace();
	}
%>
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