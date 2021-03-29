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
* 버스킹 행사 일정 상세
*******************************************/
String sql = "";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;


String no = ParamUtil.getString(request, "no", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		
		sql = "select *" + "\r\n" +
				"from public_busking_info" + "\r\n" +
				"where pbi_no = ?" + "\r\n" ;
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, no);
		
		//System.out.println(no);
		//System.out.println(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
		%>
			<DATA>
				<PBI_NO><%=ConvertUtil.toStr(rs.getString("PBI_NO")) %></PBI_NO>
				<PBI_USER_NO><%=ConvertUtil.toStr(rs.getString("PBI_USER_NO")) %></PBI_USER_NO>
				<PBI_THUMNAIL_IMG><%=ConvertUtil.toStr(rs.getString("PBI_THUMNAIL_IMG")) %></PBI_THUMNAIL_IMG>
				<PBI_MAIN_IMG><%=ConvertUtil.toStr(rs.getString("PBI_MAIN_IMG")) %></PBI_MAIN_IMG>
				<PBI_TITLE><%=ConvertUtil.toStr(rs.getString("PBI_TITLE")) %></PBI_TITLE>
				<PBI_EVENT_SDATE><%=ConvertUtil.toStr(rs.getString("PBI_EVENT_SDATE")) %></PBI_EVENT_SDATE>
				<PBI_EVENT_EDATE><%=ConvertUtil.toStr(rs.getString("PBI_EVENT_EDATE")) %></PBI_EVENT_EDATE>
				<PBI_RECEIPT_SDATE><%=ConvertUtil.toStr(rs.getString("PBI_RECEIPT_SDATE")) %></PBI_RECEIPT_SDATE>
				<PBI_RECEIPT_EDATE><%=ConvertUtil.toStr(rs.getString("PBI_RECEIPT_EDATE")) %></PBI_RECEIPT_EDATE>
				<PBI_ADDRESS><%=ConvertUtil.toStr(rs.getString("PBI_ADDRESS")) %></PBI_ADDRESS>
				<PBI_DETAILADDRESS><%=ConvertUtil.toStr(rs.getString("PBI_DETAILADDRESS")) %></PBI_DETAILADDRESS>
				<PBI_GENRE><%=ConvertUtil.toStr(rs.getString("PBI_GENRE")) %></PBI_GENRE>
				<PBI_GENRE_CODE><%=ConvertUtil.toStr(rs.getString("PBI_GENRE_CODE")) %></PBI_GENRE_CODE>
				<PBI_PERSONNEL><%=ConvertUtil.toStr(rs.getString("PBI_PERSONNEL")) %></PBI_PERSONNEL>
				<PBI_PERSONNEL_MIN><%=ConvertUtil.toStr(rs.getString("PBI_PERSONNEL_MIN")) %></PBI_PERSONNEL_MIN>
				<PBI_REGDATE><%=ConvertUtil.toStr(rs.getString("PBI_REGDATE")) %></PBI_REGDATE>
				<PBI_NO_PAY><%=ConvertUtil.toInteger(rs.getInt("PBI_NO_PAY")) %></PBI_NO_PAY>
				<PBI_TRANSPORTATION><%=ConvertUtil.toInteger(rs.getInt("PBI_TRANSPORTATION")) %></PBI_TRANSPORTATION>
				<PBI_PAY><%=ConvertUtil.toInteger(rs.getInt("PBI_PAY")) %></PBI_PAY>
				<PBI_PAY_MAX><%=ConvertUtil.toInteger(rs.getInt("PBI_PAY_MAX")) %></PBI_PAY_MAX>
				<PBI_MANAGER><%=ConvertUtil.toStr(rs.getString("PBI_MANAGER")) %></PBI_MANAGER>
				<PBI_TEL><%=ConvertUtil.toStr(rs.getString("PBI_TEL")) %></PBI_TEL>
				<PBI_EMAIL><%=ConvertUtil.toStr(rs.getString("PBI_EMAIL")) %></PBI_EMAIL>
				<PBI_PLACE_IMG><%=ConvertUtil.toStr(rs.getString("PBI_PLACE_IMG")) %></PBI_PLACE_IMG>
				<PBI_PRODUCT_IMG><%=ConvertUtil.toStr(rs.getString("PBI_PRODUCT_IMG")) %></PBI_PRODUCT_IMG>
				<PBI_CONTENT><%=ConvertUtil.toStr(rs.getString("PBI_CONTENT")) %></PBI_CONTENT>
				<PBI_LATLNG><%=ConvertUtil.toStr(rs.getString("PBI_LATLNG")) %></PBI_LATLNG>
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