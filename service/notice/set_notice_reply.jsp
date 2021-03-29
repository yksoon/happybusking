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

String ntNo = ParamUtil.getString(request, "ntNo", "");
String ntrContent = ParamUtil.getString(request, "ntrContent", "");


//현재 날짜 구해서 팀번호 생성
SimpleDateFormat tnoSdf = new SimpleDateFormat("yyMMddkkmmss");
Date nowdate = new Date();
String ntrNoS = tnoSdf.format(nowdate);

//랜덤함수
int randNum = ((int)(Math.random()*9999)+1);
String randNumS = String.format("%04d", randNum);

String ntrNo = ntrNoS + randNumS;

//현재 날짜
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String now = sdf2.format(nowdate);

conn = dbconn.dbconnect();

try{
	sql = "INSERT INTO" + "\r\n" +
			"NOTICE_REPLY(USER_NO, NT_NO, NTR_NO, NTR_CONTENT, NTR_REGDATE, NTR_DEL)" + "\r\n" +
			"VALUES(?, ?, ?, ?, ?, 'N')";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, USER_NO);
	pstmt.setString(2, ntNo);
	pstmt.setString(3, ntrNo);
	pstmt.setString(4, ntrContent);
	pstmt.setString(5, now);
	
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