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
* 팀/솔로 댓글 등록
*******************************************/
String sql = "";

Connection conn = null;
PreparedStatement pstmt = null;

String no =  ParamUtil.getString(request, "no", "");
String team_no = ParamUtil.getString(request, "team_no", "");
String content = ParamUtil.getString(request, "content", "0");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		
		sql = "insert into" + "\r\n" +
				"team_reply(no, user_no, team_no, content)" + "\r\n" +
				"values(?, ?, ?, ?)";
		
		//System.out.println(id);
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, no);
		pstmt.setString(2, USER_NO);
		pstmt.setString(3, team_no);
		pstmt.setString(4, content);
		
		//System.out.println(sql);
		
		pstmt.executeUpdate();
%>
</ROOT>
<%
	}catch(Exception e){
		e.getStackTrace();
	}
%>
<%
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>