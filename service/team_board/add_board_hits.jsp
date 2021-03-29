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
* 게시판 조회수 증가
*******************************************/

String sql = "";

Connection conn = null;
PreparedStatement pstmt = null;

String board_no = ParamUtil.getString(request, "board_no", "");

conn = dbconn.dbconnect();
		
sql = "UPDATE BOARD" + "\r\n" +
		"SET BOARD_HITS = BOARD_HITS + 1" + "\r\n" +
		"WHERE BOARD_NO = " + board_no;

pstmt = conn.prepareStatement(sql);
int result = pstmt.executeUpdate();

pstmt.close();
conn.close();

%>