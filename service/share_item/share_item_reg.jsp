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
* 물품공유 등록
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";


String si_category =  ParamUtil.getString(request, "si_category", "");
String si_name = ParamUtil.getString(request, "si_name", "");
String si_price_unit = ParamUtil.getString(request, "si_price_unit", "");
String si_price = ParamUtil.getString(request, "si_price", "");
String si_state = ParamUtil.getString(request, "si_state", "");
String si_main_image_text = ParamUtil.getString(request, "si_main_image_text", "");
String si_sub_image_text = ParamUtil.getString(request, "si_sub_image_text", "");
String si_content = ParamUtil.getString(request, "si_content", "");
String si_place = ParamUtil.getString(request, "si_place", "");
String si_delivery = ParamUtil.getString(request, "si_delivery", "");
String si_contact = ParamUtil.getString(request, "si_contact", "");

/* System.out.println(si_category);
System.out.println(si_name);
System.out.println(si_price_unit);
System.out.println(si_price);
System.out.println(si_state);
System.out.println(si_main_image_text);
System.out.println(si_sub_image_text);
System.out.println(si_content);
System.out.println(si_place);
System.out.println(si_delivery);
System.out.println(si_contact); */

%>


<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		
		
		sql = "INSERT INTO" + "\r\n" +
				"SHARE_ITEM(SI_USER_NO, SI_CATEGORY, SI_NAME, SI_PRICE_UNIT, SI_PRICE, SI_STATE, SI_MAIN_IMAGE, SI_SUB_IMAGE, SI_CONTENT, SI_PLACE, SI_DELIVERY, SI_CONTACT)" + "\r\n" +
				"VALUES('{si_user_no}','{si_category}', '{si_name}', '{si_price_unit}', '{si_price}', '{si_state}', '{si_main_image_text}', '{si_sub_image_text}', '{si_content}', '{si_place}', '{si_delivery}', '{si_contact}')";
		
		sql = sql.replace("{si_user_no}", USER_NO);
		sql = sql.replace("{si_category}", si_category);
		sql = sql.replace("{si_name}", si_name);
		sql = sql.replace("{si_price_unit}", si_price_unit);
		sql = sql.replace("{si_price}", si_price);
		sql = sql.replace("{si_state}", si_state);
		sql = sql.replace("{si_main_image_text}", si_main_image_text);
		sql = sql.replace("{si_sub_image_text}", si_sub_image_text);
		sql = sql.replace("{si_content}", si_content);
		sql = sql.replace("{si_place}", si_place);
		sql = sql.replace("{si_delivery}", si_delivery);
		sql = sql.replace("{si_contact}", si_contact);
		
		
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