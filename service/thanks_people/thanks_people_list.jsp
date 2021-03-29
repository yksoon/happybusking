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
* 해당 팀의 후원내역
*******************************************/
String sql = "";
String sql2 = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;
ResultSet rs2 = null;

//임시 팀명 하늘, 임시 유저번호 6번
String team_name = ParamUtil.getString(request, "team_name", "하늘");
String user_no = ParamUtil.getString(request, "user_no", "6");

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT TEAM_NO, TEAM_NAME, TEAM_MONEY, " + "\r\n" +
				"(SELECT LEADER_CHK FROM TEAM_MEMBER WHERE USER_NO = "+ user_no +
				" AND TEAM_NO = T.TEAM_NO) AS LEADER_CHK" + "\r\n" +
				"FROM TEAM T " + "\r\n" +
				"WHERE TEAM_NAME = '" + team_name + "'";
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
		%>
			<DATA>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
				<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
				<TEAM_MONEY><%=ConvertUtil.toStr(rs.getString("TEAM_MONEY"))%></TEAM_MONEY>
				<LEADER_CHK><%=ConvertUtil.toStr(rs.getString("LEADER_CHK"))%></LEADER_CHK>
			</DATA>
		<%
			String team_no = ConvertUtil.toString(rs.getString("TEAM_NO"));
			
			sql2 = "SELECT *, " + "\r\n" +
					"(SELECT NICKNAME FROM USER WHERE USER_NO = S.USER_NO) AS NICKNAME " + "\r\n" +
					"FROM SUPPORT S " + "\r\n" +
					"WHERE TEAM_NO = '" + team_no + "'\r\n" +
					"AND SUPPORT_SUCCESS = 'Y'" + "\r\n" +
					"ORDER BY SUPPORT_DATE DESC";
			
			rs2 = pstmt.executeQuery(sql2);
			
			while(rs2.next()){
				%>
					<DATA2>
						<SUPPORT_PRICE><%=ConvertUtil.toStr(rs2.getString("SUPPORT_PRICE"))%></SUPPORT_PRICE>
						<SUPPORT_DATE><%=ConvertUtil.toStr(rs2.getString("SUPPORT_DATE"))%></SUPPORT_DATE>
						<SUPPORT_MSG><%=ConvertUtil.toStr(rs2.getString("SUPPORT_MSG"))%></SUPPORT_MSG>
						<NICKNAME><%=ConvertUtil.toStr(rs2.getString("NICKNAME"))%></NICKNAME>
					</DATA2>
				<%
			}
		}
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
	rs2.close();
} catch (Exception ex) {}
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>