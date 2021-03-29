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
* 방문자 수 카운트 (입력)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String difference = ParamUtil.getString(request, "difference", "");
String visitor_date = ParamUtil.getString(request, "visitor_date", "");
String visitor_count = ParamUtil.getString(request, "visitor_count", "");
%>

<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

        if (difference.equals("Y")) {
  			sql = "INSERT INTO " + "\r\n" +
                    "visitor_homepage_count (HOMEPAGE_VISITOR_DATE, HOMEPAGE_VISITOR_COUNT)" + "\r\n" +
                    "VALUES ('" + visitor_date + "', 1)";
        } else if (difference.equals("N")) {
            sql = "UPDATE visitor_homepage_count"  + "\r\n" +
                    "SET HOMEPAGE_VISITOR_COUNT = '" + visitor_count + "'" + "\r\n" +
                    "WHERE HOMEPAGE_VISITOR_DATE = '" + visitor_date + "'";
        }
		
  		System.out.println(sql);

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