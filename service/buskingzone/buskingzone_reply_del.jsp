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
* 버스킹존 댓글 삭제(UPDATE)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String bz_reply_no = ParamUtil.getString(request, "bz_reply_no", "");

conn = dbconn.dbconnect();

try{
	sql = "UPDATE BUSKINGZONE_REPLY" + "\r\n" +
			"SET BZ_REPLY_DEL = 'Y'" + "\r\n" +
			"WHERE BZ_REPLY_NO = " + bz_reply_no;
	
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