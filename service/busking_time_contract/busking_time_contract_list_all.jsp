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
* 공연 신청/계약 이력
*******************************************/
String sql = "";
String sql2 = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
ResultSet rs2 = null;

boolean result = false;
String msg = "";

//세션 Parameter
String user_no = ParamUtil.getString(request, "user_no", "");
String search_date = ParamUtil.getString(request, "search_date", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		//sql = "SELECT a.PERFORM_NO, a.TEAM_NO, a.MATCHING_CHK, c.TEAM_NAME, b.BUSKINGDATE, b.STARTINGTIME, b.FINISHINGTIME, b.DAYOFTHEWEEK, b.OFFERPRICE, c.TINTRO_IMG, b.BUSKINGSTATUS " + "\r\n" +
				//"FROM   reg_perform a " + "\r\n" +
				//"JOIN reg_buskingtime b" + "\r\n" +
				//"ON a.PERFORM_NO = b.PERFORM_NO " + "\r\n" +
				//"JOIN team c" + "\r\n" +
				//"ON a.TEAM_NO = c.TEAM_NO" + "\r\n" +
				//"WHERE  a.PERFORM_NO IN (SELECT PERFORM_NO " + "\r\n" +
				//"FROM   reg_buskingtime " + "\r\n" +
				//"WHERE USER_NO <> '해피버스킹'" + "\r\n" +
				//"AND USER_NO='" + user_no + "'" + "\r\n" +
				//"AND BUSKINGDATE LIKE '%" + search_date + "%') " + "\r\n" +
				//"GROUP  BY TEAM_NO, " + "\r\n" +
				//"BUSKINGDATE, " + "\r\n" +
				//"STARTINGTIME " + "\r\n" +
				//"ORDER  BY APPLYDATE DESC ";

		sql = "SELECT CASE WHEN a.PERFORM_NO IS NULL THEN CONCAT('NULL',b.PERFORM_NO) ELSE a.PERFORM_NO END AS PERFORM_NO," + "\r\n" +
				"a.TEAM_NO, a.MATCHING_CHK, c.TEAM_NAME, b.BUSKINGDATE, b.STARTINGTIME, b.FINISHINGTIME, b.DAYOFTHEWEEK, b.OFFERPRICE, c.TINTRO_IMG, b.BUSKINGSTATUS " + "\r\n" +
				"FROM   reg_perform a " + "\r\n" +
				"RIGHT OUTER JOIN reg_buskingtime b" + "\r\n" +
				"ON a.PERFORM_NO = b.PERFORM_NO " + "\r\n" +
				"LEFT OUTER JOIN team c" + "\r\n" +
				"ON a.TEAM_NO = c.TEAM_NO" + "\r\n" +
				"WHERE  b.PERFORM_NO IN (SELECT PERFORM_NO " + "\r\n" +
				"FROM   reg_buskingtime " + "\r\n" +
				"WHERE USER_NO <> '해피버스킹'" + "\r\n" +
				"AND b.DELETE_CHK = 'N'" + "\r\n" +
				"AND USER_NO='" + user_no + "'" + "\r\n" +
				"AND BUSKINGDATE LIKE '%" + search_date + "%') " + "\r\n" +
				"GROUP  BY TEAM_NO, " + "\r\n" +
				"BUSKINGDATE, " + "\r\n" +
				"STARTINGTIME " + "\r\n" +
				"ORDER  BY b.REGDATE DESC";
		
		rs = pstmt.executeQuery(sql);

        
		
		System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
				<PERFORM_NO><%=ConvertUtil.toString(rs.getString("PERFORM_NO"))%></PERFORM_NO>
				<BUSKINGDATE><%=ConvertUtil.toString(rs.getString("BUSKINGDATE")) %></BUSKINGDATE>
                <STARTINGTIME><%=ConvertUtil.toString(rs.getString("STARTINGTIME")) %></STARTINGTIME>
                <FINISHINGTIME><%=ConvertUtil.toString(rs.getString("FINISHINGTIME")) %></FINISHINGTIME>
                <DAYOFTHEWEEK><%=ConvertUtil.toString(rs.getString("DAYOFTHEWEEK")) %></DAYOFTHEWEEK>
                <OFFERPRICE><%=ConvertUtil.toString(rs.getInt("OFFERPRICE")) %></OFFERPRICE>
                <TEAM_NO><%=ConvertUtil.toString(rs.getString("TEAM_NO")) %></TEAM_NO>
                <TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME")) %></TEAM_NAME>
				<MATCHING_CHK><%=ConvertUtil.toString(rs.getString("MATCHING_CHK")) %></MATCHING_CHK>
				<TINTRO_IMG><%=ConvertUtil.toString(rs.getString("TINTRO_IMG")) %></TINTRO_IMG>
				<BUSKINGSTATUS><%=ConvertUtil.toString(rs.getString("BUSKINGSTATUS")) %></BUSKINGSTATUS>
				<%	
				String perform_no = ConvertUtil.toString(rs.getString("PERFORM_NO"));

				sql2 = "SELECT CONTRACT_STATUS " + "\r\n" +
						"FROM e_contract" + "\r\n" +
						"WHERE PERFORM_NO = '" + perform_no + "'";
				
				rs2 = pstmt.executeQuery(sql2);

				while(rs2.next()){

					System.out.println(perform_no + " - " +ConvertUtil.toStr(rs2.getString("CONTRACT_STATUS")));

				%>
					<DATA2>
						<CONTRACT_STATUS><%=ConvertUtil.toStr(rs2.getString("CONTRACT_STATUS"))%></CONTRACT_STATUS>
					</DATA2>
				<%
				}
				%>
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