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
* USER_info list(SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String user_no = ParamUtil.getString(request, "", "");



%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT USER.*" + "\r\n" +
				"FROM USER USER";
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO")) %></USER_NO>
				<USER_ID><%=ConvertUtil.toStr(rs.getString("USER_ID"))%></USER_ID>
				<USER_PW><%=ConvertUtil.toStr(rs.getString("USER_PW"))%></USER_PW>
				<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME"))%></NICKNAME>
				<USER_ACTIVE><%=ConvertUtil.toStr(rs.getString("USER_ACTIVE"))%></USER_ACTIVE>
				<ARTIST_CHK><%=ConvertUtil.toStr(rs.getString("ARTIST_CHK"))%></ARTIST_CHK>
				<BIRTH><%=ConvertUtil.toStr(rs.getString("BIRTH"))%></BIRTH>
				<GENDER><%=ConvertUtil.toStr(rs.getString("GENDER"))%></GENDER>
				<FCM_TOKEN><%=ConvertUtil.toStr(rs.getString("FCM_TOKEN"))%></FCM_TOKEN>
				<TOKEN><%=ConvertUtil.toStr(rs.getString("TOKEN"))%></TOKEN>
				<UUID><%=ConvertUtil.toStr(rs.getString("UUID"))%></UUID>
				<LOGIN_CHK><%=ConvertUtil.toStr(rs.getString("LOGIN_CHK"))%></LOGIN_CHK>
				<BUSKER_OATH><%=ConvertUtil.toStr(rs.getString("BUSKER_OATH"))%></BUSKER_OATH>
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