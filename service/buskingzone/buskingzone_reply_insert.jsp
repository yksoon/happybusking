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
* 버스킹존 댓글 작성(INSERT)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String bz_no = ParamUtil.getString(request, "bz_no", "");
String bz_reply_content = ParamUtil.getString(request, "bz_reply_content", "");

//현재 날짜 구해서 INSERT
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date nowdate = new Date();

String now = sdf.format(nowdate);

conn = dbconn.dbconnect();

try{
	sql = "INSERT INTO" + "\r\n" +
			"BUSKINGZONE_REPLY(BZ_NO, USER_NO, BZ_REPLY_DATE, BZ_REPLY_CONTENT, BZ_REPLY_DEL, BZ_REPLY_DECLARE)" + "\r\n" +
			"VALUES(?, ?, ?, ?, 'N', 'N')";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, bz_no);
	pstmt.setString(2, USER_NO);
	pstmt.setString(3, now);
	pstmt.setString(4, bz_reply_content);
	
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