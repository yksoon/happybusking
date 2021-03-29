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
* 사업주에게 - 계약서 서명 요청
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String perform_no = ParamUtil.getString(request, "perform_no", "");
String fcm_token = "";
%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT *" + "\r\n" +
                "FROM reg_buskingtime a" + "\r\n" +
                "JOIN user b ON a.USER_NO = b.USER_NO" + "\r\n" +
                "WHERE a.PERFORM_NO = '" + perform_no + "'";
				
		System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		String title = "[서명 요청]";
		
		String body = "";
		
		while(rs.next()){
			fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
			// tname = ConvertUtil.toStr(rs.getString("TEAM_NAME"));
			
			body = "아티스트의 서명이 모두 완료되었습니다. 서명을 완료해주시기 바랍니다.";

            System.out.println(body);
			
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