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
* 모집중인 공연 리스트(SELECT)
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
		
		sql = "select *" + "\r\n" +
				"from team" + "\r\n" +
				"order by team_video <> '' desc, regupdate desc" + "\r\n";
		
		//System.out.println(sql);
				
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<TINTRO_VIDEO><%=ConvertUtil.toStr(rs.getString("TINTRO_VIDEO"))%></TINTRO_VIDEO>
				<TEAM_VIDEO><%=ConvertUtil.toStr(rs.getString("TEAM_VIDEO"))%></TEAM_VIDEO>
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