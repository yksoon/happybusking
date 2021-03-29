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
* 공연의뢰 페이지 
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		

		sql = "select distinct *" + "\r\n" +
				"from(select *" + "\r\n" + 
						"from (select t.*," + "\r\n" +
						"(select count(*) from interest where team_no = t.team_no) as cnt" + "\r\n" +
						"from team t" + "\r\n" +
						"join perform p on p.team_no = t.team_no and p.pf_cancle = '0' and p.pf_date >= date_add(now(), interval -2 month)" + "\r\n" +
						"where t.team_name <> '해피버스킹'" + "\r\n" +
						"group by p.team_no" + "\r\n" +
						"order by p.regdate desc" + "\r\n" +
						"limit 5) as A" + "\r\n" +
						"union" + "\r\n" +
						"select *" + "\r\n" +
						"from (select t.*," + "\r\n" +
						"(select count(*) from interest where team_no = t.team_no) as cnt" + "\r\n" +
						"from team t" + "\r\n" +
						"join team_member tm on tm.team_no = t.team_no and tm.leader_chk = '1'" + "\r\n" +
						"join board b on b.user_no = tm.user_no  and b.board_date >= date_add(now(), interval -2 week) and board_del = 'N'" + "\r\n" +
						"where t.team_name <> '해피버스킹'" + "\r\n" +
						"group by t.team_no" + "\r\n" +
						"order by b.board_date desc" + "\r\n" +
						"limit 5) as B" + "\r\n" +
						"union" + "\r\n" +
						"select *" + "\r\n" +
						"from (select t.*," + "\r\n" +
						"(select count(*) from interest where team_no = t.team_no) as cnt" + "\r\n" +
						"from team t" + "\r\n" +
						"where t.team_name <> '해피버스킹'" + "\r\n" +
						"order by cnt desc" + "\r\n" +
						"limit 15) as C) as D" + "\r\n" +
						"limit 15" + "\r\n" ;

		
		//System.out.println(sql);
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
					<TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME"))%></TEAM_NAME>
					<CODE_GENRE><%=ConvertUtil.toString(rs.getString("CODE_GENRE"))%></CODE_GENRE>
					<TINTRO_IMG><%=ConvertUtil.toString(rs.getString("TINTRO_IMG"))%></TINTRO_IMG>
					<BELONG><%=ConvertUtil.toString(rs.getString("BELONG"))%></BELONG>
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