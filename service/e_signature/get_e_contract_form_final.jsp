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
* 계약서 데이터 불러오기
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
//String user_no = ParamUtil.getString(request, "user_no", "");
%>
<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

        sql = "SELECT * FROM" + "\r\n" +
                    "e_contract_form "  + "\r\n" +
                    "where CONTRACT_NO = '2009141136039402202101281506-2009141136039402'";            
        

        		rs = pstmt.executeQuery(sql);
		
		// System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
                <CONTRACT_1><%=ConvertUtil.toString(rs.getString("CONTRACT_1")) %></CONTRACT_1>
                <CONTRACT_2><%=ConvertUtil.toString(rs.getString("CONTRACT_2")) %></CONTRACT_2>
                <CONTRACT_3><%=ConvertUtil.toString(rs.getString("CONTRACT_3")) %></CONTRACT_3>
                <CONTRACT_4><%=ConvertUtil.toString(rs.getString("CONTRACT_4")) %></CONTRACT_4>
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