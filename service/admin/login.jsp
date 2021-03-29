<?xml version="1.0" encoding="utf-8"?>
<%@page import="com.mysql.fabric.xmlrpc.base.Param"%>
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

<%@ page import="src.util.*"%>

<%@include file="/service_include.jsp" %>

<%
/*******************************************
* 본인이 보유한 팀 목록
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

//아티스트되기 -> 아티스트 이름 중복확인
String id = ParamUtil.getString(request, "id", "0");
String pw = ParamUtil.getString(request, "pw", "0");

String result = "";

pw = SecuritySha.SHA256(pw);	//패스워드 암호화
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT *" + "\r\n" +
				"FROM ADMIN" + "\r\n" +
				"WHERE ADMIN_ID = '"+id+"'" + "\r\n" +
				"AND ADMIN_PW = '"+pw+"'" + "\r\n";
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			result = "TRUE";
		} else {
			result = "FALSE";
		}
		
		//System.out.println(result);
		%>
		<DATA>
			<RESULT><%=result %></RESULT>
		</DATA>
		<%
%>
</ROOT>
<%
	}catch(Exception e){
		e.getStackTrace();
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