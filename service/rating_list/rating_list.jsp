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
		
		sql = "SELECT TEAM_NAME, " + "\r\n" +
				"CEIL((SELECT ROUND(AVG(RATY_STAR),1) FROM EPILOGUE WHERE TEAM_NO = T.TEAM_NO)*2)/2 AS TOTAL_RATY_STAR " + "\r\n" +
				"FROM TEAM T " + "\r\n" +
				"WHERE TEAM_NO = " + team_no;
		
		rs = pstmt.executeQuery(sql);
		
		///System.out.println(sql);
		
		while(rs.next()){
		%>
			<DATA>
				<TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<TOTAL_RATY_STAR><%=ConvertUtil.toString(rs.getFloat("TOTAL_RATY_STAR")) %></TOTAL_RATY_STAR>
			</DATA>
		<% 	
			sql2 = "SELECT *, " + "\r\n" +
					"CEIL((SELECT ROUND(AVG(RATY_STAR),1) FROM EPILOGUE WHERE PF_NO = P.PF_NO)*2)/2 AS RATY_STAR, " + "\r\n" +
					"CASE DAYOFWEEK(PF_DATE) " + "\r\n" +
					"WHEN '1' THEN '일' " + "\r\n" +
					"WHEN '2' THEN '월' " + "\r\n" +
					"WHEN '3' THEN '화' " + "\r\n" +
					"WHEN '4' THEN '수' " + "\r\n" +
					"WHEN '5' THEN '목' " + "\r\n" +
					"WHEN '6' THEN '금' " + "\r\n" +
					"WHEN '7' THEN '토' " + "\r\n" +
					"END AS WEEK, " + "\r\n" +
					"CASE WHEN (PF_DATE > DATE_FORMAT(now(), '%Y-%m-%d') OR (PF_DATE = DATE_FORMAT(now(), '%Y-%m-%d') AND PF_TIME >= DATE_FORMAT(now(), '%H:%i'))) THEN 0 ELSE 1 END AS PF_AF_BE  " + "\r\n" +
					"FROM PERFORM P " + "\r\n" +
					"WHERE TEAM_NO = " + team_no + "\r\n" +
					"ORDER BY PF_AF_BE ASC, PF_DATE DESC";
			
			rs2 = pstmt.executeQuery(sql2);
			
			//System.out.println(sql2);
			
			while(rs2.next()){
			%>
				<DATA2>
					<TEAM_NO><%=ConvertUtil.toStr(rs2.getString("TEAM_NO"))%></TEAM_NO>
					<PF_NO><%=ConvertUtil.toStr(rs2.getString("PF_NO"))%></PF_NO>
					<PF_IMG><%=ConvertUtil.toString(rs2.getString("PF_IMG"))%></PF_IMG>
					<PF_INTRO><%=ConvertUtil.toString(rs2.getString("PF_INTRO"))%></PF_INTRO>
					<PF_DATE><%=ConvertUtil.toString(rs2.getString("PF_DATE"))%></PF_DATE>
					<WEEK><%=ConvertUtil.toString(rs2.getString("WEEK"))%></WEEK>
					<PF_TIME><%=ConvertUtil.toString(rs2.getString("PF_TIME"))%></PF_TIME>
					<PF_PLACE><%=ConvertUtil.toString(rs2.getString("PF_PLACE"))%></PF_PLACE>
					<CODE_AREA><%=ConvertUtil.toString(rs2.getString("CODE_AREA"))%></CODE_AREA>
					<RATY_STAR><%=ConvertUtil.toString(rs2.getFloat("RATY_STAR")) %></RATY_STAR>
					<PF_AF_BE><%=ConvertUtil.toInteger(rs2.getInt("PF_AF_BE"))%></PF_AF_BE>
					<PF_CANCLE><%=ConvertUtil.toInteger(rs2.getInt("PF_CANCLE"))%></PF_CANCLE>
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