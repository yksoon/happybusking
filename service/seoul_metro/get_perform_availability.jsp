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
* 공연 일정 신청 가능 여부 (SELECT)
*******************************************/
String sql = "";

String pno = ParamUtil.getString(request, "pno", "");

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select date, count(date) as cnt," + "\r\n" +
				"(select min(time_format(stime, '%H:%i')) from schedule_application where date = sa.date group by date) as minstime," + "\r\n" +
				"(select max(time_format(etime, '%H:%i')) from schedule_application where date = sa.date group by date) as maxetime" + "\r\n" +
				"from schedule_application sa" + "\r\n" +
				"where pno = '"+pno+"'" + "\r\n" +
				"and cancel = 'N'" + "\r\n" +
				"group by date" + "\r\n" +
				"having minstime='09:00' and maxetime='21:00'" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		
		while(rs.next()){
			%>
			<DATA>
				<DATE><%=ConvertUtil.toStr(rs.getString("date")) %></DATE>
				<CNT><%=ConvertUtil.toStr(rs.getString("cnt")) %></CNT>
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