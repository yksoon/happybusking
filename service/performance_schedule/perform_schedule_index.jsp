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
* 인기 아티스트 목록 가져오기
*******************************************/
String sql = "";
String sql2 = "";
String sql_content = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
ResultSet rs2 = null;
boolean result = false;
String msg = "";

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
		
		//기존 메인 공연일정
		/* sql = "SELECT RE.*" + "\r\n" +
				"FROM (SELECT P.PF_NO, P.PF_IMG, P.PF_INTRO, P.PF_DATE, P.PF_TIME, T.TEAM_NO, T.TEAM_NAME" + "\r\n" +
						"FROM PERFORM P" + "\r\n" +
						"JOIN TEAM T" + "\r\n" +
						"ON P.TEAM_NO = T.TEAM_NO" + "\r\n" +
						"WHERE (DATE(P.PF_DATE) > '"+today+"' OR (DATE(P.PF_DATE) = '"+today+"' AND TIME(PF_ETIME) >= '"+time+"')) AND P.PF_CANCLE = 0" + "\r\n" +
						"ORDER BY P.PF_DATE ASC" + "\r\n" +
						"LIMIT 5) AS RE" + "\r\n" +
						"ORDER BY RE.PF_DATE ASC, RE.PF_TIME ASC" + "\r\n"; */
		
		//임시 메인일정
		//sql = "SELECT A.*," + "\r\n" +
				//"(SELECT COUNT(*) FROM PERFORM WHERE PF_NO = A.PF_NO AND (PF_DATE > DATE_FORMAT(now(), '%Y-%m-%d') OR (PF_EDATE = DATE_FORMAT(now(), '%Y-%m-%d')))) AS PF_DATE_CHK," + "\r\n" +
				//"(SELECT TEAM_NAME FROM TEAM WHERE TEAM_NO = A.TEAM_NO) AS TEAM_NAME" + "\r\n" +
				//"FROM PERFORM A" + "\r\n" +
				//"WHERE A.PF_CANCLE = 0" + "\r\n" +
				//"ORDER BY PF_DATE_CHK DESC, CASE WHEN PF_DATE_CHK = 1 THEN PF_DATE END ASC, CASE WHEN PF_DATE_CHK = 0 THEN PF_DATE END DESC, PF_TIME ASC" + "\r\n" +
				//"LIMIT 5";
        sql = "SELECT PERFORM_NO, SUBSTRING_INDEX(BUSKINGDATE,'-',-2) AS BUSKINGDATE, STARTINGTIME, FINISHINGTIME, TEAM_NAME, BUSINESS_WORKNAME, SUBSTRING_INDEX(ADDRESS,' ',2) AS ADDRESS, HASHTAG, USER_NO, SPACE_PICTURE,"  + "\r\n" +
                     "case" + "\r\n" +
                     "when BUSKINGDATE < date(NOW()) AND TEAM_NAME = '' " + "\r\n" +
                     "then '모집마감'" + "\r\n" +
                     "when BUSKINGDATE < date(NOW()) " + "\r\n" +
                     "then '5'" + "\r\n" +
                     "else BUSKINGSTATUS " + "\r\n" +
                     "end AS BUSKINGSTATUS" + "\r\n" +
                     "FROM" + "\r\n" +
                     "(SELECT a.PERFORM_NO, a.BUSKINGDATE, a.STARTINGTIME, a.FINISHINGTIME, a.TEAM_NAME, b.BUSINESS_WORKNAME, c.ADDRESS, c.HASHTAG, a.USER_NO, c.SPACE_PICTURE, a.BUSKINGSTATUS" + "\r\n" +
                        "FROM reg_buskingtime a " + "\r\n" +
                        "JOIN business b ON a.USER_NO = b.USER_NO " + "\r\n" +
                        "JOIN store c ON a.USER_NO = c.USER_NO " + "\r\n" +
                        "JOIN area_code d ON d.AREA_NAME = SUBSTRING(c.ADDRESS,1,2)" + "\r\n" +
                        "LEFT JOIN team e ON a.TEAM_NO = e.TEAM_NO" + "\r\n" +
                        "WHERE a.TEAM_NAME <> '해피버스킹'" + "\r\n" +
                        "AND a.DELETE_CHK='N' " + "\r\n" +
                        "AND a.BUSKINGDATE >= date(NOW())" + "\r\n" +
                        "ORDER BY a.REGDATE DESC LIMIT  5)  as T1 GROUP BY BUSINESS_WORKNAME"; 				
						
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
        
        sql2 =  "SELECT PERFORM_NO, SUBSTRING_INDEX(BUSKINGDATE,'-',-2) AS BUSKINGDATE, STARTINGTIME, FINISHINGTIME, TEAM_NAME, BUSINESS_WORKNAME, SUBSTRING_INDEX(ADDRESS,' ',2) AS ADDRESS, HASHTAG, USER_NO, SPACE_PICTURE,"  + "\r\n" +
                     "case" + "\r\n" +
                     "when BUSKINGDATE < date(NOW()) AND TEAM_NAME = '' " + "\r\n" +
                     "then '모집마감'" + "\r\n" +
                     "when BUSKINGDATE < date(NOW()) " + "\r\n" +
                     "then '5'" + "\r\n" +
                     "else BUSKINGSTATUS " + "\r\n" +
                     "end AS BUSKINGSTATUS" + "\r\n" +
                     "FROM" + "\r\n" +
                     "(SELECT a.PERFORM_NO, a.BUSKINGDATE, a.STARTINGTIME, a.FINISHINGTIME, a.TEAM_NAME, b.BUSINESS_WORKNAME, c.ADDRESS, c.HASHTAG, a.USER_NO, c.SPACE_PICTURE, a.BUSKINGSTATUS" + "\r\n" +
                        "FROM reg_buskingtime a " + "\r\n" +
                        "JOIN business b ON a.USER_NO = b.USER_NO " + "\r\n" +
                        "JOIN store c ON a.USER_NO = c.USER_NO " + "\r\n" +
                        "JOIN area_code d ON d.AREA_NAME = SUBSTRING(c.ADDRESS,1,2)" + "\r\n" +
                        "LEFT JOIN team e ON a.TEAM_NO = e.TEAM_NO" + "\r\n" +
                        "WHERE a.TEAM_NAME <> '해피버스킹'" + "\r\n" +
                        "AND a.DELETE_CHK='N' " + "\r\n" +
                        "AND a.BUSKINGDATE < date(NOW())" + "\r\n" +
		                "AND a.TEAM_NAME != ''" + "\r\n" +
                        "ORDER BY a.REGDATE DESC LIMIT  10)  as T1 GROUP BY BUSINESS_WORKNAME";
						
		//System.out.println(sql);
		
		rs2 = pstmt.executeQuery(sql2);
		
		while(rs.next()){
			%>
				<DATA>
					<BUSINESS_WORKNAME><%=ConvertUtil.toStr(rs.getString("BUSINESS_WORKNAME"))%></BUSINESS_WORKNAME>
					<USER_NO><%=ConvertUtil.toStr(rs.getString("USER_NO"))%></USER_NO>
					<SPACE_PICTURE><%=ConvertUtil.toStr(rs.getString("SPACE_PICTURE"))%></SPACE_PICTURE>
					<STARTINGTIME><%=ConvertUtil.toStr(rs.getString("STARTINGTIME"))%></STARTINGTIME>
					<FINISHINGTIME><%=ConvertUtil.toStr(rs.getString("FINISHINGTIME"))%></FINISHINGTIME>
					<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
                    <ADDRESS><%=ConvertUtil.toStr(rs.getString("ADDRESS"))%></ADDRESS>
                    <BUSKINGDATE><%=ConvertUtil.toStr(rs.getString("BUSKINGDATE"))%></BUSKINGDATE>
                    <BUSKINGSTATUS><%=ConvertUtil.toStr(rs.getString("BUSKINGSTATUS"))%></BUSKINGSTATUS>
				</DATA>	
			<% 
		}
        while(rs2.next()){
            %>
                <DATA>
                    <BUSINESS_WORKNAME><%=ConvertUtil.toStr(rs2.getString("BUSINESS_WORKNAME"))%></BUSINESS_WORKNAME>
                    <USER_NO><%=ConvertUtil.toStr(rs2.getString("USER_NO"))%></USER_NO>
                    <SPACE_PICTURE><%=ConvertUtil.toStr(rs2.getString("SPACE_PICTURE"))%></SPACE_PICTURE>
                    <STARTINGTIME><%=ConvertUtil.toStr(rs2.getString("STARTINGTIME"))%></STARTINGTIME>
                    <FINISHINGTIME><%=ConvertUtil.toStr(rs2.getString("FINISHINGTIME"))%></FINISHINGTIME>
                    <TEAM_NAME><%=ConvertUtil.toStr(rs2.getString("TEAM_NAME"))%></TEAM_NAME>
                    <ADDRESS><%=ConvertUtil.toStr(rs2.getString("ADDRESS"))%></ADDRESS>
                    <BUSKINGDATE><%=ConvertUtil.toStr(rs2.getString("BUSKINGDATE"))%></BUSKINGDATE>
                    <BUSKINGSTATUS><%=ConvertUtil.toStr(rs2.getString("BUSKINGSTATUS"))%></BUSKINGSTATUS>
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