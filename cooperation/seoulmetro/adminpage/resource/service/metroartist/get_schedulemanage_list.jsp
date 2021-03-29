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
		
		sql = "select sa.*, t.team_name, pp.name as pname," + "\r\n" +
				"(select count(*) from schedule_application sa2 join team t on t.team_no = sa2.tno "+condition+") as cnt" + "\r\n" +
				"from schedule_application sa" + "\r\n" +
				"join team t on t.team_no = sa.tno" + "\r\n" +
				"join perform_place pp on pp.no = sa.pno" + "\r\n" +
				condition + "\r\n" +
				"group by sa.no" + "\r\n" +
				"order by date desc" + "\r\n"+
				"limit " + start + ", 8";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<NO><%=ConvertUtil.toStr(rs.getString("NO")) %></NO>
				<DATE><%=ConvertUtil.toStr(rs.getString("DATE")) %></DATE>
				<STIME><%=ConvertUtil.toStr(rs.getString("STIME"))%></STIME>
				<ETIME><%=ConvertUtil.toStr(rs.getString("ETIME"))%></ETIME>
				<ATTENDANCE><%=ConvertUtil.toStr(rs.getString("ATTENDANCE"))%></ATTENDANCE>
				<CANCEL><%=ConvertUtil.toStr(rs.getString("CANCEL"))%></CANCEL>
				<REGDATE><%=ConvertUtil.toStr(rs.getString("REGDATE"))%></REGDATE>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<PNAME><%=ConvertUtil.toStr(rs.getString("PNAME"))%></PNAME>
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