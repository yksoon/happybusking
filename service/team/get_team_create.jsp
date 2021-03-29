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
* 팀 신청 정보 
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
String team_no = ParamUtil.getString(request, "team_no", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT * " + "\r\n" +
				"FROM TEAM " + "\r\n" +
				"WHERE TEAM_NO = " + team_no; 
		
		rs = pstmt.executeQuery(sql);
		
		//System.out.println(sql);
		
		while(rs.next()){
		%>
			<DATA>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
				<TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<TEAM_INTRO><%=ConvertUtil.toString(rs.getString("TEAM_INTRO"))%></TEAM_INTRO>
				<TEAM_PAY><%=ConvertUtil.toString(rs.getString("TEAM_PAY"))%></TEAM_PAY>
				<CODE_GENRE><%=ConvertUtil.toString(rs.getString("CODE_GENRE"))%></CODE_GENRE>
				<MAIN_GENRE><%=ConvertUtil.toString(rs.getString("MAIN_GENRE"))%></MAIN_GENRE>
				<GENRE_GUBUN><%=ConvertUtil.toString(rs.getString("GENRE_GUBUN"))%></GENRE_GUBUN>
				<CODE_AREA><%=ConvertUtil.toString(rs.getString("CODE_AREA"))%></CODE_AREA>
				<TINTRO_IMG><%=ConvertUtil.toString(rs.getString("TINTRO_IMG"))%></TINTRO_IMG>
				<TVIDEO_THUMBNAIL><%=ConvertUtil.toString(rs.getString("TVIDEO_THUMBNAIL"))%></TVIDEO_THUMBNAIL>
				<TINTRO_VIDEO><%=ConvertUtil.toString(rs.getString("TINTRO_VIDEO"))%></TINTRO_VIDEO>
				<TVIDEO_CONTENT><%=ConvertUtil.toString(rs.getString("TVIDEO_CONTENT"))%></TVIDEO_CONTENT>
			</DATA>
		<% 	
			team_no = ConvertUtil.toString(rs.getString("TEAM_NO"));
				
			sql2 = "SELECT * " + "\r\n" +
					"FROM TEAM_MEMBER TM " + "\r\n" +
					"JOIN ARTIST A ON TM.USER_NO = A.USER_NO " + "\r\n" +
					"WHERE TM.TEAM_NO = " + team_no + "\r\n" +
					"AND MEMBER_REQ_STATUS IN(2, 1)";
			
			rs2 = pstmt.executeQuery(sql2);
			
			//System.out.println(sql2);
			
			while(rs2.next()){
			%>
				<DATA2>
					<USER_NO><%=ConvertUtil.toString(rs2.getString("USER_NO")) %></USER_NO>
					<ARTIST_NAME><%=ConvertUtil.toString(rs2.getString("ARTIST_NAME"))%></ARTIST_NAME>
					<ARTIST_IMG><%=ConvertUtil.toString(rs2.getString("ARTIST_IMG"))%></ARTIST_IMG>
					<CODE_GENRE><%=ConvertUtil.toString(rs2.getString("CODE_GENRE"))%></CODE_GENRE>
					<USE_TOOL><%=ConvertUtil.toString(rs2.getString("USE_TOOL"))%></USE_TOOL>
					<LEADER_CHK><%=ConvertUtil.toString(rs2.getString("LEADER_CHK"))%></LEADER_CHK>
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