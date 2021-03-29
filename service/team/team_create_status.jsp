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
* 회원정보 수정 
*******************************************/
String sql = "";
String sql2 = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
ResultSet rs2 = null;

boolean result = false;
String msg = "";

//세션 Parameter
String user_no = ParamUtil.getString(request, "user_no", "");
String team_no;

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT *, " + "\r\n" +
				"(SELECT TEAM_NAME FROM TEAM T WHERE T.TEAM_NO = TM.TEAM_NO) AS TEAM_NAME " + "\r\n" +
				"FROM TEAM_MEMBER TM " + "\r\n" +
				"WHERE TM.USER_NO = '" + user_no + "'\r\n" +
				"AND MEMBER_REQ_STATUS NOT IN (3, 4)" + "\r\n" +
				"ORDER BY TEAM_NO DESC"; 
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
		%>
			<DATA>
				<TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
				<LEADER_CHK><%=ConvertUtil.toString(rs.getString("LEADER_CHK"))%></LEADER_CHK>
			</DATA>
		<% 	
			team_no = ConvertUtil.toString(rs.getString("TEAM_NO"));
				
			sql2 = "SELECT * " + "\r\n" +
					"FROM TEAM_MEMBER TM " + "\r\n" +
					"JOIN ARTIST A ON TM.USER_NO = A.USER_NO " + "\r\n" +
					"WHERE TM.TEAM_NO = " + team_no  + "\r\n" +
					"AND MEMBER_REQ_STATUS NOT IN (4)";
			
			rs2 = pstmt.executeQuery(sql2);
			
			while(rs2.next()){
			%>
				<DATA2>
					<TEAM_NO><%=ConvertUtil.toStr(rs2.getString("TEAM_NO"))%></TEAM_NO>
					<USER_NO><%=ConvertUtil.toString(rs2.getString("USER_NO")) %></USER_NO>
					<ARTIST_NAME><%=ConvertUtil.toString(rs2.getString("ARTIST_NAME"))%></ARTIST_NAME>
					<MEMBER_REQ_STATUS><%=ConvertUtil.toString(rs2.getString("MEMBER_REQ_STATUS"))%></MEMBER_REQ_STATUS>
					<ARTIST_IMG><%=ConvertUtil.toString(rs2.getString("ARTIST_IMG"))%></ARTIST_IMG>
					<CODE_GENRE><%=ConvertUtil.toString(rs2.getString("CODE_GENRE"))%></CODE_GENRE>
					<USE_TOOL><%=ConvertUtil.toString(rs2.getString("USE_TOOL"))%></USE_TOOL>
				</DATA2>
			<%
			}
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
	rs2.close();
} catch (Exception ex) {}
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>