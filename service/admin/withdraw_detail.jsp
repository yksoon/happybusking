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

String wdno = ParamUtil.getString(request, "wdno", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT WITHDRAW_PRICE, PAYMENTS_OK, PAYMENTS_REFUSE_REASON" + "\r\n" +
				"FROM WITHDRAW" + "\r\n" +
				"WHERE WITHDRAW_NO = " + wdno;

		
		//System.out.println(sql);
		
				
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<WITHDRAW_PRICE><%=ConvertUtil.toStr(rs.getString("WITHDRAW_PRICE"))%></WITHDRAW_PRICE>
				<PAYMENTS_OK><%=ConvertUtil.toStr(rs.getString("PAYMENTS_OK"))%></PAYMENTS_OK>
				<PAYMENTS_REFUSE_REASON><%=ConvertUtil.toStr(rs.getString("PAYMENTS_REFUSE_REASON"))%></PAYMENTS_REFUSE_REASON>
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