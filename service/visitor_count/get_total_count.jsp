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
* 방문자 수 카운트 (받아오기)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String visitor_date = ParamUtil.getString(request, "visitor_date", "");
%>
<ROOT2>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

  		sql = "SELECT SUM(visitor_count) AS TOTAL_COUNT" + "\r\n" +
                "FROM visitor_count";

		
  		System.out.println(sql);

		rs = pstmt.executeQuery(sql);

		while(rs.next()){
		%>
				<DATA2>
                    <TOTAL_COUNT><%=ConvertUtil.toString(rs.getString("TOTAL_COUNT"))%></TOTAL_COUNT>
				</DATA2>	
	    <% 	
		}
%>
</ROOT2>
<%
	}catch(Exception e){
		result = false;
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