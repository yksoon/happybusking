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
* 공연상세 답글 리스트 불러오기(SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;


boolean result = false;
String msg = "";

String pf_no = ParamUtil.getString(request, "pf_no", "0");
String parent_no = ParamUtil.getString(request, "parent_no", "0");

//System.out.println("team_no : " + team_no);	
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		

		sql = "SELECT PR.*, U.NICKNAME" + "\r\n" +
				"FROM PERFORM_REPLY PR" + "\r\n" +
				"JOIN USER U ON U.USER_NO = PR.USER_NO" + "\r\n" +
				"WHERE PARENT = " + parent_no + "\r\n"+
				"AND PERFORM_NO = " + pf_no + "\r\n" +
				"AND PERFORM_REPLY_DEL = 'N'";
		
		//System.out.println(sql);
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<PERFORM_REPLY_NO><%=ConvertUtil.toStr(rs.getString("PERFORM_REPLY_NO")) %></PERFORM_REPLY_NO>
					<PERFORM_REPLY_DATE><%=ConvertUtil.toStr(rs.getString("PERFORM_REPLY_DATE")) %></PERFORM_REPLY_DATE>
					<PERFORM_REPLY_CONTENT><%=ConvertUtil.toStr(rs.getString("PERFORM_REPLY_CONTENT")) %></PERFORM_REPLY_CONTENT>
					<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME")) %></NICKNAME>
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