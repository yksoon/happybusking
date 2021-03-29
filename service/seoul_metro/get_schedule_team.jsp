<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
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

String pno = ParamUtil.getString(request, "pno", "0");

String sno = "";
String tno = "";
String ip = request.getRemoteAddr();

String no = "";

SimpleDateFormat tnoSdf = new SimpleDateFormat("yyMMddkkmmss");
int randNum = ((int)(Math.random()*9999)+1);
Date nowdate = new Date();
no = tnoSdf.format(nowdate) + String.format("%04d", randNum);

String res = "0";
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql =  "select sa.*" + "\r\n" +
				"from schedule_application sa" + "\r\n" +
				"where sa.date = date_format(now(),'%Y%m%d')" + "\r\n" +
				"and sa.stime <= date_format(now(), '%H:%i')" + "\r\n" +
				"and sa.etime > date_format(now(), '%H:%i')" + "\r\n" +
				"and pno = '"+pno+"'";
				
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			tno = ConvertUtil.toStr(rs.getString("TNO"));
			sno = ConvertUtil.toStr(rs.getString("NO"));
			
			sql = "select *" + "\r\n" +
					"from scan_count" + "\r\n" +
					"where sno = '"+sno+"'" + "\r\n" +
					"and ip = '"+ip+"'";
					
			//System.out.println(sql);
			
			rs = pstmt.executeQuery(sql);
			
			if(!rs.next()){
				sql = "insert into" + "\r\n" +
						"scan_count(no, sno, ip)" + "\r\n" +
						"values(?, ?, ?)" + "\r\n";
				
				pstmt2 = conn.prepareStatement(sql);
				pstmt2.setString(1, no);
				pstmt2.setString(2, sno);
				pstmt2.setString(3, ip);
				
				pstmt2.executeUpdate();
				
				pstmt2.close();
				
				sql = "insert into" + "\r\n" +
						"evalution_results(no, sno, ip)" +
						"values(?, ?, ?)" + "\r\n";
				
				pstmt2 = conn.prepareStatement(sql);
				pstmt2.setString(1, no);
				pstmt2.setString(2, sno);
				pstmt2.setString(3, ip);
				
				pstmt2.executeUpdate();
				
				res = "1";
			}
		}
		
		%>
			<DATA>
				<TEAM_NO><%=tno %></TEAM_NO>
				<SNO><%=sno %></SNO>
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