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
* 공연 신청 목록 (SELECT)
*******************************************/
String sql = "";

String user_no = USER_NO;

if(USER_NO == null || USER_NO.equals("")) user_no = "0";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select tm.team_no , ap.*," + "\r\n" +
				"(select team_name from team t where t.team_no = tm.team_no) as team_name," + "\r\n" +
				"(select name from perform_place pp where pp.no = ap.pno limit 1) as pname" + "\r\n" +
				"from team_member tm" + "\r\n" +
				"join schedule_application ap on ap.tno = tm.team_no" + "\r\n" +
				"where tm.user_no = '"+USER_NO+"'" + "\r\n" +
				"order by date, ap.stime" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		
		while(rs.next()){
			%>
			<DATA>
				<NO><%=ConvertUtil.toStr(rs.getString("no")) %></NO>
				<DATE><%=ConvertUtil.toStr(rs.getString("date")) %></DATE>
				<STIME><%=ConvertUtil.toStr(rs.getString("stime")) %></STIME>
				<ETIME><%=ConvertUtil.toStr(rs.getString("etime")) %></ETIME>
				<TEAMNAME><%=ConvertUtil.toStr(rs.getString("team_name")) %></TEAMNAME>
				<PNAME><%=ConvertUtil.toStr(rs.getString("pname")) %></PNAME>
				<CANCEL><%=ConvertUtil.toStr(rs.getString("cancel")) %></CANCEL>
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