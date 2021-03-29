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
* 본인이 보유한 팀 목록
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

//공간등록 -> 공간등록 상호명 중복확인
String business_workname = ParamUtil.getString(request, "business_workname", "0");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT * " + "\r\n" +
				"FROM BUSINESS " + "\r\n" +
				"WHERE BUSINESS_WORKNAME = '" + business_workname + "'" + "\r\n";
		
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
		%>
			<DATA>
				<BUSINESS_WORKNAME><%=ConvertUtil.toStr(rs.getString("BUSINESS_WORKNAME"))%></BUSINESS_WORKNAME>
				<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO"))%></USER_NO>
			</DATA>
		<%
		}
%>
</ROOT>
<%
	}catch(Exception e){
		e.getStackTrace();
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