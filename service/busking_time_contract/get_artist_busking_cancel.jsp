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
* 공연 취소 리스트 가져오기
*******************************************/
String sql = "";
String sql2 = "";
String sql3 = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
ResultSet rs2 = null;
ResultSet rs3 = null;

boolean result = false;
String msg = "";

//세션 Parameter
String perform_no = ParamUtil.getString(request, "perform_no", "");
String user_no = ParamUtil.getString(request, "user_no", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT a.PERFORM_NO, b.BUSKINGDATE, b.STARTINGTIME, b.FINISHINGTIME, b.DAYOFTHEWEEK, b.OFFERPRICE, a.MATCHING_CHK, c.BUSINESS_WORKNAME, d.SPACE_PICTURE, b.USER_NO" + "\r\n" +
				"FROM reg_perform a" + "\r\n" +
                "JOIN reg_buskingtime b ON a.PERFORM_NO = b.PERFORM_NO" + "\r\n" +
                "JOIN business c ON b.USER_NO = c.USER_NO" + "\r\n" +
                "JOIN store d ON b.USER_NO = d.USER_NO" + "\r\n" +
				"WHERE a.PERFORM_NO='" + perform_no + "'" + "\r\n" +
                "AND a.USER_NO = '" + user_no + "'";
		
		rs = pstmt.executeQuery(sql);
		
		//System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
				<PERFORM_NO><%=ConvertUtil.toString(rs.getString("PERFORM_NO"))%></PERFORM_NO>
				<BUSKINGDATE><%=ConvertUtil.toString(rs.getString("BUSKINGDATE")) %></BUSKINGDATE>
                <STARTINGTIME><%=ConvertUtil.toString(rs.getString("STARTINGTIME")) %></STARTINGTIME>
                <FINISHINGTIME><%=ConvertUtil.toString(rs.getString("FINISHINGTIME")) %></FINISHINGTIME>
                <DAYOFTHEWEEK><%=ConvertUtil.toString(rs.getString("DAYOFTHEWEEK")) %></DAYOFTHEWEEK>
                <OFFERPRICE><%=ConvertUtil.toString(rs.getInt("OFFERPRICE")) %></OFFERPRICE>
				<MATCHING_CHK><%=ConvertUtil.toString(rs.getString("MATCHING_CHK")) %></MATCHING_CHK>
				<BUSINESS_WORKNAME><%=ConvertUtil.toString(rs.getString("BUSINESS_WORKNAME")) %></BUSINESS_WORKNAME>
                <SPACE_PICTURE><%=ConvertUtil.toString(rs.getString("SPACE_PICTURE")) %></SPACE_PICTURE>
                <USER_NO><%=ConvertUtil.toString(rs.getString("USER_NO")) %></USER_NO>
			</DATA>

		<%	

            sql2 = "SELECT a.USER_NO, a.TEAM_NO, b.TEAM_NAME, c.ARTIST_NAME, b.TINTRO_IMG, c.ARTIST_IMG, " + "\r\n" +
                    "IF((SELECT PERFORM_NO FROM reg_perform d WHERE user_no= a.USER_NO AND PERFORM_NO='" + perform_no + "'), 'Y', 'N') AS PERFORM_CHK," + "\r\n" +
                    "IF((SELECT PERSONAL_PRICE FROM reg_perform e WHERE user_no= a.USER_NO AND PERFORM_NO='" + perform_no + "'), (SELECT PERSONAL_PRICE FROM reg_perform e WHERE user_no= a.USER_NO AND PERFORM_NO='" + perform_no + "'), '0') AS PERSONAL_PRICE" + "\r\n" +
                    "FROM team_member a" + "\r\n" +
                    "JOIN team b" + "\r\n" +
                    "ON a.TEAM_NO = b.TEAM_NO" + "\r\n" +
                    "JOIN artist c" + "\r\n" +
                    "ON a.USER_NO = c.USER_NO" + "\r\n" +
                    "WHERE a.TEAM_NO = " + "\r\n" +
                    "(SELECT team_no FROM team_member WHERE user_no= '" + user_no + "' LIMIT 1)" + "\r\n" +
                    "AND a.MEMBER_REQ_STATUS = '2'";
            
            rs2 = pstmt.executeQuery(sql2);

            while(rs2.next()){
			%>
				<DATA2>
					<USER_NO><%=ConvertUtil.toStr(rs2.getString("USER_NO"))%></USER_NO>
					<TEAM_NO><%=ConvertUtil.toString(rs2.getString("TEAM_NO")) %></TEAM_NO>
					<TEAM_NAME><%=ConvertUtil.toString(rs2.getString("TEAM_NAME"))%></TEAM_NAME>
					<ARTIST_NAME><%=ConvertUtil.toString(rs2.getString("ARTIST_NAME"))%></ARTIST_NAME>
                    <TINTRO_IMG><%=ConvertUtil.toString(rs2.getString("TINTRO_IMG"))%></TINTRO_IMG>
                    <ARTIST_IMG><%=ConvertUtil.toString(rs2.getString("ARTIST_IMG"))%></ARTIST_IMG>
                    <PERFORM_CHK><%=ConvertUtil.toString(rs2.getString("PERFORM_CHK"))%></PERFORM_CHK>
                    <PERSONAL_PRICE><%=ConvertUtil.toString(rs2.getString("PERSONAL_PRICE"))%></PERSONAL_PRICE>
				</DATA2>
			<%
            }
            
            sql3 = "SELECT COUNT(*) as cnt " + "\r\n" +
                    "FROM team_member a" + "\r\n" +
                    "JOIN team b" + "\r\n" +
                    "ON a.TEAM_NO = b.TEAM_NO" + "\r\n" +
                    "JOIN artist c" + "\r\n" +
                    "ON a.USER_NO = c.USER_NO" + "\r\n" +
                    "WHERE a.TEAM_NO = " + "\r\n" +
                    "(SELECT team_no FROM team_member WHERE user_no= '" + user_no + "')" + "\r\n" +
                    "AND a.MEMBER_REQ_STATUS = '2'";
            
            rs3 = pstmt.executeQuery(sql3);

            System.out.println(sql3);
            while(rs3.next()){
                %>
                <DATA3>
                    <CNT><%=ConvertUtil.toString(rs3.getInt("cnt"))%></CNT>
                </DATA3>
                <%
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