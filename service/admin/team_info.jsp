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
* team_info list(SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String team_no = ParamUtil.getString(request, "", "");



%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT TEAM.*" + "\r\n" +
				"FROM TEAM TEAM";
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<TID><%=ConvertUtil.toInteger(rs.getInt("TID"))%></TID>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<TEAM_INTRO><%=ConvertUtil.toStr(rs.getString("TEAM_INTRO"))%></TEAM_INTRO>
				<CODE_GENRE><%=ConvertUtil.toStr(rs.getString("CODE_GENRE"))%></CODE_GENRE>
				<CODE_AREA><%=ConvertUtil.toStr(rs.getString("CODE_AREA"))%></CODE_AREA>
				<TEAM_PAY><%=ConvertUtil.toStr(rs.getString("TEAM_PAY"))%></TEAM_PAY>
				<TINTRO_IMG><%=ConvertUtil.toStr(rs.getString("TINTRO_IMG"))%></TINTRO_IMG>
				<TINTRO_VIDEO><%=ConvertUtil.toStr(rs.getString("TINTRO_VIDEO"))%></TINTRO_VIDEO>
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