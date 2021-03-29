<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%-- <%@include file="/service_include.jsp" %> --%>



<%
/*******************************************
* 회원가입 체크
*******************************************/
String sql = "";
Connection conn = null;
ResultSet rs = null;
Statement pstmt = null;
PreparedStatement pstmt2 = null;


int count = 0;

//이메일 인증 체크 Parameter
String email = ParamUtil.getString(request, "email", "");
String email_key = ParamUtil.getString(request, "email_key", ""); 
%>
	<ROOT>
<%
	try{
	conn = dbconn.dbconnect();
	pstmt = conn.createStatement();			
						
	sql = "SELECT COUNT(*) AS CNT"+ "\r\n" +
				"FROM EMAIL_CHK" + "\r\n" + 
				"WHERE EMAIL = '" + email +"'" + "\r\n" + 
				  "AND CHK_CODE = '" + email_key + "'" + "\r\n";
		
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
			count = ConvertUtil.toInteger(rs.getInt("CNT"));
			%>
			<DATA>
				<CNT><%=count %></CNT>
			</DATA>
			<%
			if(count > 0){
				sql = "DELETE "+ "\r\n" +
						"FROM EMAIL_CHK" + "\r\n" + 
						"WHERE EMAIL = '" + email +"'" + "\r\n" + 
						  "AND CHK_CODE = '" + email_key + "'" + "\r\n";
				pstmt2 = conn.prepareStatement(sql);
				pstmt2.executeUpdate();				
			}
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
	if(pstmt2 != null){
		pstmt2.close();
	}
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>