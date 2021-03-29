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
* QR코드 신청(insert)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//지원물품 등록  Parameter 
String team_no =  ParamUtil.getString(request, "team_no", "");
String qrtype =  ParamUtil.getString(request, "qrtype", "");
String addr = ParamUtil.getString(request, "addr", "");
String zip_code = ParamUtil.getString(request, "zip_code", "");
String detail_addr = ParamUtil.getString(request, "detail_addr", "");
String qr_video_share = ParamUtil.getString(request, "qr_video_share", "");

String name = ParamUtil.getString(request, "name", "");
String tel = ParamUtil.getString(request, "tel", "");
String email = ParamUtil.getString(request, "email", "");
String price = ParamUtil.getString(request, "price", "");
String paymethod = ParamUtil.getString(request, "paymethod", "");
String productcode = ParamUtil.getString(request, "productcode", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		//추후에 유료화시, 꼭 PAYMENT_RESULT 부분 N 으로 변경
		
		sql = "INSERT INTO" + "\r\n" +  
				"QR_REQUEST(TEAM_NO, USER_NO, POSTCODE, ADDR, DETAIL_ADDR, QR_REQUEST_COUNT, QR_REQUEST_DATE, QR_VIDEO_SHARE, QR_PAYMENT_NAME, QR_PAYMENT_TEL, QR_PAYMENT_EMAIL, QR_PAYMENT_PRICE, QR_PAYMENT_DATE, QR_PAYMENT_METHOD, QR_PAYMENT_RESULT, QR_PAYMENT_PRODUCTCODE, QRTYPE)" + "\r\n" +
				"VALUES( " + team_no + "," + "'{user_no}'," + "'{postcode}'," + "'{addr}'," + "'{detail_addr}'," +  "\r\n" 
				+ 1 + ", NOW(), '{qr_video_share}', '{name}', '{tel}', '{email}', '{price}', now(), '{paymethod}', 'Y', '{productcode}', '{qrtype}')" + "\r\n";  
		
		
		sql = sql.replace("{user_no}", USER_NO);
		sql = sql.replace("{postcode}", zip_code);
		sql = sql.replace("{addr}", addr);
		sql = sql.replace("{detail_addr}", detail_addr);
		sql = sql.replace("{qr_video_share}", qr_video_share);
		
		sql = sql.replace("{name}", name);
		sql = sql.replace("{tel}", tel);
		sql = sql.replace("{email}", email);
		sql = sql.replace("{price}", price);
		sql = sql.replace("{paymethod}", paymethod);
		sql = sql.replace("{productcode}", productcode);
		sql = sql.replace("{qrtype}", qrtype);
		
				
		pstmt.executeUpdate(sql);	
 
		result = true;
		msg = "QR코드 신청 성공";
				 	

	}catch(Exception e){
		result = false;
		msg = "QR코드 신청 실패";
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