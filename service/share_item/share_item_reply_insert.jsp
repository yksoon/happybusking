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
* 장비공유 상세페이지 댓글 작성(INSERT)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String si_no = ParamUtil.getString(request, "si_no", "");
String si_reply_content = ParamUtil.getString(request, "si_reply_content", "");

//현재 날짜 구해서 INSERT
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date nowdate = new Date();

String now = sdf.format(nowdate);

conn = dbconn.dbconnect();

try{
	sql = "INSERT INTO" + "\r\n" +
			"SHARE_ITEM_REPLY(SI_NO, SI_REPLY_USER_NO, SI_REPLY_DATE, SI_REPLY_CONTENT, SI_REPLY_DEL, SI_REPLY_DECLARE)" + "\r\n" +
			"VALUES(?, ?, ?, ?, 'N', 'N')";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, si_no);
	pstmt.setString(2, USER_NO);
	pstmt.setString(3, now);
	pstmt.setString(4, si_reply_content);
	
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