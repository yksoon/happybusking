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
* 공모 신청 내역
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String filter = ParamUtil.getString(request, "filter", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		sql = "select tm.team_no, fa.kid, fa.kgubun, fa.kteam, fa.regdate, fa.cancel, fa.pass, pbi.pbi_receipt_edate, pbi.pbi_title" + "\r\n" +
				"from team_member tm" + "\r\n" +
				"left join festival_apply fa on fa.kteamno = tm.team_no" + "\r\n" +
				"left join public_busking_info pbi on pbi.pbi_no = fa.kgubun" + "\r\n" +
				"where tm.user_no = '"+USER_NO+"'" + "\r\n" +
				"and tm.member_req_status = '2'" + "\r\n" +
				"having fa.cancel = 'N'" + "\r\n";

		if(filter.equals("Y")){
			sql = sql.concat("and fa.pass = 'Y'" + "\r\n");
		}
		
		sql = sql.concat("order by fa.regdate desc" + "\r\n");
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO")) %></TEAM_NO>
				<KID><%=ConvertUtil.toStr(rs.getString("KID")) %></KID>
				<KGUBUN><%=ConvertUtil.toStr(rs.getString("KGUBUN")) %></KGUBUN>
				<KTEAM><%=ConvertUtil.toStr(rs.getString("KTEAM")) %></KTEAM>
				<REGDATE><%=ConvertUtil.toStr(rs.getString("REGDATE")) %></REGDATE>
				<CANCEL><%=ConvertUtil.toStr(rs.getString("CANCEL")) %></CANCEL>
				<PASS><%=ConvertUtil.toStr(rs.getString("PASS")) %></PASS>
				<PBI_RECEIPT_EDATE><%=ConvertUtil.toStr(rs.getString("PBI_RECEIPT_EDATE")) %></PBI_RECEIPT_EDATE>
				<PBI_TITLE><%=ConvertUtil.toStr(rs.getString("PBI_TITLE")) %></PBI_TITLE>
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