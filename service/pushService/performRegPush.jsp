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
* 공연일정 등록 푸시알림
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String team_no = ParamUtil.getString(request, "team_no", "");
String date = ParamUtil.getString(request, "date", "");

/* System.out.println("team_no : " + team_no);
System.out.println("date : " + date); */

String fcm_token = "";
String title = "";
String body = "";
int pf_no;
%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT I.USER_NO, U.FCM_TOKEN," + "\r\n" +
				"(SELECT TEAM_NAME FROM TEAM WHERE TEAM_NO = I.TEAM_NO) AS TEAM_NAME," + "\r\n" +
				"(SELECT PF_NO FROM PERFORM WHERE TEAM_NO = I.TEAM_NO AND PF_DATE = '" + date + "'\r\n" +
				"AND PF_CANCLE IN (0)) AS PF_NO" + "\r\n" +
				"FROM INTEREST I JOIN USER U" + "\r\n" +
				"ON I.USER_NO = U.USER_NO" + "\r\n" +
				"WHERE TEAM_NO = " + team_no + "\r\n"+
				"AND U.FCM_TOKEN <> ''" + "\r\n" +
				"AND ALARM_CHK IN (1)" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
			body = ConvertUtil.toStr(rs.getString("TEAM_NAME")) + "가 " + date + "에 공연을 시작합니다!";
			pf_no = ConvertUtil.toInteger(rs.getInt("PF_NO"));
			
			//System.out.println("fcm token : " + fcm_token);
			//System.out.println("message : " + body);
			
			FirebaseMessagingService.pushFCMNotification(fcm_token, 
					"[새로운 공연 알림]", body, "perform_reg", String.valueOf(pf_no), true);
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