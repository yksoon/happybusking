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
* 공연의뢰 신청 날짜 중복 체크(select)
*******************************************/
String sql = "";


Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";


//공연의뢰 신청 날짜 중복 체크  Parameter );
String team_no =  ParamUtil.getString(request, "team_no", "");
String date = ParamUtil.getString(request, "date", "");
String stime = ParamUtil.getString(request, "stime", "");
String etime = ParamUtil.getString(request, "etime", "");


/* System.out.println(team_no);
System.out.println(date);
System.out.println(stime);
System.out.println(etime); */


String start_date = date + " " + stime;
String end_date = date + " " + etime;

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		
			sql = "SELECT COUNT(*) AS CNT_PRQ," + "\r\n" +  
					"(SELECT COUNT(*) FROM PERFORM" + "\r\n" +  
					  "WHERE TEAM_NO = " + team_no + "\r\n" + 
					    "AND DATE_FORMAT('"+ start_date + "', '%Y-%m-%d %H:%i') < DATE_FORMAT(CONCAT(PF_EDATE, ' ' , PF_ETIME), '%Y-%m-%d %H:%i')" + "\r\n" + 
					    "AND DATE_FORMAT('"+ end_date + "', '%Y-%m-%d %H:%i') > DATE_FORMAT(CONCAT(PF_DATE, ' ' , PF_TIME), '%Y-%m-%d %H:%i')) AS CNT_PF" + "\r\n" +		
					"FROM PERFORM_REQUEST" + "\r\n" + 
					"WHERE TEAM_NO = " + team_no + "\r\n" + 
					  "AND DATE_FORMAT('"+ start_date + "', '%Y-%m-%d %H:%i') < DATE_FORMAT(CONCAT(PF_REQUEST_EDATE, ' ' , PF_REQUEST_ETIME), '%Y-%m-%d %H:%i')" + "\r\n" + 
					  "AND DATE_FORMAT('"+ end_date + "', '%Y-%m-%d %H:%i') > DATE_FORMAT(CONCAT(PF_REQUEST_SDATE, ' ' , PF_REQUEST_STIME), '%Y-%m-%d %H:%i')" + "\r\n" +
					  "AND PF_REQUEST_STATE = 'Y'" + "\r\n";
					   
		    //System.out.println(sql);
		    rs = pstmt.executeQuery(sql);
		    
		    if(rs.next()){
		    	int count_prq = rs.getInt("CNT_PRQ");
		    	int count_pf = rs.getInt("CNT_PF");
		    	
		    	//중복된 데이터 없을 때 INSERT
		    	if(count_prq == 0 && count_pf == 0){
		    		result = true;
		    	}else{
		    		result = false;
					msg = "추가하신 공연의뢰 날짜가 해당 아티스트 일정(공연일정, 공연의뢰 내용)이랑 겹침니다! 다시 추가해주세요";	
		    	}
		    }
	
 			

			
			
			

				 	

	}catch(Exception e){
		result = false;
		msg = "공연의뢰 날짜 중복 체크 실패";
		e.printStackTrace();
	}
%>	
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