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
* 지역별 공연 검색
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String selectGenre = ParamUtil.getString(request, "selectGenre", "0");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT MAIN_GENRE" + "\r\n" +
				"FROM GENRE_CODE_TEST" + "\r\n" +
				"WHERE GENRE_NO IN ("+selectGenre+")" + "\r\n" +
				"GROUP BY MAIN_GENRE" + "\r\n";
				
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<MAIN_GENRE><%=ConvertUtil.toStr(rs.getString("MAIN_GENRE"))%></MAIN_GENRE>
			</DATA>
			<%
		}
		
		sql = "SELECT SUB_GENRE" + "\r\n" +
				"FROM GENRE_CODE_TEST" + "\r\n" +
				"WHERE GENRE_NO IN ("+selectGenre+")" + "\r\n" ;
				
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA2>
				<SUB_GENRE><%=ConvertUtil.toStr(rs.getString("SUB_GENRE"))%></SUB_GENRE>
			</DATA2>
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