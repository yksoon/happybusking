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
* 공연 승인 처리
*******************************************/
String sql = "";
String sql2 = "";
String sql3 = "";
String sql4 = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";


//String contract_no = ParamUtil.getString(request, "contract_no", "");
String perform_no = ParamUtil.getString(request, "perform_no", "");
//String user_no = ParamUtil.getString(request, "user_no", "");
String user_no_arr = ParamUtil.getString(request, "user_no_arr", "");

String[] user_no_arr2 = user_no_arr.split(",");
//System.out.println(user_no_arr2[0]);
//System.out.println(user_no_arr2[1]);

String team_no = ParamUtil.getString(request, "team_no", "");
String team_name = ParamUtil.getString(request, "team_name", "");
String business_representive = ParamUtil.getString(request, "business_representive", "");
String buskingdate = ParamUtil.getString(request, "buskingdate", "");

%>

<%

	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		//업로드
		for (int i = 0; i < user_no_arr2.length; i++) {
            String user_no = user_no_arr2[i];
            String contract_no = perform_no + "-" + user_no;

	    		sql = "INSERT INTO " + "\r\n" +
	    				"e_contract(CONTRACT_NO, PERFORM_NO, CONTRACT_EMPLOYER, CONTRACT_START_DAY, CONTRACT_END_DAY, CONTRACT_STATUS, USER_NO)" + "\r\n" +
                        "VALUES ('{contract_no}', '{perform_no}', '{business_representive}', '{buskingdate_1}', '{buskingdate_2}', '1', '{user_no}')";

	    		sql = sql.replace("{contract_no}", contract_no);
	    		sql = sql.replace("{perform_no}", perform_no);
                sql = sql.replace("{user_no}", user_no);
                sql = sql.replace("{business_representive}", business_representive);
                sql = sql.replace("{buskingdate_1}", buskingdate);
                sql = sql.replace("{buskingdate_2}", buskingdate);
	      			
	    		pstmt.executeUpdate(sql);

                System.out.println(sql);
				
        }
        


                sql2 = "UPDATE reg_buskingtime " + "\r\n" +
                        "SET BUSKINGSTATUS='1', TEAM_NO = '{team_no}', TEAM_NAME='{team_name}'" + "\r\n" +
                        "WHERE PERFORM_NO = '{perform_no}'";

                sql2 = sql2.replace("{team_no}", team_no);
                sql2 = sql2.replace("{team_name}", team_name);
                sql2 = sql2.replace("{perform_no}", perform_no);

                pstmt.executeUpdate(sql2);

                System.out.println(sql2);


                sql3 = "UPDATE reg_perform" + "\r\n" +
                        "SET MATCHING_CHK = '3'" + "\r\n" +
                        "WHERE PERFORM_NO = '{perform_no}'" + "\r\n" +
                        "AND TEAM_NO = '{team_no}'";

                sql3 = sql3.replace("{team_no}", team_no);
                sql3 = sql3.replace("{perform_no}", perform_no);

                pstmt.executeUpdate(sql3);

                System.out.println(sql3);


                sql4 = "UPDATE reg_perform" + "\r\n" +
                        "SET MATCHING_CHK = '4'" + "\r\n" +
                        "WHERE PERFORM_NO = '{perform_no}'" + "\r\n" +
                        "AND TEAM_NO <> '{team_no}'";

                sql4 = sql4.replace("{team_no}", team_no);
                sql4 = sql4.replace("{perform_no}", perform_no);

                pstmt.executeUpdate(sql4);

                System.out.println(sql4);

	    		
	    		//msg = "공연 일정 등록에 성공하였습니다.";
	    		result = true;
	}catch(Exception e){
		result = false;
		msg = "공연 승인에 실패하였습니다." + e;
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