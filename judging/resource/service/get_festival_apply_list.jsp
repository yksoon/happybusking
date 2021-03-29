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
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select *" + "\r\n" +
				"from festival_apply" + "\r\n" +
				"where kgubun like '%메트로%'" + "\r\n" +
				"order by ksort asc" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
		%>
			<DATA>
				<KID><%=ConvertUtil.toStr(rs.getString("KID")) %></KID>
				<KTEAMNO><%=ConvertUtil.toStr(rs.getString("KTEAMNO")) %></KTEAMNO>
				<KTEAM><%=ConvertUtil.toStr(rs.getString("KTEAM")) %></KTEAM>
				<KMGENRE><%=ConvertUtil.toStr(rs.getString("KMGENRE")) %></KMGENRE>
				<KGENRE><%=ConvertUtil.toStr(rs.getString("KGENRE")) %></KGENRE>
				<KINFO><%=ConvertUtil.toStr(rs.getString("KINFO")) %></KINFO>
				<KURL><%=ConvertUtil.toStr(rs.getString("KURL")) %></KURL>
				<KGREAT><%=ConvertUtil.toStr(rs.getString("KGREAT"))%></KGREAT> 
				<KVIDEO><%=ConvertUtil.toStr(rs.getString("KVIDEO"))%></KVIDEO> 
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