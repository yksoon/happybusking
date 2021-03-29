<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@page import="java.awt.Image"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="src.util.ImageSizeChange"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%@include file="/service_include.jsp" %>

<%
/*******************************************
* 공연 거절 처리
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

String team_no = ParamUtil.getString(request, "team_no", "");
String btadPerform = ParamUtil.getString(request, "btadPerform", "");

%>


<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		//업로드
		
	    		sql = "UPDATE " + "\r\n" +
	    				"reg_perform" + "\r\n" +
                        "SET MATCHING_CHK = '4' "  + "\r\n" +
                        "WHERE TEAM_NO = '{team_no}'"  + "\r\n" +
                        "AND PERFORM_NO = '{btadPerform}'";

	    		sql = sql.replace("{team_no}", team_no);
	    		sql = sql.replace("{btadPerform}", btadPerform);
	      			
	    		pstmt.executeUpdate(sql);
	    		
	    		//msg = "공연 일정 등록에 성공하였습니다.";
	    		result = true;
	}catch(Exception e){
		result = false;
		msg = "공연 거절에 실패하였습니다." + e;
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