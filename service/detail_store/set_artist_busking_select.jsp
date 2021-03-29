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
* 공연 신청 등록(insert) - 아티스트가 신청
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String user_no = ParamUtil.getString(request, "user_no", "");
String perform_no = ParamUtil.getString(request, "perform_no", "");
String team_no = ParamUtil.getString(request, "team_no", "");
String offerprice = ParamUtil.getString(request, "offerprice", "");
String personal_price = ParamUtil.getString(request, "personal_price", "");
%>

<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		//업로드
		
	    		sql = "INSERT INTO " + "\r\n" +
	    				"reg_perform (USER_NO, PERFORM_NO, MATCHING_CHK, TEAM_NO, OFFERPRICE, PERSONAL_PRICE) " + "\r\n" +
	    				"VALUES('{user_no}', '{perform_no}', '1', '{team_no}', '{offerprice}', '{personal_price}')";

                sql = sql.replace("{user_no}", user_no);
	    		sql = sql.replace("{perform_no}", perform_no);
                sql = sql.replace("{team_no}", team_no);
                sql = sql.replace("{offerprice}", offerprice);
                sql = sql.replace("{personal_price}", personal_price);
	      		
	    		pstmt.executeUpdate(sql);
	    		
	    		msg = "공연을 신청하였습니다";
	    		result = true;
	}catch(Exception e){
		result = false;
		msg = "공연 신청에 실패하였습니다." + e;
		e.printStackTrace();
	}
%>