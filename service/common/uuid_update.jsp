<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%@include file="/service_include.jsp"%>

<%
/*******************************************
* 네이버 로그인시 UUID 업데이트
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;


int count = 0;

//중복로그인 체크 Parameter
String uuid = ParamUtil.getString(request, "uuid", "");
String user_no = USER_NO;

try{
conn = dbconn.dbconnect();
pstmt = conn.createStatement();

uuid = SecuritySha.SHA256(uuid);
	
sql = "UPDATE USER " + "\r\n" +
		"UUID = '" + uuid + "'\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";


pstmt.executeUpdate(sql);
	
	   
}catch(Exception e){
	e.printStackTrace();
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