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
* 사업주, 아티스트에게 - 아티스트가 공연 종료를 완료 하였을시
*******************************************/
String sql = "";
String sql2 = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String perform_no = ParamUtil.getString(request, "perform_no", "");
String fcm_token = "";

%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT b.FCM_TOKEN, c.ARTIST_NAME" + "\r\n" +
                "FROM reg_buskingtime a" + "\r\n" +
                "JOIN user b ON a.USER_NO = b.USER_NO" + "\r\n" +
                "JOIN artist c ON a.END_PERFORM_USER_NO = c.USER_NO" + "\r\n" +
                "WHERE a.PERFORM_NO = '" + perform_no + "'";
				
		// System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		String title = "[공연 종료]";
		
		String body = "";
		
		while(rs.next()){
			fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
            artist_name = ConvertUtil.toStr(rs.getString("ARTIST_NAME"));
			// tname = ConvertUtil.toStr(rs.getString("TEAM_NAME"));
			
			body = artist_name + "님께서 공연 종료 처리를 완료 했습니다.";

            //System.out.println(body);
			
			FirebaseMessagingService.pushFCMNotification(fcm_token, 
					title, body, "danger", body, true);
		}

        sql2 = "SELECT b.FCM_TOKEN, d.ARTIST_NAME" + "\r\n" +
                "FROM reg_perform a" + "\r\n" +
                "JOIN user b ON a.USER_NO = b.USER_NO" + "\r\n" +
                "JOIN reg_buskingtime c ON a.PERFORM_NO = c.PERFORM_NO" + "\r\n" +
                "JOIN artist d ON c.END_PERFORM_USER_NO = d.USER_NO" + "\r\n" +
                "WHERE a.PERFORM_NO = '" + perform_no + "'";

        rs = pstmt.executeQuery(sql2);

        String title2 = "[공연 종료]";

        String body2 = "";

        while(rs.next()){
			fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
            artist_name = ConvertUtil.toStr(rs.getString("ARTIST_NAME"));
			// tname = ConvertUtil.toStr(rs.getString("TEAM_NAME"));
			
			body2 = artist_name + "님께서 공연 종료 처리를 완료 했습니다.";

            //System.out.println(body);
			
			FirebaseMessagingService.pushFCMNotification(fcm_token, 
					title2, body2, "danger", body2, true);
		}
%>
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