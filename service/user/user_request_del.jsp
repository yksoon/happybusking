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
* 1:1문의 삭제 UPDATE
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String uq_no = ParamUtil.getString(request, "uq_no", "0");

conn = dbconn.dbconnect();

if(USER_NO == null || USER_NO.equals("") || USER_NO.equals("null")){

	sql = "UPDATE USER_QUESTION" + "\r\n" +
			"SET UQ_DEL = 'Y'" + "\r\n" +
			"WHERE UQ_NO = " + uq_no + "\r\n";
} else {

	sql = "UPDATE USER_QUESTION" + "\r\n" +
			"SET UQ_DEL = 'Y'" + "\r\n" +
			"WHERE UQ_USER_NO = '" + USER_NO + "'\r\n" +
			"AND UQ_NO = " + uq_no + "\r\n";
}

pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();


pstmt.close();
conn.close();
%>