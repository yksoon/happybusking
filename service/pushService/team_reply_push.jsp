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
* 팀 댓글 푸시알림
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String team_no = ParamUtil.getString(request, "team_no", "");
String no = ParamUtil.getString(request, "no", "");
String fcm_token = "";

%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select tm.*, u.fcm_token, t.team_name" + "\r\n" +
				"from team_member tm" + "\r\n" +
				"left join team_reply tr on tr.team_no = tm.team_no and tr.no = '"+no+"'" + "\r\n"+
				"join user u on u.user_no = tm.user_no" + "\r\n" +
				"join team t on t.team_no = tm.team_no" + "\r\n" +
				"where tm.team_no = '"+team_no+"'" + "\r\n" +
				"and tm.member_req_status = '2'" + "\r\n";
				
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		String tname = "";
		
		String title = "[댓글 알림]";
		
		String body = "";
		
		while(rs.next()){
			fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
			tname = ConvertUtil.toStr(rs.getString("TEAM_NAME"));
			
			body = "회원님이 속한 ["+tname+"]팀에 댓글이 등록되었습니다.";
			
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