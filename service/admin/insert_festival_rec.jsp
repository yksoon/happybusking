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
* 관리자 페이지 - 모집 공연 등록(INSERT)
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String frgubun = ParamUtil.getString(request, "frgubun", "");
String frname = ParamUtil.getString(request, "frname", "");


//현재 날짜 구해서 INSERT
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
SimpleDateFormat sdf2 = new SimpleDateFormat("yyMMddkkmmss");
Date nowdate = new Date();

String now = sdf.format(nowdate);
String now2 = sdf2.format(nowdate);

//랜덤함수
int randNum = ((int)(Math.random()*9999)+1);
String randNO = String.format("%04d", randNum);
String frid = now2 + randNO;

conn = dbconn.dbconnect();

try{
	sql = "INSERT INTO" + "\r\n" +
			"FESTIVAL_REC(FRID, FRGUBUN, FRNAME, FRDATE)" + "\r\n" +
			"VALUES(?, ?, ?, ?)" + "\r\n";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, frid);
	pstmt.setString(2, frgubun);
	pstmt.setString(3, frname);
	pstmt.setString(4, now);
	
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