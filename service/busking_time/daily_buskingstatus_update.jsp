<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@page import="java.awt.Image"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="src.util.ImageSizeChange"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%@include file="/service_include.jsp" %>


<%
/*******************************************
* 매일 공연 종료 체크 - 공연일 지난후 3일뒤 자동 공연 조료, index와 관리자페이지에
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

// String user_no = ParamUtil.getString(request, "user_no", "");
// String perform_no = ParamUtil.getString(request, "perform_no", "");
// String team_no = ParamUtil.getString(request, "team_no", "");
// String matching_chk = ParamUtil.getString(request, "matching_chk", "");
%>

<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
	    		sql = "UPDATE reg_buskingtime a" + "\r\n" +
	    				"LEFT JOIN e_contract b ON a.PERFORM_NO = b.PERFORM_NO" + "\r\n" +
						"SET a.BUSKINGSTATUS = '5', a.END_PERFORM_USER_NO = '자동', a.END_PERFORM_DATE = DATE(NOW())" + "\r\n" +
						"WHERE a.BUSKINGDATE <= DATE_ADD(NOW(), INTERVAL -3 DAY)" + "\r\n" +
						"AND a.BUSKINGSTATUS = '1'" + "\r\n" +
	    				"AND b.CONTRACT_STATUS = '3'";

	      		System.out.println(sql);

	    		pstmt.executeUpdate(sql);
	    		
	    		result = true;
	}catch(Exception e){
		result = false;
		// msg = "공연 일정 등록에 실패하였습니다." + e;
		e.printStackTrace();
	}
%>