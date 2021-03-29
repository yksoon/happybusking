<?xml version="1.0" encoding="utf-8"?>
<%@page import="com.sun.mail.handlers.multipart_mixed"%>
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

<%@ page import="src.util.*"%>

<%@include file="/service_include.jsp" %>

<%
/*******************************************
* 아티스트 정보 리스트(SELECT)
*******************************************/
String sql = "";
String sqlConcat = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String str = ParamUtil.getString(request, "str", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT A.USER_NO, A.PHONE, A.ARTIST_NAME, A.ARTIST_INTRO," + "\r\n" +
				"(SELECT U.USER_ID FROM USER U WHERE U.USER_NO = A.USER_NO) AS ID," + "\r\n" +
				"(SELECT U.NICKNAME FROM USER U WHERE U.USER_NO = A.USER_NO) AS NICKNAME," + "\r\n" +
				"(SELECT COUNT(*) FROM TEAM_MEMBER TM WHERE TM.USER_NO = A.USER_NO) AS TCOUNT" + "\r\n"+
				"FROM ARTIST A" + "\r\n" +
				"WHERE ARTIST_NAME LIKE '%"+str+"%'" + "\r\n";
				
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<TCOUNT><%=ConvertUtil.toInteger(rs.getInt("TCOUNT")) %></TCOUNT>
				<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO")) %></USER_NO>
				<PHONE><%=ConvertUtil.toStr(rs.getString("PHONE"))%></PHONE>
				<ARTIST_NAME><%=ConvertUtil.toStr(rs.getString("ARTIST_NAME"))%></ARTIST_NAME>
				<ID><%=ConvertUtil.toStr(rs.getString("ID"))%></ID>
				<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME"))%></NICKNAME>
				<ARTIST_INTRO><%=ConvertUtil.toStr(rs.getString("ARTIST_INTRO"))%></ARTIST_INTRO>
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