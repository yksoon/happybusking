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
* 버스킹존 게시글 등록
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String bz_name = ParamUtil.getString(request, "bz_name", "");
String bz_image_text = ParamUtil.getString(request, "bz_image_text", "");
String bz_sub_image_text = ParamUtil.getString(request, "bz_sub_image_text", "");
String bz_address = ParamUtil.getString(request, "bz_address", "");
String bz_detailaddr = ParamUtil.getString(request, "bz_detailaddr", "");
String bz_url = ParamUtil.getString(request, "bz_url", "");
String bz_contact = ParamUtil.getString(request, "bz_contact", "");
String bz_content = ParamUtil.getString(request, "bz_content", "");
String bz_latlng = ParamUtil.getString(request, "bz_latlng", "");
%>


<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		
		
		/*System.out.println(bz_name);
		System.out.println(bz_image_text);
		System.out.println(bz_address);
		System.out.println(bz_detailaddr);
		System.out.println(bz_url);
		System.out.println(bz_contact);
		System.out.println(bz_content);*/
		
		sql = "INSERT INTO" + "\r\n" +
				"BUSKINGZONE(BZ_USER_NO, BZ_NAME, BZ_IMAGE, BZ_SUB_IMAGE, BZ_ADDRESS, BZ_DETAILADDR, BZ_URL, BZ_CONTACT, BZ_CONTENT, BZ_LATLNG, BZ_DEL)" + "\r\n" +
				"VALUES('{bz_user_no}','{bz_name}', '{bz_image_text}', '{bz_sub_image_text}', '{bz_address}', '{bz_detailaddr}', '{bz_url}', '{bz_contact}', '{bz_content}', '{bz_latlng}', 'N')";
		
		sql = sql.replace("{bz_user_no}", USER_NO);
		sql = sql.replace("{bz_name}", bz_name);
		sql = sql.replace("{bz_image_text}", bz_image_text);
		sql = sql.replace("{bz_sub_image_text}", bz_sub_image_text);
		sql = sql.replace("{bz_address}", bz_address);
		sql = sql.replace("{bz_detailaddr}", bz_detailaddr);
		sql = sql.replace("{bz_url}", bz_url);
		sql = sql.replace("{bz_contact}", bz_contact);
		sql = sql.replace("{bz_content}", bz_content);
		sql = sql.replace("{bz_latlng}", bz_latlng);
		
		pstmt.executeUpdate(sql);
		
		result = true;
		msg = "등록되었습니다.";

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