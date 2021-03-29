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
* 지원물품 재고 체크
*******************************************/
String sql = "";
String sql2 = "";
String sql3 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//지원물품 재고 체크  Parameter 
String item_no =  ParamUtil.getString(request, "item_no", "");
String item_count = ParamUtil.getString(request, "item_count", "");

%>

<ROOT>
<%
int total_itemCount = 0;
String itemName = "";

	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
	
 			sql =   "SELECT ITEM_NAME, ITEM_COUNT" + "\r\n" + 
 		 			  "FROM ITEM" + "\r\n" + 
 		 			 "WHERE ITEM_NO =" + item_no + "\r\n";


			//sql = sql.replace("{category_name}", category_name); 
					
			//System.out.println(sql);
			
			rs = pstmt.executeQuery(sql);
			
			
			
			if(rs.next()){
				itemName = rs.getString("ITEM_NAME");
				total_itemCount = rs.getInt("ITEM_COUNT");
				
				if(Integer.parseInt(item_count) <= total_itemCount){
					result = true;
				}else if(Integer.parseInt(item_count) > total_itemCount){
					result = false;
				}
				
			}
			

				 	

	}catch(Exception e){
		result = false;
		e.printStackTrace();
	}
%>	
		<DATA>
			<RESULT><%=String.valueOf(result)%></RESULT>
			<ITEM_NAME><%=itemName%></ITEM_NAME>
			<ITEM_COUNT><%=total_itemCount%></ITEM_COUNT>
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