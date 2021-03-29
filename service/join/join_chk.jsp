<?xml version="1.0" encoding="utf-8"?>
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
* 회원가입 체크
*******************************************/
String sql = "";
Connection conn = null;
ResultSet rs = null;
Statement pstmt = null;

//초기화 (0: 중복이 안되어있다)
int count = 0;

//회원가입 체크 Parameter
String user_id = ParamUtil.getString(request, "user_id", "");
String login_chk = ParamUtil.getString(request, "login_chk", "");
%>
	<ROOT>
<%
	try{
	conn = dbconn.dbconnect();
	pstmt = conn.createStatement();			
						
	sql = "SELECT COUNT(*) AS CNT, LOGIN_CHK"+ "\r\n" +
				"FROM USER" + "\r\n" + 
				"WHERE USER_ID = '" + user_id +"'" + "\r\n";
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			%>
			<DATA>
				<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT"))%></CNT>
				<LOGIN_CHK><%=ConvertUtil.toStr(rs.getString("LOGIN_CHK"))%></LOGIN_CHK>
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
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>