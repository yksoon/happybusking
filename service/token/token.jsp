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
* 토큰 등록
*******************************************/
String sql0 = "";
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";


//토큰 등록 Parameter
String token = ParamUtil.getString(request, "token", "");


//System.out.println("token:" + token);

%>

<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		/* 토큰 초기화 */
		sql0 = "UPDATE USER" + "\r\n" +
		          "SET FCM_TOKEN = ''" + "\r\n" +
		        "WHERE FCM_TOKEN = '{token}'" + "\r\n";
		
		sql0 = sql0.replace("{token}", token);
		//System.out.println(sql0);					
		
		pstmt.executeUpdate(sql0);
		
		
 		sql =	"UPDATE USER " + "\r\n" + 
				   "SET FCM_TOKEN  = '{token}'" + "\r\n" + 
				 "WHERE USER_NO = '" + USER_NO + "'\r\n";  
				 
		sql = sql.replace("{token}", token);
		//System.out.println(sql);					
		
		pstmt.executeUpdate(sql);
			
			result = true;
			msg = "토큰 등록";	

	}catch(Exception e){
		result = false;
		msg = "토큰 등록 실패";
		e.printStackTrace();
	}
%>
 	<ROOT>
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