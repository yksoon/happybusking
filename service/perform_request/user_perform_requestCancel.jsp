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
* 유저쪽 공연의뢰 신청 취소(delete)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//유저쪽 공연의뢰 신청 취소  Parameter 
String team_no =  ParamUtil.getString(request, "team_no", "");
String pf_request_no =  ParamUtil.getString(request, "pf_request_no", "");


//System.out.println(team_no);
//System.out.println(pf_request_no);

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
	
 			sql = "DELETE FROM PERFORM_REQUEST" + "\r\n" +
 		 		   "WHERE TEAM_NO =" + team_no + "\r\n" + 
 			         "AND PF_REQUEST_NO =" + pf_request_no + "\r\n";
		
					
			//System.out.println(sql);
			
			pstmt.executeUpdate(sql);	
			
			

			result = true;
			msg = "공연의뢰 취소 성공";

				 	

	}catch(Exception e){
		result = false;
		msg = "공연의뢰 취소 실패";
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