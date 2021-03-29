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

String email= ParamUtil.getString(request, "email", "");
String num = ParamUtil.getString(request, "num", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select count(*) as cnt, ja.name" + "\r\n" +
				"from (select e.*" + "\r\n" +
						"from email_chk e" + "\r\n" +
						"where e.email = '"+email+"'" + "\r\n" +
						"order by regdate desc" + "\r\n" +
						"limit 1) as A" + "\r\n" +
						"join judging_admin ja on ja.email = A.email" + "\r\n" +
						"where A.email = '"+email+"'" + "\r\n" +
						"and chk_code = '"+num+"'" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
		%>
			<DATA>
				<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT")) %></CNT>
				<NAME><%=ConvertUtil.toStr(rs.getString("NAME")) %></NAME>
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