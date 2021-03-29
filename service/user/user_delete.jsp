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
* 회원 탈퇴
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String msg = "";
String team_no = "";
String team_type = "";

String user_no = ParamUtil.getString(request, "user_no", "");


conn = dbconn.dbconnect();

//ARTIST 테이블에서 삭제
sql = "DELETE FROM ARTIST " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//BOARD 테이블에서 삭제
sql = "DELETE FROM BOARD " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//BOARD_REPLY 테이블에서 삭제
sql = "DELETE FROM BOARD_REPLY " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//BUSKINGZONE 테이블에서 삭제
sql = "DELETE FROM BUSKINGZONE " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//BUSKINGZONE REPLY 테이블에서 삭제
sql = "DELETE FROM BUSKINGZONE_REPLY " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//EPILOGUE 테이블에서 삭제
sql = "DELETE FROM EPILOGUE " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//INTEREST 테이블에서 삭제
sql = "DELETE FROM INTEREST " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//ITEM_REQUEST 테이블에서 삭제
sql = "DELETE FROM ITEM_REQUEST " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//PERFORM_ALARM 테이블에서 삭제
sql = "DELETE FROM PERFORM_ALARM " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//PERFORM_REPLY 테이블에서 삭제
sql = "DELETE FROM PERFORM_REPLY " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//PERFORM_REQUEST 테이블에서 삭제
sql = "DELETE FROM PERFORM_REQUEST " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//PERFORM_REQUEST 테이블에서 삭제
sql = "DELETE FROM PUBLIC_BUSKING_INFO " + "\r\n" +
		"WHERE PBI_USER_NO = " + user_no;
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//QR_REQUEST 테이블에서 삭제
sql = "DELETE FROM QR_REQUEST " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//SHARE_ITEM 테이블에서 삭제
sql = "DELETE FROM SHARE_ITEM " + "\r\n" +
		"WHERE SI_USER_NO = " + user_no;
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//SHARE_ITEM_REPLY 테이블에서 삭제
sql = "DELETE FROM SHARE_ITEM_REPLY " + "\r\n" +
		"WHERE SI_REPLY_USER_NO = " + user_no;
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//SUPPORT 테이블에서 삭제
sql = "DELETE FROM SUPPORT " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//TEAM 테이블에서 솔로인 팀이면 삭제
sql = "SELECT TEAM_NO AS TNO, " + "\r\n" +
		"(SELECT TEAM_TYPE FROM TEAM WHERE TEAM_NO = TNO) AS TT " + "\r\n" +
		"FROM TEAM_MEMBER" + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";

rs = pstmt.executeQuery(sql);

while(rs.next()){
	team_no = ConvertUtil.toStr(rs.getString("TNO"));
	team_type = ConvertUtil.toStr(rs.getString("TT"));
	
	if(team_type.equals("1")){
		sql = "DELETE FROM TEAM " + "\r\n" +
				"WHERE TEAM_NO = " + team_no;
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
	}
}

//TEAM_MEMBER 테이블에서 삭제
sql = "DELETE FROM TEAM_MEMBER " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//USER 테이블에서 삭제
sql = "DELETE FROM USER " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//USER_PERFORM_RECORD 테이블에서 삭제
sql = "DELETE FROM USER_PERFORM_RECORD " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//USER_QUESTION 테이블에서 삭제
sql = "DELETE FROM USER_QUESTION " + "\r\n" +
		"WHERE UQ_USER_NO = " + user_no;
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//VIDEO_UPLOAD 테이블에서 삭제
sql = "DELETE FROM VIDEO_UPLOAD " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//reg_perform 테이블에서 삭제
sql = "DELETE FROM reg_perform " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//reg_perform 테이블에서 삭제
sql = "DELETE FROM reg_perform " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//e_contract 테이블에서 삭제
sql = "DELETE FROM e_contract " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//business 테이블에서 삭제
sql = "DELETE FROM business " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//store 테이블에서 삭제
sql = "DELETE FROM store " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

rs.close();
pstmt.close();
conn.close();
%>