<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
* 홈페이지 건의사항 등록(INSERT)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String hqTitle = ParamUtil.getString(request, "hqTitle", "");
String hqContent = ParamUtil.getString(request, "hqContent", "");
String hqRequest = ParamUtil.getString(request, "hqRequest", "");


//현재 날짜 구해서 INSERT
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date nowdate = new Date();
String now = sdf.format(nowdate);

conn = dbconn.dbconnect();

sql = "INSERT INTO" + "\r\n" +
		"HOMEPAGE_QUESTION(HQ_STATE, HQ_TITLE, HQ_CONTENT, HQ_REQUEST, HQ_REGIDATE)" + "\r\n" +
		"VALUES('N', ?, ?, ?, ?)" + "\r\n";

pstmt = conn.prepareStatement(sql);
pstmt.setString(1, hqTitle);
pstmt.setString(2, hqContent);
pstmt.setString(3, hqRequest);
pstmt.setString(4, now);
pstmt.executeUpdate();


pstmt.close();
conn.close();
%>