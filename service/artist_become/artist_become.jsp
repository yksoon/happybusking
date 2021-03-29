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
* 아티스트 되기(insert)
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
Statement pstmt2 = null;
ResultSet rs2 = null;

boolean result = false;
String msg = "";


String team_no = "";

%>


<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		pstmt2 = conn.createStatement();
		
		sql2 = "SELECT *" + "\r\n" +
				"FROM ARTIST" + "\r\n" +
				"WHERE USER_NO = '" + USER_NO + "'\r\n";
		
		rs2 = pstmt2.executeQuery(sql2);
		//이미 아티스트 등록 된 유저가 다시 등록하는 경우 등록 안되게
		if(rs2.next()){
			return;
		}

		String artist_img = ParamUtil.getString(request, "artist_img", "");
		String artist_phone = ParamUtil.getString(request, "artist_phone", "");
		String artist_name =ParamUtil.getString(request, "artist_name", "");
		String artist_intro = ParamUtil.getString(request, "artist_intro", "");
		String artist_genre = ParamUtil.getString(request, "artist_genre", "");
		String artist_use_tool = ParamUtil.getString(request, "artist_use_tool", "");
		String artist_sns = ParamUtil.getString(request, "artist_sns", "");
		String main_genre = ParamUtil.getString(request, "main_genre", "");
		String add_genre = ParamUtil.getString(request, "add_genre", "");
		
		String artist_postcode = "";
		String artist_addr = "";
		String artist_detail_addr = "";
		
		
  			sql = "INSERT INTO " + "\r\n" +
  					"ARTIST(USER_NO, ARTIST_IMG, PHONE, ARTIST_NAME, ARTIST_INTRO, CODE_GENRE, USE_TOOL, ARTIST_SNS, POSTCODE, ADDR, DETAIL_ADDR, MAIN_GENRE, ADD_GENRE) " + "\r\n" +
  					"VALUES('{user_no}', '{artist_img}', '{artist_phone}', '{artist_name}', '{artist_intro}', '{artist_genre}', '{artist_use_tool}', '{artist_sns}', '{artist_postcode}', '{artist_addr}', '{artist_detail_addr}', '{main_genre}', '{add_genre}')";
		
  			sql = sql.replace("{user_no}", USER_NO);
  			sql = sql.replace("{artist_img}", artist_img);
  			sql = sql.replace("{artist_phone}", artist_phone);
  			sql = sql.replace("{artist_name}", artist_name);
  			sql = sql.replace("{artist_intro}", artist_intro);
  			sql = sql.replace("{artist_genre}", artist_genre);
  			sql = sql.replace("{artist_use_tool}", artist_use_tool);
  			sql = sql.replace("{artist_sns}", artist_sns);
  			sql = sql.replace("{artist_postcode}", artist_postcode);
  			sql = sql.replace("{artist_addr}", artist_addr);
  			sql = sql.replace("{artist_detail_addr}", artist_detail_addr);
  			sql = sql.replace("{main_genre}", main_genre);
  			sql = sql.replace("{add_genre}", add_genre);
  			
		
  		//System.out.println(sql);
  			
		pstmt.executeUpdate(sql);
		
		sql = "UPDATE USER " + "\r\n" +
				"SET ARTIST_CHK = 'Y'" + "\r\n" +
				"WHERE USER_NO = '" + USER_NO + "'\r\n";
		
		pstmt.executeUpdate(sql);

		
		result = true;
		
		if(result == true){
			msg = "아티스트 등록이 완료되었습니다.";	
			Cookie uac = new Cookie("artist_chk", "Y");

			//쿠키 유효기간 (60일)
			uac.setMaxAge(60 * 24 * 60 * 60);
	
			//쿠키 path 지정
			uac.setPath("/");
	
			response.addCookie(uac);
		}

	}catch(Exception e){
		result = false;
		msg = "아티스트 등록에 실패하였습니다.";
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