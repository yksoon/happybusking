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
* 해당 공연의 참가 아티스트
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String user_no = ParamUtil.getString(request, "user_no", "");
String team_no = ParamUtil.getString(request, "team_no", "");
String perform_no = ParamUtil.getString(request, "perform_no", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT a.PERFORM_NO, a.TEAM_NO, a.TEAM_NAME, b.CODE_GENRE, b.GENRE_GUBUN, d.USER_NO,d.ARTIST_NAME, b.CODE_AREA, b.TINTRO_VIDEO, b.TEAM_INTRO, a.BUSKINGDATE, a.STARTINGTIME, a.FINISHINGTIME, a.OFFERPRICE, b.TVIDEO_CONTENT, e.BUSINESS_REPRESENTIVE" + "\r\n" +
				"FROM REG_BUSKINGTIME a" + "\r\n" +
				"JOIN team b" + "\r\n" +
                "JOIN team_member c" + "\r\n" +
                "JOIN artist d" + "\r\n" +
				"ON a.TEAM_NO = b.TEAM_NO" + "\r\n" +
				"JOIN business e ON a.USER_NO = e.USER_NO" + "\r\n" +
                "AND b.TEAM_NO = c.TEAM_NO" + "\r\n" +
                "AND c.USER_NO = d.USER_NO" + "\r\n" +
				"WHERE a.USER_NO = " + user_no + "\r\n" +
				"AND c.MEMBER_REQ_STATUS = '2'" + "\r\n" +
                "AND a.team_no = '" + team_no + "'" + "\r\n" +
                "AND a.PERFORM_NO = '" + perform_no + "'";
		
		rs = pstmt.executeQuery(sql);
		
		System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
				<PERFORM_NO><%=ConvertUtil.toString(rs.getString("PERFORM_NO"))%></PERFORM_NO>
                <TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<TEAM_NO><%=ConvertUtil.toString(rs.getString("TEAM_NO"))%></TEAM_NO>
                <CODE_GENRE><%=ConvertUtil.toString(rs.getString("CODE_GENRE"))%></CODE_GENRE>
                <GENRE_GUBUN><%=ConvertUtil.toString(rs.getString("GENRE_GUBUN"))%></GENRE_GUBUN>
                <USER_NO><%=ConvertUtil.toString(rs.getString("USER_NO"))%></USER_NO>
                <ARTIST_NAME><%=ConvertUtil.toString(rs.getString("ARTIST_NAME"))%></ARTIST_NAME>
                <CODE_AREA><%=ConvertUtil.toString(rs.getString("CODE_AREA"))%></CODE_AREA>
                <TINTRO_VIDEO><%=ConvertUtil.toString(rs.getString("TINTRO_VIDEO"))%></TINTRO_VIDEO>
                <TEAM_INTRO><%=ConvertUtil.toString(rs.getString("TEAM_INTRO"))%></TEAM_INTRO>
                <BUSKINGDATE><%=ConvertUtil.toString(rs.getString("BUSKINGDATE"))%></BUSKINGDATE>
                <STARTINGTIME><%=ConvertUtil.toString(rs.getString("STARTINGTIME"))%></STARTINGTIME>
                <FINISHINGTIME><%=ConvertUtil.toString(rs.getString("FINISHINGTIME"))%></FINISHINGTIME>
                <OFFERPRICE><%=ConvertUtil.toString(rs.getString("OFFERPRICE"))%></OFFERPRICE>
                <TVIDEO_CONTENT><%=ConvertUtil.toString(rs.getString("TVIDEO_CONTENT"))%></TVIDEO_CONTENT>
				<BUSINESS_REPRESENTIVE><%=ConvertUtil.toString(rs.getString("BUSINESS_REPRESENTIVE"))%></BUSINESS_REPRESENTIVE>
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