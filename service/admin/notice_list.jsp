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
* 공지사항 목록 ADMIN(SELECT)
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
		
		sql = "SELECT N.*," + "\r\n" +
				"(SELECT U.NICKNAME FROM USER U WHERE U.USER_NO = N.USER_NO) AS NICKNAME" + "\r\n" +
				"FROM NOTICE N" + "\r\n";
		 
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<NT_NO><%=ConvertUtil.toStr(rs.getString("NT_NO")) %></NT_NO>
				<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME")) %></NICKNAME>
				<NT_TYPE><%=ConvertUtil.toStr(rs.getString("NT_TYPE")) %></NT_TYPE>
				<NT_TITLE><%=ConvertUtil.toStr(rs.getString("NT_TITLE"))%></NT_TITLE>
				<NT_CONTENT><%=ConvertUtil.toStr(rs.getString("NT_CONTENT"))%></NT_CONTENT>
				<NT_IMG><%=ConvertUtil.toStr(rs.getString("NT_IMG"))%></NT_IMG>
				<NT_REGDATE><%=ConvertUtil.toStr(rs.getString("NT_REGDATE"))%></NT_REGDATE>
				<NT_DEL><%=ConvertUtil.toStr(rs.getString("NT_DEL"))%></NT_DEL>
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