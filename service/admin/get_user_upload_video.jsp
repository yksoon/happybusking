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
* 모집중인 공연 리스트(SELECT)
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
		
		sql = "select v.*, u.nickname, t.team_name" + "\r\n" +
				"from video_upload v" + "\r\n" +
				"left join user u on u.user_no = v.user_no" + "\r\n" +
				"left join team t on t.team_no = v.team_no" + "\r\n" +
				"order by v.regdate desc" + "\r\n";
		
		//System.out.println(sql);
				
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<NO><%=ConvertUtil.toStr(rs.getString("NO"))%></NO>
				<VIDEO_UPLOAD_URL><%=ConvertUtil.toStr(rs.getString("VIDEO_UPLOAD_URL"))%></VIDEO_UPLOAD_URL>
				<VIDEO_UPLOAD_TITLE><%=ConvertUtil.toStr(rs.getString("VIDEO_UPLOAD_TITLE"))%></VIDEO_UPLOAD_TITLE>
				<VIDEO_UPLOAD_CONTENT><%=ConvertUtil.toStr(rs.getString("VIDEO_UPLOAD_CONTENT"))%></VIDEO_UPLOAD_CONTENT>
				<REGDATE><%=ConvertUtil.toStr(rs.getString("REGDATE"))%></REGDATE>
				<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME"))%></NICKNAME>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<STATE><%=ConvertUtil.toStr(rs.getString("STATE"))%></STATE>
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