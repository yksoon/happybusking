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
String uno = "";
if(USER_NO == null || USER_NO.equals("")){
	uno = "0";
} else {
	uno = USER_NO;
}
String MEMBER_REQ_STATUS = "";
String result = "TRUE";
%>

<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT MEMBER_REQ_STATUS " + "\r\n" +
				"FROM TEAM_MEMBER " + "\r\n" +
				"WHERE USER_NO = '" + uno + "'" + "\r\n";
		
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			MEMBER_REQ_STATUS = ConvertUtil.toStr(rs.getString("MEMBER_REQ_STATUS"));
			if(MEMBER_REQ_STATUS.equals("1")){
				result = "FALSE";
			}
		}
%>
<%
	}catch(Exception e){
		e.getStackTrace();
	}
%>
<ROOT>
	<DATA>
		<RESULT><%=result%></RESULT>
	</DATA>
</ROOT>
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