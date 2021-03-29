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
* 키움페이 결제 정보 가져오기 (SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String tid = request.getParameter("tid");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		sql = "SELECT CPID, DAOUTRX, AMOUNT, PAYMETHOD" + "\r\n" +
				"FROM KIWOOMPAY_RESULT" + "\r\n" +
				"WHERE DAOUTRX = '"+tid+"'";
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<CPID><%=ConvertUtil.toStr(rs.getString("CPID")) %></CPID>
				<DAOUTRX><%=ConvertUtil.toStr(rs.getString("DAOUTRX")) %></DAOUTRX>
				<AMOUNT><%=ConvertUtil.toStr(rs.getString("AMOUNT"))%></AMOUNT>
				<PAYMETHOD><%=ConvertUtil.toStr(rs.getString("PAYMETHOD"))%></PAYMETHOD>
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