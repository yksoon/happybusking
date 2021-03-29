<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@page import="java.net.URLEncoder"%>
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
* 버스커 선서 동의(update)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "UPDATE USER" + "\r\n" +  
				 "SET BUSKER_OATH = 'Y'" + "\r\n" +
				"WHERE USER_NO = '" + USER_NO + "'\r\n";

		
		pstmt.executeUpdate(sql);	
		
	}catch(Exception e){
		e.printStackTrace();
	}
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