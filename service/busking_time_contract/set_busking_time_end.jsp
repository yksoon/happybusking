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
* 공연 마감 처리
*******************************************/

String sql = "";
String sql2 = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String perform_no = ParamUtil.getString(request, "perform_no", "");
String user_no = ParamUtil.getString(request, "user_no", "");

%>

<%

	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

        sql = 
        "UPDATE reg_buskingtime " + "\r\n" +
        "SET BUSKINGSTATUS = '모집마감' " + "\r\n" +
        "WHERE PERFORM_NO = '" + perform_no + "'" + "\r\n" +
        "AND USER_NO = '" + user_no + "'";

        pstmt.executeUpdate(sql);

        System.out.println(sql);


        sql2 = 
        "UPDATE reg_perform" + "\r\n" +
        "SET MATCHING_CHK = '4'" + "\r\n" +
        "WHERE PERFORM_NO = '" + perform_no + "'";

        pstmt.executeUpdate(sql2);

        System.out.println(sql2);

        result = true;

	}catch(Exception e){
		result = false;
		msg = "모집 마감 처리에 실패하였습니다." + e;
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