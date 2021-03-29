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
* 상업공간 리스트
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String user_no = ParamUtil.getString(request, "user_no", "");
String slArea = ParamUtil.getString(request, "slArea", "");
String slMonth = ParamUtil.getString(request, "slMonth", "");
String slGenre = ParamUtil.getString(request, "slGenre", "");
String sls_search_result = ParamUtil.getString(request, "sls_search_result", "");
String artist = ParamUtil.getString(request, "artist", "");
String recruiting = ParamUtil.getString(request, "recruiting", "");
String recruited = ParamUtil.getString(request, "recruited", "");
// String search_date = ParamUtil.getString(request, "search_date", "");
String sl_Limit = ParamUtil.getString(request, "sl_Limit", "0");
String sl_Last = ParamUtil.getString(request, "sl_Last", "20");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

        String where = "";
        String where2 = "";
        if(!slArea.equals("")) where = "AND SUBSTRING(c.ADDRESS,1,2) = '" + slArea + "'\r\n";
        if(!slMonth.equals("")) where = "AND SUBSTRING(a.BUSKINGDATE,6,2)  LIKE '%" + slMonth + "%'\r\n";
        if(!slGenre.equals("")) where = "AND e.MAIN_GENRE = '" + slGenre + "'\r\n";
        if(!sls_search_result.equals("")) where = "AND b.BUSINESS_WORKNAME LIKE '%" + sls_search_result + "%'\r\n";
        if(!recruiting.equals("")) where2 = "AND BUSKINGSTATUS = '3' AND a.BUSKINGDATE >= date(NOW())\r\n";
        if(!recruited.equals("")) where2 = "AND BUSKINGSTATUS = '1' AND a.BUSKINGDATE >= date(NOW() AND BUSKINGSTATUS = '5')\r\n";

        if(artist.equals("Y")){     // 아티스트가 내공연
            sql = "SELECT a.PERFORM_NO, a.BUSKINGDATE, a.STARTINGTIME, a.FINISHINGTIME, a.TEAM_NAME, b.BUSINESS_WORKNAME, c.ADDRESS, c.HASHTAG, a.USER_NO, c.SPACE_PICTURE," + "\r\n" +
                    "case" + "\r\n" +
                    "when a.BUSKINGDATE < date(NOW()) AND a.TEAM_NAME = '' " + "\r\n" +
                    "then '모집마감'" + "\r\n" +
                    "when a.BUSKINGDATE < date(NOW()) " + "\r\n" +
                    "then '5'" + "\r\n" +
                    "else a.BUSKINGSTATUS " + "\r\n" +
                    "end AS BUSKINGSTATUS" + "\r\n" +
                    "FROM reg_buskingtime a" + "\r\n" +
                    "JOIN business b ON a.USER_NO = b.USER_NO" + "\r\n" +
                    "JOIN store c ON a.USER_NO = c.USER_NO" + "\r\n" +
                    "JOIN area_code d ON d.AREA_NAME = SUBSTRING(c.ADDRESS,1,2)" + "\r\n" +
                    "LEFT JOIN team e ON a.TEAM_NO = e.TEAM_NO" + "\r\n" +
                    "INNER JOIN team_member f ON E.TEAM_NO = f.TEAM_NO" + "\r\n" +
                    "WHERE a.USER_NO <> '해피버스킹'" + "\r\n" +
                    where +
                    "AND f.USER_NO = '" + user_no + "'" + "\r\n" +
                    "AND a.DELETE_CHK = 'N'" + "\r\n" +
                    "ORDER BY a.REGDATE DESC"  + "\r\n";
        } else if(artist.equals("") && user_no.equals("")){
            sql = "SELECT a.PERFORM_NO, a.BUSKINGDATE, a.STARTINGTIME, a.FINISHINGTIME, a.TEAM_NAME, b.BUSINESS_WORKNAME, c.ADDRESS, c.HASHTAG, a.USER_NO, c.SPACE_PICTURE," + "\r\n" +
                    "case" + "\r\n" +
                    "when a.BUSKINGDATE < date(NOW()) AND a.TEAM_NAME = '' " + "\r\n" +
                    "then '모집마감'" + "\r\n" +
                    "when a.BUSKINGDATE < date(NOW()) " + "\r\n" +
                    "then '5'" + "\r\n" +
                    "else a.BUSKINGSTATUS " + "\r\n" +
                    "end AS BUSKINGSTATUS" + "\r\n" +
                    "FROM reg_buskingtime a "  + "\r\n" +
                    "JOIN business b ON a.USER_NO = b.USER_NO "  + "\r\n" +
                    "JOIN store c ON a.USER_NO = c.USER_NO"  + "\r\n" +
                    "JOIN area_code d ON d.AREA_NAME = SUBSTRING(c.ADDRESS,1,2)"   + "\r\n" +
                    "LEFT JOIN team e ON a.TEAM_NO = e.TEAM_NO" + "\r\n" +
                    "WHERE a.TEAM_NAME <> '해피버스킹'" + "\r\n" +
                    "AND a.DELETE_CHK = 'N'" + "\r\n" +
                    where +
                    where2 +
                    "ORDER BY a.REGDATE DESC" + "\r\n";
        }
        else {
            sql = "SELECT a.PERFORM_NO, a.BUSKINGDATE, a.STARTINGTIME, a.FINISHINGTIME, a.TEAM_NAME, b.BUSINESS_WORKNAME, c.ADDRESS, c.HASHTAG, a.USER_NO, c.SPACE_PICTURE," + "\r\n" +
                    "case" + "\r\n" +
                    "when a.BUSKINGDATE < date(NOW()) AND a.TEAM_NAME = '' " + "\r\n" +
                    "then '모집마감'" + "\r\n" +
                    "when a.BUSKINGDATE < date(NOW()) " + "\r\n" +
                    "then '5'" + "\r\n" +
                    "else a.BUSKINGSTATUS " + "\r\n" +
                    "end AS BUSKINGSTATUS" + "\r\n" +
                    "FROM reg_buskingtime a "  + "\r\n" +
                    "JOIN business b ON a.USER_NO = b.USER_NO "  + "\r\n" +
                    "JOIN store c ON a.USER_NO = c.USER_NO"  + "\r\n" +
                    "JOIN area_code d ON d.AREA_NAME = SUBSTRING(c.ADDRESS,1,2)"   + "\r\n" +
                    "LEFT JOIN team e ON a.TEAM_NO = e.TEAM_NO" + "\r\n" +
                    "WHERE a.TEAM_NAME <> '해피버스킹'" + "\r\n" +
                    "AND a.DELETE_CHK = 'N'" + "\r\n" +
                    where +
                    "AND a.USER_NO = '" + user_no + "'"  + "\r\n" +
                    "ORDER BY a.REGDATE DESC" + "\r\n";
        }

        sql = sql.concat("limit " + sl_Limit + ", " + sl_Last + "\r\n");
		
		rs = pstmt.executeQuery(sql);
		
		System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
				<PERFORM_NO><%=ConvertUtil.toString(rs.getString("PERFORM_NO"))%></PERFORM_NO>
				<BUSKINGDATE><%=ConvertUtil.toString(rs.getString("BUSKINGDATE")) %></BUSKINGDATE>
                <STARTINGTIME><%=ConvertUtil.toString(rs.getString("STARTINGTIME")) %></STARTINGTIME>
                <FINISHINGTIME><%=ConvertUtil.toString(rs.getString("FINISHINGTIME")) %></FINISHINGTIME>
                <TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME")) %></TEAM_NAME>
                <BUSINESS_WORKNAME><%=ConvertUtil.toString(rs.getString("BUSINESS_WORKNAME")) %></BUSINESS_WORKNAME>
                <ADDRESS><%=ConvertUtil.toString(rs.getString("ADDRESS")) %></ADDRESS>
                <HASHTAG><%=ConvertUtil.toString(rs.getString("HASHTAG")) %></HASHTAG>
                <BUSKINGSTATUS><%=ConvertUtil.toString(rs.getString("BUSKINGSTATUS")) %></BUSKINGSTATUS>
                <USER_NO><%=ConvertUtil.toString(rs.getString("USER_NO")) %></USER_NO>
                <SPACE_PICTURE><%=ConvertUtil.toString(rs.getString("SPACE_PICTURE")) %></SPACE_PICTURE>
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