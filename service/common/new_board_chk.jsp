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
* 게시판 새 글 여부
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
		
		sql = "select *, ifnull(board_no, '') as board_no," + "\r\n" +
				"(select count(*) from public_busking_info where date_format(pbi_regdate, '%Y-%m-%d') >= date_add(now(),interval -7 day)) as pbi_cnt," + "\r\n" +
				"(select count(*) from buskingzone where date_format(regdate, '%Y-%m-%d') >= date_add(now(),interval -7 day) and bz_del='N') as bz_cnt," + "\r\n" +
				"(select count(*) from share_item where date_format(regdate, '%Y-%m-%d') >= date_add(now(),interval -7 day) and si_del='N') as si_cnt" + "\r\n" +
				"from board" + "\r\n" +
				"right outer join (select count(*) as notice_cnt from notice where date_format(nt_regdate, '%Y-%m-%d') > date_add(now(),interval -7 day) and nt_del='N') as notice_cnt" + "\r\n" +
				"on date_format(board_date, '%Y-%m-%d') > date_add(now(),interval -7 day)" + "\r\n" +
				"and board_del = 'N'" + "\r\n" +
				"group by board_category" + "\r\n" +
				"order by board_date desc" + "\r\n" ;
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
		%>
			<DATA>
				<BOARD_CATEGORY><%=ConvertUtil.toStr(rs.getString("BOARD_CATEGORY"))%></BOARD_CATEGORY>
				<NOTICE_CNT><%=ConvertUtil.toInteger(rs.getInt("notice_cnt"))%></NOTICE_CNT>
				<PBI_CNT><%=ConvertUtil.toInteger(rs.getInt("pbi_cnt"))%></PBI_CNT>
				<BZ_CNT><%=ConvertUtil.toInteger(rs.getInt("bz_cnt"))%></BZ_CNT>
				<SI_CNT><%=ConvertUtil.toInteger(rs.getInt("si_cnt"))%></SI_CNT>
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