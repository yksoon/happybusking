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
* 후원하기 푸시(해당 팀 팀원들에게 보내주기)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String date = ParamUtil.getString(request, "date", "");
String obj = ParamUtil.getString(request, "obj", "");
String limit = ParamUtil.getString(request, "limit", "");
String title = ParamUtil.getString(request, "title", "");
String content = ParamUtil.getString(request, "content", "");

String fcm_token = "";
%>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "select t.team_no, tm.user_no, u.fcm_token," + "\r\n" +
				"(select count(*) from schedule_application sa where sa.tno = t.team_no and sa.date like concat('%',date_format(date_sub(curdate(), interval 1 month), '%Y%m'),'%')) as cnt" + "\r\n" +
				"from team t" + "\r\n" +
				"join team_member tm on tm.team_no = t.team_no" + "\r\n" +
				"join user u on u.user_no = tm.user_no" + "\r\n" +
				"where t.belong like '%서울메트로%'" + "\r\n" +
				"and tm.member_req_status = '2'" + "\r\n" +
				"having cnt < " + limit + "\r\n";
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			fcm_token = ConvertUtil.toStr(rs.getString("fcm_token"));
			
			FirebaseMessagingService.pushFCMNotification(fcm_token, 
					title , content, "danger", content, true);
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