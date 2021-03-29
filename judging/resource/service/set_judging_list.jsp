<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
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
* 공지사항 댓글 등록(INSERT)
*******************************************/
String sql = "";
Connection conn = null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String no = ParamUtil.getString(request, "no", "");
String tno = ParamUtil.getString(request, "tno", "");
String name = ParamUtil.getString(request, "name", "");
String mcategory = ParamUtil.getString(request, "mcategory", "");
String scategory = ParamUtil.getString(request, "scategory", "");
String score1 = ParamUtil.getString(request, "score1", "0");
String score2 = ParamUtil.getString(request, "score2", "0");
String score3 = ParamUtil.getString(request, "score3", "0");
String totalscore = ParamUtil.getString(request, "totalscore", "0");

/* System.out.println("no : " + no);
System.out.println("tno : " + tno);
System.out.println("name : " + name);
System.out.println("mcategory : " + mcategory);
System.out.println("scategory : " + scategory);
System.out.println("score1 : " + score1);
System.out.println("score2 : " + score2);
System.out.println("score3 : " + score3);
System.out.println("totalscore : " + totalscore);  */

try{
	conn = dbconn.dbconnect();
	stmt = conn.createStatement();
	
	sql = "select * from metro_judging" + "\r\n" +
			"where no = '"+no+"'" + "\r\n" +
			"and name = '"+name+"'" + "\r\n";
	
	//System.out.println(sql);
	
	rs = stmt.executeQuery(sql);
	
	
	if(rs.next()){
		sql = "update metro_judging" + "\r\n" +
				"set score1 = ?, score2 = ?, score3 = ?, totalscore = ?" + "\r\n" +
				"where no = ? and name = ?" + "\r\n";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(score1));
		pstmt.setInt(2, Integer.parseInt(score2));
		pstmt.setInt(3, Integer.parseInt(score3));
		pstmt.setInt(4, Integer.parseInt(totalscore));
		pstmt.setString(5, no);
		pstmt.setString(6, name);
		
		pstmt.executeUpdate();
		
	} else {
		sql = "insert into" + "\r\n" +
				"metro_judging(no, tno, name, mcategory, scategory, score1, score2, score3, totalscore)" + "\r\n" +
				"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)" + "\r\n";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, no);
		pstmt.setString(2, tno);
		pstmt.setString(3, name);
		pstmt.setString(4, mcategory);
		pstmt.setString(5, scategory);
		pstmt.setInt(6, Integer.parseInt(score1));
		pstmt.setInt(7, Integer.parseInt(score2));
		pstmt.setInt(8, Integer.parseInt(score3));
		pstmt.setInt(9, Integer.parseInt(totalscore));
		
		pstmt.executeUpdate();
	}
	
	
} catch(Exception e){
	//System.out.println(e.getMessage());
}

if(pstmt != null){
	pstmt.close();	
}

if(rs != null){
	rs.close();
}

if(stmt != null){
	stmt.close();
}

if(conn != null){
	conn.close();	
}

%>