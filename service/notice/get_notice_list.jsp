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

String type = ParamUtil.getString(request, "type", "");
String start = ParamUtil.getString(request, "start", "0");
String limit = ParamUtil.getString(request, "limit", "15");

//System.out.println(type);


String uno = USER_NO;
if(USER_NO == null) uno = "";

int tcount = 0;
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		String andSql = "";											//타입에 따른 sql 추가
		String limitSql = "LIMIT " + start + ", " + limit + "\r\n";	//리미트에 따른 sql 추가		
		
		if(type.equals("") || type.equals("N")){
			andSql = "AND N.NT_TYPE = 'N'" + "\r\n";
		} else if(type.equals("A")){
			sql = "select count(*) as cnt" + "\r\n" +
					"from team_member tm" + "\r\n" +
					"where tm.user_no = '" + uno + "'" + "\r\n" ;
			
			//System.out.println(sql);
			
			rs = pstmt.executeQuery(sql);
			
			if(rs.next()){
				tcount = ConvertUtil.toInteger(rs.getInt("CNT"));
				//System.out.println(tcount);
			}
			
			if(tcount == 0){
				//그냥 아티스트만 등록한 경우
				andSql = "AND (N.NT_TYPE = 'N' OR N.NT_TYPE = 'A')" + "\r\n";
			} else {
				//팀 등록이 된 경우
				andSql = "";
			}
		}
		
		sql = "SELECT N.*," + "\r\n" +
				"(SELECT COUNT(*) FROM NOTICE_REPLY NR WHERE NR.NT_NO = N.NT_NO AND NR.NTR_DEL = 'N') AS RCOUNT" + "\r\n" +
				"FROM NOTICE N" + "\r\n" +
				"WHERE N.NT_DEL = 'N'" + "\r\n";
		
		sql = sql.concat(andSql);
		sql = sql.concat("ORDER BY NOTICEID DESC" + "\r\n");
		sql = sql.concat(limitSql);
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<NT_NO><%=ConvertUtil.toStr(rs.getString("NT_NO")) %></NT_NO>
				<NT_TYPE><%=ConvertUtil.toStr(rs.getString("NT_TYPE")) %></NT_TYPE>
				<NT_TITLE><%=ConvertUtil.toStr(rs.getString("NT_TITLE"))%></NT_TITLE>
				<NT_REGDATE><%=ConvertUtil.toStr(rs.getString("NT_REGDATE"))%></NT_REGDATE>
				<NT_DEL><%=ConvertUtil.toStr(rs.getString("NT_DEL"))%></NT_DEL>
				<NT_VIEWCOUNT><%=ConvertUtil.toInteger(rs.getInt("NT_VIEWCOUNT"))%></NT_VIEWCOUNT>
				<RCOUNT><%=ConvertUtil.toInteger(rs.getInt("RCOUNT"))%></RCOUNT>
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