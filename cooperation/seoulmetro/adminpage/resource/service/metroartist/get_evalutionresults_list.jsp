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

String search = ParamUtil.getString(request, "search", "");
String start = ParamUtil.getString(request, "start", "0");
String date = ParamUtil.getString(request, "date", "");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql =  "select sa.*, max(er.score) as score, t.team_name," + "\r\n" +
				"sum((select count(*) from scan_count sc where sc.sno = sa.no)) as scan_cnt," + "\r\n" +
				"(select count(*) from schedule_application sa1 where sa1.date like '%"+date+"%' and sa1.attendance = 'Y' and sa1.tno = sa.tno) as att_cnt," + "\r\n" +
				"(select count(*) from schedule_application sa2 where sa2.date like '%"+date+"%' and sa2.cancel = 'Y' and sa2.tno = sa.tno) as cancel_cnt," + "\r\n" +
				"(select count(distinct tno) from schedule_application sa3 join team t3 on t3.team_no = sa3.tno where sa3.date like '%"+date+"%' and team_name like '%"+search+"%') as cnt" + "\r\n" +
				"from schedule_application sa" + "\r\n" +
				"left join evalution_results er on er.sno = sa.no" + "\r\n" +
				"left join team t on t.team_no = sa.tno" + "\r\n" +
				"where sa.date like '%"+date+"%'" + "\r\n" +
				"and team_name like '%"+search+"%'" + "\r\n" +
				"group by sa.tno" + "\r\n" +
				"order by tno asc" + "\r\n" +
				"limit "+start+", 8" + "\r\n";
				
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<NO><%=ConvertUtil.toStr(rs.getString("NO")) %></NO>
				<ATT_CNT><%=ConvertUtil.toStr(rs.getString("ATT_CNT")) %></ATT_CNT>
				<SCAN_CNT><%=ConvertUtil.toStr(rs.getString("SCAN_CNT"))%></SCAN_CNT>
				<SCORE><%=ConvertUtil.toStr(rs.getString("SCORE"))%></SCORE>
				<CANCEL_CNT><%=ConvertUtil.toStr(rs.getString("CANCEL_CNT"))%></CANCEL_CNT>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<CNT><%=ConvertUtil.toStr(rs.getString("CNT"))%></CNT>
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