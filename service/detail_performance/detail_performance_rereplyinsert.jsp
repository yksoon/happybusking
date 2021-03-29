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
* 공연상세 댓글-> 답글 작성(INSERT)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String pf_no = ParamUtil.getString(request, "pf_no", "");
String pf_rereply_content = ParamUtil.getString(request, "pf_rereply_content", "");
String parent_no = ParamUtil.getString(request, "parent_no", "");

//현재 날짜 구해서 팀번호 생성
Date nowdate = new Date();
SimpleDateFormat tnoSdf = new SimpleDateFormat("yyMMddkkmmss");

//랜덤함수
int randNum = ((int)(Math.random()*9999)+1);

String res = tnoSdf.format(nowdate) + String.format("%04d", randNum);

//현재 날짜
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String now = sdf2.format(nowdate);

conn = dbconn.dbconnect();

try{
	sql = "INSERT INTO" + "\r\n" +
			"PERFORM_REPLY(PERFORM_NO, PARENT, USER_NO, PERFORM_REPLY_DATE, PERFORM_REPLY_CONTENT, PERFORM_REPLY_DEL, PERFORM_REPLY_DECLARE, PERFORM_REPLY_NO)" + "\r\n" +
			"VALUES(?, ?, ?, ?, ?, 'N', 'N', ?)";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, pf_no);
	pstmt.setString(2, parent_no);
	pstmt.setString(3, USER_NO);
	pstmt.setString(4, now);
	pstmt.setString(5, pf_rereply_content);
	pstmt.setString(6, res);
	//pstmt.setString(6, CreateRandomID.getID());
	
	
	pstmt.executeUpdate();
	
} catch(Exception e){
	System.out.println(e.getMessage());
}

if(pstmt != null){
	pstmt.close();	
}
if(conn != null){
	conn.close();	
}

%>