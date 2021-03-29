<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
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
* 회원가입(insert)
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
PreparedStatement pstmt = null;

Statement pstmt2 = null;
ResultSet rs = null;

//초기화 (0: 중복이 안되어있다)
int count = 0;

//회원가입 Parameter
String team_no = ParamUtil.getString(request, "team_no", "");
String user_no = ParamUtil.getString(request, "user_no", "");

//현재 날짜
Date nowdate = new Date();
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String now = sdf2.format(nowdate);
%>
<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt2 = conn.createStatement();
		
		sql2 = "SELECT *" + "\r\n" +
				"FROM INTEREST" + "\t\n" +
				"WHERE TEAM_NO = '" + team_no + "'\r\n"+
				"AND USER_NO = '" + user_no + "'\r\n";
		
		//System.out.println(sql2);
		
		rs = pstmt2.executeQuery(sql2);
		
		if(rs.next()){
			return;
		}

		sql = "INSERT INTO" + "\r\n" +  
				"INTEREST(TEAM_NO, USER_NO, I_REGDATE)" + "\r\n" +
				"VALUES(?, ?, ?)" + "\r\n"; 
				
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, team_no);
		pstmt.setString(2, user_no);
		pstmt.setString(3, now);
		
		//System.out.println(sql);
		
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
} catch (Exception ex) {}
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>