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
* 공연일정 정보
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String team_name = ParamUtil.getString(request, "team_name", "");
String team_acc_holder = ParamUtil.getString(request, "team_acc_holder", "");
String team_bank = ParamUtil.getString(request, "team_bank", "");
String team_account = ParamUtil.getString(request, "team_account", "");

conn = dbconn.dbconnect();

sql = "UPDATE " + "\r\n" +
		"TEAM SET " + "\r\n" +
		"TEAM_ACC_HOLDER = '" + team_acc_holder + "', \r\n" +
		"TEAM_BANK = '" + team_bank + "', \r\n" +
		"TEAM_ACCOUNT = '" +  team_account + "' \r\n" +
		"WHERE TEAM_NAME = '" +  team_name + "'";

pstmt = conn.prepareStatement(sql);

pstmt.executeUpdate();


pstmt.close();
conn.close();
%>