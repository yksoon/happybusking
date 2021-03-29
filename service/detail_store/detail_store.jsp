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
* STORE 상세 볼러오기(SELECT)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;

String perform_no = ParamUtil.getString(request, "perform_no", "");
//out.println("test_no : "+test_no);
//WHERE R.PERFORM_NO = ? AND S.USER_NO = 
%>
<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT USER_NO, SPACE_PICTURE, STAGE_PICTURE, ADDRESS, DETAIL_ADDR, OPERATIONHOUR, EQUIPMENT, MAIN_GENRE, GENRE, PARKING_CHK, PERFORM_TIPBOX," + "\r\n" +  
			         "MOBILE_TIPBOX, VIDEO_CHK, MENU, HASHTAG, ZONE_INFO, LICENSE_PICTURE, BUSINESS_WORKNAME, BUSINESS_PHONE, BUSINESS_REPRESENTIVE, BUSINESS_NO," + "\r\n" +   
                     "PERFORM_NO, BUSKINGDATE, STARTINGTIME, FINISHINGTIME, OFFERPRICE,"  + "\r\n" +  
                     "CASE WHEN BUSKINGDATE < date(NOW()) THEN '5'"  + "\r\n" +  
					 "ELSE BUSKINGSTATUS" + "\r\n" +  
					 "END AS BUSKINGSTATUS, group_concat(merge_column) as ARTIST_MATCHING" + "\r\n" +  
                "FROM (" + "\r\n" +  
                       " SELECT S.USER_NO, S.SPACE_PICTURE, S.STAGE_PICTURE, S.ADDRESS, S.DETAIL_ADDR, S.OPERATIONHOUR, S.EQUIPMENT, S.MAIN_GENRE, S.GENRE, S.PARKING_CHK, S.PERFORM_TIPBOX," + "\r\n" +  
                                            "S.MOBILE_TIPBOX, S.VIDEO_CHK, S.MENU, S.HASHTAG, S.ZONE_INFO, S.LICENSE_PICTURE, B.BUSINESS_WORKNAME, B.BUSINESS_PHONE, B.BUSINESS_REPRESENTIVE, B.BUSINESS_NO," + "\r\n" +  
                                            "R.PERFORM_NO, R.BUSKINGDATE, R.STARTINGTIME, R.FINISHINGTIME, R.OFFERPRICE, R.BUSKINGSTATUS, concat(P.USER_NO, '/', P.MATCHING_CHK) as merge_column" + "\r\n" +   
                                        "FROM STORE S LEFT OUTER JOIN BUSINESS B" + "\r\n" +  
                                        "ON S.USER_NO = B.USER_NO" + "\r\n" +  
                                        "LEFT OUTER JOIN REG_BUSKINGTIME R" + "\r\n" +  
                                        "ON S.USER_NO = R.USER_NO" + "\r\n" +  
                                        "LEFT OUTER JOIN REG_PERFORM P" + "\r\n" +  
                                        "ON R.PERFORM_NO = P.PERFORM_NO" + "\r\n" +    
                            "WHERE R.PERFORM_NO = '"+perform_no+"'  ) as T1";
		
		//sql = sql.replace("{test_no}", test_no);
		
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO")) %></USER_NO>
				<SPACE_PICTURE><%=ConvertUtil.toStr(rs.getString("SPACE_PICTURE")) %></SPACE_PICTURE>
				<STAGE_PICTURE><%=ConvertUtil.toStr(rs.getString("STAGE_PICTURE")) %></STAGE_PICTURE>
				<ADDRESS><%=ConvertUtil.toStr(rs.getString("ADDRESS")) %></ADDRESS>
                <DETAIL_ADDR><%=ConvertUtil.toStr(rs.getString("DETAIL_ADDR")) %></DETAIL_ADDR>
				<OPERATIONHOUR><%=ConvertUtil.toStr(rs.getString("OPERATIONHOUR")) %></OPERATIONHOUR>
				<EQUIPMENT><%=ConvertUtil.toStr(rs.getString("EQUIPMENT")) %></EQUIPMENT>
				<MAIN_GENRE><%=ConvertUtil.toStr(rs.getString("MAIN_GENRE")) %></MAIN_GENRE>
				<GENRE><%=ConvertUtil.toStr(rs.getString("GENRE")) %></GENRE>
				<PARKING_CHK><%=ConvertUtil.toStr(rs.getString("PARKING_CHK")) %></PARKING_CHK>
				<PERFORM_TIPBOX><%=ConvertUtil.toStr(rs.getString("PERFORM_TIPBOX")) %></PERFORM_TIPBOX>
				<MOBILE_TIPBOX><%=ConvertUtil.toStr(rs.getString("MOBILE_TIPBOX")) %></MOBILE_TIPBOX>
				<VIDEO_CHK><%=ConvertUtil.toStr(rs.getString("VIDEO_CHK")) %></VIDEO_CHK>
				<MENU><%=ConvertUtil.toStr(rs.getString("MENU")) %></MENU>
				<HASHTAG><%=ConvertUtil.toStr(rs.getString("HASHTAG")) %></HASHTAG>
				<ZONE_INFO><%=ConvertUtil.toStr(rs.getString("ZONE_INFO")) %></ZONE_INFO>
				<LICENSE_PICTURE><%=ConvertUtil.toStr(rs.getString("LICENSE_PICTURE")) %></LICENSE_PICTURE>
				<BUSINESS_WORKNAME><%=ConvertUtil.toStr(rs.getString("BUSINESS_WORKNAME")) %></BUSINESS_WORKNAME>
				<BUSINESS_PHONE><%=ConvertUtil.toStr(rs.getString("BUSINESS_PHONE")) %></BUSINESS_PHONE>
                <BUSINESS_REPRESENTIVE><%=ConvertUtil.toStr(rs.getString("BUSINESS_REPRESENTIVE")) %></BUSINESS_REPRESENTIVE>
                <BUSINESS_NO><%=ConvertUtil.toStr(rs.getString("BUSINESS_NO")) %></BUSINESS_NO>
				<PERFORM_NO><%=ConvertUtil.toStr(rs.getString("PERFORM_NO")) %></PERFORM_NO>
                <BUSKINGDATE><%=ConvertUtil.toStr(rs.getString("BUSKINGDATE")) %></BUSKINGDATE>
                <STARTINGTIME><%=ConvertUtil.toStr(rs.getString("STARTINGTIME")) %></STARTINGTIME>
                <FINISHINGTIME><%=ConvertUtil.toStr(rs.getString("FINISHINGTIME")) %></FINISHINGTIME>
                <OFFERPRICE><%=ConvertUtil.toStr(rs.getString("OFFERPRICE")) %></OFFERPRICE>
                <BUSKINGSTATUS><%=ConvertUtil.toStr(rs.getString("BUSKINGSTATUS")) %></BUSKINGSTATUS>
                <ARTIST_MATCHING><%=ConvertUtil.toStr(rs.getString("ARTIST_MATCHING")) %></ARTIST_MATCHING>
			</DATA>
			<%
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
} catch (Exception ex) {}
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>