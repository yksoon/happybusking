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
* 공연상세 댓글 삭제(UPDATE)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String reply_no = ParamUtil.getString(request, "reply_no", "");

conn = dbconn.dbconnect();

try{
	sql = "UPDATE PERFORM_REPLY" + "\r\n" +
			"SET PERFORM_REPLY_DEL = 'Y'" + "\r\n" +
			"WHERE PERFORM_REPLY_NO = '" + reply_no + "'" + "\r\n";
	
	pstmt = conn.prepareStatement(sql);
	
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