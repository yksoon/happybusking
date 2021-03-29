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
* 버스킹존 게시글 삭제
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String bz_no = ParamUtil.getString(request, "bz_no", "");

conn = dbconn.dbconnect();

sql = "UPDATE BUSKINGZONE " + "\r\n" +
		"SET BZ_DEL = 'Y'" + "\r\n" +
		"WHERE BZ_NO = ?"; 

pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bz_no);
			pstmt.executeUpdate();

pstmt.close();
conn.close();
%>