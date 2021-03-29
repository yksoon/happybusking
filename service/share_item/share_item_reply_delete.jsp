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
* 장비공유 상세페이지 댓글 삭제(UPDATE)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String si_reply_no = ParamUtil.getString(request, "si_reply_no", "");


conn = dbconn.dbconnect();

try{
	sql = "UPDATE SHARE_ITEM_REPLY" + "\r\n" +
			"SET SI_REPLY_DEL = 'Y' " + "\r\n" +
			"WHERE SI_REPLY_NO = ?";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, si_reply_no);
	
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