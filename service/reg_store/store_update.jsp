<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.io.File"%>
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
* 공연 정보 수정(update)
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
Statement pstmt2 = null;
ResultSet rs2 = null;

boolean result = false;
String msg = "";

        /* 공간정보 */
		String business_workname = ParamUtil.getString(request, "business_workname", "");
		String business_representive = ParamUtil.getString(request, "business_representive", "");
		String business_no =ParamUtil.getString(request, "business_no", "");
		String business_phone = ParamUtil.getString(request, "business_phone", "");
		String address = ParamUtil.getString(request, "address", "");
        String detail_addr = ParamUtil.getString(request, "detail_addr", "");
		String parking_chk = ParamUtil.getString(request, "parking_chk", "");
		String perform_tipbox = ParamUtil.getString(request, "perform_tipbox", "");
        String mobile_tipbox = ParamUtil.getString(request, "mobile_tipbox", "");
        String video_chk = ParamUtil.getString(request, "video_chk", "");
		String zone_info = ParamUtil.getString(request, "zone_info", "");
		String space_picture = ParamUtil.getString(request, "space_picture", "");
		String stage_picture = ParamUtil.getString(request, "stage_picture", "");
		String menu = ParamUtil.getString(request, "menu", "");
		String hashtag = ParamUtil.getString(request, "hashtag", "");
		String operationhour = ParamUtil.getString(request, "operationhour", "");
        String main_genre = ParamUtil.getString(request, "main_genre", "");
		String genre = ParamUtil.getString(request, "genre", "");
		String equipment = ParamUtil.getString(request, "equipment", "");
        /* 공연정보 */
        String perform_no = ParamUtil.getString(request, "perform_no", "");
        String buskingdate = ParamUtil.getString(request, "buskingdate", "");
        String dayOfWeek = ParamUtil.getString(request, "dayOfWeek", "");
        String startingtime = ParamUtil.getString(request, "startingtime", "");
        String finishingtime = ParamUtil.getString(request, "finishingtime", "");
        String offerprice = ParamUtil.getString(request, "offerprice", "");

%>


<%
	try{
		conn = dbconn.dbconnect();
        conn.setAutoCommit(false);
		//업로드
		

        sql = "update business" + "\r\n" +
                "set business_workname=?, business_representive=?, business_no=?, business_phone=?" + "\r\n" +
                "where user_no=?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, business_workname);
        pstmt.setString(2, business_representive);
        pstmt.setString(3, business_no);
        pstmt.setString(4, business_phone);
        pstmt.setString(5, USER_NO);
        pstmt.executeUpdate();


        sql = "update store" + "\r\n" +
                "set address=?, detail_addr=?, operationhour=?, equipment=?, main_genre=?, genre=?, parking_chk=?, perform_tipbox=?, mobile_tipbox=?, " + "\r\n" +
                "video_chk=?, hashtag=?, zone_info=?, space_picture=?, stage_picture=?, menu=?" + "\r\n" +
                "where user_no=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, address);
        pstmt.setString(2, detail_addr);
        pstmt.setString(3, operationhour);
        pstmt.setString(4, equipment);
        pstmt.setString(5, main_genre);
        pstmt.setString(6, genre);
        pstmt.setString(7, parking_chk);
        pstmt.setString(8, perform_tipbox);
        pstmt.setString(9, mobile_tipbox);
        pstmt.setString(10, video_chk);
        pstmt.setString(11, hashtag);
        pstmt.setString(12, zone_info);
        pstmt.setString(13, space_picture);
        pstmt.setString(14, stage_picture);
        pstmt.setString(15, menu);
        pstmt.setString(16, USER_NO);
        pstmt.executeUpdate();
		
		
		sql = "update reg_buskingtime" + "\r\n" +
                "set buskingdate=?, dayoftheweek=?, startingtime=?, finishingtime=?, offerprice=?"  + "\r\n" +
                "where perform_no=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, buskingdate);
        pstmt.setString(2, dayOfWeek);
        pstmt.setString(3, startingtime);
        pstmt.setString(4, finishingtime);
        pstmt.setString(5, offerprice);
        pstmt.setString(6, perform_no);
        pstmt.executeUpdate();
		

        conn.commit();
		result = true;

        if(result == true){
			msg = "공연일정 수정이 완료되었습니다.";	
			
		}

	}catch(Exception e){
		if(conn != null){
            try{
                conn.rollback();
				return;
            }catch(SQLException ex){e.printStackTrace();}
        }
		result = false;
		msg = "공연일정 수정에 실패하였습니다.";
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