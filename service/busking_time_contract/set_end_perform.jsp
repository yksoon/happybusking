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
* 공연 완료 처리 - 아티스트
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;


boolean result = false;
String msg = "";

String perform_no = ParamUtil.getString(request, "perform_no", "");
String user_no = ParamUtil.getString(request, "user_no", "");
String end_perform_date = ParamUtil.getString(request, "end_perform_date", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		//업로드
		
	    		sql = "UPDATE reg_buskingtime " + "\r\n" +
	    				"SET BUSKINGSTATUS = '5', END_PERFORM_USER_NO = '" + user_no + "', END_PERFORM_DATE = '" + end_perform_date + "'" + "\r\n" +
                        "WHERE PERFORM_NO = '" + perform_no + "'";

	      			
	    		pstmt.executeUpdate(sql);

                sql2 = "SELECT a.END_PERFORM_USER_NO, a.END_PERFORM_DATE, b.ARTIST_NAME "  + "\r\n" +
                        "FROM reg_buskingtime a"  + "\r\n" +
                        "JOIN artist b ON a.END_PERFORM_USER_NO = b.USER_NO"  + "\r\n" +
                        "WHERE PERFORM_NO = '" + perform_no + "'";

                System.out.println(sql2);

                rs = pstmt.executeQuery(sql2);

	    		
	    		//msg = "공연 일정 등록에 성공하였습니다.";
	    		result = true;

                while(rs.next()){
                %>
                    <DATA>
                        <END_PERFORM_USER_NO><%=ConvertUtil.toString(rs.getString("END_PERFORM_USER_NO"))%></END_PERFORM_USER_NO>
                        <END_PERFORM_DATE><%=ConvertUtil.toString(rs.getString("END_PERFORM_DATE")) %></END_PERFORM_DATE>
                        <ARTIST_NAME><%=ConvertUtil.toString(rs.getString("ARTIST_NAME")) %></ARTIST_NAME>
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