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
* 사업주 전자서명 완료
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String emp_sign = ParamUtil.getString(request, "emp_sign", "");
String perform_no = ParamUtil.getString(request, "perform_no", "");
String user_no = ParamUtil.getString(request, "user_no", "");
%>

<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
  			sql = "UPDATE e_contract " + "\r\n" +
  					"SET EMP_SIGN = '" + emp_sign + "', CONTRACT_STATUS = '3'" + "\r\n" +
  					"WHERE PERFORM_NO = '" + perform_no + "'";
		
		
  		//System.out.println(sql);
  			
		pstmt.executeUpdate(sql);

			sql2 = "UPDATE business " + "\r\n" +
  					"SET CONSIGNMENT_AGREE = 'Y'" + "\r\n" +
  					"WHERE USER_NO = '" + user_no + "'";

		pstmt.executeUpdate(sql2);
		result = true;

	}catch(Exception e){
		result = false;
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