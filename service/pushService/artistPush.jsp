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
* 아티스트 등록한 사람한테 푸시
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
		
		sql = "SELECT A.USER_NO, U.FCM_TOKEN" + "\r\n" +
				"FROM ARTIST A" + "\r\n" +
				"JOIN USER U ON A.USER_NO = U.USER_NO" + "\r\n" +
				"GROUP BY FCM_TOKEN";
		
		rs = pstmt.executeQuery(sql);
		
		String title = "[버스킹 공연팀 모집안내]";
		String body = "행사명: KOICA WeKO AWARD\n	일시: 12월23일(월요일)\n장소 : KOICA 본사 강당(성남)\n장르 : 밝고 신나는 노래 / 댄스\n공연비 : 최소 20만 ~ 최대 40만 지급\n	자세한 사항은 앱 공지사항 참조.";
		
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