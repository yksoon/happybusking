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
* 팀신청 정보 수정 페이지에서 팀원 삭제 버튼 클릭시
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String user_no = ParamUtil.getString(request, "user_no", "0");
String team_no = ParamUtil.getString(request, "team_no", "0");
%>

<%
try{
	conn = dbconn.dbconnect();
	pstmt = conn.createStatement();
	
	//테스트용 sql
	//sql = "DELETE " + "\r\n" +
	//		"FROM TEAM_MEMBER " + "\r\n" +
	//		"WHERE USER_NO = '" + user_no + "'\r\n" +
	//		"AND TEAM_NO = " + team_no;
	sql = "UPDATE " + "\r\n" +
		"TEAM_MEMBER " + "\r\n" +
		"SET MEMBER_REQ_STATUS = '4' " + "\r\n" +
		"WHERE USER_NO = '" + user_no + "'\r\n" +
		"AND TEAM_NO = " + team_no;
			
			
	rs = pstmt.executeQuery(sql);
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
} catch (Exception ex) {}
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>