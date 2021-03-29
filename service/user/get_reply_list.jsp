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
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT *" + "\r\n" +
				"FROM BOARD_REPLY" + "\r\n" +
				"JOIN BOARD ON BOARD_REPLY.BOARD_NO = BOARD.BOARD_NO" + "\r\n" +
				"WHERE BOARD_REPLY.USER_NO = '" + user_no + "'\r\n"+
				"ORDER BY BOARD_REPLY_DATE DESC" + "\r\n" +
				"LIMIT " + board_count + ", 10" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<BOARD_NO><%=ConvertUtil.toInteger(rs.getInt("BOARD_NO"))%></BOARD_NO>
					<BOARD_TITLE><%=ConvertUtil.toString(rs.getString("BOARD_TITLE"))%></BOARD_TITLE>
					<BOARD_CATEGORY><%=ConvertUtil.toString(rs.getString("BOARD_CATEGORY"))%></BOARD_CATEGORY>
					<BOARD_DEL><%=ConvertUtil.toString(rs.getString("BOARD_DEL"))%></BOARD_DEL>
					<BOARD_REPLY_CONTENT><%=ConvertUtil.toString(rs.getString("BOARD_REPLY_CONTENT"))%></BOARD_REPLY_CONTENT>
					<BOARD_REPLY_DEL><%=ConvertUtil.toString(rs.getString("BOARD_REPLY_DEL"))%></BOARD_REPLY_DEL>
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