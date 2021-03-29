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
* 계약서 데이터 불러오기
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String perform_no = ParamUtil.getString(request, "perform_no", "");
String user_no = ParamUtil.getString(request, "user_no", "");
%>
<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

        sql = "SELECT a.CONTRACT_NO, a.CONTRACT_EMPLOYER, a.CONTRACT_ARTIST, d.BUSINESS_WORKNAME, b.BUSKINGDATE," + "\r\n" +
                    "c.ADDRESS, b.STARTINGTIME, b.FINISHINGTIME, a.CONTRACT_PRICE, a.ART_BANK_NAME, a.ART_BANK_NUMBER, a.ART_BANK_USER,"  + "\r\n" +
                    "a.CONTRACT_DATE, a.CONTRACT_RESIDENT_REG_NUM, a.CONTRACT_ARTIST_ADDR, a.EMP_SIGN, a.ARTIST_SIGN,"  + "\r\n" +
                    "TIME_TO_SEC(TIMEDIFF(b.FINISHINGTIME, b.STARTINGTIME)) DIV 60 AS PERFORM_MIN"  + "\r\n" +
                    "FROM e_contract AS a"  + "\r\n" +
                    "JOIN reg_buskingtime AS b ON a.PERFORM_NO = b.PERFORM_NO"  + "\r\n" +
                    "JOIN store AS c ON b.USER_NO = c.USER_NO"  + "\r\n" +
                    "JOIN business AS d ON b.USER_NO = d.USER_NO"  + "\r\n" +
                    "WHERE "  + "\r\n" +
                    "a.PERFORM_NO = '" + perform_no + "'";
        

        		rs = pstmt.executeQuery(sql);
		
		// System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
                <CONTRACT_NO><%=ConvertUtil.toString(rs.getString("CONTRACT_NO")) %></CONTRACT_NO>
                <CONTRACT_EMPLOYER><%=ConvertUtil.toString(rs.getString("CONTRACT_EMPLOYER")) %></CONTRACT_EMPLOYER>
                <CONTRACT_ARTIST><%=ConvertUtil.toString(rs.getString("CONTRACT_ARTIST")) %></CONTRACT_ARTIST>
                <BUSINESS_WORKNAME><%=ConvertUtil.toString(rs.getString("BUSINESS_WORKNAME")) %></BUSINESS_WORKNAME>
                <BUSKINGDATE><%=ConvertUtil.toString(rs.getString("BUSKINGDATE")) %></BUSKINGDATE>
                <ADDRESS><%=ConvertUtil.toString(rs.getString("ADDRESS")) %></ADDRESS>
                <STARTINGTIME><%=ConvertUtil.toString(rs.getString("STARTINGTIME")) %></STARTINGTIME>
                <FINISHINGTIME><%=ConvertUtil.toString(rs.getString("FINISHINGTIME")) %></FINISHINGTIME>
                <CONTRACT_PRICE><%=ConvertUtil.toString(rs.getString("CONTRACT_PRICE")) %></CONTRACT_PRICE>
                <ART_BANK_NAME><%=ConvertUtil.toString(rs.getString("ART_BANK_NAME")) %></ART_BANK_NAME>
                <ART_BANK_NUMBER><%=ConvertUtil.toString(rs.getString("ART_BANK_NUMBER")) %></ART_BANK_NUMBER>
                <ART_BANK_USER><%=ConvertUtil.toString(rs.getString("ART_BANK_USER")) %></ART_BANK_USER>
                <CONTRACT_DATE><%=ConvertUtil.toString(rs.getString("CONTRACT_DATE")) %></CONTRACT_DATE>
                <CONTRACT_RESIDENT_REG_NUM><%=ConvertUtil.toString(rs.getString("CONTRACT_RESIDENT_REG_NUM")) %></CONTRACT_RESIDENT_REG_NUM>
                <CONTRACT_ARTIST_ADDR><%=ConvertUtil.toString(rs.getString("CONTRACT_ARTIST_ADDR")) %></CONTRACT_ARTIST_ADDR>
                <EMP_SIGN><%=ConvertUtil.toString(rs.getString("EMP_SIGN")) %></EMP_SIGN>
                <ARTIST_SIGN><%=ConvertUtil.toString(rs.getString("ARTIST_SIGN")) %></ARTIST_SIGN>
                <PERFORM_MIN><%=ConvertUtil.toString(rs.getString("PERFORM_MIN")) %></PERFORM_MIN>
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