<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.io.File"%>
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
* 전자서명 등록(insert) - 아티스트
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String contract_artist = ParamUtil.getString(request, "contract_artist", "");
String contract_resident_reg_num = ParamUtil.getString(request, "contract_resident_reg_num", "");
String contract_artist_addr = ParamUtil.getString(request, "contract_artist_addr", "");
String artist_sign = ParamUtil.getString(request, "artist_sign", "");
String contract_price = ParamUtil.getString(request, "contract_price", "");
String contract_date = ParamUtil.getString(request, "contract_date", "");
String perform_no = ParamUtil.getString(request, "perform_no", "");
String contract_bank_name = ParamUtil.getString(request, "contract_bank_name", "");
String contract_bank_number = ParamUtil.getString(request, "contract_bank_number", "");
String contract_bank_user = ParamUtil.getString(request, "contract_bank_user", "");
String user_no = ParamUtil.getString(request, "user_no", "");
%>

<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
  			sql = "UPDATE e_contract " + "\r\n" +
  					"SET CONTRACT_ARTIST = '" + contract_artist + "', CONTRACT_RESIDENT_REG_NUM = '" + contract_resident_reg_num + "', CONTRACT_ARTIST_ADDR = '" + contract_artist_addr + "', ARTIST_SIGN = '" + artist_sign + "',"  + "\r\n" + 
                    "CONTRACT_PRICE = '" + contract_price + "', CONTRACT_DATE = '" + contract_date + "', CONTRACT_STATUS = '2', ART_BANK_NAME = '" + contract_bank_name + "', ART_BANK_NUMBER = '" + contract_bank_number + "', ART_BANK_USER = '" + contract_bank_user + "'" + "\r\n" +
  					"WHERE PERFORM_NO = '" + perform_no + "'" + "\r\n" +
                    "AND USER_NO = '" + user_no + "'";
		
		
  		System.out.println(sql);
  			
		pstmt.executeUpdate(sql);
		result = true;

	}catch(Exception e){
		result = false;
		e.printStackTrace();
	}
%>
 	<ROOT>
	 <%
		try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

        sql2 = "SELECT CONTRACT_STATUS" + "\r\n" +
                    "FROM e_contract"  + "\r\n" +
                    "WHERE PERFORM_NO = '" + perform_no + "'";
        

        		rs = pstmt.executeQuery(sql2);
		
		// System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
                <CONTRACT_STATUS><%=ConvertUtil.toString(rs.getString("CONTRACT_STATUS")) %></CONTRACT_STATUS>
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