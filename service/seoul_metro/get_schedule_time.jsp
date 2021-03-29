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
* 공연 일정 신청 가능 시간 (SELECT)
*******************************************/
String sql = "";

String date = ParamUtil.getString(request, "date", "");
String pno = ParamUtil.getString(request, "pno", "");
String beforedate = ParamUtil.getString(request, "beforedate", "");
String nowmonth = date.substring(0, 6);

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		//이전달꺼 막아야되면 해당 부분 쿼리에 추가
		//(select count(*) from schedule_application where pno = pp.no and date like '%"+beforedate+"%' and cancel = 'N') as cntmonth
		
		
		sql = "select pp.no, pp.stime, pp.etime, pp.operation, pp.maxcount," + "\r\n" +
				"(select count(*) from schedule_application where pno = pp.no and stime = pp.stime and date='"+date+"' and cancel = 'N') as cnt," + "\r\n" +
				"(select count(*) from schedule_application where pno = pp.no and date like '%"+nowmonth+"%' and cancel = 'N') as cntmonth," + "\r\n" +
				"(select group_concat(stime separator ',') from schedule_application where pno = pp.no and date='"+date+"' and cancel = 'N') as stimeconcat," + "\r\n" +
				"(select group_concat(etime separator ',') from schedule_application where pno = pp.no and date='"+date+"' and cancel = 'N') as etimeconcat" + "\r\n" +
				"from perform_place pp" + "\r\n" +
				"where pp.no = '"+pno+"'" + "\r\n" +
				"and pp.operation = 'Y'" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		
		while(rs.next()){
			%>
			<DATA>
				<STIME><%=ConvertUtil.toStr(rs.getString("stime")) %></STIME>
				<ETIME><%=ConvertUtil.toStr(rs.getString("etime")) %></ETIME>
				<CNTMONTH><%=ConvertUtil.toStr(rs.getString("cntmonth")) %></CNTMONTH>
				<MAXCOUNT><%=ConvertUtil.toStr(rs.getString("maxcount")) %></MAXCOUNT>
				<STIMECONCAT><%=ConvertUtil.toStr(rs.getString("stimeconcat")) %></STIMECONCAT>
				<ETIMECONCAT><%=ConvertUtil.toStr(rs.getString("etimeconcat")) %></ETIMECONCAT>
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