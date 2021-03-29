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
* 게시글 수정
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String board_no = ParamUtil.getString(request, "board_no", "");
String board_category = ParamUtil.getString(request, "board_category", "");
String board_title = ParamUtil.getString(request, "board_title", "");
String board_content = ParamUtil.getString(request, "board_content", "");

conn = dbconn.dbconnect();

sql = "UPDATE BOARD" + "\r\n" +
		"SET BOARD_CATEGORY=?, BOARD_TITLE=?, BOARD_CONTENT=?" + "\r\n" +
		"WHERE BOARD_NO = " + board_no;

pstmt = conn.prepareStatement(sql);

pstmt.setString(1, board_category);	
pstmt.setString(2, board_title);	
pstmt.setString(3, board_content);	

//System.out.println(sql);
	
int result = pstmt.executeUpdate();

pstmt.close();
conn.close();
%>