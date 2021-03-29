<?xml version="1.0" encoding="utf-8"?>
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
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//정보 수정 Parameter

String hq_no =  ParamUtil.getString(request, "hq_no", "");
String hq_state =  ParamUtil.getString(request, "hq_state", "");


%>


<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		//업로드						
		sql = "UPDATE HOMEPAGE_QUESTION " + "\r\n" +  
				"SET HQ_STATE='{hq_state}' " + "\r\n" + 
				"WHERE HQ_NO =" + hq_no;
  		
		sql = sql.replace("{hq_state}", hq_state);
		pstmt.executeUpdate(sql);		
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