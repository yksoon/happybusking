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
* 업로드 된 동영상 리스트
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String team_no = ParamUtil.getString(request, "team_no", "0");

//System.out.println("team_no : " + team_no);	
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		

		sql = "SELECT U.NICKNAME, VU.* " + "\r\n" +  
				"FROM VIDEO_UPLOAD VU, USER U" + "\r\n" +
			   "WHERE VU.USER_NO = U.USER_NO" + "\r\n" +
				 "AND VU.TEAM_NO = " + team_no + "\r\n" + 
				 "AND VU.VIDEO_UPLOAD_URL IS NOT NULL" + "\r\n" + 
				 "ORDER BY VIDEO_UPLOAD_DATE DESC" + "\r\n";


		
		//System.out.println(sql);
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME"))%></NICKNAME>
					<VIDEO_UPLOAD_CONTENT><%=ConvertUtil.toStr(rs.getString("VIDEO_UPLOAD_CONTENT"))%></VIDEO_UPLOAD_CONTENT>
					<VIDEO_UPLOAD_URL><%=ConvertUtil.toStr(rs.getString("VIDEO_UPLOAD_URL"))%></VIDEO_UPLOAD_URL>
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