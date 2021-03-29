<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
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
* 동영상 업로드(INSERT)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String no = ParamUtil.getString(request, "no", "");
String tno = ParamUtil.getString(request, "tno", "");
String url = ParamUtil.getString(request, "url", "");
String title = ParamUtil.getString(request, "title", "");
String content = ParamUtil.getString(request, "content", "");

/* System.out.println(no);
System.out.println(tno);
System.out.println(url);
System.out.println(title);
System.out.println(content); */


try{
	 conn = dbconn.dbconnect();
	
	sql = "insert into" + "\r\n" +
			"video_upload(no, user_no, team_no, video_upload_url, video_upload_title, video_upload_content)" + "\r\n" +
			"VALUES(?, ?, ?, ?, ?, ?)";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, no);
	pstmt.setString(2, USER_NO);
	pstmt.setString(3, tno);
	pstmt.setString(4, url);
	pstmt.setString(5, title);
	pstmt.setString(6, content);
	
	pstmt.executeUpdate();

} catch(Exception e){
	System.out.println(e.getMessage());
}

if(pstmt != null){
	pstmt.close();	
}
if(conn != null){
	conn.close();	
}

%>