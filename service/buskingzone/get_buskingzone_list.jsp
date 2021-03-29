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
* 버스킹존 리스트 볼러오기(SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String bz_addr = ParamUtil.getString(request, "bz_addr", "");
String keyword = ParamUtil.getString(request, "keyword", "");
String limit = ParamUtil.getString(request, "limit", "");
String lastlimit = ParamUtil.getString(request, "lastlimit", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT BZ.BZ_NO, BZ.BZ_USER_NO, BZ.BZ_NAME, BZ.BZ_IMAGE, BZ.BZ_ADDRESS, BZ.BZ_CONTENT, U.NICKNAME" + "\r\n" +
				"FROM BUSKINGZONE BZ" + "\r\n" +
				"JOIN USER U ON BZ.BZ_USER_NO = U.USER_NO" + "\r\n" +
				"WHERE BZ.BZ_DEL = 'N'" + "\r\n" +
				"AND BZ.BZ_ADDRESS LIKE '{bz_addr}%'" + "\r\n" ;
				
		
		String[] arry = keyword.split(" ");
		
		for(int i = 0; i < arry.length; i++){
			if( i == 0){
				sql = sql.concat("AND( BZ.BZ_NAME LIKE '%"+arry[i]+"%'");
			} else {
				sql = sql.concat(" AND BZ.BZ_NAME LIKE '%" + arry[i] +"%'");
			}
		}
		
		sql = sql.concat(") \r\n");
				
				
		sql = sql.concat("ORDER BY CASE WHEN BZ_IMAGE = '' THEN BZ_NO END ASC\r\n");
		
		if(lastlimit.equals("0")){
			sql = sql.concat("LIMIT " + limit + ", 20\r\n");
		} else {
			sql = sql.concat("LIMIT 0, "+lastlimit+"\r\n");
		}
		
		
		
		sql = sql.replace("{bz_addr}", bz_addr);
		
		//System.out.println(sql);
				
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<BZ_NO><%=ConvertUtil.toInteger(rs.getInt("BZ_NO")) %></BZ_NO>
				<BZ_USER_NO><%=ConvertUtil.toStr(rs.getString("BZ_USER_NO")) %></BZ_USER_NO>
				<BZ_NAME><%=ConvertUtil.toStr(rs.getString("BZ_NAME"))%></BZ_NAME>
				<BZ_IMAGE><%=ConvertUtil.toStr(rs.getString("BZ_IMAGE"))%></BZ_IMAGE>
				<BZ_ADDRESS><%=ConvertUtil.toStr(rs.getString("BZ_ADDRESS"))%></BZ_ADDRESS>
				<BZ_CONTENT><%=ConvertUtil.toStr(rs.getString("BZ_CONTENT"))%></BZ_CONTENT>
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