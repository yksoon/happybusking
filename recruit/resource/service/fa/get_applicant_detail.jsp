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
* 버스킹 행사 일정 리스트
*******************************************/
String sql = "";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String no = ParamUtil.getString(request, "no", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		
		sql = "select *" + "\r\n" +
				"from festival_apply" + "\r\n" +
				"where kid = ?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, no);
		
		//System.out.println(no);
		//System.out.println(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
		%>
			<DATA>
				<KID><%=ConvertUtil.toStr(rs.getString("KID")) %></KID>
				<KGENRE><%=ConvertUtil.toStr(rs.getString("KGENRE")) %></KGENRE>
				<KNAME><%=ConvertUtil.toStr(rs.getString("KNAME")) %></KNAME>
				<KBIRTH><%=ConvertUtil.toStr(rs.getString("KBIRTH")) %></KBIRTH>
				<KADDR><%=ConvertUtil.toStr(rs.getString("KADDR")) %></KADDR>
				<KEMAIL><%=ConvertUtil.toStr(rs.getString("KEMAIL")) %></KEMAIL>
				<KTEL><%=ConvertUtil.toStr(rs.getString("KTEL")) %></KTEL>
				<KTEAMNO><%=ConvertUtil.toStr(rs.getString("KTEAMNO")) %></KTEAMNO>
				<KTEAM><%=ConvertUtil.toStr(rs.getString("KTEAM")) %></KTEAM>
				<KINFO><%=ConvertUtil.toStr(rs.getString("KINFO")) %></KINFO>
				<KURL><%=ConvertUtil.toStr(rs.getString("KURL")) %></KURL>
				<SCORING><%=ConvertUtil.toStr(rs.getString("SCORING")) %></SCORING>
				<KCOUNTMIN><%=ConvertUtil.toInteger(rs.getInt("KCOUNTMIN")) %></KCOUNTMIN>
				<KCOUNTMAX><%=ConvertUtil.toInteger(rs.getInt("KCOUNTMAX")) %></KCOUNTMAX>
				<SCORE><%=ConvertUtil.toInteger(rs.getInt("SCORE")) %></SCORE>
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