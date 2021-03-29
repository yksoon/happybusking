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
* 버스킹 행사 일정 리스트
*******************************************/
String sql = "";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String no = ParamUtil.getString(request, "no", "");
String start = ParamUtil.getString(request, "start", "");
String sort = ParamUtil.getString(request, "sort", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		
		sql = "select fa.*," + "\r\n" +
				"(select pbi_title from public_busking_info pbi where pbi.pbi_no = fa.kgubun) as title," + "\r\n" +
				"(select count(*) from festival_apply where kgubun = ?) as cnt" + "\r\n" +
				"from festival_apply fa" + "\r\n" +
				"where fa.kgubun = ?" + "\r\n" +
				"and fa.scoring = 'Y'" + "\r\n" +
				"and fa.cancel = 'N'" + "\r\n";
		
		if(sort.equals("date")) sql = sql.concat("order by fa.regdate desc \r\n");
		else sql = sql.concat("order by fa.score desc \r\n");
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, no);
		pstmt.setString(2, no);
		
		//System.out.println(USER_NO);
		//System.out.println(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
		%>
			<DATA>
				<KID><%=ConvertUtil.toStr(rs.getString("KID")) %></KID>
				<KTEAM><%=ConvertUtil.toStr(rs.getString("KTEAM")) %></KTEAM>
				<KURL><%=ConvertUtil.toStr(rs.getString("KURL")) %></KURL>
				<TITLE><%=ConvertUtil.toStr(rs.getString("TITLE")) %></TITLE>
				<SCORE><%=ConvertUtil.toInteger(rs.getInt("SCORE")) %></SCORE>
				<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT")) %></CNT>
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