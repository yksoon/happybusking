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
* 공연 취소
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

<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		//업로드
		
	    		sql = "DELETE FROM reg_perform" + "\r\n" +
	    				"WHERE TEAM_NO = " + "\r\n" +
                        "(SELECT team_no FROM team_member WHERE user_no= '" + user_no + "' LIMIT 1)" + "\r\n" +
	    				"AND PERFORM_NO = '" + perform_no + "'";

	      		
	    		pstmt.executeUpdate(sql);
	    		
	    		msg = "공연 취소 완료";
	    		result = true;
	}catch(Exception e){
		result = false;
		msg = "공연 신청에 실패하였습니다." + e;
		e.printStackTrace();
	}
%>