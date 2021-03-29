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
* 공연 상세 정보
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
ResultSet rs2 = null;

String pf_no = ParamUtil.getString(request, "pf_no", "");
String user_no = ParamUtil.getString(request, "user_no", "0");
%>
<ROOT2>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT * ," + "\r\n" +
				"DAYOFWEEK(PF_DATE) AS Week_n," + "\r\n" +
				"CASE DAYOFWEEK(PF_DATE) " + "\r\n" +
				"WHEN '1' THEN '일'" + "\r\n" +
				"WHEN '2' THEN '월'" + "\r\n" +
				"WHEN '3' THEN '화'" + "\r\n" +
				"WHEN '4' THEN '수'" + "\r\n" +
				"WHEN '5' THEN '목'" + "\r\n" +
				"WHEN '6' THEN '금'" + "\r\n" +
				"WHEN '7' THEN '토'" + "\r\n" +
				"END AS WEEK " + "\r\n" +
				"FROM PERFORM " + "\r\n" +
				"WHERE PF_NO = " + pf_no;
		
		rs = pstmt.executeQuery(sql);
		
		//System.out.println(sql);
		
		if(rs.next()){
			String PF_CANCLE_MSG = ConvertUtil.toStr(rs.getString("PF_CANCLE_MSG"));
			if(!PF_CANCLE_MSG.equals("")){
				PF_CANCLE_MSG = PF_CANCLE_MSG.replaceAll("<br/>", "\r\n");
			}
			%>
			<DATA>
				<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
				<PF_INTRO><%=ConvertUtil.toStr(rs.getString("PF_INTRO")) %></PF_INTRO>
				<PF_IMG><%=ConvertUtil.toString(rs.getString("PF_IMG"))%></PF_IMG>
				<PF_DATE><%=ConvertUtil.toStr(rs.getString("PF_DATE")) %></PF_DATE>
				<PF_TIME><%=ConvertUtil.toStr(rs.getString("PF_TIME")) %></PF_TIME>
				<CODE_AREA><%=ConvertUtil.toStr(rs.getString("CODE_AREA")) %></CODE_AREA>
				<PF_DETAIL_CONTENT><%=ConvertUtil.toStr(rs.getString("PF_DETAIL_CONTENT")) %></PF_DETAIL_CONTENT>
				<PF_LATLNG><%=ConvertUtil.toStr(rs.getString("PF_LATLNG"))%></PF_LATLNG>
				<PF_ADDR><%=ConvertUtil.toStr(rs.getString("PF_ADDR"))%></PF_ADDR>
				<PF_PLACE><%=ConvertUtil.toStr(rs.getString("PF_PLACE"))%></PF_PLACE>
				<PF_PLACE_TYPE><%=ConvertUtil.toStr(rs.getString("PF_PLACE_TYPE"))%></PF_PLACE_TYPE>
				<PF_TRAFFIC><%=ConvertUtil.toStr(rs.getString("PF_TRAFFIC"))%></PF_TRAFFIC>
				<WEEK><%=ConvertUtil.toStr(rs.getString("WEEK"))%></WEEK>
				<PF_CANCLE><%=ConvertUtil.toStr(rs.getString("PF_CANCLE"))%></PF_CANCLE>
				<CODE_GENRE><%=ConvertUtil.toStr(rs.getString("CODE_GENRE")) %></CODE_GENRE>
				<PF_CANCLE_MSG><%=PF_CANCLE_MSG%></PF_CANCLE_MSG>
			<%
			
			String team_no = ConvertUtil.toString(rs.getString("TEAM_NO"));
				sql2 = "SELECT * ,(SELECT COUNT(*) FROM INTEREST WHERE TEAM_NO = '" + team_no + "') AS CNT, " + "\r\n" +
						"(SELECT COUNT(*) FROM INTEREST WHERE TEAM_NO = '"+ team_no +"' AND USER_NO = '"+user_no+"') AS I_CHK, " + "\r\n" +
						"(SELECT PF_DATE FROM PERFORM WHERE TEAM_NO = '"+team_no+"' AND PF_DATE > NOW() AND PF_CANCLE IN(0) ORDER BY PF_DATE ASC LIMIT 1) AS PF_DATE_CHK " + "\r\n" +
						"FROM TEAM " + "\r\n" +
						"WHERE TEAM_NO='"+team_no+"'\r\n";
				//System.out.println(sql2);
				
			rs2 = pstmt.executeQuery(sql2);
			if(rs2.next()){
				%>
				<CNT><%=ConvertUtil.toInteger(rs2.getInt("CNT"))%></CNT>
				<I_CHK><%=ConvertUtil.toInteger(rs2.getInt("I_CHK"))%></I_CHK>
				<TEAM_INTRO><%=ConvertUtil.toStr(rs2.getString("TEAM_INTRO"))%></TEAM_INTRO>
				<TEAM_GENRE><%=ConvertUtil.toStr(rs2.getString("CODE_GENRE"))%></TEAM_GENRE>
				<TINTRO_IMG><%=ConvertUtil.toStr(rs2.getString("TINTRO_IMG"))%></TINTRO_IMG>
				<TEAM_NAME><%=ConvertUtil.toStr(rs2.getString("TEAM_NAME")) %></TEAM_NAME>
				<PF_DATE_CHK><%=ConvertUtil.toStr(rs2.getString("PF_DATE_CHK"))%></PF_DATE_CHK>
				<BELONG><%=ConvertUtil.toStr(rs2.getString("BELONG"))%></BELONG>
				</DATA>
				<%
			}
		}
		
%>
</ROOT2>
<%	
}catch(Exception e){
		e.getStackTrace();
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