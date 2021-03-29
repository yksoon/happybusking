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

String date = ParamUtil.getString(request, "date", "");
String sort = ParamUtil.getString(request, "sort", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT SUM(SUPPORT_PRICE) AS TOTAL_PRICE" + "\r\n" +
				"FROM SUPPORT" + "\r\n" +
				"WHERE USER_NO = '" + USER_NO + "'\r\n" +
				"AND SUPPORT_SUCCESS = 'Y'";
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			%>
			<DATA0>
				<TOTAL_PRICE><%=ConvertUtil.toInteger(rs.getInt("TOTAL_PRICE"))%></TOTAL_PRICE>
			</DATA0>
			<%
		}
		
		sql = "SELECT S.*," + "\r\n" +
				"(SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_NO = S.TEAM_NO) AS TEAM_NAME" + "\r\n" +
				"FROM SUPPORT S" + "\r\n" +
				"WHERE S.USER_NO = '"+ USER_NO + "'\r\n" +
				"AND S.SUPPORT_SUCCESS = 'Y'" + "\r\n";

		if(date.equals("1") || date.equals("3")){
			sql = sql.concat("AND SUPPORT_DATE >= date_sub(now(), interval "+date+" month) AND SUPPORT_DATE <= now()" + "\r\n");
		} else {
			sql = sql.concat("AND SUPPORT_DATE LIKE '"+date+"%'" + "\r\n");
		}
		
		if(sort.equals("1")){
			//최신순
			sql = sql.concat("ORDER BY SUPPORT_DATE DESC");
		} else {
			//오래된순
			sql = sql.concat("ORDER BY SUPPORT_DATE ASC");
		}
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<SUPPORT_NO><%=ConvertUtil.toInteger(rs.getInt("SUPPORT_NO"))%></SUPPORT_NO>
				<SUPPORT_PRICE><%=ConvertUtil.toInteger(rs.getInt("SUPPORT_PRICE"))%></SUPPORT_PRICE>
				<SUPPORT_DATE><%=ConvertUtil.toStr(rs.getString("SUPPORT_DATE"))%></SUPPORT_DATE>
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