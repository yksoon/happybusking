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
* 공지사항 목록 (SELECT)
*******************************************/
String sql = "";
String condition = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String search = ParamUtil.getString(request, "search", "");
String start = ParamUtil.getString(request, "start", "0");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		condition = "where belong like '%서울메트로%' and team_name like '%"+search+"%'";
		
		sql = "select t.team_no, t.team_name, t.team_intro, concat(t.main_genre, ',', t.code_genre) as genre, t.code_area," + "\r\n" +
				"(select count(*) from team " + condition + ") as cnt \r\n" +
				"from team t" + "\r\n" +
				condition + "\r\n" +
				"order by team_no desc" + "\r\n" +
				"limit " + start + ", 8" + "\r\n" ;
				
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO")) %></TEAM_NO>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME")) %></TEAM_NAME>
				<TEAM_INTRO><%=ConvertUtil.toStr(rs.getString("TEAM_INTRO"))%></TEAM_INTRO>
				<GENRE><%=ConvertUtil.toStr(rs.getString("GENRE"))%></GENRE>
				<CODE_AREA><%=ConvertUtil.toStr(rs.getString("CODE_AREA"))%></CODE_AREA>
				<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT"))%></CNT>
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