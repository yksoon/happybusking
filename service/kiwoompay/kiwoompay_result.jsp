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
* 키움페이 결제 결과 통보 DB INSERT
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

String msg = "";

//NOT NULL
String PAYMETHOD = ParamUtil.getString(request, "PAYMETHOD", "");
String CPID = ParamUtil.getString(request, "CPID", "");
String DAOUTRX = ParamUtil.getString(request, "DAOUTRX", "");
String ORDERNO = ParamUtil.getString(request, "ORDERNO", "");
String AMOUNT = ParamUtil.getString(request, "AMOUNT", "");
String PRODUCTNAME = ParamUtil.getString(request, "PRODUCTNAME", "");
String SETTDATE = ParamUtil.getString(request, "SETTDATE", "");
String AUTHNO = ParamUtil.getString(request, "AUTHNO", "");
////////////
//NULL 허용
String CARDCODE = ParamUtil.getString(request, "CARDCODE", "");
String CARDNAME = ParamUtil.getString(request, "CARDNAME", "");
String CARDNO = ParamUtil.getString(request, "CARDNO", "");
String EMAIL = ParamUtil.getString(request, "EMAIL", "");
String USERID = ParamUtil.getString(request, "USERID", "");
String USERNAME = ParamUtil.getString(request, "USERNAME", "");
String PRODUCTCODE = ParamUtil.getString(request, "PRODUCTCODE", "");
String RESERVEDINDEX1 = ParamUtil.getString(request, "RESERVEDINDEX1", "");
String RESERVEDINDEX2 = ParamUtil.getString(request, "RESERVEDINDEX2", "");
String RESERVEDSTRING = ParamUtil.getString(request, "RESERVEDSTRING", "");
////////////

System.out.println("PAYMETHOD : " + PAYMETHOD);
System.out.println("CPID : " + CPID);
System.out.println("ORDERNO : " + ORDERNO);

conn = dbconn.dbconnect();

sql = "INSERT INTO " + "\r\n" +
		"KIWOOMPAY_RESULT(PAYMETHOD, CPID, DAOUTRX, ORDERNO, AMOUNT, PRODUCTNAME, SETTDATE, AUTHNO" +
							", CARDCODE, CARDNAME, CARDNO, EMAIL, USERID, USERNAME, PRODUCTCODE, RESERVEDINDEX1, RESERVEDINDEX2, RESERVEDSTRING)" + "\r\n" +
		"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

pstmt = conn.prepareStatement(sql);

pstmt.setString(1, PAYMETHOD);
pstmt.setString(2, CPID);
pstmt.setString(3, DAOUTRX);
pstmt.setString(4, ORDERNO);
pstmt.setString(5, AMOUNT);
pstmt.setString(6, PRODUCTNAME);
pstmt.setString(7, SETTDATE);
pstmt.setString(8, AUTHNO);
pstmt.setString(9, CARDCODE);
pstmt.setString(10, CARDNAME);
pstmt.setString(11, CARDNO);
pstmt.setString(12, EMAIL);
pstmt.setString(13, USERID);
pstmt.setString(14, USERNAME);
pstmt.setString(15, PRODUCTCODE);
pstmt.setString(16, RESERVEDINDEX1);
pstmt.setString(17, RESERVEDINDEX2);
pstmt.setString(18, RESERVEDSTRING);

System.out.println(sql);

int result = pstmt.executeUpdate();
//System.out.println(result);

%>
<ROOT>
	<DATA>
		<RESULT><%=result %></RESULT>
	</DATA>	
</ROOT>
<%

pstmt.close();
conn.close();
%>