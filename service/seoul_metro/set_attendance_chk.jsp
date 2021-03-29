<?xml version="1.0" encoding="utf-8"?>
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
* 앱 QR SCAN시 출석 여부 (SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
PreparedStatement pstmt2 = null;
ResultSet rs = null;

String user_no = USER_NO;
if(USER_NO == null || USER_NO.equals("")) user_no = "0";

String no = "";
String res = "0";
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql =  "select tm.team_no, sa.*" + "\r\n" +
				"from team_member tm" + "\r\n" +
				"join schedule_application sa on sa.tno = tm.team_no" + "\r\n" +
				"where tm.user_no = '"+user_no+"'" + "\r\n" +
				"and tm.member_req_status = '2'" + "\r\n" +
				"and sa.attendance = 'N'" + "\r\n" +
				"and sa.cancel = 'N'" + "\r\n" +
				"and sa.date = date_format(now(),'%Y%m%d')" + "\r\n" +
				"and sa.stime <= date_format(now(), '%H:%i')" + "\r\n" +
				"and sa.etime > date_format(now(), '%H:%i')" + "\r\n" ;
				
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			no = ConvertUtil.toStr(rs.getString("NO"));
			
			sql = "update schedule_application" + "\r\n" +
					"set attendance = 'Y'" + "\r\n" +
					"where no = ?" + "\r\n";
			
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setString(1, no);
			
			pstmt2.executeUpdate();
			
			res = "1";
		}
		
		%>
			<DATA>
				<RES><%=res %></RES>
			</DATA>
		<%
		
%>
</ROOT>
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
	if(pstmt2 != null) pstmt2.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>