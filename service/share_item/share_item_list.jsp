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
* 장비공유 리스트
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String si_category = ParamUtil.getString(request, "si_category", "");
String si_search = ParamUtil.getString(request, "si_search", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT *" + "\r\n" +
				"FROM SHARE_ITEM" + "\r\n" +
				"WHERE SI_DEL = 'N'" + "\r\n";
		
		if(!si_category.equals("")){
			sql += "AND SI_CATEGORY = '{si_category}'" + "\r\n";
			sql = sql.replace("{si_category}", si_category);	
		}
		
		if(!si_search.equals("")){
			sql += "AND (SI_NAME LIKE '%{si_search}%'" + "\r\n" +
					"OR SI_CONTENT LIKE '%{si_search}%')" + "\r\n";
			sql = sql.replace("{si_search}", si_search);
		}
		
		sql += "ORDER BY SI_NO DESC \r\n";

		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<SI_NO><%=ConvertUtil.toInteger(rs.getInt("SI_NO"))%></SI_NO>
					<SI_USER_NO><%=ConvertUtil.toStr(rs.getString("SI_USER_NO"))%></SI_USER_NO>
					<SI_CATEGORY><%=ConvertUtil.toStr(rs.getString("SI_CATEGORY"))%></SI_CATEGORY>
					<SI_NAME><%=ConvertUtil.toStr(rs.getString("SI_NAME"))%></SI_NAME>
					<SI_PRICE_UNIT><%=ConvertUtil.toStr(rs.getString("SI_PRICE_UNIT"))%></SI_PRICE_UNIT>
					<SI_PRICE><%=ConvertUtil.toInteger(rs.getInt("SI_PRICE"))%></SI_PRICE>
					<SI_STATE><%=ConvertUtil.toStr(rs.getString("SI_STATE"))%></SI_STATE>
					<SI_MAIN_IMAGE><%=ConvertUtil.toStr(rs.getString("SI_MAIN_IMAGE"))%></SI_MAIN_IMAGE>
					<SI_SUB_IMAGE><%=ConvertUtil.toStr(rs.getString("SI_SUB_IMAGE"))%></SI_SUB_IMAGE>
					<SI_CONTENT><%=ConvertUtil.toStr(rs.getString("SI_CONTENT"))%></SI_CONTENT>
					<SI_PLACE><%=ConvertUtil.toStr(rs.getString("SI_PLACE"))%></SI_PLACE>
					<SI_DELIVERY><%=ConvertUtil.toStr(rs.getString("SI_DELIVERY"))%></SI_DELIVERY>
					<SI_CONTACT><%=ConvertUtil.toStr(rs.getString("SI_CONTACT"))%></SI_CONTACT>
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