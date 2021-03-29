<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr"
	pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%@include file="/service_include.jsp"%>

<%
	/*******************************************
	* 유저 문의사항 등록(INSERT)
	*******************************************/
	String sql = "";
	Connection conn = null;
	PreparedStatement pstmt = null;

	String urwType = ParamUtil.getString(request, "urwType", "");
	String urwTitle = ParamUtil.getString(request, "urwTitle", "");
	String urwContent = ParamUtil.getString(request, "urwContent", "");
	String urwID = ParamUtil.getString(request, "urwID", "");
	String urwPW = ParamUtil.getString(request, "urwPW", "");

	//현재 날짜 구해서 INSERT
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	Date nowdate = new Date();
	String now = sdf.format(nowdate);

	conn = dbconn.dbconnect();

	if (USER_NO == null || USER_NO.equals("") || USER_NO.equals(null) || USER_NO.equals("null")) {
		urwPW = SecuritySha.SHA256(urwPW);

		sql = "INSERT INTO" + "\r\n"
				+ "USER_QUESTION(UQ_STATE, UQ_TYPE, UQ_TITLE, UQ_CONTENT, UQ_REGIDATE, UQ_DEL, UQ_NONMEMBERID, UQ_NONMEMBERPW)"
				+ "\r\n" + "VALUES('N', ?, ?, ?, ?, 'N', ?, ?)" + "\r\n";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, urwType);
		pstmt.setString(2, urwTitle);
		pstmt.setString(3, urwContent);
		pstmt.setString(4, now);
		pstmt.setString(5, urwID);
		pstmt.setString(6, urwPW);
		pstmt.executeUpdate();

	} else {

		sql = "INSERT INTO" + "\r\n"
				+ "USER_QUESTION(UQ_USER_NO, UQ_STATE, UQ_TYPE, UQ_TITLE, UQ_CONTENT, UQ_REGIDATE, UQ_DEL)"
				+ "\r\n" + "VALUES(?, 'N', ?, ?, ?, ?, 'N')" + "\r\n";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, USER_NO);
		pstmt.setString(2, urwType);
		pstmt.setString(3, urwTitle);
		pstmt.setString(4, urwContent);
		pstmt.setString(5, now);
		pstmt.executeUpdate();
	}

	pstmt.close();
	conn.close();
%>