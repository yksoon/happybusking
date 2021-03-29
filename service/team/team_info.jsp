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
* 아티스트 정보
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
ResultSet rs2 = null;

boolean result = false;
String msg = "";

String team_no = ParamUtil.getString(request, "team_no", "0");
String user_no = ParamUtil.getString(request, "user_no", "0");
String team_name = ParamUtil.getString(request, "team_name", "");

//System.out.println("team_no : " + team_no);	
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		if(team_name.equals("")){
			//아티스트 정보 및 관심수 COUNT
			sql = "SELECT *, (SELECT COUNT(*) FROM INTEREST WHERE TEAM_NO = '" + team_no + "') AS CNT, " + "\r\n" +  
					"(SELECT COUNT(*) FROM INTEREST WHERE TEAM_NO = '"+ team_no +"' AND USER_NO = "+user_no+") AS I_CHK, " + "\r\n" +
					"(SELECT PF_DATE FROM PERFORM WHERE TEAM_NO = '"+ team_no + "' AND PF_DATE > NOW() AND PF_CANCLE IN(0) ORDER BY PF_DATE ASC LIMIT 1) AS PF_DATE," + "\r\n" +
					"(SELECT COUNT(*) FROM TEAM_MEDIA WHERE TM_TEAM_NO = '"+team_no+"' AND TM_TYPE = 2) AS TM_COUNT" + "\r\n" +
					"FROM TEAM " + "\r\n" +
					"WHERE TEAM_NO  = '" + team_no + "'\r\n";
			
		}
		else{
			sql = "SELECT * , (SELECT COUNT(*) FROM INTEREST WHERE TEAM_NO = '" + team_no + "') AS CNT, " + "\r\n" +
					"(SELECT COUNT(*) FROM INTEREST WHERE TEAM_NO = '"+ team_no +"' AND USER_NO = "+user_no+") AS I_CHK, " + "\r\n" +
					"(SELECT PF_DATE FROM PERFORM WHERE TEAM_NO = '" + team_no + "' AND PF_DATE > NOW() AND PF_CANCLE IN(0) ORDER BY PF_DATE ASC LIMIT 1) AS PF_DATE," + "\r\n" +
					"(SELECT COUNT(*) FROM TEAM_MEDIA WHERE TM_TEAM_NO = '"+team_no+"' AND TM_TYPE = 2) AS TM_COUNT" + "\r\n" +
					"FROM TEAM" + "\r\n" +
					"WHERE TEAM_NAME = '" + team_name + "'";
		}

		
		//System.out.println(sql);
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			%>
				<DATA>
					<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
					<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT"))%></CNT>
					<PF_DATE><%=ConvertUtil.toStr(rs.getString("PF_DATE"))%></PF_DATE>
					<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
					<TEAM_INTRO><%=ConvertUtil.toStr(rs.getString("TEAM_INTRO"))%></TEAM_INTRO>
					<TEAM_GENRE><%=ConvertUtil.toStr(rs.getString("CODE_GENRE"))%></TEAM_GENRE>
					<TINTRO_IMG><%=ConvertUtil.toStr(rs.getString("TINTRO_IMG"))%></TINTRO_IMG>
					<TINTRO_VIDEO><%=ConvertUtil.toString(rs.getString("TINTRO_VIDEO"))%></TINTRO_VIDEO>	 
					<TVIDEO_THUMBNAIL><%=ConvertUtil.toStr(rs.getString("TVIDEO_THUMBNAIL"))%></TVIDEO_THUMBNAIL>	
					<TVIDEO_TITLE><%=ConvertUtil.toStr(rs.getString("TVIDEO_TITLE"))%></TVIDEO_TITLE>	
					<TVIDEO_CONTENT><%=ConvertUtil.toStr(rs.getString("TVIDEO_CONTENT"))%></TVIDEO_CONTENT>	
					<TEAM_MONEY><%=ConvertUtil.toStr(rs.getString("TEAM_MONEY"))%></TEAM_MONEY>	
					<TEAM_ACC_HOLDER><%=ConvertUtil.toStr(rs.getString("TEAM_ACC_HOLDER"))%></TEAM_ACC_HOLDER>	
					<TEAM_BANK><%=ConvertUtil.toStr(rs.getString("TEAM_BANK"))%></TEAM_BANK>	
					<TEAM_ACCOUNT><%=ConvertUtil.toStr(rs.getString("TEAM_ACCOUNT"))%></TEAM_ACCOUNT>	
					<I_CHK><%=ConvertUtil.toStr(rs.getString("I_CHK"))%></I_CHK>
					<TM_COUNT><%=ConvertUtil.toStr(rs.getString("TM_COUNT"))%></TM_COUNT>
					<BELONG><%=ConvertUtil.toStr(rs.getString("BELONG"))%></BELONG>		
				</DATA>	
	<% 	
		}
			
		
		 	sql2 = "SELECT *  " + "\r\n" +  
		 			 "FROM TEAM_MEMBER TM, ARTIST A " + "\r\n" + 
		 			"WHERE TM.USER_NO = A.USER_NO" + "\r\n" + 
		 			  "AND TM.TEAM_NO = '" + team_no + "'\r\n" +
		 			  "AND MEMBER_REQ_STATUS IN (2)";
		 	
		 	//System.out.println(sql2);
			rs2 = pstmt.executeQuery(sql2);
			
			while(rs2.next()){
			%>
					<DATA2>
						<USER_NO><%=ConvertUtil.toStr(rs2.getString("USER_NO"))%></USER_NO>
						<TEAM_NO><%=ConvertUtil.toStr(rs2.getString("TEAM_NO"))%></TEAM_NO>
						<PART><%=ConvertUtil.toStr(rs2.getString("PART"))%></PART>
						<ARTIST_IMG><%=ConvertUtil.toStr(rs2.getString("ARTIST_IMG"))%></ARTIST_IMG>
						<ARTIST_NAME><%=ConvertUtil.toStr(rs2.getString("ARTIST_NAME"))%></ARTIST_NAME>
					</DATA2>	
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
	rs2.close();
} catch (Exception ex) {}
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>