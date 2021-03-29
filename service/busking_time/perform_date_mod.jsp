<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@page import="java.awt.Image"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="src.util.ImageSizeChange"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%@include file="/service_include.jsp" %>

<%
/*******************************************
* 날짜에 따른 자동 공연 완료 처리
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
%>

<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
	    		sql = "UPDATE reg_buskingtime" + "\r\n" +
	    				"SET BUSKINGSTATUS = '5'" + "\r\n" +
	    				"where date(BUSKINGDATE) <= date(subdate(now(), interval 1 DAY))";

	    		pstmt.executeUpdate(sql);
	    		
	    		result = true;
	}catch(Exception e){
		result = false;
		e.printStackTrace();
	}
%>

<%
try {
	rs.close();
} catch (Exception ex) {}
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>