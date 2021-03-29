<?xml version="1.0" encoding="utf-8"?>
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
* 내가 작성한 게시글 목록
*******************************************/
String sql = "";
String sql_content = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String uq_no = ParamUtil.getString(request, "uq_no", "0");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT *" + "\r\n" +
				"FROM USER_QUESTION" + "\r\n" +
				"WHERE UQ_NO = " + uq_no + "\r\n";

		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			%>
				<DATA>
					<UQ_NO><%=ConvertUtil.toInteger(rs.getInt("UQ_NO"))%></UQ_NO>
					<UQ_STATE><%=ConvertUtil.toString(rs.getString("UQ_STATE"))%></UQ_STATE>
					<UQ_TYPE><%=ConvertUtil.toString(rs.getString("UQ_TYPE"))%></UQ_TYPE>
					<UQ_TITLE><%=ConvertUtil.toString(rs.getString("UQ_TITLE"))%></UQ_TITLE>
					<UQ_CONTENT><%=ConvertUtil.toString(rs.getString("UQ_CONTENT"))%></UQ_CONTENT>
					<UQ_REGIDATE><%=ConvertUtil.toString(rs.getString("UQ_REGIDATE"))%></UQ_REGIDATE>
					<%-- <CODE_DECLARE><%=ConvertUtil.toString(rs.getString("CODE_DECLARE"))%></CODE_DECLARE> --%>
				</DATA>	
			<% 
		}
	%>
	</ROOT>	
	<%
	}catch(Exception e){
		e.printStackTrace();
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