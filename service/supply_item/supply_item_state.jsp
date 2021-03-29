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
* 지원물품 신청현황 리스트
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
		
		sql = "SELECT IR.ITEM_REQUEST_NO, IR.ITEM_REQUEST_GRP_NO, IR.ITEM_NO, IR.ITEM_REQUEST_COUNT, IR.ITEM_REQUEST_DATE, IR.ITEM_REQUEST_STATE, I.ITEM_IMG, I.ITEM_NAME, T.TEAM_NAME" + "\r\n" +
				"FROM ITEM_REQUEST IR, ITEM I, TEAM T, TEAM_MEMBER TM" + "\r\n" +
			   "WHERE TM.USER_NO ='" + USER_NO + "'\r\n" +
				 "AND IR.ITEM_NO = I.ITEM_NO" + "\r\n" +
				 "AND T.TEAM_NO = IR.TEAM_NO" + "\r\n" +
				 "AND IR.TEAM_NO = TM.TEAM_NO" + "\r\n" +
				 "AND TM.TEAM_NO = T.TEAM_NO" + "\r\n" +				 
			   "ORDER BY ITEM_REQUEST_DATE DESC" + "\r\n";

		
		//System.out.println(sql);		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<ITEM_REQUEST_NO><%=ConvertUtil.toInteger(rs.getInt("ITEM_REQUEST_NO"))%></ITEM_REQUEST_NO>
					<ITEM_REQUEST_GRP_NO><%=ConvertUtil.toInteger(rs.getInt("ITEM_REQUEST_GRP_NO"))%></ITEM_REQUEST_GRP_NO>
					<ITEM_NO><%=ConvertUtil.toInteger(rs.getInt("ITEM_NO"))%></ITEM_NO>
					<ITEM_REQUEST_COUNT><%=ConvertUtil.toInteger(rs.getInt("ITEM_REQUEST_COUNT"))%></ITEM_REQUEST_COUNT>
					<ITEM_REQUEST_DATE><%=ConvertUtil.toStr(rs.getString("ITEM_REQUEST_DATE"))%></ITEM_REQUEST_DATE>
					<ITEM_REQUEST_STATE><%=ConvertUtil.toStr(rs.getString("ITEM_REQUEST_STATE"))%></ITEM_REQUEST_STATE>
					<ITEM_IMG><%=ConvertUtil.toStr(rs.getString("ITEM_IMG"))%></ITEM_IMG>
					<ITEM_NAME><%=ConvertUtil.toStr(rs.getString("ITEM_NAME"))%></ITEM_NAME>	
					<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
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