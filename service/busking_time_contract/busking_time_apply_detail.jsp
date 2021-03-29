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
String sql2 = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String team_no = ParamUtil.getString(request, "team_no", "");
String perform_no = ParamUtil.getString(request, "perform_no", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT a.PERFORM_NO, b.TEAM_NAME, a.TEAM_NO, b.CODE_GENRE, c.ARTIST_NAME, b.CODE_AREA, b.TINTRO_VIDEO, b.TEAM_INTRO, d.BUSKINGDATE, d.STARTINGTIME, d.FINISHINGTIME, d.OFFERPRICE, b.TVIDEO_CONTENT, a.USER_NO, e.BUSINESS_REPRESENTIVE, d.BUSKINGSTATUS" + "\r\n" +
				"FROM reg_perform a" + "\r\n" +
				"JOIN team b ON a.TEAM_NO = b.TEAM_NO" + "\r\n" +
                "JOIN artist c ON a.USER_NO = c.USER_NO" + "\r\n" +
                "JOIN reg_buskingtime d ON a.PERFORM_NO = d.PERFORM_NO" + "\r\n" +
				"JOIN business e ON d.USER_NO = e.USER_NO" + "\r\n" +
				"WHERE a.PERFORM_NO='" + perform_no + "'" + "\r\n" +
                "AND a.TEAM_NO='" + team_no + "'";

		
		rs = pstmt.executeQuery(sql);
		
		// System.out.println(sql);
		System.out.println(perform_no);
		
		while(rs.next()){
        %>
			<DATA>
				<PERFORM_NO><%=ConvertUtil.toString(rs.getString("PERFORM_NO"))%></PERFORM_NO>
                <TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<TEAM_NO><%=ConvertUtil.toString(rs.getString("TEAM_NO"))%></TEAM_NO>
                <CODE_GENRE><%=ConvertUtil.toString(rs.getString("CODE_GENRE"))%></CODE_GENRE>
                <ARTIST_NAME><%=ConvertUtil.toString(rs.getString("ARTIST_NAME"))%></ARTIST_NAME>
                <CODE_AREA><%=ConvertUtil.toString(rs.getString("CODE_AREA"))%></CODE_AREA>
                <TINTRO_VIDEO><%=ConvertUtil.toString(rs.getString("TINTRO_VIDEO"))%></TINTRO_VIDEO>
                <TEAM_INTRO><%=ConvertUtil.toString(rs.getString("TEAM_INTRO"))%></TEAM_INTRO>
                <BUSKINGDATE><%=ConvertUtil.toString(rs.getString("BUSKINGDATE"))%></BUSKINGDATE>
                <STARTINGTIME><%=ConvertUtil.toString(rs.getString("STARTINGTIME"))%></STARTINGTIME>
                <FINISHINGTIME><%=ConvertUtil.toString(rs.getString("FINISHINGTIME"))%></FINISHINGTIME>
                <OFFERPRICE><%=ConvertUtil.toString(rs.getString("OFFERPRICE"))%></OFFERPRICE>
                <TVIDEO_CONTENT><%=ConvertUtil.toString(rs.getString("TVIDEO_CONTENT"))%></TVIDEO_CONTENT>
				<USER_NO><%=ConvertUtil.toString(rs.getString("USER_NO"))%></USER_NO>
				<BUSINESS_REPRESENTIVE><%=ConvertUtil.toString(rs.getString("BUSINESS_REPRESENTIVE"))%></BUSINESS_REPRESENTIVE>
				<BUSKINGSTATUS><%=ConvertUtil.toString(rs.getString("BUSKINGSTATUS"))%></BUSKINGSTATUS>
			</DATA>

		<%	
		}

				sql2 = "SELECT ART_BANK_NAME, ART_BANK_NUMBER, ART_BANK_USER" + "\r\n" +
				"FROM e_contract" + "\r\n" +
				"WHERE PERFORM_NO='" + perform_no + "'" + "\r\n" +
				"AND length(ART_BANK_NAME)>0";

				rs = pstmt.executeQuery(sql2);

				System.out.println(perform_no);

						while(rs.next()){
        %>
			<DATA2>
				<ART_BANK_NAME><%=ConvertUtil.toString(rs.getString("ART_BANK_NAME"))%></ART_BANK_NAME>
                <ART_BANK_NUMBER><%=ConvertUtil.toString(rs.getString("ART_BANK_NUMBER"))%></ART_BANK_NUMBER>
				<ART_BANK_USER><%=ConvertUtil.toString(rs.getString("ART_BANK_USER"))%></ART_BANK_USER>
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
} catch (Exception ex) {}
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>
