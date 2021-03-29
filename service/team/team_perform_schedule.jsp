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

String team_no = ParamUtil.getString(request, "team_no", "");
String Date = ParamUtil.getString(request, "sDate", "");
String sDate = "";
String nDate = "";
if(!Date.equals("")){
	sDate = Date.substring(0, 10);
	nDate = Date.substring(11);
	/* System.out.println(sDate);
	System.out.println(nDate); */
}
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		//아티스트 정보 및 관심수 COUNT
		sql = "SELECT *, (SELECT COUNT(*) FROM INTEREST WHERE TEAM_NO = " + team_no + ") AS CNT " + "\r\n" +  
			  "FROM TEAM " + "\r\n" +
			  "WHERE TEAM_NO = " + team_no;
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			%>
				<DATA>
					<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
					<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT"))%></CNT>
					<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
					<TEAM_INTRO><%=ConvertUtil.toStr(rs.getString("TEAM_INTRO"))%></TEAM_INTRO>
					<TINTRO_IMG><%=ConvertUtil.toStr(rs.getString("TINTRO_IMG"))%></TINTRO_IMG>
				</DATA>	
				
		<% 		
		}

		String sql_content;
		sql2 = "SELECT * ," + "\r\n" +
				"(SELECT COUNT(*) FROM PERFORM WHERE PF_NO = A.PF_NO AND PF_DATE < NOW()) AS PF_DATE_CHK, " + "\r\n" +
				"DAYOFWEEK(PF_DATE) AS Week_n," + "\r\n" +
				"CASE DAYOFWEEK(PF_DATE) " + "\r\n" +
				"WHEN '1' THEN '일'" + "\r\n" +
				"WHEN '2' THEN '월'" + "\r\n" +
				"WHEN '3' THEN '화'" + "\r\n" +
				"WHEN '4' THEN '수'" + "\r\n" +
				"WHEN '5' THEN '목'" + "\r\n" +
				"WHEN '6' THEN '금'" + "\r\n" +
				"WHEN '7' THEN '토'" + "\r\n" +
				"END AS WEEK " + "\r\n" +
				"FROM PERFORM A " + "\r\n";
		
		if(Date == null || Date.equals("")){
			sql_content = "WHERE TEAM_NO = "+ team_no + "\r\n"+
							"ORDER BY CASE WHEN PF_DATE >= NOW() THEN 0 ELSE 1 END, PF_DATE ASC" + "\r\n"+
							"LIMIT 0, 3";
		}
		else{
			sql_content = "WHERE (TEAM_NO  = " + team_no + ") AND \r\n" + 
							"(PF_DATE BETWEEN '" + sDate + "' and '" + nDate + "')" +
							"ORDER BY CASE WHEN PF_DATE >= NOW() THEN 0 ELSE 1 END, PF_DATE ASC" + "\r\n" +
							"LIMIT 0, 3";
		}

		
		sql2 = sql2.concat(sql_content);
		
		rs2 = pstmt.executeQuery(sql2);
		
		//System.out.println(sql2);
		
		while(rs2.next()){
			%>
			<DATA2>
				<PF_NO><%=ConvertUtil.toStr(rs2.getString("PF_NO"))%></PF_NO>
				<PF_IMG><%=ConvertUtil.toString(rs2.getString("PF_IMG"))%></PF_IMG>
				<PF_INTRO><%=ConvertUtil.toString(rs2.getString("PF_INTRO"))%></PF_INTRO>
				<PF_DATE><%=ConvertUtil.toString(rs2.getDate("PF_DATE"))%></PF_DATE>
				<PF_TIME><%=ConvertUtil.toString(rs2.getString("PF_TIME"))%></PF_TIME>
				<CODE_AREA><%=ConvertUtil.toString(rs2.getString("CODE_AREA"))%></CODE_AREA>
				<PF_DETAIL_CONTENT><%=ConvertUtil.toString(rs2.getString("PF_DETAIL_CONTENT"))%></PF_DETAIL_CONTENT>
				<WEEK><%=ConvertUtil.toString(rs2.getString("WEEK"))%></WEEK>
				<PF_PLACE><%=ConvertUtil.toStr(rs2.getString("PF_PLACE"))%></PF_PLACE>
				<PF_DATE_CHK><%=ConvertUtil.toInteger(rs2.getInt("PF_DATE_CHK"))%></PF_DATE_CHK>
				<PF_CANCLE><%=ConvertUtil.toInteger(rs2.getInt("PF_CANCLE")) %></PF_CANCLE>
			</DATA2>
			
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
	rs2.close();
} catch (Exception ex) {}
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>