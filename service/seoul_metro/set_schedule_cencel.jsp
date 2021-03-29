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
* 공연 일정 신청 취소(UPDATE)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String no = ParamUtil.getString(request, "no", "");
int result;

conn = dbconn.dbconnect();

try{
	sql = "update schedule_application" + "\r\n" +
			"set cancel = 'Y'" + "\r\n" +
			"where no = ?";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, no);
	
	result = pstmt.executeUpdate();
	
	pstmt.close();
	
	sql = "update perform" + "\r\n" +
			"set pf_cancle=1, pf_cancle_msg = '해당 공연이 사정상 취소되었습니다. 다른 공연을 관람해주세요.'" + "\r\n" +
			"where pf_no=?" + "\r\n";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, no);
	
	result = pstmt.executeUpdate();
	
	//System.out.println(result);
	
	%>
	<ROOT>
		<DATA>
			<RES><%=result %></RES>
		</DATA>
	</ROOT>
	<%
	
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