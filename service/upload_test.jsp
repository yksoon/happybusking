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
<%@ page import="upload.*"%>

<%@include file="/service_include.jsp" %>



<%
/*******************************************
* 지역코드로 인한 점포 리스트를 가져온다.
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String num = ParamUtil.getString(request, "num", "");
System.out.println("num:" + num);

VLog.Info("test.jsp call");

%>



<ROOT>
	<%if(USER_ID != null && USER_ID.equals("") == false) {
	
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
	
		sql = 
"SELECT " + "\r\n" +  
"	USER_NO " + "\r\n" +
"	,NICKNAME " + "\r\n" +
"	,USER_ID " + "\r\n" +
"	,USER_PASS " + "\r\n" +
"	,USER_ACTIVE " + "\r\n" +
"	,USER_DEL " + "\r\n" +
"	,ARTIST_CHK " + "\r\n" +
"	,USER_IMG " + "\r\n" +
"	,AGE " + "\r\n" +
"	,GENDER " + "\r\n" +
"FROM  " + "\r\n" +
"	user " + "\r\n" +
"WHERE 1=1 " + "\r\n" + 
"    AND USER_NO = '{USER_NO}' " + "\r\n";
	
		sql = sql.replace("{USER_NO}", num);
		System.out.print(sql);
		
		VLog.Info(sql);
		
		
		rs = pstmt.executeQuery(sql);
		
		
		while (rs.next()) {
			
			/*  세션 저장
			session.setAttribute("USER_ID",ConvertUtil.toStr(rs.getString("USER_ID")));
			*/
					
			%>
			<DATA>
				<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO"))%></USER_NO>
				<NICKNAME><%=ConvertUtil.toStr(rs.getString("NICKNAME"))%></NICKNAME>
				<USER_ID><%=ConvertUtil.toStr(rs.getString("USER_ID"))%></USER_ID>
				<USER_PASS><%=ConvertUtil.toStr(rs.getString("USER_PASS"))%></USER_PASS>
				<USER_ACTIVE><%=ConvertUtil.toStr(rs.getString("USER_ACTIVE"))%></USER_ACTIVE>
				<USER_DEL><%=ConvertUtil.toStr(rs.getString("USER_DEL"))%></USER_DEL>
			</DATA>
			<%
		}
	}%>
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