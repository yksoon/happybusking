<?xml version="1.0" encoding="utf-8"?>
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

<%@include file="/service_include.jsp" %>

<%
/*******************************************
* 버스킹 행사 일정 리스트
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String pbiNo = ParamUtil.getString(request, "pbiNo", "");
//System.out.println(pbiNo);
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT *" + "\r\n" +
				"FROM PUBLIC_BUSKING_INFO" + "\r\n" +
				"WHERE PBI_NO = " + pbiNo;
		
		rs = pstmt.executeQuery(sql);
		
		//System.out.println(sql);
		
		if(rs.next()){
		%>
			<DATA>
				<PBI_NO><%=ConvertUtil.toStr(rs.getString("PBI_NO")) %></PBI_NO>
				<PBI_USER_NO><%=ConvertUtil.toStr(rs.getString("PBI_USER_NO")) %></PBI_USER_NO>
				<PBI_MAIN_IMG><%=ConvertUtil.toStr(rs.getString("PBI_MAIN_IMG")) %></PBI_MAIN_IMG>
				<PBI_TITLE><%=ConvertUtil.toStr(rs.getString("PBI_TITLE")) %></PBI_TITLE>
				<PBI_EVENT_SDATE><%=ConvertUtil.toStr(rs.getString("PBI_EVENT_SDATE")) %></PBI_EVENT_SDATE>
				<PBI_EVENT_EDATE><%=ConvertUtil.toStr(rs.getString("PBI_EVENT_EDATE")) %></PBI_EVENT_EDATE>
				<PBI_EVENT_STIME><%=ConvertUtil.toStr(rs.getString("PBI_EVENT_STIME")) %></PBI_EVENT_STIME>
				<PBI_EVENT_ETIME><%=ConvertUtil.toStr(rs.getString("PBI_EVENT_ETIME")) %></PBI_EVENT_ETIME>
				<PBI_RECEIPT_SDATE><%=ConvertUtil.toStr(rs.getString("PBI_RECEIPT_SDATE")) %></PBI_RECEIPT_SDATE>
				<PBI_RECEIPT_EDATE><%=ConvertUtil.toStr(rs.getString("PBI_RECEIPT_EDATE")) %></PBI_RECEIPT_EDATE>
				<PBI_ADDRESS><%=ConvertUtil.toStr(rs.getString("PBI_ADDRESS")) %></PBI_ADDRESS>
				<PBI_DETAILADDRESS><%=ConvertUtil.toStr(rs.getString("PBI_DETAILADDRESS")) %></PBI_DETAILADDRESS>
				<PBI_GENRE><%=ConvertUtil.toStr(rs.getString("PBI_GENRE")) %></PBI_GENRE>
				<PBI_GENRE_CODE><%=ConvertUtil.toStr(rs.getString("PBI_GENRE_CODE")) %></PBI_GENRE_CODE>
				<PBI_CONTENT><%=ConvertUtil.toStr(rs.getString("PBI_CONTENT")) %></PBI_CONTENT>
				<PBI_LATLNG><%=ConvertUtil.toStr(rs.getString("PBI_LATLNG")) %></PBI_LATLNG>
				<PBI_PAY><%=ConvertUtil.toStr(rs.getString("PBI_PAY")) %></PBI_PAY>
				<PBI_PAY_MAX><%=ConvertUtil.toStr(rs.getString("PBI_PAY_MAX")) %></PBI_PAY_MAX>
				<PBI_PERSONNEL><%=ConvertUtil.toStr(rs.getString("PBI_PERSONNEL")) %></PBI_PERSONNEL>
				<PBI_PERSONNEL_MIN><%=ConvertUtil.toStr(rs.getString("PBI_PERSONNEL_MIN")) %></PBI_PERSONNEL_MIN>
				<PBI_SITE><%=ConvertUtil.toStr(rs.getString("PBI_SITE")) %></PBI_SITE>
				<PBI_MANAGER><%=ConvertUtil.toStr(rs.getString("PBI_MANAGER")) %></PBI_MANAGER>
				<PBI_TEL><%=ConvertUtil.toStr(rs.getString("PBI_TEL")) %></PBI_TEL>
				<PBI_EMAIL><%=ConvertUtil.toStr(rs.getString("PBI_EMAIL")) %></PBI_EMAIL>
				<PBI_FILE><%=ConvertUtil.toStr(rs.getString("PBI_FILE")) %></PBI_FILE>
				<PBI_NO_PAY><%=ConvertUtil.toStr(rs.getString("PBI_NO_PAY")) %></PBI_NO_PAY>
				<PBI_TRANSPORTATION><%=ConvertUtil.toStr(rs.getString("PBI_TRANSPORTATION")) %></PBI_TRANSPORTATION>
				<PBI_PLACE_IMG><%=ConvertUtil.toStr(rs.getString("PBI_PLACE_IMG")) %></PBI_PLACE_IMG>
				<PBI_PRODUCT_IMG><%=ConvertUtil.toStr(rs.getString("PBI_PRODUCT_IMG")) %></PBI_PRODUCT_IMG>
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