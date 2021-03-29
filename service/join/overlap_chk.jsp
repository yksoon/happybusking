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
* ID 중복 체크
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//초기화 (0: 중복이 안되어있다)
int count = 0;

//id 중복체크 Parameter
String user_id = ParamUtil.getString(request, "user_id", "");

%>


<%
	try{
	conn = dbconn.dbconnect();
	pstmt = conn.createStatement();
	
	sql = "SELECT count(*)" + "\r\n" +  
			"FROM USER" + "\r\n" +  
		   "WHERE USER_ID = '{user_id}'" + "\r\n";

			
	
	sql = sql.replace("{user_id}", user_id);
			
	rs = pstmt.executeQuery(sql);
		
		
		if(rs.next()) {
			//id 중복 체크 변수(0: 중복 x, 1: 중복 O)
			count = ConvertUtil.toInteger(rs.getInt("COUNT(*)"));
			
			if(count == 0){
				msg = "사용할 수 있는 id입니다.";
			}else if(count == 1){
				msg = "id값이 중복되었습니다. 사용할 수 없는 id입니다.";
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
	<ROOT>
		<DATA>
			<COUNT><%=String.valueOf(count)%></COUNT>
			<MESSAGE><%=msg%></MESSAGE>
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