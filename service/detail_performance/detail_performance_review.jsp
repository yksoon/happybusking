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
* 공연 상세 정보
*******************************************/
String sql = "";
String sql2 = "";
String sql3 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
ResultSet rs2 = null;
ResultSet rs3 = null;

String pf_no = ParamUtil.getString(request, "pf_no", "");
String start = ParamUtil.getString(request, "start", "0");
String sort = ParamUtil.getString(request, "sort", "");

String orderby = "";

if (sort.equals("0")) {
	orderby = "ORDER BY EPILOGUE_DATE DESC";
} else {
	orderby = "ORDER BY RATY_STAR DESC";
}

String user_no ;
String team_no;

%>
<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT * " + "\r\n" +
				"FROM EPILOGUE " + "\r\n" +
				"WHERE PF_NO = " + pf_no + "\r\n"
				+ orderby + "\r\n" +
				"LIMIT " + start + ", 5";
		
		rs = pstmt.executeQuery(sql);	
		
		while(rs.next()){
			%>
			<DATA>
				<EPILOGUE_NO><%=ConvertUtil.toInteger(rs.getInt("EPILOGUE_NO")) %></EPILOGUE_NO>
				<PF_NO><%=ConvertUtil.toStr(rs.getString("PF_NO")) %></PF_NO>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
				<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO")) %></USER_NO>
				<EPILOGUE_IMG><%=ConvertUtil.toString(rs.getString("EPILOGUE_IMG")) %></EPILOGUE_IMG>
				<EPILOGUE_TITLE><%=ConvertUtil.toString(rs.getString("EPILOGUE_TITLE")) %></EPILOGUE_TITLE>
				<EPILOGUE_CONTENT><%=ConvertUtil.toString(rs.getString("EPILOGUE_CONTENT")) %></EPILOGUE_CONTENT>
				<RATY_STAR><%=ConvertUtil.toString(rs.getString("RATY_STAR")) %></RATY_STAR>
				<EPILOGUE_DATE><%=ConvertUtil.toString(rs.getString("EPILOGUE_DATE")) %></EPILOGUE_DATE>
				<EPILOGUE_DEL><%=ConvertUtil.toString(rs.getString("EPILOGUE_DEL")) %></EPILOGUE_DEL>
				<CODE_DECLARE><%=ConvertUtil.toString(rs.getString("CODE_DECLARE")) %></CODE_DECLARE>
			<%			
			user_no = ConvertUtil.toString(rs.getString("USER_NO"));
			team_no = ConvertUtil.toString(rs.getString("TEAM_NO"));
			
			sql2 = "SELECT NICKNAME " + "\r\n" +
					"FROM USER " + "\r\n" +
					"WHERE USER_NO = '" + user_no + "'\r\n";
			
			rs2 = pstmt.executeQuery(sql2);
			if(rs2.next()){
				
				%>
						<NICKNAME><%=ConvertUtil.toString(rs2.getString("NICKNAME")) %></NICKNAME>
				<%
			}
			
			sql3 = "SELECT * ,(SELECT COUNT(*) FROM INTEREST WHERE TEAM_NO = " + team_no + ") AS CNT " + "\r\n" +
					"FROM TEAM " + "\r\n" +
					"WHERE TEAM_NO="+team_no;
			
			rs3 = pstmt.executeQuery(sql3);
			
			if(rs3.next()){
				%>
					<CNT><%=ConvertUtil.toInteger(rs3.getInt("CNT"))%></CNT>
					<TEAM_INTRO><%=ConvertUtil.toStr(rs3.getString("TEAM_INTRO"))%></TEAM_INTRO>
					<TEAM_GENRE><%=ConvertUtil.toStr(rs3.getString("CODE_GENRE"))%></TEAM_GENRE>
					<TINTRO_IMG><%=ConvertUtil.toStr(rs3.getString("TINTRO_IMG"))%></TINTRO_IMG>
					<TEAM_NAME><%=ConvertUtil.toStr(rs3.getString("TEAM_NAME")) %></TEAM_NAME>
					<CODE_GENRE><%=ConvertUtil.toStr(rs3.getString("CODE_GENRE")) %></CODE_GENRE>
					
					</DATA>
				<%
			}
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