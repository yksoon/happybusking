<?xml version="1.0" encoding="utf-8"?>
<%@page import="com.sun.mail.handlers.multipart_mixed"%>
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

<%@ page import="src.util.*"%>

<%@include file="/service_include.jsp" %>

<%
/*******************************************
* 공연 일정 신청 장소 (SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String user_no = USER_NO;

if(USER_NO == null || USER_NO.equals("null") || USER_NO.equals("")) user_no = "6";
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select tm.team_no, t.team_name" + "\r\n" +
				"from team_member tm" + "\r\n" +
				"join team t on t.TEAM_NO = tm.team_no and t.belong like '%서울메트로%'" + "\r\n" +
				"where tm.user_no = '" + user_no +"'\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		
		while(rs.next()){
			%>
			<DATA>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("team_no")) %></TEAM_NO>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("team_name")) %></TEAM_NAME>
			</DATA>
			<%
		}
		
%>
</ROOT>
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