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
* 공연 신청 상세보기
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String user_no = ParamUtil.getString(request, "user_no", "");
String perform_no = ParamUtil.getString(request, "perform_no", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT a.PERFORM_NO, e.TEAM_NAME, e.TEAM_NO, d.ARTIST_NAME, b.BUSKINGDATE, b.STARTINGTIME, b.FINISHINGTIME, a.USER_NO, c.BUSINESS_WORKNAME, a.OFFERPRICE, a.PERSONAL_PRICE,f.CONTRACT_STATUS, b.BUSKINGSTATUS," + "\r\n" +
				"(SELECT ARTIST_NAME FROM artist WHERE USER_NO = b.END_PERFORM_USER_NO) AS END_PERFORM_ART, " + "\r\n" +
				"b.END_PERFORM_DATE, b.END_PERFORM_USER_NO, f.CONTRACT_PRICE" + "\r\n" +
				"FROM reg_perform a" + "\r\n" +
				"JOIN reg_buskingtime b" + "\r\n" +
                "ON a.PERFORM_NO = b.PERFORM_NO" + "\r\n" +
                "JOIN business c" + "\r\n" +
				"ON b.USER_NO = c.USER_NO" + "\r\n" +
                "JOIN artist d" + "\r\n" +
                "ON a.USER_NO = d.USER_NO" + "\r\n" +
                "JOIN team e" + "\r\n" +
                "ON a.TEAM_NO = e.TEAM_NO" + "\r\n" +
                "LEFT JOIN e_contract f" + "\r\n" +
                "ON f.PERFORM_NO = a.PERFORM_NO AND f.USER_NO = a.USER_NO" + "\r\n" +
                "WHERE a.TEAM_NO = " + "\r\n" +
                "(SELECT team_no FROM team_member WHERE user_no= '" + user_no + "' LIMIT 1)" + "\r\n" +
                "AND a.PERFORM_NO = '" + perform_no + "'";

		
		rs = pstmt.executeQuery(sql);
		
		System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
				<PERFORM_NO><%=ConvertUtil.toString(rs.getString("PERFORM_NO"))%></PERFORM_NO>
                <TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<TEAM_NO><%=ConvertUtil.toString(rs.getString("TEAM_NO"))%></TEAM_NO>
                <ARTIST_NAME><%=ConvertUtil.toString(rs.getString("ARTIST_NAME"))%></ARTIST_NAME>
                <BUSKINGDATE><%=ConvertUtil.toString(rs.getString("BUSKINGDATE"))%></BUSKINGDATE>
                <STARTINGTIME><%=ConvertUtil.toString(rs.getString("STARTINGTIME"))%></STARTINGTIME>
                <FINISHINGTIME><%=ConvertUtil.toString(rs.getString("FINISHINGTIME"))%></FINISHINGTIME>
                <USER_NO><%=ConvertUtil.toString(rs.getString("USER_NO"))%></USER_NO>
                <BUSINESS_WORKNAME><%=ConvertUtil.toString(rs.getString("BUSINESS_WORKNAME"))%></BUSINESS_WORKNAME>
                <OFFERPRICE><%=ConvertUtil.toString(rs.getString("OFFERPRICE"))%></OFFERPRICE>
                <PERSONAL_PRICE><%=ConvertUtil.toString(rs.getString("PERSONAL_PRICE"))%></PERSONAL_PRICE>
                <CONTRACT_STATUS><%=ConvertUtil.toString(rs.getString("CONTRACT_STATUS"))%></CONTRACT_STATUS>
				<BUSKINGSTATUS><%=ConvertUtil.toString(rs.getString("BUSKINGSTATUS"))%></BUSKINGSTATUS>
				<END_PERFORM_ART><%=ConvertUtil.toString(rs.getString("END_PERFORM_ART"))%></END_PERFORM_ART>
				<END_PERFORM_DATE><%=ConvertUtil.toString(rs.getString("END_PERFORM_DATE"))%></END_PERFORM_DATE>
				<END_PERFORM_USER_NO><%=ConvertUtil.toString(rs.getString("END_PERFORM_USER_NO"))%></END_PERFORM_USER_NO>
				<CONTRACT_PRICE><%=ConvertUtil.toString(rs.getString("CONTRACT_PRICE"))%></CONTRACT_PRICE>
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

