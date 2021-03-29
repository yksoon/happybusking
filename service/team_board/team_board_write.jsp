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
* 게시판 글쓰기
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;
Statement pstmt2 = null;
ResultSet rs = null;
String fcm_token = "";


String msg = "";

String user_no = ParamUtil.getString(request, "user_no", "0");
String board_category = ParamUtil.getString(request, "board_category", "");
String board_title = ParamUtil.getString(request, "board_title", "");
String board_content = ParamUtil.getString(request, "board_content", "");

conn = dbconn.dbconnect();

sql = "INSERT INTO " + "\r\n" +
		"BOARD(USER_NO, BOARD_CATEGORY, BOARD_DATE, BOARD_TITLE, BOARD_CONTENT)" + "\r\n" +
		"VALUES(?,?,NOW(),?,?)";

pstmt = conn.prepareStatement(sql);

pstmt.setString(1, user_no);
pstmt.setString(2, board_category);
pstmt.setString(3, board_title);
pstmt.setString(4, board_content);

//System.out.println(sql);

int result = pstmt.executeUpdate();


// 새 게시글 아티스트 전체 푸시
/* if(result > 0){
	pstmt2 = conn.createStatement();
	
	sql = "SELECT A.USER_NO, U.FCM_TOKEN" + "\r\n" +
			"FROM ARTIST A" + "\r\n" +
			"JOIN USER U ON A.USER_NO = U.USER_NO" + "\r\n" +
			"where a.user_no = 6" + "\r\n" +
			"GROUP BY FCM_TOKEN";
	
	//System.out.println(sql);
	
	rs = pstmt2.executeQuery(sql);
	
	String title = "[새 게시글]";
	String body = board_title;
	
	while(rs.next()){
		fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
		
		FirebaseMessagingService.pushFCMNotification(fcm_token, 
				title, body, "newboard", body, true);
	}
} */
//System.out.println(result);

/* if(rs != null) rs.close();
pstmt2.close(); */
pstmt.close();
conn.close();
%>