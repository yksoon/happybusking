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
String condition = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String search = ParamUtil.getString(request, "search", "");
String start = ParamUtil.getString(request, "start", "0");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		condition = "where (kgubun like '%서울메트로%' or kgubun like '%메트로 아티스트%')and kapply <> 'Y' and kteam like '%"+search+"%'";
		
		sql = "select fa.kid, fa.kgubun, fa.kname, fa.kteam, fa.kgenre, fa.kdate, fa.kapply, fa.kcountmin, fa.kcountmax, " + "\r\n" +
				"(select count(*) from festival_apply " + condition + ") as cnt \r\n" +
				"from festival_apply fa" + "\r\n" +
				condition + "\r\n" +
				"order by fa.kid desc" + "\r\n" +
				"limit " + start + ", 8" + "\r\n" ;
				
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<KID><%=ConvertUtil.toStr(rs.getString("KID")) %></KID>
				<KGUBUN><%=ConvertUtil.toStr(rs.getString("KGUBUN")) %></KGUBUN>
				<KNAME><%=ConvertUtil.toStr(rs.getString("KNAME"))%></KNAME>
				<KTEAM><%=ConvertUtil.toStr(rs.getString("KTEAM"))%></KTEAM>
				<KGENRE><%=ConvertUtil.toStr(rs.getString("KGENRE"))%></KGENRE>
				<KDATE><%=ConvertUtil.toStr(rs.getString("KDATE"))%></KDATE>
				<KAPPLY><%=ConvertUtil.toStr(rs.getString("KAPPLY"))%></KAPPLY>
				<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT"))%></CNT>
				<KCOUNTMIN><%=ConvertUtil.toInteger(rs.getInt("KCOUNTMIN"))%></KCOUNTMIN>
				<KCOUNTMAX><%=ConvertUtil.toInteger(rs.getInt("KCOUNTMAX"))%></KCOUNTMAX>
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