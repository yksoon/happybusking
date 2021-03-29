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
* 승인 상세페이지 계약상태 받아오기
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String perform_no = ParamUtil.getString(request, "perform_no", "");
%>
<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

        sql = "SELECT b.TEAM_NAME, c.ARTIST_NAME, a.CONTRACT_PRICE, a.CONTRACT_STATUS, b.OFFERPRICE, a.USER_NO, b.BUSKINGSTATUS" + "\r\n" +
                    "FROM e_contract a" + "\r\n" +
                    "JOIN reg_buskingtime b ON a.PERFORM_NO = b.PERFORM_NO" + "\r\n" +
                    "JOIN artist c ON a.USER_NO = c.USER_NO" + "\r\n" +
                    "WHERE a.PERFORM_NO = '"+ perform_no +"'";
        

        		rs = pstmt.executeQuery(sql);
		
		// System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
                <TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME")) %></TEAM_NAME>
                <ARTIST_NAME><%=ConvertUtil.toString(rs.getString("ARTIST_NAME")) %></ARTIST_NAME>
                <CONTRACT_PRICE><%=ConvertUtil.toString(rs.getString("CONTRACT_PRICE")) %></CONTRACT_PRICE>
                <CONTRACT_STATUS><%=ConvertUtil.toString(rs.getString("CONTRACT_STATUS")) %></CONTRACT_STATUS>
                <OFFERPRICE><%=ConvertUtil.toString(rs.getInt("OFFERPRICE")) %></OFFERPRICE>
                <USER_NO><%=ConvertUtil.toString(rs.getString("USER_NO")) %></USER_NO>
				<BUSKINGSTATUS><%=ConvertUtil.toString(rs.getString("BUSKINGSTATUS")) %></BUSKINGSTATUS>
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