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

String fcm_token = ParamUtil.getString(request, "fcm_token", "");
%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		String body = "제12기 메트로 아티스트로 선정되셨습니다.\n해피버스킹과 함께 지하철 예술무대에서 즐거운 공연활동 하시기 바라며, 메트로 아티스트 인증식 및 워크숍 일정이 준비되는데로 개별적으로 안내 드리겠습니다.	다시한번 제12기 메트로 아티스트로 선정되신것을 축하드립니다. 감사합니다";
		
		/* System.out.println("fcm token : " + fcm_token);
		System.out.println("message : " + body); */
		
		FirebaseMessagingService.pushFCMNotification(fcm_token, 
				"[제12기 메트로 아티스트로 선정안내]", body, "danger", body, true);
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