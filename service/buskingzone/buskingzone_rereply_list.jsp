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
* 버스킹존 답글 리스트 불러오기(SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;


boolean result = false;
String msg = "";

String bz_no = ParamUtil.getString(request, "bz_no", "0");
String parent_no = ParamUtil.getString(request, "parent_no", "0");

//System.out.println("team_no : " + team_no);	
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		

		sql = "SELECT BR.*, U.NICKNAME" + "\r\n" +
				"FROM BUSKINGZONE_REPLY BR" + "\r\n" +
				"JOIN USER U ON U.USER_NO = BR.USER_NO" + "\r\n" +
				"WHERE PARENT = " + parent_no + "\r\n"+
				"AND BZ_NO = " + bz_no + "\r\n" +
				"AND BZ_REPLY_DEL = 'N'";
		
		//System.out.println(sql);
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<BZ_REPLY_NO><%=ConvertUtil.toInteger(rs.getInt("BZ_REPLY_NO")) %></BZ_REPLY_NO>
					<BZ_REPLY_DATE><%=ConvertUtil.toStr(rs.getString("BZ_REPLY_DATE")) %></BZ_REPLY_DATE>
					<BZ_REPLY_CONTENT><%=ConvertUtil.toStr(rs.getString("BZ_REPLY_CONTENT")) %></BZ_REPLY_CONTENT>
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