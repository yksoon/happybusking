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
* 게시판 댓글 수정
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String board_reply_no = ParamUtil.getString(request, "board_reply_no", "");
String board_reply_content = ParamUtil.getString(request, "board_reply_content", "");

//System.out.println("board_reply_content : " + board_reply_content);

conn = dbconn.dbconnect();

sql = "UPDATE BOARD_REPLY" + "\r\n" +
		"SET BOARD_REPLY_CONTENT = ?" + "\r\n" +
		"WHERE BOARD_REPLY_NO = " + board_reply_no;

pstmt = conn.prepareStatement(sql);

pstmt.setString(1, board_reply_content);	

//System.out.println(sql);
	
int result = pstmt.executeUpdate();

pstmt.close();
conn.close();
%>