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
String ptype = ParamUtil.getString(request, "ptype", "");
String ptitle = ParamUtil.getString(request, "ptitle", "");
String pcontent = ParamUtil.getString(request, "pcontent", "");

%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		if(ptype.equals("N")){
			//전체 푸시
			sql = "select fcm_token" + "\r\n" +
					"from user" + "\r\n" +
					"where fcm_token <> ''" + "\r\n";
		} else if(ptype.equals("A")){
			//아티스트 푸시
			sql = "select a.user_no, u.fcm_token" + "\r\n" +
					"from artist a" + "\r\n" +
					"join user u on a.user_no = u.user_no" + "\r\n" +
					"group by fcm_token" + "\r\n";
		} else if(ptype.equals("T")){
			//팀 푸시
			sql = "select t.user_no, u.fcm_token" + "\r\n" +
					"from team_member t" + "\r\n" +
					"join user u on t.user_no = u.user_no" + "\r\n" +
					"group by fcm_token" + "\r\n";
		} else {
			sql = "error";
		}
		
		if(sql.equals("error")){
			System.out.println("push send error");
		}
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
			
			FirebaseMessagingService.pushFCMNotification(fcm_token, 
					ptitle, pcontent, "danger", pcontent, true);
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