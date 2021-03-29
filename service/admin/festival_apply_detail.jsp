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
* QR_request list(SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String kid = ParamUtil.getString(request, "kid", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT *" + "\r\n" +
				"FROM FESTIVAL_APPLY" + "\r\n" +
				"WHERE KID = '" + kid + "'\n";

		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<KNAME><%=ConvertUtil.toStr(rs.getString("KNAME"))%></KNAME>
				<KBIRTH><%=ConvertUtil.toStr(rs.getString("KBIRTH"))%></KBIRTH>
				<KPOSTCODE><%=ConvertUtil.toStr(rs.getString("KPOSTCODE"))%></KPOSTCODE>
				<KADDR><%=ConvertUtil.toStr(rs.getString("KADDR"))%></KADDR>
				<KDETAILADDR><%=ConvertUtil.toStr(rs.getString("KDETAILADDR"))%></KDETAILADDR>
				<KEMAIL><%=ConvertUtil.toStr(rs.getString("KEMAIL"))%></KEMAIL>
				<KTEL><%=ConvertUtil.toStr(rs.getString("KTEL"))%></KTEL>
				<KTEAM><%=ConvertUtil.toStr(rs.getString("KTEAM"))%></KTEAM>
				<KGENRE><%=ConvertUtil.toStr(rs.getString("KGENRE"))%></KGENRE>
				<KTYPE><%=ConvertUtil.toStr(rs.getString("KTYPE"))%></KTYPE>
				<KINFO><%=ConvertUtil.toStr(rs.getString("KINFO"))%></KINFO>
				<KURL><%=ConvertUtil.toStr(rs.getString("KURL"))%></KURL>
				<KDATE><%=ConvertUtil.toStr(rs.getString("KDATE"))%></KDATE>
				<KGUBUN><%=ConvertUtil.toStr(rs.getString("KGUBUN"))%></KGUBUN>
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