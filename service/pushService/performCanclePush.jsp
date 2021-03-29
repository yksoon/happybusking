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
* 공연 취소 푸시알림
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String pf_no = ParamUtil.getString(request, "pf_no", "");

//System.out.println("pf_no : " + pf_no);

String fcm_token = "";
String title = "";
String body = "";
String date = "";
%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT P.TEAM_NO, P.PF_DATE, I.USER_NO, U.FCM_TOKEN, T.TEAM_NAME" + "\r\n" +
				"FROM PERFORM P" + "\r\n" +
				"JOIN INTEREST I" + "\r\n" +
				"ON I.TEAM_NO = P.TEAM_NO" + "\r\n" +
				"JOIN USER U" + "\r\n" +
				"ON U.USER_NO = I.USER_NO" + "\r\n" +
				"JOIN TEAM T" + "\r\n" +
				"ON T.TEAM_NO = P.TEAM_NO" + "\r\n" +
				"WHERE PF_NO = " + pf_no + "\r\n" +
				"AND U.FCM_TOKEN <> ''" + "\r\n" +
				"AND I.ALARM_CHK IN (1)";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
			date = ConvertUtil.toStr(rs.getString("PF_DATE"));
			body = ConvertUtil.toStr(rs.getString("TEAM_NAME")) + "의 " + date + " 공연이 취소되었습니다.";
			
			//System.out.println("fcm token : " + fcm_token);
			//System.out.println("message : " + body);
			
			FirebaseMessagingService.pushFCMNotification(fcm_token, 
					"[공연 취소 알림]", body, "perform_cancle", String.valueOf(pf_no), true);
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