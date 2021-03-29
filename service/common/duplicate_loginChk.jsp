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

<%@include file="/service_include.jsp"%>

<%
/*******************************************
* 중복로그인 체크
*******************************************/
String sql = "";
Connection conn = null;
ResultSet rs = null;
Statement pstmt = null;


int count = 0;

//중복로그인 체크 Parameter
String uuid = ParamUtil.getString(request, "uuid", "");
String user_no = USER_NO;
String login_chk = LOGIN_CHK;
%>
	<ROOT>
<%
	try{
	conn = dbconn.dbconnect();
	pstmt = conn.createStatement();
	
	if(user_no == "null" || user_no.isEmpty() || user_no == null){
		%>
		<DATA>
			<RESULT>1</RESULT>
		</DATA>
		<%
		return;
	}
	else{
		sql = "SELECT COUNT(*) AS CNT"+ "\r\n" +
				"FROM USER" + "\r\n" + 
				"WHERE (UUID = '" + uuid +"'" + "\r\n" +
				"OR UUID IS NULL)" + "\r\n" + 
				"AND LOGIN_CHK = '" + login_chk + "'\r\n" +
				"AND USER_NO = '" + user_no + "'" + "\r\n";
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			int cnt = ConvertUtil.toInteger(rs.getInt("CNT"));
			if(cnt == 0){
			%>
				<DATA>
					<RESULT>0</RESULT>
				</DATA>
			<%
			}
			else{
			%>
				<DATA>
					<RESULT>1</RESULT>
				</DATA>
			<%
			}
		}
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