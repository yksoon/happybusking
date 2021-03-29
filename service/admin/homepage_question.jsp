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
* HQ_QUESTION LIST(SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String hq_no = ParamUtil.getString(request, "", "");



%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT HQ.*" + "\r\n" +
		"FROM HOMEPAGE_QUESTION HQ";
		 
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<HQ_NO><%=ConvertUtil.toInteger(rs.getInt("HQ_NO")) %></HQ_NO>
				<HQ_STATE><%=ConvertUtil.toStr(rs.getString("HQ_STATE")) %></HQ_STATE>
				<HQ_TITLE><%=ConvertUtil.toStr(rs.getString("HQ_TITLE"))%></HQ_TITLE>
				<HQ_CONTENT><%=ConvertUtil.toStr(rs.getString("HQ_CONTENT"))%></HQ_CONTENT>
				<HQ_REQUEST><%=ConvertUtil.toStr(rs.getString("HQ_REQUEST"))%></HQ_REQUEST>
				<HQ_REGIDATE><%=ConvertUtil.toStr(rs.getString("HQ_REGIDATE"))%></HQ_REGIDATE>
				<HQ_REQUESTDATE><%=ConvertUtil.toStr(rs.getString("HQ_REQUESTDATE"))%></HQ_REQUESTDATE>
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