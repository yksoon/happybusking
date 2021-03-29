<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
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
* 관리자 페이지 - 지급 상태 변경(UPDATE)
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

String wdno = ParamUtil.getString(request, "wdno", "");
String tno = ParamUtil.getString(request, "tno", "");
String wdOK = ParamUtil.getString(request, "wdOK", "");
String wdRefuseReason = ParamUtil.getString(request, "wdRefuseReason", "");
String wdPrice = ParamUtil.getString(request, "wdPrice", "");


//현재 날짜 구해서 INSERT
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date nowdate = new Date();

String now = sdf.format(nowdate);

conn = dbconn.dbconnect();

try{
	sql = "UPDATE WITHDRAW" + "\r\n" +
			"SET PAYMENTS_DATE = ?, PAYMENTS_OK = ?, PAYMENTS_REFUSE_REASON = ?" + "\r\n" +
			"WHERE WITHDRAW_NO = ?";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, now);
	pstmt.setString(2, wdOK);
	pstmt.setString(3, wdRefuseReason);
	pstmt.setString(4, wdno);
	
	//System.out.println(sql);
	
	pstmt.executeUpdate();
	
	
	if(wdOK.equals("3")){
		sql2 = "UPDATE TEAM" + "\r\n" +
				"SET TEAM_MONEY = TEAM_MONEY + "+ wdPrice + "\r\n" +
				"WHERE TEAM_NO = '" + tno + "'";
		
		pstmt = conn.prepareStatement(sql2);

		pstmt.executeUpdate();
	}
	
} catch(Exception e){
	//System.out.println(e.getMessage());
}

if(pstmt != null){
	pstmt.close();	
}
if(conn != null){
	conn.close();	
}

%>