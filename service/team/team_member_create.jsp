<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%-- <%@include file="/service_include.jsp" %> --%>



<%
/*******************************************
* 팀 멤버 추가(insert)
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

//팀 멤버 추가 Parameter
String user_no = ParamUtil.getString(request, "user_no", "");
String team_no = ParamUtil.getString(request, "team_no", "");
String leader_chk = ParamUtil.getString(request, "leader_chk", "2");
String part = ParamUtil.getString(request, "part", "");
String member_req_status = ParamUtil.getString(request, "member_req_status", "1");
%>
	<ROOT>
<%
	try{
	conn = dbconn.dbconnect();
	
	stmt = conn.createStatement();
	
	sql2 = "SELECT * " + "\r\n" +
			"FROM TEAM_MEMBER " + "\r\n" +
			"WHERE USER_NO = '" + user_no + "'\r\n" +
			"AND TEAM_NO = '" + team_no + "'\r\n";
	
	rs = stmt.executeQuery(sql2);
	
	if(rs.next()){
		sql = "UPDATE TEAM_MEMBER" + "\r\n" +
				"SET PART = ?" + "\r\n" +
				"WHERE USER_NO = '" + user_no + "'\r\n" +
				"AND TEAM_NO = '" + team_no + "'\r\n";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, part);
		
	} else {
		sql = "INSERT INTO" + "\r\n" +  
				"TEAM_MEMBER(USER_NO, TEAM_NO, LEADER_CHK, PART, MEMBER_REQ_STATUS)" +
				"VALUES(?, ?, ?, ?, ?)" + "\r\n"; 
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, user_no);
		pstmt.setString(2, team_no);
		pstmt.setString(3, leader_chk);
		pstmt.setString(4, part);
		pstmt.setString(5, member_req_status);
	}
	
	/* 최종적으로 DB로 값이 들어가는 단계(쿼리 실행단계) */
	int result = pstmt.executeUpdate();		
	
	if(result == 1){
	%>
		<DATA>
			<RESULT>result</RESULT>
		</DATA>
	<%
	}
		   
	%>
	</ROOT>
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<%
try {
	rs.close();
} catch (Exception ex) {}
try {
	stmt.close();
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>