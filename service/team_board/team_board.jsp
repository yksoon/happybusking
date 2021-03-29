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
* 게시판 목록 가져오기
*******************************************/
String sql = "";
String sql_content = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String board_category = ParamUtil.getString(request, "board_category", "");
String team_board_sort = ParamUtil.getString(request, "team_board_sort", "1");
String start = ParamUtil.getString(request, "start", "0");
String end = ParamUtil.getString(request, "end", "10");
String tb_search = ParamUtil.getString(request, "tb_search", "");

if(board_category.equals("자유")){
	board_category = "1";
}
else if(board_category.equals("팀원모집")){
	board_category = "2";
}
else{
	board_category = "3";
}

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT B.*, A.ARTIST_NAME, A.ARTIST_IMG, " + "\r\n" +
				"(SELECT COUNT(*) FROM BOARD_REPLY WHERE BOARD_NO = B.BOARD_NO) AS CNT " + "\r\n" +
				"FROM BOARD B " + "\r\n" +
				"JOIN ARTIST A ON B.USER_NO = A.USER_NO " + "\r\n" +
				"WHERE B.BOARD_CATEGORY = " + board_category + " AND BOARD_DEL <> 'Y'" +"\r\n";
		if(tb_search.equals("")){
			if(team_board_sort.equals("1")){
				sql_content =  "ORDER BY B.BOARD_DATE DESC" + "\r\n" + 
									"LIMIT " + start + ", " + end + "\r\n";
			}
			else if(team_board_sort.equals("2")){
				sql_content = "ORDER BY CNT DESC, B.BOARD_DATE DESC " + "\r\n" +
						"LIMIT " + start + ", " + end + "\r\n";
			}
			else{
				sql_content = "ORDER BY BOARD_HITS DESC, B.BOARD_DATE DESC" + "\r\n" +
						"LIMIT " + start + ", " + end + "\r\n";
			}
		}
		else{
			if(team_board_sort.equals("1")){
				sql_content = "AND (B.BOARD_TITLE LIKE '%"+tb_search+"%' " + "\r\n" +
								"OR ARTIST_NAME LIKE '%"+tb_search+"%')" + "\r\n" +
								"ORDER BY B.BOARD_DATE DESC" + "\r\n" + 
								"LIMIT " + start + ", " + end + "\r\n";
			}
			else if(team_board_sort.equals("2")){
				sql_content = "AND (B.BOARD_TITLE LIKE '%"+tb_search+"%' " + "\r\n" +
								"OR ARTIST_NAME LIKE '%"+tb_search+"%')" + "\r\n" +
								"ORDER BY CNT DESC, B.BOARD_DATE DESC " + "\r\n" +
								"LIMIT " + start + ", " + end + "\r\n";
			}
			else{
				sql_content = "AND (B.BOARD_TITLE LIKE '%"+tb_search+"%' " + "\r\n" +
								"OR ARTIST_NAME LIKE '%"+tb_search+"%')" + "\r\n" +
								"ORDER BY BOARD_HITS DESC, B.BOARD_DATE DESC" + "\r\n" +
								"LIMIT " + start + ", " + end + "\r\n";
			}
		}
		
		sql = sql.concat(sql_content);
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<BOARD_NO><%=ConvertUtil.toInteger(rs.getInt("BOARD_NO"))%></BOARD_NO>
					<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO"))%></USER_NO>
					<BOARD_DATE><%=ConvertUtil.toString(rs.getString("BOARD_DATE"))%></BOARD_DATE>
					<BOARD_HITS><%=ConvertUtil.toInteger(rs.getInt("BOARD_HITS"))%></BOARD_HITS>
					<BOARD_TITLE><%=ConvertUtil.toString(rs.getString("BOARD_TITLE"))%></BOARD_TITLE>
					<BOARD_CONTENT><%=ConvertUtil.toString(rs.getString("BOARD_CONTENT"))%></BOARD_CONTENT>
					<CODE_DECLARE><%=ConvertUtil.toString(rs.getString("CODE_DECLARE"))%></CODE_DECLARE>
					<BOARD_DEL><%=ConvertUtil.toString(rs.getString("BOARD_DEL"))%></BOARD_DEL>
					<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT"))%></CNT>
					<ARTIST_NAME><%=ConvertUtil.toString(rs.getString("ARTIST_NAME"))%></ARTIST_NAME>
					<ARTIST_IMG><%=ConvertUtil.toString(rs.getString("ARTIST_IMG"))%></ARTIST_IMG>
				</DATA>	
	<% 	
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