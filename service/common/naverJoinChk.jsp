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
* 네이버 회원가입 체크
*******************************************/
String sql = "";
Connection conn = null;
ResultSet rs = null;
Statement pstmt = null;


int count = 0;

//중복로그인 체크 Parameter
String email = ParamUtil.getString(request, "email", "");
%>
	<ROOT>
<%
	try{
	conn = dbconn.dbconnect();
	pstmt = conn.createStatement();
	
	sql = "SELECT COUNT(*) AS CNT"+ "\r\n" +
			"FROM USER" + "\r\n" + 
			"WHERE USER_ID = '" + email + "'\r\n" +
			"AND LOGIN_CHK = 'N'";
	
	
	rs = pstmt.executeQuery(sql);
	
	if(rs.next()){
		int cnt = ConvertUtil.toInteger(rs.getInt("CNT"));
		%>
		<DATA>
			<CNT><%=cnt %></CNT>
		</DATA>
		<%
	}

		   
	%>
	</ROOT>
	<%
	}catch(Exception e){
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