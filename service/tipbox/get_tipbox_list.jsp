<?xml version="1.0" encoding="utf-8"?>
<%@page import="com.mysql.fabric.xmlrpc.base.Param"%>
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
* 지역별 공연 검색
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String scName = ParamUtil.getString(request, "scName", "");
String scGenre = ParamUtil.getString(request, "scGenre", "");
String scArea = ParamUtil.getString(request, "scArea", "");
String scLimit = ParamUtil.getString(request, "scLimit", "0");
String scLimitEnd = ParamUtil.getString(request, "scLimitEnd", "20");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT T.TINTRO_IMG,T.TEAM_NO, T.TEAM_NAME, T.CODE_GENRE, T.MAIN_GENRE," + "\r\n" +
				"CEIL((SELECT ROUND(AVG(RATY_STAR),1) FROM EPILOGUE WHERE TEAM_NO = T.TEAM_NO)*2)/2 AS RATY_STAR," + "\r\n" +
				"(SELECT COUNT(*) FROM INTEREST WHERE TEAM_NO = T.TEAM_NO) AS LIKE_COUNT," + "\r\n" +
				"(SELECT PF_DATE FROM PERFORM WHERE TEAM_NO = T.TEAM_NO AND PF_DATE >= NOW() ORDER BY PF_DATE ASC LIMIT 1) AS PF_SCHEDULE" + "\r\n" +
				"FROM TEAM T" + "\r\n" +
				"WHERE T.TEAM_NAME LIKE '%"+scName+"%'" + "\r\n" +
				"AND T.TEAM_NAME <> '해피버스킹'" + "\r\n";
		
		if(!scGenre.equals("")){
			sql = sql.concat("AND T.MAIN_GENRE LIKE '%"+scGenre+"%' \r\n");
		}
		
		if(!scArea.equals("") && !scArea.equals("전국")){
			sql = sql.concat("AND CODE_AREA = '"+scArea+"' \r\n");
		}
		
		sql = sql.concat("ORDER BY RATY_STAR DESC, LIKE_COUNT DESC , TEAM_NO ASC \r\n");
		sql = sql.concat("LIMIT "+scLimit+", " + scLimitEnd+ " \r\n");
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
				<TINTRO_IMG><%=ConvertUtil.toStr(rs.getString("TINTRO_IMG"))%></TINTRO_IMG>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<CODE_GENRE><%=ConvertUtil.toStr(rs.getString("CODE_GENRE"))%></CODE_GENRE>
				<RATY_STAR><%=ConvertUtil.toString(rs.getFloat("RATY_STAR"))%></RATY_STAR>
				<PF_SCHEDULE><%=ConvertUtil.toStr(rs.getString("PF_SCHEDULE"))%></PF_SCHEDULE>
			</DATA>
			<%  
		}
%>
</ROOT>
<%
	}catch(Exception e){
		e.getStackTrace();
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