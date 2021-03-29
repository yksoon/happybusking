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
* 아티스트 되기(insert)
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";


%>


<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

		String uploading_img = ParamUtil.getString(request, "uploading_img", "");
		
  			sql = "INSERT INTO " + "\r\n" +
  					"TEST_IMAGE_UPLOAD(UPLOADING_IMG) " + "\r\n" +
  					"VALUES('{uploading_img}')";
		

  			sql = sql.replace("{uploading_img}", uploading_img);
		
  		//System.out.println(sql);			
		pstmt.executeUpdate(sql);
		
		result = true;
		
		if(result == true){
			msg = "사진 등록이 완료되었습니다.";
		}

	}catch(Exception e){
		result = false;
		msg = "사진 등록에 실패하였습니다.";
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