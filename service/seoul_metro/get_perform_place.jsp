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
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select no, name" + "\r\n" +
				"from perform_place" + "\r\n" +
				"where operation = 'Y'" + "\r\n" +
				"group by name" + "\r\n" +
				"order by uid" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		
		while(rs.next()){
			%>
			<DATA>
				<NO><%=ConvertUtil.toStr(rs.getString("no")) %></NO>
				<NAME><%=ConvertUtil.toStr(rs.getString("name")) %></NAME>
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