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
* 후원메시지 보내기
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String support_no = ParamUtil.getString(request, "support_no", "");
String send_msg = ParamUtil.getString(request, "send_msg", "");

conn = dbconn.dbconnect();

sql = "UPDATE SUPPORT " + "\r\n" +
		"SET SUPPORT_MSG = ?" + "\r\n" +
		"WHERE SUPPORT_PRODUCTCODE = ?"; 

pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_msg);
			pstmt.setString(2, support_no);
			pstmt.executeUpdate();

pstmt.close();
conn.close();
%>