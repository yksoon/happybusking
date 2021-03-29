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
* 일정관리 수락/거절(UPDATE)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String id = ParamUtil.getString(request, "id", "");
String value = ParamUtil.getString(request, "value", "");

conn = dbconn.dbconnect();

try{
	sql = "update schedule_application" + "\r\n" +
			"set cancel = ?" + "\r\n" +
			"where no = ?" + "\r\n";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, value);
	pstmt.setString(2, id);
	
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