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
* QR_request list(SELECT)
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
		
		sql = "SELECT QR.*," + "\r\n" +
		"(SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_NO = QR.TEAM_NO) AS TEAM_NAME," + "\r\n" +
		"(SELECT U.NICKNAME FROM USER U WHERE U.USER_NO = QR.USER_NO) AS NICKNAME," + "\r\n" +
		"(SELECT A.PHONE FROM ARTIST A WHERE A.USER_NO = QR.USER_NO) AS PHONE" + "\r\n" +
		"FROM QR_REQUEST QR" + "\r\n" +
		"WHERE QR_PAYMENT_RESULT = 'Y'";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<QR_REQUEST_NO><%=ConvertUtil.toInteger(rs.getInt("QR_REQUEST_NO")) %></QR_REQUEST_NO>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
				<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO")) %></USER_NO>
				<POSTCODE><%=ConvertUtil.toInteger(rs.getInt("POSTCODE")) %></POSTCODE>
				<ADDR><%=ConvertUtil.toStr(rs.getString("ADDR"))%></ADDR>
				<DETAIL_ADDR><%=ConvertUtil.toStr(rs.getString("DETAIL_ADDR"))%></DETAIL_ADDR>
				<QR_REQUEST_COUNT><%=ConvertUtil.toInteger(rs.getString("QR_REQUEST_COUNT"))%></QR_REQUEST_COUNT>
				<QR_REQUEST_DATE><%=ConvertUtil.toStr(rs.getString("QR_REQUEST_DATE"))%></QR_REQUEST_DATE>
				<QR_REQUEST_STATE><%=ConvertUtil.toStr(rs.getString("QR_REQUEST_STATE"))%></QR_REQUEST_STATE>
				<QR_VIDEO_SHARE><%=ConvertUtil.toStr(rs.getString("QR_VIDEO_SHARE"))%></QR_VIDEO_SHARE>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME"))%></NICKNAME>
				<PHONE><%=ConvertUtil.toStr(rs.getString("PHONE"))%></PHONE>
				<QRTYPE><%=ConvertUtil.toStr(rs.getString("QRTYPE"))%></QRTYPE>
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