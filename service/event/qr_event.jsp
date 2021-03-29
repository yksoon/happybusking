<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
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
* 신청 받고있는 공연 목록 (SELECT)
*******************************************/
String sql = "";
String sql2 = "";

Connection conn = null;
Statement pstmt = null;
PreparedStatement pstmt2 = null;
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
SimpleDateFormat sdf = new SimpleDateFormat("yyMMddkkmmss");
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
int randNum = ((int)(Math.random()*9999)+1);
Date nowdate = new Date();
String cnt;

String evno = sdf.format(nowdate) + String.format("%04d", randNum);
String tno = request.getParameter("tno");
String winning = "N";
String regdate = sdf2.format(nowdate);

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		sql = "select count(*) as cnt" + "\r\n" +
				"from event" + "\r\n" +
				"where ev_team_no = '"+tno+"'" + "\r\n";
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			cnt = ConvertUtil.toStr(rs.getString("cnt"));
		} else {
			cnt = "-1";
		}
		
		if(cnt.equals("0") || cnt.equals("6")|| cnt.equals("11") || cnt.equals("16") || cnt.equals("21")){
			winning = "Y";
		}
		
		
		sql2 = "insert into" + "\r\n" +
				"event(ev_no, ev_team_no, ev_winning, ev_ip, ev_regdate)" + "\r\n" +
				"values(?, ?, ?, ?, ?)" + "\r\n";
		
		pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setString(1, evno);
		pstmt2.setString(2, tno);
		pstmt2.setString(3, winning);
		pstmt2.setString(4, ip);
		pstmt2.setString(5, regdate);
		
		pstmt2.executeUpdate();
		
		%>
			<DATA>
				<WINNING><%=winning %></WINNING>
				<EVIP><%=ip %></EVIP>
			</DATA>
		<%
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