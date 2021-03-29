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
* 버스킹존 상세 볼러오기(SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String bz_no = ParamUtil.getString(request, "bz_no", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT BZ.BZ_NO, BZ.BZ_USER_NO, BZ.BZ_NAME, BZ.BZ_IMAGE, BZ.BZ_SUB_IMAGE, BZ.BZ_ADDRESS, BZ.BZ_DETAILADDR, BZ.BZ_URL, BZ.BZ_CONTACT, BZ.BZ_CONTENT, BZ.BZ_LATLNG, U.NICKNAME" + "\r\n" +
				"FROM BUSKINGZONE BZ" + "\r\n" +
				"JOIN USER U ON BZ.BZ_USER_NO = U.USER_NO" + "\r\n" +
				"WHERE BZ.BZ_NO = " + bz_no + "\r\n" +
				"AND BZ.BZ_DEL = 'N'";
		
		//System.out.println(sql);
				
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<BZ_NO><%=ConvertUtil.toInteger(rs.getInt("BZ_NO")) %></BZ_NO>
				<BZ_USER_NO><%=ConvertUtil.toStr(rs.getString("BZ_USER_NO")) %></BZ_USER_NO>
				<BZ_NAME><%=ConvertUtil.toStr(rs.getString("BZ_NAME"))%></BZ_NAME>
				<BZ_IMAGE><%=ConvertUtil.toStr(rs.getString("BZ_IMAGE"))%></BZ_IMAGE>
				<BZ_SUB_IMAGE><%=ConvertUtil.toStr(rs.getString("BZ_SUB_IMAGE"))%></BZ_SUB_IMAGE>
				<BZ_ADDRESS><%=ConvertUtil.toStr(rs.getString("BZ_ADDRESS"))%></BZ_ADDRESS>
				<BZ_DETAILADDR><%=ConvertUtil.toStr(rs.getString("BZ_DETAILADDR"))%></BZ_DETAILADDR>
				<BZ_URL><%=ConvertUtil.toStr(rs.getString("BZ_URL"))%></BZ_URL>
				<BZ_CONTACT><%=ConvertUtil.toStr(rs.getString("BZ_CONTACT"))%></BZ_CONTACT>
				<BZ_CONTENT><%=ConvertUtil.toStr(rs.getString("BZ_CONTENT"))%></BZ_CONTENT>
				<BZ_LATLNG><%=ConvertUtil.toStr(rs.getString("BZ_LATLNG"))%></BZ_LATLNG>
				<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME"))%></NICKNAME>
			</DATA>
			<%
		}
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