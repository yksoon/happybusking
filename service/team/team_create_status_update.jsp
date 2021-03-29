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

<%-- <%@include file="/service_include.jsp" %> --%>



<%
/*******************************************
* 팀 요청 수락/거절
*******************************************/
String sql = "";
String sql2 = "";
String sql3 = "";
Connection conn = null;
Statement pstmt = null;
Statement pstmt2 = null;
PreparedStatement pstmt3 = null;
ResultSet rs = null;
ResultSet rs2 = null;

boolean result = false;
String msg = "";

String user_no = ParamUtil.getString(request, "user_no", "");
String team_no = ParamUtil.getString(request, "team_no", "");
String member_seq_status = ParamUtil.getString(request, "member_seq_status", "");
%>

<%
try{
	conn = dbconn.dbconnect();
	pstmt = conn.createStatement();
	
	//테스트용 sql
	sql = "UPDATE TEAM_MEMBER SET " + "\r\n" +
			"MEMBER_REQ_STATUS = " + member_seq_status + "\r\n" +
			"WHERE USER_NO = '" + user_no + "'\r\n" +
			"AND TEAM_NO = '" + team_no + "'\r\n" +
			"AND MEMBER_REQ_STATUS = '1'";
			
			
	//System.out.println(sql);
		
			
	rs = pstmt.executeQuery(sql);
	
	pstmt2 = conn.createStatement();
	
	sql2 = "SELECT MEMBER_REQ_STATUS " + "\r\n" +
			"FROM TEAM_MEMBER " + "\r\n" +
			"WHERE TEAM_NO = " +  team_no + "\r\n" +
			"AND MEMBER_REQ_STATUS NOT IN (2)";
	
	rs2 = pstmt2.executeQuery(sql2);
	
	if(rs2.next()){
	}
	else{
		sql3 = "UPDATE TEAM SET " + "\r\n"+
				"TEAM_OK = 2" + "\r\n" +
				"WHERE TEAM_NO  = " + team_no;
		pstmt3 = conn.prepareStatement(sql3);
		pstmt3.executeUpdate();
		//System.out.println(sql3);
	}
	
	
	
	result = true;
	
}
catch(Exception e){
	result = false;
	e.printStackTrace();
}
	%>
<ROOT>
	<DATA>
		<RESULT><%=String.valueOf(result)%></RESULT>
	</DATA>
</ROOT>

<%
try {
	rs.close();
	rs2.close();
} catch (Exception ex) {}
try {
	pstmt.close();
	pstmt2.close();
	pstmt3.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>