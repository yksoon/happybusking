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
* 회원가입(insert)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

//초기화 (0: 중복이 안되어있다)
int count = 0;

//회원가입 Parameter
String team_no = ParamUtil.getString(request, "team_no", "");
String user_no = ParamUtil.getString(request, "user_no", "");
%>
<ROOT>
<%
	try{
	conn = dbconn.dbconnect();
				
						
	sql = "DELETE" + "\r\n" +  
			"FROM INTEREST" + "\r\n" +
			"WHERE TEAM_NO = " + team_no + "\r\n" +
			"AND USER_NO = '" + user_no + "'\r\n"; 
			
	pstmt = conn.prepareStatement(sql);
	
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