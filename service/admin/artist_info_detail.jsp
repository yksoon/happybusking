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

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String uno = ParamUtil.getString(request, "uno", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT TM.USER_NO, TM.TEAM_NO, TM.LEADER_CHK, TM.MEMBER_REQ_STATUS," + "\r\n" +
				"(SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_NO = TM.TEAM_NO) AS TEAM_NAME," + "\r\n" +
				"(SELECT A.ARTIST_NAME FROM ARTIST A WHERE A.USER_NO = TM.USER_NO) AS ARTIST_NAME" + "\r\n" +
				"FROM TEAM_MEMBER TM" + "\r\n" +
				"WHERE TM.USER_NO = '" + uno + "'\r\n";

		
				
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO"))%></USER_NO>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
				<LEADER_CHK><%=ConvertUtil.toStr(rs.getString("LEADER_CHK"))%></LEADER_CHK>
				<MEMBER_REQ_STATUS><%=ConvertUtil.toStr(rs.getString("MEMBER_REQ_STATUS"))%></MEMBER_REQ_STATUS>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<ARTIST_NAME><%=ConvertUtil.toStr(rs.getString("ARTIST_NAME"))%></ARTIST_NAME>
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