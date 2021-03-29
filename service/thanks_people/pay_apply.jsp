<?xml version="1.0" encoding="utf-8"?>
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
* 지급 신청
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String withdraw_price = ParamUtil.getString(request, "withdraw_price", "");
String withdraw_real_price = ParamUtil.getString(request, "withdraw_real_price", "");
String team_no = ParamUtil.getString(request, "team_no", "");
String withdraw_bank = ParamUtil.getString(request, "withdraw_bank", "");
String withdraw_account = ParamUtil.getString(request, "withdraw_account", "");

conn = dbconn.dbconnect();

sql = "INSERT INTO " + "\r\n" +
		"WITHDRAW (TEAM_NO, WITHDRAW_PRICE, WITHDRAW_REAL_PRICE, WITHDRAW_DATE, WITHDRAW_BANK, WITHDRAW_ACCOUNT) " + "\r\n" +
		"VALUES (?, ?, ?, NOW(), ?, ?) ";

pstmt = conn.prepareStatement(sql);

pstmt.setString(1, team_no);
pstmt.setString(2, withdraw_price);
pstmt.setString(3, withdraw_real_price);
pstmt.setString(4, withdraw_bank);
pstmt.setString(5, withdraw_account);

pstmt.executeUpdate();

sql = "UPDATE " + "\r\n" +
		"TEAM SET " + "\r\n" +
		"TEAM_MONEY = TEAM_MONEY- " + withdraw_price + "\r\n" +
		"WHERE TEAM_NO = " +team_no;

pstmt = conn.prepareStatement(sql);

pstmt.executeUpdate();

pstmt.close();
conn.close();
%>