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
* 공지사항 목록 (SELECT)
*******************************************/
String sql = "";
String condition = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String search = ParamUtil.getString(request, "search", "");
String start = ParamUtil.getString(request, "start", "0");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		condition = "where t.team_name like '%"+search+"%'";
		
		sql =  "select er.*, sa.tno, sa.date, sa.stime, sa.etime, t.team_name," + "\r\n" +
				"(select count(*) from evalution_results er1 join schedule_application sa1 on sa1.no = er1.sno join team t1 on t1.team_no = sa1.tno "+condition+") as cnt" + "\r\n" +
				"from evalution_results er" + "\r\n" +
				"join schedule_application sa on sa.no = er.sno" + "\r\n" +
				"join team t on t.team_no = sa.tno" + "\r\n" +
				condition + "\r\n" +
				"order by er.uid desc" + "\r\n" +
				"limit " + start + ", 8";
				
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<NO><%=ConvertUtil.toStr(rs.getString("NO")) %></NO>
				<SCORE><%=ConvertUtil.toStr(rs.getString("SCORE")) %></SCORE>
				<CONTENT><%=ConvertUtil.toStr(rs.getString("CONTENT"))%></CONTENT>
				<REGDATE><%=ConvertUtil.toStr(rs.getString("REGDATE"))%></REGDATE>
				<DATE><%=ConvertUtil.toStr(rs.getString("DATE"))%></DATE>
				<STIME><%=ConvertUtil.toStr(rs.getString("STIME"))%></STIME>
				<ETIME><%=ConvertUtil.toStr(rs.getString("ETIME"))%></ETIME>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT"))%></CNT>
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