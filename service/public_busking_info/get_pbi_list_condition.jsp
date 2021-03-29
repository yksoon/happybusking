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

String pbiLimit = ParamUtil.getString(request, "pbiLimit", "0");
String pbiLast = ParamUtil.getString(request, "pbiLast", "10");

String apply_sdate = "";
String apply_edate = "";
String perform_sdate = "";
String perform_edate = "";
String genre = "";
String area = "";
String pay = "";
String personnel_min = "";
String personnel_max = "";

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select *" + "\r\n" + 
				"from busking_condition" + "\r\n" +
				"where uno = '"+USER_NO+"'" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			apply_sdate = ConvertUtil.toStr(rs.getString("APPLY_SDATE"));
			apply_edate = ConvertUtil.toStr(rs.getString("APPLY_EDATE"));
			perform_sdate = ConvertUtil.toStr(rs.getString("PERFORM_SDATE"));
			perform_edate = ConvertUtil.toStr(rs.getString("PERFORM_EDATE"));
			genre = ConvertUtil.toStr(rs.getString("GENRE"));
			area = ConvertUtil.toStr(rs.getString("AREA"));
			pay = ConvertUtil.toStr(rs.getString("PAY"));
			personnel_min = ConvertUtil.toStr(rs.getString("PERSONNEL_MIN"));
			personnel_max = ConvertUtil.toStr(rs.getString("PERSONNEL_MAX"));
		}
		
		if(genre.equals("전체")) genre = "";
		if(area.equals("전체")) area = "";
		if(!genre.equals("")) genre = genre.replaceAll(",", "|");
		if(!area.equals("")) area = area.replaceAll(",", "|");
		
		
		
		
		sql = "SELECT PBI.*," + "\r\n" +
				"(SELECT COUNT(*) FROM PUBLIC_BUSKING_INFO PBI2 WHERE PBI.PBI_NO = PBI2.PBI_NO AND PBI2.PBI_RECEIPT_EDATE >= DATE_FORMAT(now(), '%Y-%m-%d')) AS TIMECHK" + "\r\n" +
				"FROM PUBLIC_BUSKING_INFO PBI" + "\r\n" +
				"WHERE (PBI.PBI_GENRE = '' OR PBI.PBI_GENRE REGEXP('"+genre+"'))" + "\r\n" +
				"AND (PBI.PBI_ADDRESS REGEXP('"+area+"'))" + "\r\n" +
				"AND (PBI.PBI_PAY = 0 OR PBI.PBI_PAY >= "+pay+")" + "\r\n";
				
				
		
		if(!personnel_min.equals("")){
			sql = sql.concat("AND (PBI.PBI_PERSONNEL_MIN='제한없음' OR PBI.PBI_PERSONNEL_MIN <= "+personnel_min+")" + "\r\n");
		}
		if(!personnel_max.equals("")){
			sql = sql.concat("AND (PBI.PBI_PERSONNEL='제한없음' OR PBI.PBI_PERSONNEL >= "+personnel_max+")" + "\r\n");
			
		}
		
		if(!apply_sdate.equals("")){
			sql = sql.concat("AND ((PBI.PBI_RECEIPT_SDATE BETWEEN DATE_FORMAT('"+apply_sdate+"', '%Y-%m-%d') AND DATE_FORMAT('"+apply_edate+"', '%Y-%m-%d'))" + "\r\n" +
					"OR (PBI.PBI_RECEIPT_EDATE BETWEEN DATE_FORMAT('"+apply_sdate+"', '%Y-%m-%d') AND DATE_FORMAT('"+apply_edate+"', '%Y-%m-%d')))" + "\r\n");
		}
		
		if(!perform_sdate.equals("")){
			sql = sql.concat("AND ((PBI.PBI_EVENT_SDATE BETWEEN DATE_FORMAT('"+perform_sdate+"', '%Y-%m-%d') AND DATE_FORMAT('"+perform_edate+"', '%Y-%m-%d'))" + "\r\n" +
					"OR (PBI.PBI_EVENT_EDATE BETWEEN DATE_FORMAT('"+perform_sdate+"', '%Y-%m-%d') AND DATE_FORMAT('"+perform_edate+"', '%Y-%m-%d')))" + "\r\n");
		}
		
		sql = sql.concat("ORDER BY TIMECHK DESC, CASE WHEN TIMECHK = 1 THEN PBI.PBI_RECEIPT_SDATE END ASC, CASE WHEN TIMECHK = 0 THEN PBI.PBI_RECEIPT_SDATE END DESC" + "\r\n");
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