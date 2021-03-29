<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.io.File"%>
<%@page import="com.sun.mail.handlers.multipart_mixed"%>
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

<%@ page import="src.util.*"%>

<%@include file="/service_include.jsp" %>

<%
/*******************************************
* hq list(update)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//정보 수정 Parameter

String newTno =  ParamUtil.getString(request, "newTno", "");
String oldTno =  ParamUtil.getString(request, "oldTno", "");


%>


<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		String path = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.0\\happybusking\\ROOT\\upload\\team\\";
		
		String oldTeamF = path + "team" + oldTno;
		String newTeamF = path + "team" + newTno;
		
		File oldFile = new File(oldTeamF);
		File newFile = new File(newTeamF);
		
		if(oldFile.exists()){ 
			oldFile.renameTo(newFile); 
		} else {
			System.out.println("not found file");
		}
		
		sql = "UPDATE EPILOGUE" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE INTEREST" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE ITEM_REQUEST" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE PAY_REQUEST" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		
		sql = "UPDATE PERFORM" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE PERFORM_ALARM" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE PERFORM_REQUEST" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE PERFORM_SYMPATHY" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE QR_REQUEST" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE REVIEW" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE SUPPORT" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE TEAM " + "\r\n" +  
				"SET TEAM_NO='"+newTno+"' " + "\r\n" + 
				"WHERE TEAM_NO ='" + oldTno + "'";
  		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE TEAM_JOIN" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE TEAM_MEDIA" + "\r\n" +
				"SET TM_TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TM_TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE TEAM_MEMBER" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE VIDEO_UPLOAD" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE VISITOR" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE VISITOR_REPLY" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE WITHDRAW" + "\r\n" +
				"SET TEAM_NO='"+newTno+"'" + "\r\n" +
				"WHERE TEAM_NO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);

		sql = "UPDATE SCHEDULE_APPLYCATION" + "\r\n" +
				"SET TNO='"+newTno+"'" + "\r\n" +
				"WHERE TNO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE TEAM_BELONG" + "\r\n" +
				"SET TNO='"+newTno+"'" + "\r\n" +
				"WHERE TNO='"+oldTno+"'";
		
		pstmt.executeUpdate(sql);
		
		result = true;

	}catch(Exception e){
		result = false;
		e.printStackTrace();
	}

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