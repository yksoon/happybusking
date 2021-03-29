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
* 아티스트 세부 정보
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;


boolean result = false;
String msg = "";

String user_no = ParamUtil.getString(request, "uno", "");
String team_no = ParamUtil.getString(request, "tno", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		//아티스트 세부 정보 및 카운트
		sql = 	"SELECT USER.USER_NO, USER.GENDER, " + "\r\n" +  
				"ARTIST.*, TEAM.TEAM_NAME, TEAM_MEMBER.PART, " + "\r\n" +  
				"(SELECT COUNT(*) FROM INTEREST WHERE TEAM_NO ='" + team_no + "') AS CNT" + "\r\n" + 
				  "FROM USER, ARTIST, TEAM, TEAM_MEMBER " + "\r\n" + 
				 "WHERE USER.USER_NO = ARTIST.USER_NO " + "\r\n" + 
				   "AND TEAM_MEMBER.USER_NO = ARTIST.USER_NO " + "\r\n" + 
				   "AND TEAM_MEMBER.TEAM_NO = TEAM.TEAM_NO " + "\r\n" + 
				   "AND TEAM.TEAM_NO =" + team_no + "\r\n" + 
				   "AND ARTIST.USER_NO = '"+ user_no + "'\r\n" + 
				   "AND USER.ARTIST_CHK = 'Y' " + "\r\n";

		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			%>
				<DATA>
					<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO"))%></USER_NO>
					<%-- <AGE><%=ConvertUtil.toStr(rs.getString("AGE"))%></AGE> --%>
					<GENDER><%=ConvertUtil.toStr(rs.getString("GENDER"))%></GENDER>
					<ARTIST_NAME><%=ConvertUtil.toStr(rs.getString("ARTIST_NAME"))%></ARTIST_NAME>
					<ARTIST_INTRO><%=ConvertUtil.toStr(rs.getString("ARTIST_INTRO"))%></ARTIST_INTRO>
					<ARTIST_IMG><%=ConvertUtil.toStr(rs.getString("ARTIST_IMG"))%></ARTIST_IMG>
					<CODE_GENRE><%=ConvertUtil.toString(rs.getString("CODE_GENRE"))%></CODE_GENRE>	 
					<USE_TOOL><%=ConvertUtil.toStr(rs.getString("USE_TOOL"))%></USE_TOOL>	
					<ARTIST_SNS><%=ConvertUtil.toStr(rs.getString("ARTIST_SNS"))%></ARTIST_SNS>	
					<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
					<PART><%=ConvertUtil.toStr(rs.getString("PART"))%></PART>
					<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT"))%></CNT>
					<PHONE><%=ConvertUtil.toStr(rs.getString("PHONE"))%></PHONE>
					<POSTCODE><%=ConvertUtil.toStr(rs.getString("POSTCODE"))%></POSTCODE>
					<ADDR><%=ConvertUtil.toStr(rs.getString("ADDR"))%></ADDR>
					<DETAIL_ADDR><%=ConvertUtil.toStr(rs.getString("DETAIL_ADDR"))%></DETAIL_ADDR>
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