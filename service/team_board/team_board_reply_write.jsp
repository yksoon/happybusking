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
* 게시판 댓글 작성
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String msg = "";

String board_no = ParamUtil.getString(request, "board_no", "0");
String user_no = ParamUtil.getString(request, "user_no", "0");
String parent_no = ParamUtil.getString(request, "parent_no", "");
String board_reply_content = ParamUtil.getString(request, "board_reply_content", "");

conn = dbconn.dbconnect();

if(parent_no.equals("")){
	sql = "INSERT INTO " + "\r\n" +
			"BOARD_REPLY(BOARD_NO, USER_NO, BOARD_REPLY_DATE, BOARD_REPLY_CONTENT)" + "\r\n" +
			"VALUES(?,?,NOW(),?)";	
}
else{
	sql = "INSERT INTO " + "\r\n" +
			"BOARD_REPLY(BOARD_NO, USER_NO, PARENT, BOARD_REPLY_DATE, BOARD_REPLY_CONTENT)" + "\r\n" +
			"VALUES(?,?,?,NOW(),?)";	
}


pstmt = conn.prepareStatement(sql);

if(parent_no.equals("")){
	pstmt.setString(1, board_no);
	pstmt.setString(2, user_no);
	pstmt.setString(3, board_reply_content);	
}
else{
	pstmt.setString(1, board_no);
	pstmt.setString(2, user_no);
	pstmt.setString(3, parent_no);
	pstmt.setString(4, board_reply_content);	
}

int result = pstmt.executeUpdate();

if(result == 1){
	if(parent_no.equals("")){
		sql = "SELECT *" + "\r\n" +
				"FROM BOARD B" + "\r\n" +
				"JOIN USER U ON U.USER_NO = B.USER_NO" + "\r\n" +
				"WHERE B.BOARD_NO = " + board_no;
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			int rPush_user_no = ConvertUtil.toInteger(rs.getInt("USER_NO"));
			if(rPush_user_no != Integer.parseInt(user_no)){
				String fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
				String board_title = ConvertUtil.toStr(rs.getString("BOARD_TITLE"));
				
				board_title = board_title.replaceAll("&amp;", "&").replaceAll("&apos;", "'").replaceAll("&quot;", "\"").replaceAll("&lt;", "<").replaceAll("&gt;", ">");
				
				String body = board_title + "에 댓글이 등록되었습니다.";
				
				//System.out.println("fcm_token : " + fcm_token);
				//System.out.println("message : " + body);
				
				FirebaseMessagingService.pushFCMNotification(fcm_token, 
						"[댓글 알림]", body, "board_reply_write", String.valueOf(board_no), true);
			}
			else{
				return;
			}
		}
	}
	else{
		sql = "SELECT *" + "\r\n" +
				"FROM BOARD_REPLY BR" + "\r\n" +
				"JOIN USER U ON U.USER_NO = BR.USER_NO" + "\r\n" +
				"WHERE BOARD_REPLY_NO = " + parent_no;
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			int rPush_user_no = ConvertUtil.toInteger(rs.getInt("USER_NO"));
			if(rPush_user_no != Integer.parseInt(user_no)){
				String fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
				String body_brc = ConvertUtil.toStr(rs.getString("BOARD_REPLY_CONTENT"));
				
				String body = body_brc + "에 답글이 등록되었습니다.";
				
				//System.out.println("fcm_token : " + fcm_token);
				//System.out.println("message : " + body);
				
				FirebaseMessagingService.pushFCMNotification(fcm_token, 
						"[답글 알림]", body, "board_rereply_write", String.valueOf(board_no), true);
			}
			else{
				return;
			}
		}
	}
}

pstmt.close();
conn.close();
%>