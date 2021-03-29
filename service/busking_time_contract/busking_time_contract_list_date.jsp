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
* 공연 신청/계약 이력
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String user_no = ParamUtil.getString(request, "user_no", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT * " + "\r\n" +
				"FROM REG_BUSKINGTIME a" + "\r\n" +
				"JOIN team b" + "\r\n" +
				"ON a.TEAM_NO = b.TEAM_NO" + "\r\n" +
				"WHERE USER_NO = " + user_no;
				
		
		rs = pstmt.executeQuery(sql);
		
		System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
				<PERFORM_NO><%=ConvertUtil.toString(rs.getString("PERFORM_NO"))%></PERFORM_NO>
				<BUSKINGDATE><%=ConvertUtil.toString(rs.getString("BUSKINGDATE")) %></BUSKINGDATE>
                <STARTINGTIME><%=ConvertUtil.toString(rs.getString("STARTINGTIME")) %></STARTINGTIME>
                <FINISHINGTIME><%=ConvertUtil.toString(rs.getString("FINISHINGTIME")) %></FINISHINGTIME>
                <DAYOFTHEWEEK><%=ConvertUtil.toString(rs.getString("DAYOFTHEWEEK")) %></DAYOFTHEWEEK>
                <OFFERPRICE><%=ConvertUtil.toString(rs.getInt("OFFERPRICE")) %></OFFERPRICE>
                <TEAM_NO><%=ConvertUtil.toString(rs.getString("TEAM_NO")) %></TEAM_NO>
                <TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME")) %></TEAM_NAME>
				<BUSKINGSTATUS><%=ConvertUtil.toString(rs.getString("BUSKINGSTATUS")) %></BUSKINGSTATUS>
				<TINTRO_IMG><%=ConvertUtil.toString(rs.getString("TINTRO_IMG")) %></TINTRO_IMG>
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