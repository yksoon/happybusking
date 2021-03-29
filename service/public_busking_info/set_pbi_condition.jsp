<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
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
* 맞춤 공연 설정
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

Statement stmt = null;
ResultSet rs = null;

//현재 날짜 구해서 팀번호 생성
SimpleDateFormat sdf = new SimpleDateFormat("yyMMddkkmmss");
Date nowdate = new Date();
String no = sdf.format(nowdate);

//랜덤함수
int randNum = ((int)(Math.random()*9999)+1);
no = no.concat(String.format("%04d", randNum));

String user_no = USER_NO;
String apply_sdate = ParamUtil.getString(request, "apply_sdate", "");
String apply_edate = ParamUtil.getString(request, "apply_edate", "");
String perform_sdate = ParamUtil.getString(request, "perform_sdate", "");
String perform_edate = ParamUtil.getString(request, "perform_edate", "");
String select_genre = ParamUtil.getString(request, "select_genre", "");
String genre = ParamUtil.getString(request, "genre", "");
String select_area = ParamUtil.getString(request, "select_area", "");
String area = ParamUtil.getString(request, "area", "");
String pay = ParamUtil.getString(request, "pay", "");
String min_personnel = ParamUtil.getString(request, "min_personnel", "");
String max_personnel = ParamUtil.getString(request, "max_personnel", "");

conn = dbconn.dbconnect();
stmt = conn.createStatement();

sql = "select count(*) as cnt" + "\r\n" +
		"from busking_condition" + "\r\n" +
		"where uno = '"+user_no+"'" + "\r\n";

//System.out.println(sql);

rs = stmt.executeQuery(sql);

int count = 0;

if(rs.next()){
	count = ConvertUtil.toInteger(rs.getInt("cnt"));
}

if(count == 0){
	//처음 설정하는 경우
	//insert
	sql = "insert into" + "\r\n" +
			"busking_condition(uno, no, apply_sdate, apply_edate, perform_sdate, perform_edate, genre_code, genre, area_code, area, pay, personnel_min, personnel_max)" + "\r\n" +
			"values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,?)" + "\r\n";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, user_no);
	pstmt.setString(2, no);
	pstmt.setString(3, apply_sdate);
	pstmt.setString(4, apply_edate);
	pstmt.setString(5, perform_sdate);
	pstmt.setString(6, perform_edate);
	pstmt.setString(7, select_genre);
	pstmt.setString(8, genre);
	pstmt.setString(9, select_area);
	pstmt.setString(10, area);
	pstmt.setString(11, pay);
	pstmt.setString(12, min_personnel);
	pstmt.setString(13, max_personnel);
	
} else {
	//이미 설정했던 경우
	//update
	sql = "update busking_condition" + "\r\n" +
			"set apply_sdate=?, apply_edate=?, perform_sdate=?, perform_edate=?, genre_code=?, genre=?, area_code=?, area=?, pay=?, personnel_min=?, personnel_max=?" + "\r\n" +
			"where uno = ?";
	
	pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, apply_sdate);
	pstmt.setString(2, apply_edate);
	pstmt.setString(3, perform_sdate);
	pstmt.setString(4, perform_edate);
	pstmt.setString(5, select_genre);
	pstmt.setString(6, genre);
	pstmt.setString(7, select_area);
	pstmt.setString(8, area);
	pstmt.setString(9, pay);
	pstmt.setString(10, min_personnel);
	pstmt.setString(11, max_personnel);
	pstmt.setString(12, user_no);
}

//System.out.println(sql);


int result = pstmt.executeUpdate();

if(pstmt != null) pstmt.close();
if(rs != null) rs.close();
if(stmt != null) stmt.close();
if(conn != null) conn.close();
%>