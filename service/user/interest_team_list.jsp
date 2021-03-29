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
* 아티스트 정보
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
ResultSet rs2 = null;

boolean result = false;
String msg = "";

String user_no = ParamUtil.getString(request, "user_no", "");
String team_no;

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		//아티스트 정보 및 관심수 COUNT
		sql = "SELECT *, " + "\r\n" +
				"(SELECT COUNT(*) FROM INTEREST WHERE TEAM_NO = I.TEAM_NO) AS CNT, " + "\r\n" +
				"(SELECT TEAM_NAME FROM TEAM WHERE TEAM_NO = I.TEAM_NO) AS TEAM_NAME, " + "\r\n" +
				"(SELECT TINTRO_IMG FROM TEAM WHERE TEAM_NO = I.TEAM_NO) AS TINTRO_IMG " + "\r\n" +
				"FROM INTEREST I " + "\r\n" +
				"WHERE USER_NO = '" + user_no + "'\r\n"+
				"ORDER BY I_REGDATE DESC";
		
		//System.out.println(sql);		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
					<ALARM_CHK><%=ConvertUtil.toInteger(rs.getInt("ALARM_CHK"))%></ALARM_CHK>
					<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT"))%></CNT>
					<TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME"))%></TEAM_NAME>
					<TINTRO_IMG><%=ConvertUtil.toString(rs.getString("TINTRO_IMG"))%></TINTRO_IMG>
				</DATA>
			<%			
			team_no = ConvertUtil.toString(rs.getString("TEAM_NO"));
			
			//System.out.println(ConvertUtil.toInteger(rs.getInt("ALARM_CHK")));
			
			sql2 = "SELECT *, " + "\r\n" + 
					"(SELECT ARTIST_NAME FROM ARTIST WHERE USER_NO = T.USER_NO) AS ARTIST_NAME " + "\r\n" +
					"FROM TEAM_MEMBER T " + "\r\n" +
					"WHERE TEAM_NO = " + team_no;
			
			rs2 = pstmt.executeQuery(sql2);
			
			while(rs2.next()){
				%>
					<DATA2>
						<TEAM_NO><%=ConvertUtil.toStr(rs2.getString("TEAM_NO"))%></TEAM_NO>
						<ARTIST_NAME><%=ConvertUtil.toString(rs2.getString("ARTIST_NAME"))%></ARTIST_NAME>
					</DATA2>
				<%
			}
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