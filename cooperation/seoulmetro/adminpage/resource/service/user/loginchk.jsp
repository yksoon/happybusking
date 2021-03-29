<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.net.InetAddress"%>
<%@page import="java.net.Inet4Address"%>
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
* 로그인 체크 (SELECT)
*******************************************/
String sql = "";
String condition = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String uid = ParamUtil.getString(request, "uid", "");

int cnt = 0;
String ip = "";

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		try{
			ip = request.getRemoteAddr();
			ip = SecuritySha.SHA256(ip);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		sql = "select count(*) as lcnt," + "\r\n" +
				"(select count(*) from metroartist_admin where uid = md.uid and loginchk = '"+ip+"') as dcnt" + "\r\n" +
				"from metroartist_admin md" + "\r\n" +
				"where md.uid = '"+uid+"'" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			%>
			<DATA>
				<LCNT><%=ConvertUtil.toInteger(rs.getInt("LCNT")) %></LCNT>
				<DCNT><%=ConvertUtil.toInteger(rs.getInt("DCNT")) %></DCNT>
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