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
* 버스킹 행사 일정 리스트(관리자용)
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
		
		sql = "select _pbi.*," + "\r\n" +
				"(select count(*) from public_busking_info pbi where _pbi.pbi_no = pbi.pbi_no and pbi.pbi_receipt_edate >= date_format(now(), '%Y-%m-%d')) as timechk" + "\r\n" +
				"from public_busking_info as _pbi" + "\r\n" +
				"order by pbi_regdate desc, timechk desc, case when timechk = 1 then pbi_receipt_sdate end asc, case when timechk = 0 then pbi_receipt_sdate end desc" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
		%>
			<DATA>
				<PBI_NO><%=ConvertUtil.toInteger(rs.getInt("PBI_NO")) %></PBI_NO>
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