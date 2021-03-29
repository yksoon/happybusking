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
* 팀 답글 가져오기
*******************************************/
String sql = "";
String sql_content = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String team_no = ParamUtil.getString(request, "team_no", "8000000");
String no = ParamUtil.getString(request, "no", "8000000");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select tr.*," + "\r\n" +
				"(select count(*) from team_reply where no = tr.no and user_no = '"+USER_NO+"') as mychk," + "\r\n" +
				"(select nickname from user where user_no = tr.user_no) as nickname" + "\r\n" +
				"from team_reply tr" + "\r\n" +
				"where tr.team_no = '"+team_no+"'" + "\r\n" +
				"and tr.parent = '"+no+"'" + "\r\n" +
				"and tr.del = 'N'" + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<NO><%=ConvertUtil.toString(rs.getString("NO"))%></NO>
					<CONTENT><%=ConvertUtil.toString(rs.getString("CONTENT"))%></CONTENT>
					<REGDATE><%=ConvertUtil.toString(rs.getString("REGDATE"))%></REGDATE>
					<NICKNAME><%=ConvertUtil.toString(rs.getString("NICKNAME"))%></NICKNAME>
					<MYCHK><%=ConvertUtil.toString(rs.getString("MYCHK"))%></MYCHK>
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