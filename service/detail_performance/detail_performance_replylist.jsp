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
* 공연 상세 댓글 리스트 불러오기(SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;


boolean result = false;
String msg = "";

String pf_no = ParamUtil.getString(request, "pf_no", "0");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		

		sql = "SELECT PR.*, U.NICKNAME," + "\r\n" +
				"(SELECT COUNT(*) FROM PERFORM_REPLY PRY WHERE PRY.PERFORM_NO = "+pf_no+" AND ISNULL(PRY.PARENT) AND PRY.PERFORM_REPLY_DEL = 'N') AS CNT," + "\r\n" +
				"(SELECT COUNT(*) FROM PERFORM_REPLY PRY2 WHERE PRY2.PARENT = PR.PERFORM_REPLY_NO) AS CNT2" + "\r\n" +
				"FROM PERFORM_REPLY PR" + "\r\n" +
				"LEFT JOIN USER U ON U.USER_NO = PR.USER_NO" + "\r\n" +
				"WHERE PR.PERFORM_NO = " + pf_no + "\r\n" +
				"AND ISNULL(PR.PARENT)" + "\r\n" +
				"AND PERFORM_REPLY_DEL = 'N'";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<PERFORM_REPLY_NO><%=ConvertUtil.toStr(rs.getString("PERFORM_REPLY_NO")) %></PERFORM_REPLY_NO>
					<PERFORM_REPLY_DATE><%=ConvertUtil.toStr(rs.getString("PERFORM_REPLY_DATE")) %></PERFORM_REPLY_DATE>
					<PERFORM_REPLY_CONTENT><%=ConvertUtil.toStr(rs.getString("PERFORM_REPLY_CONTENT")) %></PERFORM_REPLY_CONTENT>
					<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME")) %></NICKNAME>
					<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT")) %></CNT>
					<CNT2><%=ConvertUtil.toInteger(rs.getInt("CNT2")) %></CNT2>
					<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO")) %></USER_NO>
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