<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.io.File"%>
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
* 전자서명 등록(insert)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String image = ParamUtil.getString(request, "image", "");
String business_no = ParamUtil.getString(request, "business_no", "");
String sign_employer = ParamUtil.getString(request, "sign_employer", "");
%>

<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
  			sql = "INSERT INTO " + "\r\n" +
  					"e_signature " + "\r\n" +
  					"VALUES('" + business_no + "', '" + sign_employer + "', '" + image + "');";
		
		
  		//System.out.println(sql);
  			
		pstmt.executeUpdate(sql);
		result = true;

	}catch(Exception e){
		result = false;
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