<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@page import="java.awt.Image"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="src.util.ImageSizeChange"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%@include file="/service_include.jsp" %>



<%
/*******************************************
* 공연 일정 등록(insert)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String perform_no = ParamUtil.getString(request, "perform_no", "");
String busking_date = ParamUtil.getString(request, "busking_date", "");
String starting_time = ParamUtil.getString(request, "starting_time", "");
String finishing_time = ParamUtil.getString(request, "finishing_time", "");
String day_of_the_week = ParamUtil.getString(request, "day_of_the_week", "");
String offer_price = ParamUtil.getString(request, "offer_price", "");
String team_no = ParamUtil.getString(request, "team_no", "");
String team_name = ParamUtil.getString(request, "team_name", "");
String user_no = ParamUtil.getString(request, "user_no", "");
String busking_status = ParamUtil.getString(request, "busking_status", "");

System.out.println(perform_no);
%>

<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		//업로드
		
	    		sql = "INSERT INTO " + "\r\n" +
	    				"REG_BUSKINGTIME(PERFORM_NO, BUSKINGDATE, STARTINGTIME, FINISHINGTIME, DAYOFTHEWEEK, OFFERPRICE, TEAM_NO, TEAM_NAME, USER_NO, BUSKINGSTATUS) " + "\r\n" +
	    				"VALUES('{perform_no}', STR_TO_DATE('{busking_date}','%Y-%m-%d'), '{starting_time}', '{finishing_time}', '{day_of_the_week}', '{offer_price}', '{team_no}', '{team_name}', '{user_no}', '{busking_status}')";

	    		sql = sql.replace("{perform_no}", perform_no);
	    		sql = sql.replace("{busking_date}", busking_date);
	    		sql = sql.replace("{starting_time}", starting_time);
	    		sql = sql.replace("{finishing_time}", finishing_time);
	    		sql = sql.replace("{day_of_the_week}", day_of_the_week);
	    		sql = sql.replace("{offer_price}", offer_price);
	    		sql = sql.replace("{team_no}", team_no);
	    		sql = sql.replace("{team_name}", team_name);
                sql = sql.replace("{user_no}", user_no);
                sql = sql.replace("{busking_status}", busking_status);
	      			
	    		pstmt.executeUpdate(sql);

                System.out.println(sql);
	    		
	    		msg = "공연 일정 등록에 성공하였습니다.";
	    		result = true;
	}catch(Exception e){
		result = false;
		msg = "공연 일정 등록에 실패하였습니다." + e;
		e.printStackTrace();
	}
%>
 	<ROOT>
		<DATA>
			<RESULT><%=String.valueOf(result)%></RESULT>
			<MESSAGE><%=msg%></MESSAGE>
		</DATA>
	</ROOT> 
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