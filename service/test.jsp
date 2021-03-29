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
* 지역코드로 인한 점포 리스트를 가져온다.
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String lat = ParamUtil.getString(request, "lat", "");
String lng = ParamUtil.getString(request, "lng", "");
String radius = ParamUtil.getString(request, "radius", "");

%>



<ROOT>
	<%
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
	
	
		sql = "SELECT *," + "\r\n" +
				"(6371*acos(cos(radians("+lat+"))*cos(radians(sLat))*cos(radians(sLng)" + "\r\n" +
						"-radians("+lng+"))+sin(radians("+lat+"))*sin(radians(sLat))))" + "\r\n" +
						"AS distance" + "\r\n" +
					"FROM test_table" + "\r\n" +
					"HAVING distance <= " + radius + "\r\n" +
					"ORDER BY distance" + "\r\n";
					
		//System.out.print(sql);
		
		rs = pstmt.executeQuery(sql);
		
		
		while (rs.next()) {
			%>
			<DATA>
				<sLat><%=ConvertUtil.toStr(rs.getString("sLat"))%></sLat>
				<sLng><%=ConvertUtil.toStr(rs.getString("sLng"))%></sLng>
				<sInfo><%=ConvertUtil.toStr(rs.getString("sInfo"))%></sInfo>
			</DATA>
			<%
		}
	%>
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