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
* 지역별 공연 검색
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT MP_STATE, MP_URL, MP_COOKIE, MP_WIDTH, MP_HEIGHT " + "\r\n" +
				"FROM MAIN_POPUP " + "\r\n";
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			%>
			<DATA>
				<MP_STATE><%=ConvertUtil.toInteger(rs.getInt("MP_STATE"))%></MP_STATE>
				<MP_URL><%=ConvertUtil.toStr(rs.getString("MP_URL"))%></MP_URL>
				<MP_COOKIE><%=ConvertUtil.toStr(rs.getString("MP_COOKIE"))%></MP_COOKIE>
				<MP_WIDTH><%=ConvertUtil.toStr(rs.getString("MP_WIDTH"))%></MP_WIDTH>
				<MP_HEIGHT><%=ConvertUtil.toStr(rs.getString("MP_HEIGHT"))%></MP_HEIGHT>
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