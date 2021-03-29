<?xml version="1.0" encoding="utf-8"?>
<%@page import="com.sun.mail.handlers.multipart_mixed"%>
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

<%@ page import="src.util.*"%>

<%@include file="/service_include.jsp" %>

<%
/*******************************************
* 공지사항 목록 (SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String n = ParamUtil.getString(request, "n", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select fa.kid, fa.kname, fa.ktel, fa.kteam, fa.kgenre, fa.kurl, fa.kapply, fa.kinfo, fa.kcountmin, fa.kcountmax, fa.kbirth, t.belong, t.code_area, t.team_no,fa.kemail" + "\r\n" +
				"from festival_apply fa" + "\r\n" +
				"left join team t on t.team_name = fa.kteam" + "\r\n" +
				"where fa.kid = '"+n+"'" + "\r\n" ;
				
		System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			%>
			<DATA>
				<KID><%=ConvertUtil.toStr(rs.getString("KID")) %></KID>
				<KNAME><%=ConvertUtil.toStr(rs.getString("KNAME")) %></KNAME>
				<KTEL><%=ConvertUtil.toStr(rs.getString("KTEL"))%></KTEL>
				<KTEAMNO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></KTEAMNO>
				<KTEAM><%=ConvertUtil.toStr(rs.getString("KTEAM"))%></KTEAM>
				<KGENRE><%=ConvertUtil.toStr(rs.getString("KGENRE"))%></KGENRE>
				<KURL><%=ConvertUtil.toStr(rs.getString("KURL"))%></KURL>
				<KAPPLY><%=ConvertUtil.toStr(rs.getString("KAPPLY"))%></KAPPLY>
				<KINFO><%=ConvertUtil.toStr(rs.getString("KINFO"))%></KINFO>
				<BELONG><%=ConvertUtil.toStr(rs.getString("BELONG"))%></BELONG>
				<KBIRTH><%=ConvertUtil.toStr(rs.getString("KBIRTH"))%></KBIRTH>
				<EMAIL><%=ConvertUtil.toStr(rs.getString("KEMAIL"))%></EMAIL>
				<CODE_AREA><%=ConvertUtil.toStr(rs.getString("CODE_AREA"))%></CODE_AREA>
				<KCOUNTMIN><%=ConvertUtil.toStr(rs.getString("KCOUNTMIN"))%></KCOUNTMIN>
				<KCOUNTMAX><%=ConvertUtil.toStr(rs.getString("KCOUNTMAX"))%></KCOUNTMAX>
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