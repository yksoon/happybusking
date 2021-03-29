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
* 공지사항 댓글 목록 (SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String ntNo = ParamUtil.getString(request, "ntNo", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		
		
		pstmt = conn.createStatement();
		sql = "SELECT NTR.*," + "\r\n" +
				"(SELECT COUNT(*) FROM NOTICE_REPLY NR WHERE NR.NT_NO = NTR.NT_NO AND NR.NTR_DEL = 'N') AS CNT," + "\r\n" +
				"(SELECT U.NICKNAME FROM USER U WHERE U.USER_NO = NTR.USER_NO) AS NICKNAME" + "\r\n" +
				"FROM NOTICE_REPLY NTR" + "\r\n" +
				"WHERE NTR.NT_NO = '"+ntNo+"'" + "\r\n" +
				"ORDER BY NTRID DESC";
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO")) %></USER_NO>
				<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT")) %></CNT>
				<NT_NO><%=ConvertUtil.toStr(rs.getString("NT_NO")) %></NT_NO>
				<NTR_NO><%=ConvertUtil.toStr(rs.getString("NTR_NO")) %></NTR_NO>
				<NTR_CONTENT><%=ConvertUtil.toStr(rs.getString("NTR_CONTENT")) %></NTR_CONTENT>
				<NTR_REGDATE><%=ConvertUtil.toStr(rs.getString("NTR_REGDATE")) %></NTR_REGDATE>
				<NTR_DEL><%=ConvertUtil.toStr(rs.getString("NTR_DEL")) %></NTR_DEL>
				<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME")) %></NICKNAME>
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