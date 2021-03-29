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
* 신청 받고있는 공연 목록 (SELECT)
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
		

		if(USER_NO.equals("6")){
			sql = "select pbi_no, pbi_title" + "\r\n" +
					"from public_busking_info" + "\r\n" +
					"where date_format(pbi_receipt_sdate, '%Y-%m-%d') <= date_format(now(), '%Y-%m-%d')" + "\r\n" +
					"and date_format(pbi_receipt_edate, '%Y-%m-%d') >= date_format(now(), '%Y-%m-%d')" + "\r\n";
		} else {
			sql = "select pbi_no, pbi_title" + "\r\n" +
					"from public_busking_info" + "\r\n" +
					"where date_format(pbi_receipt_sdate, '%Y-%m-%d') <= date_format(now(), '%Y-%m-%d')" + "\r\n" +
					"and date_format(pbi_receipt_edate, '%Y-%m-%d') >= date_format(now(), '%Y-%m-%d')" + "\r\n" +
					"and pbi_user_no <> '0'" + "\r\n";
		}
		
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<PBI_NO><%=ConvertUtil.toStr(rs.getString("PBI_NO")) %></PBI_NO>
				<PBI_TITLE><%=ConvertUtil.toStr(rs.getString("PBI_TITLE")) %></PBI_TITLE>
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