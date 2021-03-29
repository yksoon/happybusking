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

%>
 
<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select count(*) as qrcnt," + "\r\n" +
				"(select count(*) from homepage_question where hq_regidate > date_add(now(), interval -7 day) and hq_state = 'N') as hqcnt," + "\r\n" +
				"(select count(*) from user_question where uq_regidate > date_add(now(), interval -7 day) and isnull(uq_parent) and uq_del='N' and uq_state ='N') as uqcnt," + "\r\n" +
				"(select count(*) from withdraw where withdraw_date > date_add(now(), interval -7 day) and payments_ok = '1') as wcnt," + "\r\n" +
				"(select count(*) from video_upload where regdate > date_add(now(), interval -7 day) and state = 'N') as uuv," + "\r\n" +
				"(select count(*) from team where team_video <> '') as tvcnt" + "\r\n" +
				"from qr_request" + "\r\n" +
				"where regdate > date_add(now(), interval -7 day)" + "\r\n" +
				"and qr_request_state = 'W'" + "\r\n";
				
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<QRCNT><%=ConvertUtil.toInteger(rs.getInt("QRCNT")) %></QRCNT>
				<HQCNT><%=ConvertUtil.toInteger(rs.getInt("HQCNT")) %></HQCNT>
				<UQCNT><%=ConvertUtil.toInteger(rs.getInt("UQCNT")) %></UQCNT>
				<WCNT><%=ConvertUtil.toInteger(rs.getInt("WCNT")) %></WCNT>
				<TVCNT><%=ConvertUtil.toInteger(rs.getInt("TVCNT")) %></TVCNT>
				<UUV><%=ConvertUtil.toInteger(rs.getInt("UUV")) %></UUV>
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