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
* 공연 정보 수정(update)
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
Statement pstmt2 = null;
ResultSet rs2 = null;

boolean result = false;
String msg = "";

        /* 공간정보 */
	
        String perform_no = ParamUtil.getString(request, "perform_no", "");
        String artist_matching = ParamUtil.getString(request, "artist_matching", "");
    
%>


<%
	try{
		conn = dbconn.dbconnect();
        conn.setAutoCommit(false);
		//업로드
		
        sql = "update reg_buskingtime" + "\r\n" +
              "set delete_chk='Y'" + "\r\n" +
              "where perform_no =?";
    
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, perform_no);
        pstmt.executeUpdate();

        if(artist_matching.equals("Y")){
            sql = "update reg_perform" + "\r\n" +
                  "set matching_chk='4'" + "\r\n" +
                  "where perform_no =?";
                
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, perform_no);
                    pstmt.executeUpdate();
        }

        conn.commit();
		result = true;

        if(result == true){
			msg = "공연일정 삭제가 완료되었습니다.";	
			
		}

	}catch(Exception e){
		if(conn != null){
            try{
                conn.rollback();
				return;
            }catch(SQLException ex){e.printStackTrace();}
        }
		result = false;
		msg = "공연일정 삭제에 실패하였습니다.";
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