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
<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

  		sql = "SELECT * FROM " + "\r\n" +
                "visitor_homepage_count" + "\r\n" +
                "WHERE HOMEPAGE_VISITOR_DATE = '" + visitor_date + "'";

		
  		System.out.println(sql);

		rs = pstmt.executeQuery(sql);
        
		while(rs.next()){
			%>
				<DATA>
					<HOMEPAGE_VISITOR_DATE><%=ConvertUtil.toStr(rs.getString("HOMEPAGE_VISITOR_DATE"))%></HOMEPAGE_VISITOR_DATE>
					<HOMEPAGE_VISITOR_COUNT><%=ConvertUtil.toString(rs.getString("HOMEPAGE_VISITOR_COUNT"))%></HOMEPAGE_VISITOR_COUNT>
				</DATA>	
	<% 	
		}
%>
</ROOT>
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