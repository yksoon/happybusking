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
* 관리자 페이지 - 지급 상태 변경(UPDATE)
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String uq_title = ParamUtil.getString(request, "uq_title", "");
String uq_type = ParamUtil.getString(request, "uq_type", "");
String uq_no = ParamUtil.getString(request, "uq_no", "");
String uq_content = ParamUtil.getString(request, "uq_content", "");


//현재 날짜 구해서 INSERT
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date nowdate = new Date();

String now = sdf.format(nowdate);

conn = dbconn.dbconnect();

try{
	sql = "INSERT INTO " + "\r\n" +
			"USER_QUESTION(UQ_TYPE, UQ_TITLE, UQ_CONTENT, UQ_REGIDATE, UQ_PARENT, UQ_DEL)" + "\r\n" +
			"VALUES(?,?,?,?,?,'N')";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, uq_type);
	pstmt.setString(2, uq_title);
	pstmt.setString(3, uq_content);
	pstmt.setString(4, now);
	pstmt.setInt(5, Integer.parseInt(uq_no));
	
	//System.out.println(sql);
	
	pstmt.executeUpdate();
	
	
	
	sql2 = "UPDATE USER_QUESTION" + "\r\n" +
			"SET UQ_STATE = 'Y'" + "\r\n" +
			"WHERE UQ_NO = " + uq_no;
	
	pstmt = conn.prepareStatement(sql2);

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