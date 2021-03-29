<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
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
* 팀 사진/동영상 DB UPDATE
*******************************************/
String sql = "";
String sql2 = "";
String sql3 = "";
Connection conn = null;
PreparedStatement pstmt = null;

String team_no = ParamUtil.getString(request, "team_no", "");
String imgText = ParamUtil.getString(request, "imgText", "");
String videoUrl = ParamUtil.getString(request, "videoUrl", "");
String videoContent = ParamUtil.getString(request, "videoContent", "");


//현재 날짜 구해서 INSERT
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date nowdate = new Date();
String now = sdf.format(nowdate);



conn = dbconn.dbconnect();

sql = "DELETE FROM TEAM_MEDIA" + "\r\n" +
		"WHERE TM_TEAM_NO = ?"; 

pstmt = conn.prepareStatement(sql);
pstmt.setString(1, team_no);
pstmt.executeUpdate();

if(!imgText.equals("")){
	String[] img = imgText.split("__happybusking__");

	for(int i = 0; i < img.length; i++){
		sql2 = "INSERT INTO" + "\r\n" +
				"TEAM_MEDIA(TM_TEAM_NO, TM_TYPE, TM_URL, TM_REGIDATE)" + "\r\n" +
				"VALUES(?, ?, ?, ?)" + "\r\n";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, team_no);
		pstmt.setString(2, "1");
		pstmt.setString(3, img[i]);
		pstmt.setString(4, now);
		pstmt.executeUpdate();	
	}
}

if(!videoUrl.equals("")){
	String[] vu = videoUrl.split("__happybusking__");
	String[] vc = videoContent.split("__happybusking__");
	
	for(int i = 0; i < vu.length; i++){
		sql2 = "INSERT INTO" + "\r\n" +
				"TEAM_MEDIA(TM_TEAM_NO, TM_TYPE, TM_URL, TM_CONTENT, TM_REGIDATE)" + "\r\n" +
				"VALUES(?, ?, ?, ?, ?)" + "\r\n";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, team_no);
		pstmt.setString(2, "2");
		pstmt.setString(3, vu[i]);
		pstmt.setString(4, vc[i]);
		pstmt.setString(5, now);
		pstmt.executeUpdate();
	}
}


pstmt.close();
conn.close();
%>