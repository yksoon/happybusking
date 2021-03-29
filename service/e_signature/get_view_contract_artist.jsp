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
* 계약서 이미지 불러오기 - 아티스트
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String contract_no = ParamUtil.getString(request, "contract_no", "");
%>
<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

        sql = "SELECT *" + "\r\n" +
                    "FROM e_contract_form"  + "\r\n" +
                    "WHERE CONTRACT_NO = '" + contract_no + "'";
        

        		rs = pstmt.executeQuery(sql);
		
		// System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
                <CONTRACT_NO><%=ConvertUtil.toString(rs.getString("CONTRACT_NO")) %></CONTRACT_NO>
                <CONTRACT_1><%=ConvertUtil.toString(rs.getString("CONTRACT_1")) %></CONTRACT_1>
                <PERFORM_NO><%=ConvertUtil.toString(rs.getString("PERFORM_NO")) %></PERFORM_NO>
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