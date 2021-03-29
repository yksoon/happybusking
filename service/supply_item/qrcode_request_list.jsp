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
* qr코드 신청현황 리스트
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";


%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT QR.*, T.TEAM_NO, T.TINTRO_IMG, T.TEAM_NAME" + "\r\n" +
				"FROM QR_REQUEST QR, TEAM T, TEAM_MEMBER TM" + "\r\n" +
			   "WHERE TM.USER_NO ='" + USER_NO + "'\r\n" +
				 "AND T.TEAM_NO = QR.TEAM_NO" + "\r\n" +
				 "AND QR.TEAM_NO = TM.TEAM_NO" + "\r\n" +
				 "AND TM.TEAM_NO = T.TEAM_NO" + "\r\n" +
				 "AND QR.QR_PAYMENT_RESULT = 'Y'" + "\r\n" +
			   "ORDER BY QR_REQUEST_DATE DESC" + "\r\n";

		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<QR_REQUEST_NO><%=ConvertUtil.toInteger(rs.getInt("QR_REQUEST_NO"))%></QR_REQUEST_NO>
					<QR_REQUEST_COUNT><%=ConvertUtil.toInteger(rs.getInt("QR_REQUEST_COUNT"))%></QR_REQUEST_COUNT>
					<QR_REQUEST_DATE><%=ConvertUtil.toStr(rs.getString("QR_REQUEST_DATE"))%></QR_REQUEST_DATE>
					<QR_REQUEST_STATE><%=ConvertUtil.toStr(rs.getString("QR_REQUEST_STATE"))%></QR_REQUEST_STATE>
					<QR_PAYMENT_TID><%=ConvertUtil.toStr(rs.getString("QR_PAYMENT_TID"))%></QR_PAYMENT_TID>
					<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
					<TINTRO_IMG><%=ConvertUtil.toStr(rs.getString("TINTRO_IMG"))%></TINTRO_IMG>
					<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
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