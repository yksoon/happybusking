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
* 공연 장비 공유글 삭제
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String si_no = ParamUtil.getString(request, "si_no", "");

conn = dbconn.dbconnect();

sql = "UPDATE SHARE_ITEM " + "\r\n" +
		"SET SI_DEL = 'Y'" + "\r\n" +
		"WHERE SI_NO = ?"; 

pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, si_no);
			pstmt.executeUpdate();

pstmt.close();
conn.close();
%>