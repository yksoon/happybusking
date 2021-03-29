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
* 모집 공연 신청 정보 불러오기
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String name= ParamUtil.getString(request, "name", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select *" + "\r\n" +
				"from metro_judging" + "\r\n" +
				"where name = '"+name+"'" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
		%>
			<DATA>
				<NO><%=ConvertUtil.toStr(rs.getString("NO")) %></NO>
				<SCORE1><%=ConvertUtil.toInteger(rs.getInt("SCORE1")) %></SCORE1>
				<SCORE2><%=ConvertUtil.toInteger(rs.getInt("SCORE2")) %></SCORE2>
				<SCORE3><%=ConvertUtil.toInteger(rs.getInt("SCORE3")) %></SCORE3>
				<TOTALSCORE><%=ConvertUtil.toInteger(rs.getInt("TOTALSCORE")) %></TOTALSCORE>
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