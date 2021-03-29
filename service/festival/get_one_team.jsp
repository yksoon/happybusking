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

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String tno = ParamUtil.getString(request, "tno", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		sql = "select t.TEAM_NAME, t.TEAM_INTRO, t.CODE_GENRE," + "\r\n" +
				"(select a.PHONE from artist a where user_no = '"+USER_NO+"') AS PHONE," + "\r\n" +
				"(select u.USER_ID from user u where user_no = '"+USER_NO+"') AS EMAIL" + "\r\n" +
				"from team t" + "\r\n" +
				"where t.team_no = '"+tno+"'" + "\r\n";
		
		/* sql = "select t.TEAM_NAME, t.TEAM_INTRO, t.CODE_GENRE," + "\r\n" +
				"(select a.PHONE from artist a where user_no = '"+USER_NO+"') AS PHONE," + "\r\n" +
				"(select u.USER_ID from user u where user_no = '"+USER_NO+"') AS EMAIL" + "\r\n" +
				"from team t" + "\r\n" +
				"where t.team_no = (select tm.team_no" + "\r\n" +
				"from team_member tm" + "\r\n" +
				"where tm.user_no = '"+USER_NO+"' limit 1)"; */
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME")) %></TEAM_NAME>
				<TEAM_INTRO><%=ConvertUtil.toStr(rs.getString("TEAM_INTRO")) %></TEAM_INTRO>
				<CODE_GENRE><%=ConvertUtil.toStr(rs.getString("CODE_GENRE"))%></CODE_GENRE>
				<PHONE><%=ConvertUtil.toStr(rs.getString("PHONE"))%></PHONE>
				<EMAIL><%=ConvertUtil.toStr(rs.getString("EMAIL"))%></EMAIL>
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