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
* 공간등록(insert)
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
        conn.setAutoCommit(false);
		pstmt = conn.createStatement();
		pstmt2 = conn.createStatement();
		
		sql2 = "SELECT *" + "\r\n" +
				"FROM BUSINESS" + "\r\n" +
				"WHERE USER_NO = '" + USER_NO + "'\r\n";
		
		rs2 = pstmt2.executeQuery(sql2);
		//이미 공간 등록 된 유저가 다시 등록하는 경우 등록 안되게
		if(rs2.next()){
			return;
		}

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
		String genre = ParamUtil.getString(request, "genre", "");
        String main_genre = ParamUtil.getString(request, "main_genre", "");
		String equipment = ParamUtil.getString(request, "equipment", "");
        String license_picture = ParamUtil.getString(request, "license_picture", "");
        String business_regist_no = ParamUtil.getString(request, "business_regist_no", "");
		
  			sql = "INSERT INTO " + "\r\n" +
  					"BUSINESS(USER_NO, BUSINESS_NO, BUSINESS_LICENSE, BUSINESS_WORKNAME, BUSINESS_REPRESENTIVE, BUSINESS_PHONE, BUSINESS_REGIST_NO) " + "\r\n" +
  					"VALUES('{user_no}',  '{business_no}', '{business_license}', '{business_workname}', '{business_representive}', '{business_phone}', '{business_regist_no}')";
		
  			sql = sql.replace("{user_no}", USER_NO);
  			sql = sql.replace("{business_no}", business_no);
  			sql = sql.replace("{business_license}", license_picture);
  			sql = sql.replace("{business_workname}", business_workname);
  			sql = sql.replace("{business_representive}", business_representive);
  			sql = sql.replace("{business_phone}", business_phone);
            sql = sql.replace("{business_regist_no}", business_regist_no);
  			
		
  		
  			
		pstmt.executeUpdate(sql);
        

			sql = "INSERT INTO " + "\r\n" +
  					"STORE(USER_NO, SPACE_PICTURE, STAGE_PICTURE, ADDRESS, DETAIL_ADDR, OPERATIONHOUR, EQUIPMENT, MAIN_GENRE, GENRE, PARKING_CHK, PERFORM_TIPBOX, MOBILE_TIPBOX, VIDEO_CHK, MENU, HASHTAG, ZONE_INFO, LICENSE_PICTURE ) " + "\r\n" +
  					"VALUES('{user_no}',  '{space_picture}', '{stage_picture}', '{address}', '{detail_addr}', '{operationhour}', '{equipment}', '{main_genre}', '{genre}', '{parking_chk}', '{perform_tipbox}', '{mobile_tipbox}', '{video_chk}', '{menu}', '{hashtag}', '{zone_info}', '{license_picture}')";
		
  			sql = sql.replace("{user_no}", USER_NO);
  			sql = sql.replace("{space_picture}", space_picture);
  			sql = sql.replace("{stage_picture}", stage_picture);
  			sql = sql.replace("{address}", address);
			sql = sql.replace("{detail_addr}", detail_addr);
  			sql = sql.replace("{operationhour}", operationhour);
  			sql = sql.replace("{equipment}",equipment);
            sql = sql.replace("{main_genre}", main_genre);
		    sql = sql.replace("{genre}", genre);
  			sql = sql.replace("{parking_chk}", parking_chk);
  			sql = sql.replace("{perform_tipbox}", perform_tipbox);
            sql = sql.replace("{mobile_tipbox}", mobile_tipbox);
  			sql = sql.replace("{video_chk}", video_chk);
  			sql = sql.replace("{menu}", menu);
			sql = sql.replace("{hashtag}", hashtag);
  			sql = sql.replace("{zone_info}", zone_info);
			sql = sql.replace("{license_picture}", license_picture);
  		
  	
		pstmt.executeUpdate(sql);


        sql = "UPDATE USER " + "\r\n" +
            "SET OWNER_CHK = 'Y'" + "\r\n" +
            "WHERE USER_NO = '{user_no}'\r\n";
		
		sql = sql.replace("{user_no}", USER_NO);
		pstmt.executeUpdate(sql);




		conn.commit();
		result = true;
		
		if(result == true){
			msg = "상업공간 등록이 완료되었습니다.";	
			Cookie uac = new Cookie("store_chk", "Y");

			//쿠키 유효기간 (60일)
			uac.setMaxAge(60 * 24 * 60 * 60);
	
			//쿠키 path 지정
			uac.setPath("/");
	
			response.addCookie(uac);
		}

	}catch(Exception e){
        if(conn != null){
            try{
                conn.rollback();
				return;
            }catch(SQLException ex){e.printStackTrace();}
        }
		result = false;
		msg = "공간 등록에 실패하였습니다.";
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