<?xml version="1.0" encoding="utf-8"?>
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
* 장비공유 상세페이지 답글 리스트(SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;


boolean result = false;
String msg = "";

String si_no = ParamUtil.getString(request, "si_no", "0");
String parent_no = ParamUtil.getString(request, "parent_no", "0");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		

		sql = "SELECT SIR.*, U.NICKNAME" + "\r\n" +
				"FROM SHARE_ITEM_REPLY SIR" + "\r\n" +
				"JOIN USER U ON U.USER_NO = SIR.SI_REPLY_USER_NO" + "\r\n" +
				"WHERE SIR.SI_REPLY_PARENT_NO = " + parent_no + "\r\n" +
				"AND SIR.SI_NO = " + si_no + "\r\n" +
				"AND SIR.SI_REPLY_DEL = 'N'";
		
		//System.out.println(sql);
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<SI_REPLY_NO><%=ConvertUtil.toInteger(rs.getInt("SI_REPLY_NO")) %></SI_REPLY_NO>
					<SI_REPLY_CONTENT><%=ConvertUtil.toStr(rs.getString("SI_REPLY_CONTENT")) %></SI_REPLY_CONTENT>
					<SI_REPLY_DATE><%=ConvertUtil.toStr(rs.getString("SI_REPLY_DATE")) %></SI_REPLY_DATE>
					<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME")) %></NICKNAME>
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