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
* 후원하기 (INSERT)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String team_no = ParamUtil.getString(request, "team_no", "");
String price = ParamUtil.getString(request, "price", "");
String name = ParamUtil.getString(request, "name", "");
String tel = ParamUtil.getString(request, "tel", "");
String email = ParamUtil.getString(request, "email", "");
String paymethod = ParamUtil.getString(request, "paymethod", "");
String productcode = ParamUtil.getString(request, "productcode", "");

//현재 날짜 구해서 INSERT
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date nowdate = new Date();

String now = sdf.format(nowdate);

conn = dbconn.dbconnect();

sql = "INSERT INTO " + "\r\n" +
		"SUPPORT (USER_NO, TEAM_NO, SUPPORT_NAME, SUPPORT_TEL, SUPPORT_EMAIL, SUPPORT_PRICE, SUPPORT_DATE, SUPPORT_SUCCESS, SUPPORT_PAYMETHOD, SUPPORT_PRODUCTCODE) " + "\r\n" +
		"VALUES (?, ?, ?, ?, ?, ?, ?, 'N', ?, ?) ";


pstmt = conn.prepareStatement(sql);

pstmt.setString(1, USER_NO);
pstmt.setString(2, team_no);
pstmt.setString(3, name);
pstmt.setString(4, tel);
pstmt.setString(5, email);
pstmt.setString(6, price);
pstmt.setString(7, now);
pstmt.setString(8, paymethod);
pstmt.setString(9, productcode);

pstmt.executeUpdate();

pstmt.close();
conn.close();
%>