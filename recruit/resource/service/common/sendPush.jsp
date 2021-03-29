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
* 선택한 아티스트한테 통보 푸시
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
PreparedStatement pstmt2 = null;

ResultSet rs = null;

String no = ParamUtil.getString(request, "no", "");
String body = ParamUtil.getString(request, "body", "");
String fcm_token = "";

%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select fa.kteamno, tm.user_no, u.fcm_token" + "\r\n" +
				"from festival_apply fa" + "\r\n" +
				"left join team_member tm on tm.team_no = fa.kteamno and member_req_status = '2'" + "\r\n" +
				"left join user u on u.user_no = tm.user_no" + "\r\n" +
				"where fa.kid = '"+no+"'" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		String title = "[공연모집 선발 결과 안내]";
		
		while(rs.next()){
			fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
			
			FirebaseMessagingService.pushFCMNotification(fcm_token, 
					title, body, "danger", body, true);
		}
		
		
		sql = "update festival_apply" + "\r\n" +
				"set pass = 'Y'" + "\r\n" +
				"where kid = ?" + "\r\n";
		
		pstmt2 = conn.prepareStatement(sql);
		pstmt2.setString(1, no);
		
		pstmt2.executeUpdate();
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
	pstmt2.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>