<?xml version="1.0" encoding="utf-8"?>
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
* QR코드 신청 취소(update)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;

//QR코드 신청 취소  Parameter 

String tid = ParamUtil.getString(request, "tid", "0");
String msg = ParamUtil.getString(request, "msg", "0");
String date = ParamUtil.getString(request, "date", "0");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
	
 			sql = "UPDATE QR_REQUEST" + "\r\n" +
 				  "SET QR_PAYMENT_RESULT = 'N', QR_PAYMENT_CANCEL_MSG = '"+msg+"', QR_PAYMENT_CANCEL_DATE='"+date+"'" + "\r\n" +
 		 		   "WHERE QR_PAYMENT_TID = '" + tid + "'\r\n";

			pstmt.executeUpdate(sql);	
			
			result = true;

	}catch(Exception e){
		result = false;
		e.printStackTrace();
	}
%>	
		<DATA>
			<RESULT><%=String.valueOf(result)%></RESULT>
			<MESSAGE><%=msg%></MESSAGE>
		</DATA>
	</ROOT> 
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