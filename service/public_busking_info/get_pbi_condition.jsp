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
* 맞춤 공연 설정 데이터 불러오기
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String user_no = USER_NO;
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select *" + "\r\n" +
				"from busking_condition" + "\r\n" +
				"where uno = '"+user_no+"'" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
		%>
			<DATA>
				<APPLY_SDATE><%=ConvertUtil.toStr(rs.getString("APPLY_SDATE")) %></APPLY_SDATE>
				<APPLY_EDATE><%=ConvertUtil.toStr(rs.getString("APPLY_EDATE")) %></APPLY_EDATE>
				<PERFORM_SDATE><%=ConvertUtil.toStr(rs.getString("PERFORM_SDATE")) %></PERFORM_SDATE>
				<PERFORM_EDATE><%=ConvertUtil.toStr(rs.getString("PERFORM_EDATE")) %></PERFORM_EDATE>
				<GENRE_CODE><%=ConvertUtil.toStr(rs.getString("GENRE_CODE")) %></GENRE_CODE>
				<GENRE><%=ConvertUtil.toStr(rs.getString("GENRE")) %></GENRE>
				<AREA_CODE><%=ConvertUtil.toStr(rs.getString("AREA_CODE")) %></AREA_CODE>
				<AREA><%=ConvertUtil.toStr(rs.getString("AREA")) %></AREA>
				<PAY><%=ConvertUtil.toInteger(rs.getInt("PAY")) %></PAY>
				<PERSONNEL_MIN><%=ConvertUtil.toStr(rs.getString("PERSONNEL_MIN")) %></PERSONNEL_MIN>
				<PERSONNEL_MAX><%=ConvertUtil.toStr(rs.getString("PERSONNEL_MAX")) %></PERSONNEL_MAX>
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