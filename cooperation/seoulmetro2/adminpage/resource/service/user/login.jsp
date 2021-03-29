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
* 로그인 (SELECT)
*******************************************/
String sql = "";
String condition = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String id = ParamUtil.getString(request, "id", "");
String pw = ParamUtil.getString(request, "pw", "");
pw = SecuritySha.SHA256(pw);

int cnt = 0;

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		
		
		sql = "select uid, count(*) as cnt from metroartist_admin" + "\r\n" +
				"where id = '"+id+"'" + "\r\n" +
				"and pw = '"+pw+"'" + "\r\n" +
				"and apply = 'Y'" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			cnt = ConvertUtil.toInteger(rs.getInt("CNT"));
			%>
			<DATA>
				<UID><%=ConvertUtil.toStr(rs.getString("UID")) %></UID>
				<CNT><%=cnt %></CNT>
			</DATA>
			<%
		}
		
		if(cnt > 0){
			try{
				String ip = request.getRemoteAddr();
				ip = SecuritySha.SHA256(ip);
				
				sql = "update metroartist_admin" + "\r\n" +
						"set loginchk = '"+ip+"'" + "\r\n" +
						"where id = '"+id+"'" + "\r\n" +
						"and pw = '"+pw+"'" + "\r\n" ;
				
				//System.out.println(sql);
				
				pstmt.executeUpdate(sql);
				
			} catch(Exception e) {
				e.printStackTrace();
			}
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