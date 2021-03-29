<?xml version="1.0" encoding="utf-8"?>
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

<%@include file="/service_include.jsp" %>



<%
/*******************************************
* qr코드 신청현황 리스트
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String tid = ParamUtil.getString(request, "tid", "0");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT *" + "\r\n" + 
				"FROM QR_REQUEST" + "\r\n" +
				"WHERE QR_PAYMENT_TID = '"+tid+"'" + "\r\n";

		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			%>
				<DATA>
					<QR_REQUEST_NO><%=ConvertUtil.toInteger(rs.getInt("QR_REQUEST_NO"))%></QR_REQUEST_NO>
					<QR_PAYMENT_PRICE><%=ConvertUtil.toInteger(rs.getInt("QR_PAYMENT_PRICE"))%></QR_PAYMENT_PRICE>
					<QR_PAYMENT_METHOD><%=ConvertUtil.toStr(rs.getString("QR_PAYMENT_METHOD"))%></QR_PAYMENT_METHOD>
					<QR_PAYMENT_TID><%=ConvertUtil.toStr(rs.getString("QR_PAYMENT_TID"))%></QR_PAYMENT_TID>
				</DATA>	
	<% 	
		}
			
		
	%>
	</ROOT>	
	<%
	}catch(Exception e){
		e.printStackTrace();
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