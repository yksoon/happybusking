<?xml version="1.0" encoding="utf-8"?>
<%@page import="com.mysql.fabric.xmlrpc.base.Param"%>
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
* 지역별 공연 검색
*******************************************/
String sql = "";
String sql2 = "";
String sql_content = "";

Connection conn = null;
Statement pstmt = null;

ResultSet rs = null;
ResultSet rs2 = null;

String sLimit = ParamUtil.getString(request, "sLimit", "");
String eLimit = ParamUtil.getString(request, "eLimit", "");
String code_area = ParamUtil.getString(request, "code_area", "");
String code_genre = ParamUtil.getString(request, "code_genre", "");
String team_name = ParamUtil.getString(request, "team_name", "");
String Date = ParamUtil.getString(request, "sDate", "");
String team_no;

String sDate = "";
String nDate = "";
if(!Date.equals("")){
	sDate = Date.substring(0, 10);
	nDate = Date.substring(11);
}


SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf2 = new SimpleDateFormat("kk:mm");
Calendar c1 = Calendar.getInstance();
String today = sdf.format(c1.getTime());
String time = sdf2.format(c1.getTime());
%>
<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		if(!code_genre.equals("")){
			sql ="SELECT * ," + "\r\n" +
					"(SELECT COUNT(*) FROM PERFORM WHERE PF_NO = A.PF_NO AND (PF_DATE > DATE_FORMAT(now(), '%Y-%m-%d') OR (PF_EDATE = DATE_FORMAT(now(), '%Y-%m-%d') AND PF_ETIME >= DATE_FORMAT(now(), '%H:%i')))) AS PF_DATE_CHK," + "\r\n" +
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
					"FROM PERFORM A" + "\r\n" +
					"WHERE MAIN_GENRE LIKE '%" + code_genre + "%'" + "\r\n" ;
		}
		else if(!code_area.equals("")){
			sql ="SELECT * ," + "\r\n" +
					"(SELECT COUNT(*) FROM PERFORM WHERE PF_NO = A.PF_NO AND (PF_DATE > DATE_FORMAT(now(), '%Y-%m-%d') OR (PF_EDATE = DATE_FORMAT(now(), '%Y-%m-%d') AND PF_ETIME >= DATE_FORMAT(now(), '%H:%i')))) AS PF_DATE_CHK," + "\r\n" +
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
					"FROM PERFORM A" + "\r\n" +
					"WHERE CODE_AREA='" + code_area + "'" + "\r\n";
		}
		else{			
			sql = "SELECT * ," + "\r\n" +
					"(SELECT COUNT(*) FROM PERFORM WHERE PF_NO = A.PF_NO AND (PF_DATE > DATE_FORMAT(now(), '%Y-%m-%d') OR (PF_EDATE = DATE_FORMAT(now(), '%Y-%m-%d') AND PF_ETIME >= DATE_FORMAT(now(), '%H:%i')))) AS PF_DATE_CHK," + "\r\n" +
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
					"FROM PERFORM A" + "\r\n";
		}
		
		sql_content = "LIMIT " + sLimit +", " + eLimit + "\r\n";
		
		if(code_area.equals("") && code_genre.equals("")){
			if(Date.equals("")){
				sql_content = "WHERE TEAM_NO IN" + "\r\n" +
								"(SELECT TEAM_NO " + "\r\n" +
								"FROM TEAM " + "\r\n" +
								"WHERE TEAM_NAME like '%" + team_name + "%')" + "\r\n"+
								"ORDER BY PF_DATE_CHK DESC, CASE WHEN PF_DATE_CHK = 1 THEN PF_DATE END ASC, CASE WHEN PF_DATE_CHK = 0 THEN PF_DATE END DESC, PF_TIME ASC" + "\r\n"+
								"LIMIT " + sLimit +", " + eLimit + "\r\n";
			}
			else{
				sql_content = "WHERE TEAM_NO IN" + "\r\n" +
						"(SELECT TEAM_NO " + "\r\n" +
						"FROM TEAM " + "\r\n" +
						"WHERE TEAM_NAME like '%" + team_name + "%')" + "\r\n"+
						"AND (PF_DATE BETWEEN '" + sDate + "' and '" + nDate + "')" +
						"ORDER BY PF_DATE_CHK DESC, CASE WHEN PF_DATE_CHK = 1 THEN PF_DATE END ASC, CASE WHEN PF_DATE_CHK = 0 THEN PF_DATE END DESC, PF_TIME ASC" + "\r\n"+
						"LIMIT " + sLimit +", " + eLimit + "\r\n";
			}
		}
		else{
			if(Date.equals("")){
				sql_content = "AND TEAM_NO IN" + "\r\n" +
								"(SELECT TEAM_NO " + "\r\n" +
								"FROM TEAM " + "\r\n" +
								"WHERE TEAM_NAME like '%" + team_name + "%')" + "\r\n"+
								"ORDER BY PF_DATE_CHK DESC, CASE WHEN PF_DATE_CHK = 1 THEN PF_DATE END ASC, CASE WHEN PF_DATE_CHK = 0 THEN PF_DATE END DESC, PF_TIME ASC" + "\r\n"+
								"LIMIT " + sLimit +", " + eLimit + "\r\n";
			}
			else{
				sql_content = "AND TEAM_NO IN" + "\r\n" +
						"(SELECT TEAM_NO " + "\r\n" +
						"FROM TEAM " + "\r\n" +
						"WHERE TEAM_NAME like '%" + team_name + "%')" + "\r\n"+
						"AND (PF_DATE BETWEEN '" + sDate + "' and '" + nDate + "')" +
						"ORDER BY PF_DATE_CHK DESC, CASE WHEN PF_DATE_CHK = 1 THEN PF_DATE END ASC, CASE WHEN PF_DATE_CHK = 0 THEN PF_DATE END DESC, PF_TIME ASC" + "\r\n"+
						"LIMIT " + sLimit +", " + eLimit + "\r\n";
			}
		}
		
		sql = sql.concat(sql_content);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
			<DATA>
				<PF_NO><%=ConvertUtil.toStr(rs.getString("PF_NO")) %></PF_NO>
				<PF_IMG><%=ConvertUtil.toString(rs.getString("PF_IMG"))%></PF_IMG>
				<PF_INTRO><%=ConvertUtil.toStr(rs.getString("PF_INTRO")) %></PF_INTRO>
				<PF_DATE><%=ConvertUtil.toStr(rs.getString("PF_DATE")) %></PF_DATE>
				<PF_TIME><%=ConvertUtil.toStr(rs.getString("PF_TIME")) %></PF_TIME>
				<CODE_AREA><%=ConvertUtil.toStr(rs.getString("CODE_AREA")) %></CODE_AREA>
				<PF_PLACE><%=ConvertUtil.toStr(rs.getString("PF_PLACE"))%></PF_PLACE>
				<PF_LATLNG><%=ConvertUtil.toStr(rs.getString("PF_LATLNG"))%></PF_LATLNG>
				<PF_ADDR><%=ConvertUtil.toStr(rs.getString("PF_ADDR"))%></PF_ADDR>
				<PF_DETAIL_CONTENT><%=ConvertUtil.toStr(rs.getString("PF_DETAIL_CONTENT")) %></PF_DETAIL_CONTENT>
				<WEEK><%=ConvertUtil.toStr(rs.getString("WEEK"))%></WEEK>
				<CODE_GENRE><%=ConvertUtil.toStr(rs.getString("CODE_GENRE"))%></CODE_GENRE>
				<PF_DATE_CHK><%=ConvertUtil.toInteger(rs.getInt("PF_DATE_CHK")) %></PF_DATE_CHK>
				<PF_CANCLE><%=ConvertUtil.toInteger(rs.getInt("PF_CANCLE")) %></PF_CANCLE>
			<%
				team_no = ConvertUtil.toString(rs.getString("TEAM_NO"));
				
				sql2 = "SELECT * ,(SELECT COUNT(*) FROM INTEREST WHERE TEAM_NO = '" + team_no + "') AS CNT " + "\r\n" +
						"FROM TEAM " + "\r\n" +
						"WHERE TEAM_NO='"+team_no+"'";
				
				rs2 = pstmt.executeQuery(sql2);
				if(rs2.next()){
					%>
						<TEAM_NO><%=team_no%></TEAM_NO>
						<CNT><%=ConvertUtil.toInteger(rs2.getInt("CNT"))%></CNT>
						<TEAM_NAME><%=ConvertUtil.toStr(rs2.getString("TEAM_NAME"))%></TEAM_NAME>
						<TEAM_INTRO><%=ConvertUtil.toStr(rs2.getString("TEAM_INTRO"))%></TEAM_INTRO>
						<TEAM_GENRE><%=ConvertUtil.toStr(rs2.getString("CODE_GENRE"))%></TEAM_GENRE>
						<TINTRO_IMG><%=ConvertUtil.toStr(rs2.getString("TINTRO_IMG"))%></TINTRO_IMG>
						</DATA>
					<%
			}
		}
%>
</ROOT>
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