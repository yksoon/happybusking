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
* 해당 팀의 지급내역
*******************************************/
String sql = "";
String sql2 = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;
ResultSet rs2 = null;

//임시 팀번호 1번, 임시 유저번호 6번
String team_no = ParamUtil.getString(request, "team_no", "1");
String user_no = ParamUtil.getString(request, "user_no", "6");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT * " + "\r\n" +
				"FROM WITHDRAW " + "\r\n" +
				"WHERE TEAM_NO = " + team_no + "\r\n" +
				"ORDER BY WITHDRAW_DATE DESC";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
		%>
			<DATA>
				<WITHDRAW_NO><%=ConvertUtil.toInteger(rs.getInt("WITHDRAW_NO")) %></WITHDRAW_NO>
				<WITHDRAW_PRICE><%=ConvertUtil.toStr(rs.getString("WITHDRAW_PRICE"))%></WITHDRAW_PRICE>
				<WITHDRAW_REAL_PRICE><%=ConvertUtil.toStr(rs.getString("WITHDRAW_REAL_PRICE"))%></WITHDRAW_REAL_PRICE>
				<WITHDRAW_DATE><%=ConvertUtil.toStr(rs.getString("WITHDRAW_DATE"))%></WITHDRAW_DATE>
				<WITHDRAW_BANK><%=ConvertUtil.toStr(rs.getString("WITHDRAW_BANK"))%></WITHDRAW_BANK>
				<WITHDRAW_ACCOUNT><%=ConvertUtil.toStr(rs.getString("WITHDRAW_ACCOUNT"))%></WITHDRAW_ACCOUNT>
				<PAYMENTS_DATE><%=ConvertUtil.toStr(rs.getString("PAYMENTS_DATE"))%></PAYMENTS_DATE>
				<PAYMENTS_OK><%=ConvertUtil.toStr(rs.getString("PAYMENTS_OK"))%></PAYMENTS_OK>
				<PAYMENTS_REFUSE_REASON><%=ConvertUtil.toStr(rs.getString("PAYMENTS_REFUSE_REASON"))%></PAYMENTS_REFUSE_REASON>
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
	rs2.close();
} catch (Exception ex) {}
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>