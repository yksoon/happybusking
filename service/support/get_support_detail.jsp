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

String sptno = ParamUtil.getString(request, "sptno", "0");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT S.*," + "\r\n" +
				"(SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_NO = S.TEAM_NO) AS TEAM_NAME" + "\r\n" +
				"FROM SUPPORT S" + "\r\n" +
				"WHERE S.SUPPORT_NO = " + sptno;
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			%>
			<DATA>
				<SUPPORT_PRICE><%=ConvertUtil.toInteger(rs.getInt("SUPPORT_PRICE"))%></SUPPORT_PRICE>
				<SUPPORT_NAME><%=ConvertUtil.toStr(rs.getString("SUPPORT_NAME"))%></SUPPORT_NAME>
				<SUPPORT_TEL><%=ConvertUtil.toStr(rs.getString("SUPPORT_TEL"))%></SUPPORT_TEL>
				<SUPPORT_DATE><%=ConvertUtil.toStr(rs.getString("SUPPORT_DATE"))%></SUPPORT_DATE>
				<SUPPORT_PAYMETHOD><%=ConvertUtil.toStr(rs.getString("SUPPORT_PAYMETHOD"))%></SUPPORT_PAYMETHOD>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
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