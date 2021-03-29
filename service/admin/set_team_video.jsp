<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.io.File"%>
<%@page import="com.sun.mail.handlers.multipart_mixed"%>
<%@page import="com.mysql.fabric.xmlrpc.base.Param"%>
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

<%@ page import="src.util.*"%>

<%@include file="/service_include.jsp" %>

<%
/*******************************************
* hq list(update)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//정보 수정 Parameter

String url =  ParamUtil.getString(request, "url", "");
String tno =  ParamUtil.getString(request, "tno", "");
%>


<%
	try{
		conn = dbconn.dbconnect();
		
		sql = "update team" + "\r\n" +
				"set tintro_video = ?, team_video = ''" + "\r\n" +
				"where team_no = ?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, url);
		pstmt.setString(2, tno);
		
		pstmt.executeUpdate();
		
		result = true;
	}catch(Exception e){
		result = false;
		e.printStackTrace();
	}

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