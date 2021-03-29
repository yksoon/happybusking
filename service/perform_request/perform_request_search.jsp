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
* 공연의뢰 검색 페이지 
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;


boolean result = false;
String msg = "";

String tname = ParamUtil.getString(request, "tname", "");
String tgenre = ParamUtil.getString(request, "tgenre", "");
String tarea = ParamUtil.getString(request, "tarea", "");
String tsmoney = ParamUtil.getString(request, "tsmoney", "");
String temoney = ParamUtil.getString(request, "temoney", "");
String ttype = ParamUtil.getString(request, "ttype", "");

String[] tgenre_arry = tgenre.split(",");
int allChk;

/* System.out.println("tsmoney : " + tsmoney);
System.out.println("temoney : " + temoney); */
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		sql = "SELECT TEAM_NO, TEAM_NAME, CODE_GENRE, TINTRO_IMG" + "\r\n" +
				"FROM TEAM" + "\r\n" +
				"WHERE TEAM_NAME LIKE '%"+tname+"%'" + "\r\n";
		
		if(!tgenre.equals("")){
			sql += "AND (";
			
			for(int i = 0; i < tgenre_arry.length; i++){
				allChk = tgenre_arry[i].split(" ").length;
				
				if(allChk > 1){
					if(i == 0){
						sql += "FIND_IN_SET('"+tgenre_arry[i].split(" ")[0]+"',GENRE_GUBUN)";
					} else {
						sql += " OR FIND_IN_SET('"+tgenre_arry[i].split(" ")[0]+"',GENRE_GUBUN)";
					}
				} else {
					if(i == 0){
						sql += "FIND_IN_SET('"+tgenre_arry[i]+"',GENRE_GUBUN)";
					} else {
						sql += " OR FIND_IN_SET('"+tgenre_arry[i]+"',GENRE_GUBUN)";
					}
				}
				
			}
			
			sql += ")" + "\r\n";
		}
		
		if(!tarea.equals("")){
			sql += "AND CODE_AREA = '"+tarea+"'" + "\r\n";
		}
		
		if(!tsmoney.equals("") && !temoney.equals("")){
			sql += "AND (TEAM_PAY >= "+tsmoney+" AND TEAM_PAY <= "+temoney+")" + "\r\n";
		} else if(!tsmoney.equals("") && temoney.equals("")){
			sql += "AND TEAM_PAY >= " + tsmoney + "\r\n";
		} else if(tsmoney.equals("") && !temoney.equals("")){
			sql += "AND TEAM_PAY <= " + temoney + "\r\n";
		}
		
		if(!ttype.equals("") && !ttype.equals("3")){
			sql += "AND TEAM_TYPE = " + ttype + "\r\n";
		}
		
		
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
					<TEAM_NAME><%=ConvertUtil.toStr(rs.getString("TEAM_NAME"))%></TEAM_NAME>
					<CODE_GENRE><%=ConvertUtil.toStr(rs.getString("CODE_GENRE"))%></CODE_GENRE>
					<TINTRO_IMG><%=ConvertUtil.toStr(rs.getString("TINTRO_IMG"))%></TINTRO_IMG>
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