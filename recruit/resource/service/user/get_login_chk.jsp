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
ResultSet rs = null;

String email = ParamUtil.getString(request, "email", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		
		sql = "select *" + "\r\n" +
				"from user" + "\r\n" +
				"where user_id = ?" + "\r\n";
		
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		
		//System.out.println(USER_NO);
		//System.out.println(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
		%>
			<DATA>
				<LOGIN_CHK><%=ConvertUtil.toStr(rs.getString("LOGIN_CHK")) %></LOGIN_CHK>
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