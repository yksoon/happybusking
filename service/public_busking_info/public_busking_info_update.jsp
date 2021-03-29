<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.io.File"%>
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
* 공공 버스킹 정보 게시글 수정(UPDATE)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String no = ParamUtil.getString(request, "no", "0"); 
String pbiThumnailImg = ParamUtil.getString(request, "pbiThumnailImg", "");
String pbiMainImg = ParamUtil.getString(request, "pbiMainImg", "");
String pbiTitle = ParamUtil.getString(request, "pbiTitle", "");
String pbiEventSdate = ParamUtil.getString(request, "pbiEventSdate", "");
String pbiEventEdate = ParamUtil.getString(request, "pbiEventEdate", "");
String pbiReceiptSdate = ParamUtil.getString(request, "pbiReceiptSdate", "");
String pbiReceiptEdate = ParamUtil.getString(request, "pbiReceiptEdate", "");
String pbiGenre = ParamUtil.getString(request, "pbiGenre", "");
String pbiGenreCode = ParamUtil.getString(request, "pbiGenreCode", "");
String pbiPersonner = ParamUtil.getString(request, "pbiPersonner", "");
String pbiPersonner_min = ParamUtil.getString(request, "pbiPersonner_min", "");
String pbiPay = ParamUtil.getString(request, "pbiPay", "");
String pbiPayMax = ParamUtil.getString(request, "pbiPayMax", "");
String pbiAddress = ParamUtil.getString(request, "pbiAddress", "");
String pbiDetailaddress = ParamUtil.getString(request, "pbiDetailaddress", "");
String pbiLatlng = ParamUtil.getString(request, "pbiLatlng", "");
String pbiContent = ParamUtil.getString(request, "pbiContent", "");
String pbiManager = ParamUtil.getString(request, "pbiManager", "");
String pbiTel = ParamUtil.getString(request, "pbiTel", "");
String pbiEmail = ParamUtil.getString(request, "pbiEmail", "");
String pbiNoPay = ParamUtil.getString(request, "pbiNoPay", "");
String pbiTransportation = ParamUtil.getString(request, "pbiTransportation", "");
String hallImg = ParamUtil.getString(request, "hallImg", "");
String productImg = ParamUtil.getString(request, "productImg", "");

%>
	

<%
	try{
		conn = dbconn.dbconnect();
		/* System.out.println(no);
		System.out.println(pbiThumnailImg);
		System.out.println(pbiMainImg);
		System.out.println(pbiTitle);
		System.out.println(pbiEventSdate);
		System.out.println(pbiEventEdate);
		System.out.println(pbiReceiptSdate);
		System.out.println(pbiReceiptEdate);
		System.out.println(pbiGenre);
		System.out.println(pbiGenreCode);
		System.out.println(pbiPersonner);
		System.out.println(pbiPersonner_min);
		System.out.println(pbiPay);
		System.out.println(pbiPayMax);
		System.out.println(pbiAddress);
		System.out.println(pbiDetailaddress);
		System.out.println(pbiLatlng);
		System.out.println(pbiContent);
		System.out.println(pbiManager);
		System.out.println(pbiTel);
		System.out.println(pbiEmail);
		System.out.println(pbiNoPay);
		System.out.println(pbiTransportation);
		System.out.println(hallImg);
		System.out.println(productImg); */
		 
		/*System.out.println(bz_name);
		System.out.println(bz_image_text);
		System.out.println(bz_address);
		System.out.println(bz_detailaddr);
		System.out.println(bz_url);
		System.out.println(bz_contact);
		System.out.println(bz_content);*/
		
		sql = "update public_busking_info" + "\r\n" +	
				"set PBI_THUMNAIL_IMG=?, PBI_MAIN_IMG=?, PBI_TITLE=?, PBI_EVENT_SDATE=?, PBI_EVENT_EDATE=?, PBI_RECEIPT_SDATE=?, PBI_RECEIPT_EDATE=?," + "\r\n" +
				"PBI_GENRE=?, PBI_GENRE_CODE=?, PBI_NO_PAY=?, PBI_PAY=?, PBI_PAY_MAX=?, PBI_TRANSPORTATION=?, PBI_PERSONNEL=?, PBI_PERSONNEL_MIN=?," + "\r\n" +
				"PBI_ADDRESS=?, PBI_DETAILADDRESS=?, PBI_LATLNG=?, PBI_CONTENT=?, PBI_SITE=?, PBI_MANAGER=?, PBI_TEL=?, PBI_EMAIL=?, PBI_FILE=?, PBI_PLACE_IMG=?, PBI_PRODUCT_IMG=?" + "\r\n" +
				"where PBI_NO=?" + "\r\n";
		
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, pbiThumnailImg);
		pstmt.setString(2, pbiMainImg);
		pstmt.setString(3, pbiTitle);
		pstmt.setString(4, pbiEventSdate);
		pstmt.setString(5, pbiEventEdate);
		pstmt.setString(6, pbiReceiptSdate);
		pstmt.setString(7, pbiReceiptEdate);
		pstmt.setString(8, pbiGenre);
		pstmt.setString(9, pbiGenreCode);
		pstmt.setString(10, pbiNoPay);
		pstmt.setString(11, pbiPay);
		pstmt.setString(12, pbiPayMax);
		pstmt.setString(13, pbiTransportation);
		pstmt.setString(14, pbiPersonner);
		pstmt.setString(15, pbiPersonner_min);
		pstmt.setString(16, pbiAddress);
		pstmt.setString(17, pbiDetailaddress);
		pstmt.setString(18, pbiLatlng);
		pstmt.setString(19, pbiContent);
		pstmt.setString(20, "");
		pstmt.setString(21, pbiManager);
		pstmt.setString(22, pbiTel);
		pstmt.setString(23, pbiEmail);
		pstmt.setString(24, "");
		pstmt.setString(25, hallImg);
		pstmt.setString(26, productImg);
		pstmt.setString(27, no);
		
		//System.out.println(sql);
		
		pstmt.executeUpdate();
		
		result = true;
		msg = "수정되었습니다.";

	}catch(Exception e){
		result = false;
		msg = "다시 시도해주세요.";
		e.printStackTrace();
	}
%>
 	<ROOT>
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