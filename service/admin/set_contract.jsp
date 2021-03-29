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
* 사업자 수임 상태 변경(UPDATE)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//정보 수정 Parameter

String user_no =  ParamUtil.getString(request, "user_no", "");
String consignment_agree_admin =  ParamUtil.getString(request, "consignment_agree_admin", "");
String return_code =  ParamUtil.getString(request, "return_code", "");

//System.out.println(no);
//System.out.println(state);
%>


<%
	try{
		conn = dbconn.dbconnect();
        pstmt = conn.createStatement();
		
		sql = "UPDATE business " + "\r\n" +
				"SET CONSIGNMENT_AGREE_ADMIN = '" + consignment_agree_admin + "', RETURN_CODE = '" + return_code + "'" + "\r\n" +
				"WHERE USER_NO = '" + user_no + "'";
		

		pstmt.executeUpdate(sql);

        System.out.println(sql);
		
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