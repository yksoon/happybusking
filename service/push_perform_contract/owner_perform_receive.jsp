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
* 사업주에게 - 아티스트가 공연 신청했을 시
*******************************************/
String sql = "";
String sql2 = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String team_no = ParamUtil.getString(request, "team_no", "");
String perform_no = ParamUtil.getString(request, "perform_no", "");
String fcm_token = "";

String team_name = "";
%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT *" + "\r\n" +
                "FROM reg_perform a" + "\r\n" +
                "LEFT JOIN team b ON a.TEAM_NO = b.TEAM_NO" + "\r\n" +
                "WHERE a.PERFORM_NO = '" + perform_no + "'" + "\r\n" +
                "AND a.TEAM_NO = '" + team_no + "'";
				
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);

		while(rs.next()){
            team_name = ConvertUtil.toStr(rs.getString("TEAM_NAME"));
        }
		
        sql2 = "SELECT *"  + "\r\n" +
                "FROM reg_buskingtime a"  + "\r\n" +
                "JOIN user b ON a.USER_NO = b.USER_NO"  + "\r\n" +
                "WHERE PERFORM_NO = '" + perform_no + "'";

        rs = pstmt.executeQuery(sql2);

        System.out.println(sql2);
		
		String title = "[공연 신청]";
		
		String body = "";
		
		while(rs.next()){
			fcm_token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
			// tname = ConvertUtil.toStr(rs.getString("TEAM_NAME"));
			
			body = team_name + " 팀이 공연을 신청 했습니다";

            System.out.println(body);
			
			FirebaseMessagingService.pushFCMNotification(fcm_token, 
					title, body, "danger", body, true);
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