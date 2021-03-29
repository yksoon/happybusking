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
* 아티스트 정보 수정(update)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String artist_img = ParamUtil.getString(request, "artist_img", "");
String artist_phone = ParamUtil.getString(request, "artist_phone", "");
String artist_name = ParamUtil.getString(request, "artist_name", "");
String artist_intro = ParamUtil.getString(request, "artist_intro", "");
String artist_use_tool = ParamUtil.getString(request, "artist_use_tool", "");
String artist_sns = ParamUtil.getString(request, "artist_sns", "");

%>


<%
	try{
		conn = dbconn.dbconnect();
		//업로드
		
		if(artist_img.equals("")){
			sql = "update artist" + "\r\n" +
					"set phone=?, artist_name=?, artist_intro=?, use_tool=?, artist_sns=?" + "\r\n" +
					"where user_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, artist_phone);
			pstmt.setString(2, artist_name);
			pstmt.setString(3, artist_intro);
			pstmt.setString(4, artist_use_tool);
			pstmt.setString(5, artist_sns);
			pstmt.setString(6, USER_NO);
		} else {
			sql = "update artist" + "\r\n" +
					"set phone=?, artist_name=?, artist_intro=?, use_tool=?, artist_sns=?, artist_img=?" + "\r\n" +
					"where user_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, artist_phone);
			pstmt.setString(2, artist_name);
			pstmt.setString(3, artist_intro);
			pstmt.setString(4, artist_use_tool);
			pstmt.setString(5, artist_sns);
			pstmt.setString(6, artist_img);
			pstmt.setString(7, USER_NO);
		}
  			
		pstmt.executeUpdate();
		result = true;

	}catch(Exception e){
		result = false;
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