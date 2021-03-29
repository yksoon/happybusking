<%-- <?xml version="1.0" encoding="utf-8"?>
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
* UQ_QUESTION LIST(SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String uq_no = ParamUtil.getString(request, "", "");



%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT UQ.*," + "\r\n" +
		"(SELECT U.NICKNAME FROM USER U WHERE U.USER_NO = UQ.UQ_USER_NO) AS NICKNAME" + "\r\n" +
		"FROM USER_QUESTION UQ"+ "\r\n" +
		"WHERE ISNULL(UQ_PARENT) AND UQ_DEL='N'";
		 
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<UQ_NO><%=ConvertUtil.toInteger(rs.getInt("UQ_NO")) %></UQ_NO>
				<UQ_USER_NO><%=ConvertUtil.toInteger(rs.getInt("UQ_USER_NO")) %></UQ_USER_NO>
				<UQ_STATE><%=ConvertUtil.toStr(rs.getString("UQ_STATE")) %></UQ_STATE>
				<UQ_TYPE><%=ConvertUtil.toStr(rs.getString("UQ_TYPE")) %></UQ_TYPE>
				<UQ_TITLE><%=ConvertUtil.toStr(rs.getString("UQ_TITLE"))%></UQ_TITLE>
				<UQ_CONTENT><%=ConvertUtil.toStr(rs.getString("UQ_CONTENT"))%></UQ_CONTENT>
				<UQ_REGIDATE><%=ConvertUtil.toStr(rs.getString("UQ_REGIDATE"))%></UQ_REGIDATE>
				<UQ_PARENT><%=ConvertUtil.toInteger(rs.getInt("UQ_PARENT"))%></UQ_PARENT>
				<UQ_DEL><%=ConvertUtil.toStr(rs.getString("UQ_DEL"))%></UQ_DEL>
				<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME")) %></NICKNAME>
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
%> --%>