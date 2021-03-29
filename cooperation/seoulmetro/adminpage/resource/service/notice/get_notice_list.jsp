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
String type = ParamUtil.getString(request, "type", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		// and nt_type='M' 추후 조건에 추가
		condition = "where nt_title like '%"+search+"%' and nt_del = 'N' and nt_type='M'";
		
		sql = "select *," + "\r\n" +
				"(select count(*) from notice "+condition+") as cnt" + "\r\n" +
				"from notice" + "\r\n" +
				condition + "\r\n" +
				"order by nt_regdate desc" + "\r\n" +
				"limit " + start + ",8" + "\r\n";
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<NOTICEID><%=ConvertUtil.toInteger(rs.getInt("NOTICEID")) %></NOTICEID>
				<NT_NO><%=ConvertUtil.toStr(rs.getString("NT_NO")) %></NT_NO>
				<NT_TYPE><%=ConvertUtil.toStr(rs.getString("NT_TYPE")) %></NT_TYPE>
				<NT_TITLE><%=ConvertUtil.toStr(rs.getString("NT_TITLE"))%></NT_TITLE>
				<NT_REGDATE><%=ConvertUtil.toStr(rs.getString("NT_REGDATE"))%></NT_REGDATE>
				<NT_DEL><%=ConvertUtil.toStr(rs.getString("NT_DEL"))%></NT_DEL>
				<NT_VIEWCOUNT><%=ConvertUtil.toInteger(rs.getInt("NT_VIEWCOUNT"))%></NT_VIEWCOUNT>
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