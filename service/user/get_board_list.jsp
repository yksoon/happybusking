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

//세션 Parameter
String user_no = ParamUtil.getString(request, "user_no", "0");
String board_count = ParamUtil.getString(request, "board_count", "0");
String sort = ParamUtil.getString(request, "sort", "최신순");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT * ," + "\r\n" +
				"(SELECT COUNT(*) FROM BOARD_REPLY WHERE BOARD_NO = B.BOARD_NO) AS CNT" + "\r\n" +		
				"FROM BOARD B" + "\r\n" +
				"WHERE USER_NO = '" + user_no + "'\r\n";
		
		if(sort.equals("최신순")){
			sql += "ORDER BY BOARD_DATE DESC" + "\r\n" +
					"LIMIT " + board_count + ", 10" + "\r\n";
		}
		else if(sort.equals("댓글순")){
			sql += "ORDER BY CNT DESC" + "\r\n" +
					"LIMIT " + board_count + ", 10" + "\r\n";
		}
		else{
			sql += "LIMIT " + board_count + ", 10" + "\r\n";
		}
		
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<BOARD_NO><%=ConvertUtil.toInteger(rs.getInt("BOARD_NO"))%></BOARD_NO>
					<BOARD_HITS><%=ConvertUtil.toInteger(rs.getInt("BOARD_HITS"))%></BOARD_HITS>
					<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT"))%></CNT>
					<BOARD_TITLE><%=ConvertUtil.toString(rs.getString("BOARD_TITLE"))%></BOARD_TITLE>
					<BOARD_CONTENT><%=ConvertUtil.toString(rs.getString("BOARD_CONTENT"))%></BOARD_CONTENT>
					<BOARD_CATEGORY><%=ConvertUtil.toString(rs.getString("BOARD_CATEGORY"))%></BOARD_CATEGORY>
					<BOARD_DATE><%=ConvertUtil.toString(rs.getString("BOARD_DATE"))%></BOARD_DATE>
					<BOARD_DEL><%=ConvertUtil.toString(rs.getString("BOARD_DEL"))%></BOARD_DEL>
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