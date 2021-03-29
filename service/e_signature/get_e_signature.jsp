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
* 싸인 받아오기
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String business_no = ParamUtil.getString(request, "business_no", "");
%>
<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

        sql = "SELECT COUNT(*) AS cnt, SIGN_EMPLOYER, SIGN " + "\r\n" +
                    "FROM e_signature" + "\r\n" +
                    "WHERE BUSINESS_NO = '"+ business_no +"'";
        

        		rs = pstmt.executeQuery(sql);
		
		// System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
                <SIGN><%=ConvertUtil.toString(rs.getString("SIGN")) %></SIGN>
                <cnt><%=ConvertUtil.toString(rs.getString("cnt")) %></cnt>
			</DATA>

		<%	
		}
	%>
	</ROOT>	
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>

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