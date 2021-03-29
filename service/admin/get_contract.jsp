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
		
		sql = "SELECT a.*, b.ADDRESS" + "\r\n" +
				"FROM business a" + "\r\n" +
				"JOIN store b ON a.USER_NO = b.USER_NO" + "\r\n" +
				"WHERE a.CONSIGNMENT_AGREE = 'Y'";
		
		//System.out.println(sql);
				
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<BUSINESS_NO><%=ConvertUtil.toStr(rs.getString("BUSINESS_NO"))%></BUSINESS_NO>
				<BUSINESS_WORKNAME><%=ConvertUtil.toStr(rs.getString("BUSINESS_WORKNAME"))%></BUSINESS_WORKNAME>
				<BUSINESS_REPRESENTIVE><%=ConvertUtil.toStr(rs.getString("BUSINESS_REPRESENTIVE"))%></BUSINESS_REPRESENTIVE>
				<BUSINESS_PHONE><%=ConvertUtil.toStr(rs.getString("BUSINESS_PHONE"))%></BUSINESS_PHONE>
				<BUSINESS_REGIST_NO><%=ConvertUtil.toStr(rs.getString("BUSINESS_REGIST_NO"))%></BUSINESS_REGIST_NO>
				<ADDRESS><%=ConvertUtil.toStr(rs.getString("ADDRESS"))%></ADDRESS>
                <BUSINESS_LICENSE><%=ConvertUtil.toStr(rs.getString("BUSINESS_LICENSE"))%></BUSINESS_LICENSE>
                <USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO"))%></USER_NO>
                <CONSIGNMENT_AGREE_ADMIN><%=ConvertUtil.toStr(rs.getString("CONSIGNMENT_AGREE_ADMIN"))%></CONSIGNMENT_AGREE_ADMIN>
                <RETURN_CODE><%=ConvertUtil.toStr(rs.getString("RETURN_CODE"))%></RETURN_CODE>
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