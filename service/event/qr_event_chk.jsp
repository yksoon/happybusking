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
* QR 이벤트 참여여부
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

//접속자 ip 확인
String ip = request.getHeader("X-FORWARDED-FOR");
if(ip == null || ip.length() == 0 || ip.equals("null")){
	ip = request.getHeader("Proxy-Client-IP");
}
if(ip == null || ip.length() == 0 || ip.equals("null")){
	ip = request.getHeader("WL-Proxy-Client-IP");
}
if(ip == null || ip.length() == 0 || ip.equals("null")){
	ip = request.getRemoteAddr();
}
if(ip== null || ip.length() == 0 || ip.equals("null")){
	ip = request.getHeader("REMOTE_ADDR");
}
if(ip== null || ip.length() == 0 || ip.equals("null")){
	ip = request.getHeader("HTTP_X_FORWAREDE_FOR");
}
if(ip== null || ip.length() == 0 || ip.equals("null")){
	ip = request.getHeader("HTTP_CLIENT_IP");
}

String tno = request.getParameter("tno");


%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		sql = "select count(*) cnt" + "\r\n" +
				"from event" + "\r\n" +
				"where (ev_team_no = '"+tno+"'" + "\r\n"+
				"and ev_ip = '"+ip+"')" + "\r\n" +
				"or(ev_ip='"+ip+"' and ev_winning = 'Y')" + "\r\n";
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<CNT><%=ConvertUtil.toStr(rs.getString("cnt")) %></CNT>
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