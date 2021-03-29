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

Connection conn = null;
Statement pstmt = null;
PreparedStatement pstmt2 = null;
ResultSet rs = null;

String ntNo = ParamUtil.getString(request, "ntNo", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		
		sql = "UPDATE NOTICE" + "\r\n" +
				"SET NT_VIEWCOUNT = NT_VIEWCOUNT + 1" + "\r\n" +
				"WHERE NT_NO = '" + ntNo + "'";
		
		pstmt2 = conn.prepareStatement(sql);
		pstmt2.executeUpdate();
		
		
		pstmt = conn.createStatement();
		sql = "SELECT N.*," + "\r\n" +
				"(SELECT COUNT(*) FROM NOTICE_REPLY NR WHERE NR.NT_NO = N.NT_NO) AS RCOUNT" + "\r\n" +
				"FROM NOTICE N" + "\r\n" +
				"WHERE N.NT_NO = '"+ntNo+"'" + "\r\n";
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<NT_NO><%=ConvertUtil.toStr(rs.getString("NT_NO")) %></NT_NO>
				<NT_TYPE><%=ConvertUtil.toStr(rs.getString("NT_TYPE")) %></NT_TYPE>
				<NT_TITLE><%=ConvertUtil.toStr(rs.getString("NT_TITLE"))%></NT_TITLE>
				<NT_CONTENT><%=ConvertUtil.toStr(rs.getString("NT_CONTENT"))%></NT_CONTENT>
				<NT_REGDATE><%=ConvertUtil.toStr(rs.getString("NT_REGDATE"))%></NT_REGDATE>
				<NT_VIEWCOUNT><%=ConvertUtil.toInteger(rs.getInt("NT_VIEWCOUNT"))%></NT_VIEWCOUNT>
				<RCOUNT><%=ConvertUtil.toInteger(rs.getInt("RCOUNT"))%></RCOUNT>
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
	pstmt2.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>