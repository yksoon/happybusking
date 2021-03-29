<?xml version="1.0" encoding="utf-8"?>
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
* 지원물품 신청 취소(delete)
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//지원물품 신청 취소  Parameter 
String item_request_no = ParamUtil.getString(request, "item_request_no", "");
String item_no =  ParamUtil.getString(request, "item_no", "");
String item_count =  ParamUtil.getString(request, "item_count", "");

/* System.out.println(item_request_no);
System.out.println(item_no);
System.out.println(item_count); */

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
	
 			sql = "DELETE FROM ITEM_REQUEST" + "\r\n" +
 		 		   "WHERE ITEM_REQUEST_NO =" + item_request_no + "\r\n";



			
					
			//System.out.println(sql);
			
			pstmt.executeUpdate(sql);	
			
			
			sql2 = "UPDATE ITEM" + "\r\n" +  
					  "SET ITEM_COUNT = ITEM_COUNT + " + item_count + "\r\n" +
					"WHERE ITEM_NO = " + item_no + "\r\n";


			//System.out.println(sql2);
			
			pstmt.executeUpdate(sql2);	
			
			result = true;
			msg = "신청 취소 성공";

				 	

	}catch(Exception e){
		result = false;
		msg = "신청 취소 실패";
		e.printStackTrace();
	}
%>	
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