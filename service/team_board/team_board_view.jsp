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
* 게시판 불러오기
*******************************************/
String sql = "";
String sql2 = "";
String sql3 = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;
ResultSet rs2 = null;
ResultSet rs3 = null;

//세션 Parameter
String board_no = ParamUtil.getString(request, "board_no", "");
int board_reply_no;
%>
	<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT B.*, " + "\r\n" +
				"(SELECT ARTIST_NAME FROM ARTIST WHERE USER_NO = B.USER_NO) AS ARTIST_NAME," + "\r\n" +
				"(SELECT COUNT(*) FROM BOARD_REPLY WHERE BOARD_NO = "+ board_no +") AS CNT" + "\r\n" +
				"FROM BOARD B" + "\r\n" +
				"WHERE B.BOARD_NO = " + board_no;
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
		%>
			<DATA>
				<BOARD_NO><%=ConvertUtil.toInteger(rs.getInt("BOARD_NO"))%></BOARD_NO>
				<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO"))%></USER_NO>
				<BOARD_CATEGORY><%=ConvertUtil.toString(rs.getString("BOARD_CATEGORY"))%></BOARD_CATEGORY>
				<BOARD_DATE><%=ConvertUtil.toString(rs.getString("BOARD_DATE"))%></BOARD_DATE>
				<BOARD_HITS><%=ConvertUtil.toInteger(rs.getInt("BOARD_HITS"))%></BOARD_HITS>
				<BOARD_TITLE><%=ConvertUtil.toString(rs.getString("BOARD_TITLE"))%></BOARD_TITLE>
				<BOARD_CONTENT><%=ConvertUtil.toString(rs.getString("BOARD_CONTENT"))%></BOARD_CONTENT>
				<BOARD_DEL><%=ConvertUtil.toString(rs.getString("BOARD_CONTENT"))%></BOARD_DEL>
				<ARTIST_NAME><%=ConvertUtil.toString(rs.getString("ARTIST_NAME"))%></ARTIST_NAME>
				<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT"))%></CNT>
			</DATA>
		<% 
			sql2 = "SELECT *, " + "\r\n" +
					"(SELECT ARTIST_NAME FROM ARTIST WHERE USER_NO = R.USER_NO) AS ARTIST_NAME, " + "\r\n" +
					"(SELECT COUNT(*) FROM BOARD_REPLY WHERE PARENT = R.BOARD_REPLY_NO) AS CNT" + "\r\n" +
					"FROM BOARD_REPLY R" + "\r\n" +
					"WHERE BOARD_NO = " + board_no + "\r\n" +
					"AND PARENT IS NULL" + "\r\n" +
					"ORDER BY BOARD_REPLY_DATE DESC";
			
			rs2 = pstmt.executeQuery(sql2);
			
			while(rs2.next()){
				%>
				<DATA2>
					<USER_NO><%=ConvertUtil.toStr(rs2.getString("USER_NO")) %></USER_NO>
					<BOARD_REPLY_NO><%=ConvertUtil.toInteger(rs2.getInt("BOARD_REPLY_NO")) %></BOARD_REPLY_NO>
					<ARTIST_NAME><%=ConvertUtil.toString(rs2.getString("ARTIST_NAME"))%></ARTIST_NAME>
					<BOARD_REPLY_DATE><%=ConvertUtil.toString(rs2.getString("BOARD_REPLY_DATE"))%></BOARD_REPLY_DATE>
					<BOARD_REPLY_CONTENT><%=ConvertUtil.toString(rs2.getString("BOARD_REPLY_CONTENT"))%></BOARD_REPLY_CONTENT>
					<BOARD_REPLY_DEL><%=ConvertUtil.toString(rs2.getString("BOARD_REPLY_DEL"))%></BOARD_REPLY_DEL>
					<CODE_DECLARE><%=ConvertUtil.toString(rs2.getString("CODE_DECLARE"))%></CODE_DECLARE>
					<CNT><%=ConvertUtil.toInteger(rs2.getInt("CNT"))%></CNT>
				</DATA2>
				<%
				board_reply_no = ConvertUtil.toInteger(rs2.getInt("BOARD_REPLY_NO"));
					
				sql3 = "SELECT *, " + "\r\n" +
						"(SELECT ARTIST_NAME FROM ARTIST WHERE USER_NO = R.USER_NO) AS ARTIST_NAME " + "\r\n" +
						"FROM BOARD_REPLY R" + "\r\n" +
						"WHERE BOARD_NO = "+ board_no +" AND PARENT =" + board_reply_no;
				
				rs3 = pstmt.executeQuery(sql3);					
				while(rs3.next()){
					%>
					<DATA3>
						<USER_NO><%=ConvertUtil.toStr(rs3.getString("USER_NO")) %></USER_NO>
						<BOARD_REPLY_NO><%=ConvertUtil.toInteger(rs3.getInt("BOARD_REPLY_NO")) %></BOARD_REPLY_NO>
						<PARENT><%=ConvertUtil.toInteger(rs3.getInt("PARENT")) %></PARENT>
						<ARTIST_NAME><%=ConvertUtil.toString(rs3.getString("ARTIST_NAME"))%></ARTIST_NAME>
						<BOARD_REPLY_DATE><%=ConvertUtil.toString(rs3.getString("BOARD_REPLY_DATE"))%></BOARD_REPLY_DATE>
						<BOARD_REPLY_CONTENT><%=ConvertUtil.toString(rs3.getString("BOARD_REPLY_CONTENT"))%></BOARD_REPLY_CONTENT>
						<BOARD_REPLY_DEL><%=ConvertUtil.toString(rs3.getString("BOARD_REPLY_DEL"))%></BOARD_REPLY_DEL>
						<CODE_DECLARE><%=ConvertUtil.toString(rs3.getString("CODE_DECLARE"))%></CODE_DECLARE>
					</DATA3>
					<%
				}
			}
		}
	%>
	</ROOT>
	<%
		}catch(Exception e){
			e.printStackTrace();
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