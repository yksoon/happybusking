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
* 공연의뢰 내역(관람자) 페이지 
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;


boolean result = false;
String msg = "";

	
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		

			sql = "SELECT T.TEAM_NO, T.TEAM_NAME, PRQ.*" + "\r\n" +
					"FROM PERFORM_REQUEST PRQ, TEAM T" + "\r\n" +
					"WHERE PRQ.TEAM_NO = T.TEAM_NO" + "\r\n" +
					"AND PRQ.USER_NO  = '" + USER_NO + "'\r\n" +
					"ORDER BY PF_REQUEST_REG_DATE DESC";

		
		//System.out.println(sql);
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
					<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
					<PF_REQUEST_NO><%=ConvertUtil.toInteger(rs.getInt("PF_REQUEST_NO"))%></PF_REQUEST_NO>
					<PF_REQUEST_GRP_NO><%=ConvertUtil.toInteger(rs.getInt("PF_REQUEST_GRP_NO"))%></PF_REQUEST_GRP_NO>
					<PF_REQUEST_SDATE><%=ConvertUtil.toStr(rs.getString("PF_REQUEST_SDATE"))%></PF_REQUEST_SDATE>
					<PF_REQUEST_STIME><%=ConvertUtil.toStr(rs.getString("PF_REQUEST_STIME"))%></PF_REQUEST_STIME>
					<PF_REQUEST_EDATE><%=ConvertUtil.toStr(rs.getString("PF_REQUEST_EDATE"))%></PF_REQUEST_EDATE>
					<PF_REQUEST_ETIME><%=ConvertUtil.toStr(rs.getString("PF_REQUEST_ETIME"))%></PF_REQUEST_ETIME>
					<PF_REQUEST_DETAIL_ADDR><%=ConvertUtil.toStr(rs.getString("PF_REQUEST_DETAIL_ADDR"))%></PF_REQUEST_DETAIL_ADDR>
					<PF_REQUEST_REG_DATE><%=ConvertUtil.toStr(rs.getString("PF_REQUEST_REG_DATE"))%></PF_REQUEST_REG_DATE>
					<PF_REQUEST_STATE><%=ConvertUtil.toStr(rs.getString("PF_REQUEST_STATE"))%></PF_REQUEST_STATE>
					<PF_REQUEST_PRICE><%=ConvertUtil.toStr(rs.getString("PF_REQUEST_PRICE"))%></PF_REQUEST_PRICE>
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