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

String dno = ParamUtil.getString(request, "dno", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		//메트로 아티스트 공지만 나오게 조건 바꿔야함
		sql = "select n.*," + "\r\n" +
				"(select nickname from user where user_no = n.user_no) as nickname," + "\r\n" +
				"(select nt_no from notice where noticeid < n.noticeid and nt_del = 'N' order by noticeid desc limit 1) as prev_no," + "\r\n" +
				"(select nt_no from notice where noticeid > n.noticeid and nt_del = 'N' order by noticeid limit 1) as next_no" + "\r\n" +
				"from notice n" + "\r\n" +
				"where n.nt_no = '"+dno+"'" + "\r\n" +
				"order by n.noticeid desc" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<NT_TITLE><%=ConvertUtil.toStr(rs.getString("NT_TITLE")) %></NT_TITLE>
				<NT_CONTENT><%=ConvertUtil.toStr(rs.getString("NT_CONTENT")) %></NT_CONTENT>
				<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME")) %></NICKNAME>
				<NT_REGDATE><%=ConvertUtil.toStr(rs.getString("NT_REGDATE")) %></NT_REGDATE>
				<PREV_NO><%=ConvertUtil.toStr(rs.getString("PREV_NO")) %></PREV_NO>
				<NEXT_NO><%=ConvertUtil.toStr(rs.getString("NEXT_NO")) %></NEXT_NO>
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