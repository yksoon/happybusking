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

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT W.*," + "\r\n" +
				"(SELECT TEAM_NAME FROM TEAM T WHERE T.TEAM_NO = W.TEAM_NO) AS TEAM_NAME," + "\r\n" + 
				"(SELECT TEAM_ACC_HOLDER FROM TEAM T2 WHERE T2.TEAM_NO = W.TEAM_NO) AS TEAM_ACC_HOLDER" + "\r\n" +
				"FROM WITHDRAW W" + "\r\n";

		
		//System.out.println(sql);
		
		
				
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<WITHDRAW_NO><%=ConvertUtil.toInteger(rs.getInt("WITHDRAW_NO")) %></WITHDRAW_NO>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
				<WITHDRAW_PRICE><%=ConvertUtil.toStr(rs.getString("WITHDRAW_PRICE"))%></WITHDRAW_PRICE>
				<WITHDRAW_REAL_PRICE><%=ConvertUtil.toStr(rs.getString("WITHDRAW_REAL_PRICE"))%></WITHDRAW_REAL_PRICE>
				<WITHDRAW_DATE><%=ConvertUtil.toStr(rs.getString("WITHDRAW_DATE"))%></WITHDRAW_DATE>
				<WITHDRAW_BANK><%=ConvertUtil.toStr(rs.getString("WITHDRAW_BANK"))%></WITHDRAW_BANK>
				<WITHDRAW_ACCOUNT><%=ConvertUtil.toStr(rs.getString("WITHDRAW_ACCOUNT"))%></WITHDRAW_ACCOUNT>
				<PAYMENTS_DATE><%=ConvertUtil.toStr(rs.getString("PAYMENTS_DATE"))%></PAYMENTS_DATE>
				<PAYMENTS_OK><%=ConvertUtil.toStr(rs.getString("PAYMENTS_OK"))%></PAYMENTS_OK>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<TEAM_ACC_HOLDER><%=ConvertUtil.toStr(rs.getString("TEAM_ACC_HOLDER"))%></TEAM_ACC_HOLDER>
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