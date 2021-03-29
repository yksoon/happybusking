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
* 만족도 작성
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String sno = ParamUtil.getString(request, "sno", "");
String score = ParamUtil.getString(request, "score", "");
String content = ParamUtil.getString(request, "content", "");
String ip = request.getRemoteAddr();

conn = dbconn.dbconnect();

try{
	sql = "update evalution_results" + "\r\n" +
			"set score = ?, content = ?" + "\r\n" +
			"where sno = ? and ip = ?" + "\r\n";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, score);
	pstmt.setString(2, content);
	pstmt.setString(3, sno);
	pstmt.setString(4, ip);
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