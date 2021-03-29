<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

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
* 공모 신청 취소(UPDATE)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String kid = ParamUtil.getString(request, "kid", "");

conn = dbconn.dbconnect();

try{
	sql = "update festival_apply" + "\r\n" +
			"set cancel = 'Y'" + "\r\n" +
			"where kid = ?" + "\r\n";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, kid);
	
	//System.out.println(sql);
	
	pstmt.executeUpdate();
	
} catch(Exception e){
	//System.out.println(e.getMessage());
}

if(pstmt != null){
	pstmt.close();	
}
if(conn != null){
	conn.close();	
}

%>