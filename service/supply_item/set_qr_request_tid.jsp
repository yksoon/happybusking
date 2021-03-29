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
* 후원 완료 정보 가져오기
*******************************************/
String sql = "";
String sql2 = "";

Connection conn = null;
Statement pstmt = null;
PreparedStatement pstmt2 = null;

ResultSet rs = null;

String team_no = ParamUtil.getString(request, "team_no", "0");
String tid = ParamUtil.getString(request, "tid", "0");
String amt = ParamUtil.getString(request, "amt", "0");
int qr_request_no = 0;

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT QR.* , " + "\r\n" +
				"(SELECT TEAM_NAME FROM TEAM WHERE TEAM_NO = QR.TEAM_NO) AS TEAM_NAME" + "\r\n" +
				"FROM QR_REQUEST QR " + "\r\n" +
				"WHERE QR.USER_NO = " + USER_NO + "\r\n" +
				"AND QR.TEAM_NO = " + team_no + "\r\n" +
				"ORDER BY QR.QR_REQUEST_NO DESC " + "\r\n" +
				"LIMIT 1";
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			qr_request_no = ConvertUtil.toInteger(rs.getInt("QR_REQUEST_NO"));
			%>
			<DATA>
				<QR_REQUEST_NO><%=ConvertUtil.toInteger(rs.getInt("QR_REQUEST_NO"))%></QR_REQUEST_NO>
			</DATA>
			<%  
		}
		
		
		if(qr_request_no != 0){
			sql2 = "UPDATE QR_REQUEST" + "\r\n" +
					"SET QR_PAYMENT_RESULT = 'Y'" + "\r\n" +
					", QR_PAYMENT_TID = ?" + "\r\n" +
					"WHERE QR_REQUEST_NO = ?";
			
			pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, tid);
			pstmt2.setInt(2, qr_request_no);
			pstmt2.executeUpdate();
			
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
	if(pstmt2 != null){
		pstmt2.close();
	}
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>