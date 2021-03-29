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
* 관리자 페이지 - 모집 공연 상태변경(UPDATE)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String frid = ParamUtil.getString(request, "frid", "");
String frstate = ParamUtil.getString(request, "frstate", "");


//현재 날짜 구해서 INSERT
conn = dbconn.dbconnect();

try{
	sql = "UPDATE FESTIVAL_REC" + "\r\n" +
			"SET FRSTATE = ?" + "\r\n" +
			"WHERE FRID = ?";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, frstate);
	pstmt.setString(2, frid);
	
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