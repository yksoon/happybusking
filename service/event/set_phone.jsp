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

String phone = request.getParameter("phone");
String ip = request.getParameter("ip");
String tno = request.getParameter("tno");


conn = dbconn.dbconnect();

try{
	sql = "UPDATE EVENT" + "\r\n" +
			"SET EV_PHONE = ?" + "\r\n" +
			"WHERE EV_IP = ?" + "\r\n" +
			"AND EV_TEAM_NO = ?" + "\r\n";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, phone);
	pstmt.setString(2, ip);
	pstmt.setString(3, tno);
	
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