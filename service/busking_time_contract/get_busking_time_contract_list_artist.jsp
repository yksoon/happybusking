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
		
		sql = "SELECT a.PERFORM_NO, d.BUSINESS_WORKNAME, " + "\r\n" +
                "case" + "\r\n" +
                "when b.BUSKINGDATE < date(NOW()) AND a.MATCHING_CHK = '3' " + "\r\n" +
                "then '공연완료'" + "\r\n" +
                "else a.MATCHING_CHK " + "\r\n" +
                "end AS MATCHING_CHK, " + "\r\n" +
                "b.DAYOFTHEWEEK, b.BUSKINGDATE, b.STARTINGTIME, b.FINISHINGTIME, c.SPACE_PICTURE, b.USER_NO, a.TEAM_NO" + "\r\n" +
				"FROM reg_perform a" + "\r\n" +
				"LEFT JOIN reg_buskingtime b" + "\r\n" +
				"ON a.PERFORM_NO = b.PERFORM_NO" + "\r\n" +
                "JOIN store c" + "\r\n" +
                "ON b.USER_NO = c.USER_NO" + "\r\n" +
				"JOIN business d" + "\r\n" +
				"ON c.USER_NO = d.USER_NO" + "\r\n" +
				"WHERE a.USER_NO = '" + user_no + "'" + "\r\n" +
				"AND BUSKINGDATE LIKE '%" + search_date + "%'" + "\r\n" +
				"ORDER BY a.APPLYDATE DESC";
		
		rs = pstmt.executeQuery(sql);
		
		System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
				<USER_NO><%=ConvertUtil.toString(rs.getString("USER_NO"))%></USER_NO>
				<PERFORM_NO><%=ConvertUtil.toString(rs.getString("PERFORM_NO"))%></PERFORM_NO>
				<BUSKINGDATE><%=ConvertUtil.toString(rs.getString("BUSKINGDATE")) %></BUSKINGDATE>
                <STARTINGTIME><%=ConvertUtil.toString(rs.getString("STARTINGTIME")) %></STARTINGTIME>
                <FINISHINGTIME><%=ConvertUtil.toString(rs.getString("FINISHINGTIME")) %></FINISHINGTIME>
                <DAYOFTHEWEEK><%=ConvertUtil.toString(rs.getString("DAYOFTHEWEEK")) %></DAYOFTHEWEEK>
                <TEAM_NO><%=ConvertUtil.toString(rs.getString("TEAM_NO")) %></TEAM_NO>
				<MATCHING_CHK><%=ConvertUtil.toString(rs.getString("MATCHING_CHK")) %></MATCHING_CHK>
				<BUSINESS_WORKNAME><%=ConvertUtil.toString(rs.getString("BUSINESS_WORKNAME")) %></BUSINESS_WORKNAME>
				<SPACE_PICTURE><%=ConvertUtil.toString(rs.getString("SPACE_PICTURE")) %></SPACE_PICTURE>
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