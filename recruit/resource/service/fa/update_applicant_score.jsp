<?xml version="1.0" encoding="utf-8"?>
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

<%@include file="/service_include.jsp" %>

<%
/*******************************************
* 버스킹 행사 일정 리스트
*******************************************/
String sql = "";

Connection conn = null;
PreparedStatement pstmt = null;

String id = ParamUtil.getString(request, "id", "");
String score = ParamUtil.getString(request, "score", "0");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		
		sql = "update festival_apply" + "\r\n" +
				"set score = ?, scoring = 'Y'" + "\r\n" +
				"where kid = ?";
		
		//System.out.println(id);
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(score));
		pstmt.setString(2, id);
		
		//System.out.println(sql);
		
		pstmt.executeUpdate();
%>
</ROOT>
<%
	}catch(Exception e){
		e.getStackTrace();
	}
%>
<%
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>