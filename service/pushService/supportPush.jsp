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
* 후원하기 푸시(해당 팀 팀원들에게 보내주기)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String tid = ParamUtil.getString(request, "tid", "");

String fcm_token = "";
String title = "";
String body = "";
String team_name = "";
String support_name = "";
int price = 0;
%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT S.TEAM_NO, S.SUPPORT_NAME, S.SUPPORT_PRICE, TM.USER_NO, T.TEAM_NAME , U.FCM_TOKEN" + "\r\n" +
				"FROM SUPPORT S" + "\r\n" +
				"JOIN TEAM_MEMBER TM ON TM.TEAM_NO = S.TEAM_NO" + "\r\n" +
				"JOIN TEAM T ON T.TEAM_NO = S.TEAM_NO" + "\r\n" +
				"JOIN USER U ON U.USER_NO = TM.USER_NO" + "\r\n" +
				"WHERE S.SUPPORT_TID = '" + tid + "'";
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
			support_name = ConvertUtil.toStr(rs.getString("SUPPORT_NAME"));
			team_name = ConvertUtil.toStr(rs.getString("TEAM_NAME"));
			price = ConvertUtil.toInteger(rs.getInt("SUPPORT_PRICE"));
			body = support_name + "님이 " + team_name + "님에게 " + Integer.toString(price) + "원을 후원하셨습니다.";
			
			//System.out.println("fcm token : " + fcm_token);
			//System.out.println("message : " + body);
			
			FirebaseMessagingService.pushFCMNotification(fcm_token, 
					"[모바일 팁박스]", body, "support", "support", true);
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