<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@page import="java.net.URLEncoder"%>
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
* 유저 기본정보 수정(update)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = true;
String msg = "";

//유저 기본정보 수정  Parameter 
String email = ParamUtil.getString(request, "email", "");
String user_pw =  ParamUtil.getString(request, "user_pw", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		user_pw = SecuritySha.SHA256(user_pw);

		sql = "UPDATE USER" + "\r\n" +  
				 "SET user_pw = '"+ user_pw +"'" + "\r\n" +
				"WHERE USER_ID = '" + email + "'\r\n";

			
		pstmt.executeUpdate(sql);	
		
	}catch(Exception e){
		result = false;
		msg = "수정 실패";
		e.printStackTrace();
	}
%>	
		<DATA>
			<RESULT><%=String.valueOf(result)%></RESULT>
			<MESSAGE><%=msg%></MESSAGE>  
		</DATA>
	</ROOT> 
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