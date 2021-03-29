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
* 회원정보 수정 
*******************************************/
String sql = "";
String sql_content = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String phone= ParamUtil.getString(request, "phone", "none");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		if(!phone.equals("none")){
			sql = "SELECT * " + "\r\n" +
					"FROM ARTIST" + "\r\n" +
					"WHERE REPLACE(PHONE,'-','') = " + phone;
		}
		else{
			sql = "SELECT * " + "\r\n" +
					"FROM ARTIST" + "\r\n" +
					"WHERE USER_NO = '" + USER_NO + "'\r\n";
		}
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO"))%></USER_NO>
					<ARTIST_NAME><%=ConvertUtil.toString(rs.getString("ARTIST_NAME"))%></ARTIST_NAME>
					<ARTIST_IMG><%=ConvertUtil.toString(rs.getString("ARTIST_IMG"))%></ARTIST_IMG>
					<USE_TOOL><%=ConvertUtil.toString(rs.getString("USE_TOOL"))%></USE_TOOL>
					<CODE_GENRE><%=ConvertUtil.toString(rs.getString("CODE_GENRE"))%></CODE_GENRE>
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