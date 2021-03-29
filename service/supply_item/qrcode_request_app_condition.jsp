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
* qr코드 신청현황 리스트
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String team_no = ParamUtil.getString(request, "team_no", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT COUNT(CASE WHEN TM.TM_TYPE=1 THEN 1 END) AS PCOUNT," + "\r\n" +
				"COUNT(CASE WHEN TM.TM_TYPE=2 THEN 1 END) AS VCOUNT," + "\r\n" +
				"(SELECT COUNT(*) FROM PERFORM P WHERE P.TEAM_NO = "+team_no+") AS PERFORMCHK" + "\r\n" +
				"FROM TEAM_MEDIA TM" + "\r\n" +
				"WHERE TM.TM_TEAM_NO =" + team_no; 

		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<PCOUNT><%=ConvertUtil.toInteger(rs.getInt("PCOUNT"))%></PCOUNT>
					<VCOUNT><%=ConvertUtil.toInteger(rs.getInt("VCOUNT"))%></VCOUNT>
					<PERFORMCHK><%=ConvertUtil.toInteger(rs.getInt("PERFORMCHK"))%></PERFORMCHK>
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