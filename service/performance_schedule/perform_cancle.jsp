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
* 유저 기본정보 수정(update)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;

boolean result = false;
String msg = "";

//공연 취소 
String pf_no =  ParamUtil.getString(request, "pf_no", "");
String pf_cancle_msg =  ParamUtil.getString(request, "pf_cancle_msg", "");

/* System.out.println("pf_no : " + pf_no);
System.out.println("pf_cancle_msg : " + pf_cancle_msg); */

%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		

			sql = "UPDATE PERFORM" + "\r\n" +  
					"SET PF_CANCLE = 1, " + "\r\n" +
					"PF_CANCLE_MSG = '" + pf_cancle_msg + "'\r\n" +
					"WHERE PF_NO = '" + pf_no + "'\r\n";

			pstmt.executeUpdate(sql);
			
			sql = "update schedule_application" + "\r\n" +
					"set cancel='Y'" + "\r\n" +
					"where no = '"+pf_no+"'" + "\r\n";
			
			pstmt.executeUpdate(sql);
			
			msg = "공연 일정이 취소되었습니다.";
			
%>
		<ROOT>
			<MSG><%=msg%></MSG>
		</ROOT>
<%
				 	

	}catch(Exception e){
		e.printStackTrace();
	}
%>
<%
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>