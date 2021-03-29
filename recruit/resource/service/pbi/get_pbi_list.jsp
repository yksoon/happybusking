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

String start = ParamUtil.getString(request, "start", "0");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		
		sql = "select pbi.*," + "\r\n" +
				"(select count(*) from public_busking_info pbi2 where pbi.pbi_no = pbi2.pbi_no and pbi2.pbi_receipt_edate >= date_format(now(), '%Y-%m-%d')) as timechk," + "\r\n" +
				"(select count(*) from festival_apply ap where ap.kgubun = pbi.pbi_no and ap.cancel = 'N') as cnt," + "\r\n" +
				"(select count(*) from festival_apply ap2 where ap2.kgubun = pbi.pbi_no and ap2.scoring = 'Y' and ap2.cancel = 'N') as cnt2," + "\r\n" +
				"(select count(*) from public_busking_info where pbi_user_no = ?) as cnt3" + "\r\n" +
				"from public_busking_info pbi" + "\r\n" +
				"where pbi.pbi_user_no = ?" + "\r\n" +
				"order by timechk desc, pbi_regdate desc" + "\r\n" +
				"limit "+start+", 10" + "\r\n";
		
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, USER_NO);
		pstmt.setString(2, USER_NO);
		
		//System.out.println(USER_NO);
		//System.out.println(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
		%>
			<DATA>
				<PBI_NO><%=ConvertUtil.toStr(rs.getString("PBI_NO")) %></PBI_NO>
				<PBI_USER_NO><%=ConvertUtil.toStr(rs.getString("PBI_USER_NO")) %></PBI_USER_NO>
				<PBI_THUMNAIL_IMG><%=ConvertUtil.toStr(rs.getString("PBI_THUMNAIL_IMG")) %></PBI_THUMNAIL_IMG>
				<TIMECHK><%=ConvertUtil.toInteger(rs.getInt("TIMECHK")) %></TIMECHK>
				<PBI_TITLE><%=ConvertUtil.toStr(rs.getString("PBI_TITLE")) %></PBI_TITLE>
				<PBI_EVENT_SDATE><%=ConvertUtil.toStr(rs.getString("PBI_EVENT_SDATE")) %></PBI_EVENT_SDATE>
				<PBI_EVENT_EDATE><%=ConvertUtil.toStr(rs.getString("PBI_EVENT_EDATE")) %></PBI_EVENT_EDATE>
				<PBI_RECEIPT_SDATE><%=ConvertUtil.toStr(rs.getString("PBI_RECEIPT_SDATE")) %></PBI_RECEIPT_SDATE>
				<PBI_RECEIPT_EDATE><%=ConvertUtil.toStr(rs.getString("PBI_RECEIPT_EDATE")) %></PBI_RECEIPT_EDATE>
				<PBI_ADDRESS><%=ConvertUtil.toStr(rs.getString("PBI_ADDRESS")) %></PBI_ADDRESS>
				<PBI_DETAILADDRESS><%=ConvertUtil.toStr(rs.getString("PBI_DETAILADDRESS")) %></PBI_DETAILADDRESS>
				<PBI_GENRE><%=ConvertUtil.toStr(rs.getString("PBI_GENRE")) %></PBI_GENRE>
				<PBI_REGDATE><%=ConvertUtil.toStr(rs.getString("PBI_REGDATE")) %></PBI_REGDATE>
				<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT")) %></CNT>
				<CNT2><%=ConvertUtil.toInteger(rs.getInt("CNT2")) %></CNT2>
				<CNT3><%=ConvertUtil.toInteger(rs.getInt("CNT3")) %></CNT3>
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