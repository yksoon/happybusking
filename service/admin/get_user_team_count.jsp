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
* 아티스트 정보 리스트(SELECT)
*******************************************/
String sql = "";
String sqlConcat = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select count(*) as ucount," + "\r\n" +
				"(select count(*) from team where team_name <> '해피버스킹') as tcount," + "\r\n" +
				"(select count(*) from artist) as acount" + "\r\n" +
				"from user" + "\r\n";
				
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<UCOUNT><%=ConvertUtil.toInteger(rs.getInt("UCOUNT")) %></UCOUNT>
				<TCOUNT><%=ConvertUtil.toInteger(rs.getInt("TCOUNT")) %></TCOUNT>
				<ACOUNT><%=ConvertUtil.toInteger(rs.getInt("ACOUNT")) %></ACOUNT>
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