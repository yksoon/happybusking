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

String pbiSearchTitle = ParamUtil.getString(request, "pbiSearchTitle", "");
String pbiSearchDate = ParamUtil.getString(request, "pbiSearchDate", "");
String pbiArea = ParamUtil.getString(request, "pbiArea", "");
String pbiGenre = ParamUtil.getString(request, "pbiGenre", "");
String pbiLimit = ParamUtil.getString(request, "pbiLimit", "0");
String pbiLast = ParamUtil.getString(request, "pbiLast", "10");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT *," + "\r\n" +
				"(SELECT COUNT(*) FROM PUBLIC_BUSKING_INFO PBI2 WHERE PBI.PBI_NO = PBI2.PBI_NO AND PBI2.PBI_RECEIPT_EDATE >= DATE_FORMAT(now(), '%Y-%m-%d')) AS TIMECHK" + "\r\n" +
				"FROM PUBLIC_BUSKING_INFO PBI" + "\r\n";
		
		if(pbiSearchTitle.equals("")){
			sql = sql.concat("WHERE PBI.PBI_TITLE LIKE '%%'" + "\r\n");
		} else {
			sql = sql.concat("WHERE PBI.PBI_TITLE LIKE '%"+pbiSearchTitle+"%'" + "\r\n");
		}
		
		if(!pbiSearchDate.equals("")){
			String date1 = pbiSearchDate.split("~")[0];
			String date2 = pbiSearchDate.split("~")[1];
			sql = sql.concat("AND ((PBI.PBI_EVENT_SDATE >= DATE_FORMAT('"+date1+"', '%Y-%m-%d') AND PBI.PBI_EVENT_SDATE <= DATE_FORMAT('"+date2+"', '%Y-%m-%d'))" + "\r\n");
			sql = sql.concat("OR (PBI.PBI_EVENT_EDATE >= DATE_FORMAT('"+date1+"', '%Y-%m-%d') AND PBI.PBI_EVENT_EDATE <= DATE_FORMAT('"+date2+"', '%Y-%m-%d')))" + "\r\n");
		}
		
		if(!pbiArea.equals("")){
			sql = sql.concat("AND PBI.PBI_ADDRESS LIKE '"+pbiArea+"%'" + "\r\n");
		}
		
		if(!pbiGenre.equals("")){
			sql = sql.concat("AND (PBI.PBI_GENRE = '' OR PBI.PBI_GENRE LIKE '%"+pbiGenre+"%')" + "\r\n");
		}
		
		sql = sql.concat("ORDER BY PBI_FIRST DESC, TIMECHK DESC, CASE WHEN TIMECHK = 1 THEN PBI.PBI_RECEIPT_SDATE END ASC, CASE WHEN TIMECHK = 0 THEN PBI.PBI_RECEIPT_SDATE END DESC" + "\r\n");
		sql = sql.concat("limit " + pbiLimit + ", " + pbiLast + "\r\n");
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
		%>
			<DATA>
				<PBI_NO><%=ConvertUtil.toStr(rs.getString("PBI_NO")) %></PBI_NO>
				<PBI_USER_NO><%=ConvertUtil.toStr(rs.getString("PBI_USER_NO")) %></PBI_USER_NO>
				<PBI_THUMNAIL_IMG><%=ConvertUtil.toStr(rs.getString("PBI_THUMNAIL_IMG")) %></PBI_THUMNAIL_IMG>
				<TIMECHK><%=ConvertUtil.toInteger(rs.getInt("TIMECHK")) %></TIMECHK>
				<PBI_TITLE><%=ConvertUtil.toStr(rs.getString("PBI_TITLE")) %></PBI_TITLE>
				<PBI_EVENT_SDATE><%=ConvertUtil.toStr(rs.getString("PBI_EVENT_SDATE")) %></PBI_EVENT_SDATE>
				<PBI_EVENT_EDATE><%=ConvertUtil.toStr(rs.getString("PBI_EVENT_EDATE")) %></PBI_EVENT_EDATE>
				<PBI_RECEIPT_SDATE><%=ConvertUtil.toStr(rs.getString("PBI_RECEIPT_SDATE")) %></PBI_RECEIPT_SDATE>
				<PBI_RECEIPT_EDATE><%=ConvertUtil.toStr(rs.getString("PBI_RECEIPT_EDATE")) %></PBI_RECEIPT_EDATE>
				<PBI_ADDRESS><%=ConvertUtil.toStr(rs.getString("PBI_ADDRESS")) %></PBI_ADDRESS>
				<PBI_DETAILADDRESS><%=ConvertUtil.toStr(rs.getString("PBI_DETAILADDRESS")) %></PBI_DETAILADDRESS>
				<PBI_GENRE><%=ConvertUtil.toStr(rs.getString("PBI_GENRE")) %></PBI_GENRE>
				<PBI_REGDATE><%=ConvertUtil.toStr(rs.getString("PBI_REGDATE")) %></PBI_REGDATE>
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