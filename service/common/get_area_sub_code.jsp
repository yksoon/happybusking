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
* 지역명에 맞는 하위 지역 코드 가져오기
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String area_key = ParamUtil.getString(request, "area_key", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		 
		sql = "SELECT AREA_VALUE" + "\r\n" +
				"FROM AREA_SUB_CODE" + "\r\n" +
				"WHERE AREA_KEY = '{area_key}'";
		sql = sql.replace("{area_key}" , area_key);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<AREA_VALUE><%=ConvertUtil.toStr(rs.getString("AREA_VALUE"))%></AREA_VALUE>
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