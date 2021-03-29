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
* 공지사항 댓글 등록(INSERT)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String ntrNo = ParamUtil.getString(request, "ntrNo", "");

conn = dbconn.dbconnect();

try{
	sql = "UPDATE NOTICE_REPLY" + "\r\n" +
			"SET NTR_DEL = 'Y'" + "\r\n" +
			"WHERE NTR_NO = ?";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, ntrNo);
	
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