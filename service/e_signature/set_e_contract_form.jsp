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
* 계약서 등록
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
//StringBuffer sb1 = new StringBuffer();
//StringBuffer sb2 = new StringBuffer();
//StringBuffer sb3 = new StringBuffer();
//StringBuffer sb4 = new StringBuffer();

//sb1.append(ParamUtil.getString(request, "contract_img_1", ""));
//sb2.append(ParamUtil.getString(request, "contract_img_2", ""));
//sb3.append(ParamUtil.getString(request, "contract_img_3", ""));
//sb4.append(ParamUtil.getString(request, "contract_img_4", ""));

String contract_no = ParamUtil.getString(request, "contract_no", "");
String contract_img_1 = ParamUtil.getString(request, "contract_img_1", "");
String perform_no = ParamUtil.getString(request, "perform_no", "");

%>

<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
  			sql = "INSERT INTO " + "\r\n" +
  					"e_contract_form (CONTRACT_NO, CONTRACT_1, PERFORM_NO)"  + "\r\n" + 
                    "VALUES"  + "\r\n" + 
					"('" + contract_no + "', " + "\r\n" + 
					"'" + contract_img_1 +"', " + "\r\n" + 
					"'" + perform_no + "')";
		
		
  		// System.out.println(sql);
  			
		pstmt.executeUpdate(sql);
		result = true;
		msg = "성공 ㄱㄱㄱㄱ";

	}catch(Exception e){
		result = false;
		e.printStackTrace();
	}
%>
 	<ROOT>
		<DATA>
			<RESULT><%=String.valueOf(result)%></RESULT>
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