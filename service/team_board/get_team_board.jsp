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
* 게시물 내용 가져오기
*******************************************/
String sql = "";
String sql_content = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String board_no = ParamUtil.getString(request, "board_no", "0");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT *" + "\r\n" +
				"FROM BOARD" + "\r\n" +
				"WHERE BOARD_NO = " + board_no;
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			%>
				<DATA>
					<BOARD_TITLE><%=ConvertUtil.toString(rs.getString("BOARD_TITLE"))%></BOARD_TITLE>
					<BOARD_CONTENT><%=ConvertUtil.toString(rs.getString("BOARD_CONTENT"))%></BOARD_CONTENT>
					<BOARD_CATEGORY><%=ConvertUtil.toString(rs.getString("BOARD_CATEGORY"))%></BOARD_CATEGORY>
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