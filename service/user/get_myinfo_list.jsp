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
* 내 정보 가져오기
*******************************************/
String sql = "";
String sql_content = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";


%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT * FROM USER" + "\r\n" +
				"WHERE USER_NO = '" + USER_NO + "'\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO"))%></USER_NO>
					<USER_ID><%=ConvertUtil.toString(rs.getString("USER_ID"))%></USER_ID>
					<NICKNAME><%=ConvertUtil.toString(rs.getString("NICKNAME"))%></NICKNAME>
					<BIRTH><%=ConvertUtil.toString(rs.getString("BIRTH"))%></BIRTH>
					<GENDER><%=ConvertUtil.toString(rs.getString("GENDER"))%></GENDER>
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