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
* 공연일정 정보
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
ResultSet rs2 = null;

boolean result = false;
String msg = "";

String user_no = ParamUtil.getString(request, "user_no", "0");
String start = ParamUtil.getString(request, "start", "0");
String team_no;
//System.out.println("user_no = " + user_no);
%>
<ROOT>
<%
try{
	conn = dbconn.dbconnect();
	pstmt = conn.createStatement();
	
	//아티스트 정보 및 관심수 COUNT
	sql = "SELECT R.PF_NO, R.RECORD_CHK, P.*," + "\r\n" + 
			"CASE DAYOFWEEK(P.PF_DATE)"+ "\r\n" +
			"WHEN '1' THEN '일'"+ "\r\n" +
			"WHEN '2' THEN '월'"+ "\r\n" +
			"WHEN '3' THEN '화'"+ "\r\n" +
			"WHEN '4' THEN '수'"+ "\r\n" +
			"WHEN '5' THEN '목'"+ "\r\n" +
			"WHEN '6' THEN '금'"+ "\r\n" +
			"WHEN '7' THEN '토'"+ "\r\n" +
			"END AS WEEK"+ "\r\n" +
			"FROM USER_PERFORM_RECORD R"+ "\r\n" +
			"JOIN PERFORM P on P.PF_NO = R.PF_NO"+" \r\n" +
			"WHERE R.USER_NO ='"+ user_no+ "'\r\n" +
			"ORDER BY PF_DATE DESC, PF_TIME DESC" + "\r\n" +
			"LIMIT "+ start +" , 5";
	
	//System.out.println(sql);		
	rs = pstmt.executeQuery(sql);
	
	while(rs.next()){
	%>
		<DATA>
				<PF_NO><%=ConvertUtil.toStr(rs.getString("PF_NO")) %></PF_NO>
				<RECORD_CHK><%=ConvertUtil.toStr(rs.getString("RECORD_CHK"))%></RECORD_CHK>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
				<PF_IMG><%=ConvertUtil.toString(rs.getString("PF_IMG"))%></PF_IMG>
				<PF_INTRO><%=ConvertUtil.toStr(rs.getString("PF_INTRO")) %></PF_INTRO>
				<PF_DATE><%=ConvertUtil.toStr(rs.getString("PF_DATE")) %></PF_DATE>
				<PF_TIME><%=ConvertUtil.toStr(rs.getString("PF_TIME")) %></PF_TIME>
				<CODE_AREA><%=ConvertUtil.toStr(rs.getString("CODE_AREA")) %></CODE_AREA>
				<PF_PLACE><%=ConvertUtil.toStr(rs.getString("PF_PLACE"))%></PF_PLACE>
				<PF_LATLNG><%=ConvertUtil.toStr(rs.getString("PF_LATLNG"))%></PF_LATLNG>
				<PF_ADDR><%=ConvertUtil.toStr(rs.getString("PF_ADDR"))%></PF_ADDR>
				<PF_DETAIL_CONTENT><%=ConvertUtil.toStr(rs.getString("PF_DETAIL_CONTENT")) %></PF_DETAIL_CONTENT>
				<WEEK><%=ConvertUtil.toStr(rs.getString("WEEK"))%></WEEK>
				<CODE_GENRE><%=ConvertUtil.toStr(rs.getString("CODE_GENRE"))%></CODE_GENRE>
			<%
				team_no = ConvertUtil.toString(rs.getString("TEAM_NO"));
			
				sql2 = "SELECT TEAM_NO,TEAM_NAME " + "\r\n" +
						"FROM TEAM " + "\r\n" +
						"WHERE TEAM_NO = " + team_no;
				
				rs2 = pstmt.executeQuery(sql2);
				//System.out.println(sql2);
				
				if(rs2.next()){
			%>
					<TEAM_NAME><%=ConvertUtil.toStr(rs2.getString("TEAM_NAME"))%></TEAM_NAME>
			<%
				}
			%>
		</DATA>
		<%
	}
%>
</ROOT>
<%
} catch(Exception e){
	e.getStackTrace();
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