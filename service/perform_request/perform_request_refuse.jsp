<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="java.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%@include file="/service_include.jsp" %>



<%
/*******************************************
* 공연 의뢰 거절(update)
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//공연 의뢰 거절 Parameter 
String team_no =  ParamUtil.getString(request, "team_no", "");
String prq_grp_no =  ParamUtil.getString(request, "prq_grp_no", "");
String prq_refuse_msg =  ParamUtil.getString(request, "prq_refuse_msg", "");


//System.out.println(team_no);
//System.out.println(prq_grp_no);

//거절 날짜 update를 위한 변수
String request_date = "";
String request_time = "";


//거절 날짜 현재시간으로 설정하기
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date time = new Date();

String now = sdf.format(time);

request_date = now.split(" ")[0];
request_time = now.split(" ")[1];

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
	
 			sql = "UPDATE PERFORM_REQUEST" + "\r\n" +
 					"SET PF_REQUEST_STATE = 'N', PF_REQUEST_RE_DATE = '{request_date}', PF_REQUEST_RE_TIME = '{request_time}'," + "\r\n" +
					  "PF_REQUEST_CANCEL_MSG = '" + prq_refuse_msg + "'\r\n" +
 		 		   "WHERE TEAM_NO =" + team_no + "\r\n" + 
 			         "AND PF_REQUEST_NO =" + prq_grp_no + "\r\n";
			sql = sql.replace("{request_date}", request_date);
			sql = sql.replace("{request_time}", request_time);
		
					
			//System.out.println(sql);
			
			pstmt.executeUpdate(sql);	
			
			

			result = true;
			msg = "공연 요청을 거절하셨습니다.";
			
			
			sql2 = "SELECT T.TEAM_NAME, MIN(PF_REQUEST_SDATE) AS MIN_DATE, MAX(PF_REQUEST_SDATE) AS MAX_DATE, U.FCM_TOKEN" + "\r\n" +
					 "FROM PERFORM_REQUEST PRQ, TEAM T, USER U" + "\r\n" +
			        "WHERE PRQ.TEAM_NO = T.TEAM_NO" + "\r\n" +
			          "AND PRQ.USER_NO = U.USER_NO" + "\r\n" +
			          "AND PRQ.TEAM_NO = '" + team_no + "'\r\n" +
			          "AND PRQ.PF_REQUEST_NO = " + prq_grp_no + "\r\n";

			//System.out.println(sql2);
			
			rs = pstmt.executeQuery(sql2);
			
			if(rs.next()){
				String team_name = ConvertUtil.toString(rs.getString("TEAM_NAME"));
				String token = ConvertUtil.toString(rs.getString("FCM_TOKEN"));
				String min_date = ConvertUtil.toString(rs.getString("MIN_DATE"));
				String max_date = ConvertUtil.toString(rs.getString("MAX_DATE"));
				String date = "(" + min_date + "~" + max_date + ")";
				String data = "'" + team_name + "' 아티스트가  요청하신 공연 의뢰" + date + "를 거절하였습니다";
				FirebaseMessagingService.pushFCMNotification(token, 
						"[공연 의뢰 알림]", data, "/jsp/perform_request/user_perform_requestList.jsp", data, true);		
			}
			

	}catch(Exception e){
		result = false;
		msg = "공연 요청을 거절하지 못했습니다.잠시후에 다시 시도해주세요.\n해당 문제가 지속되는 경우 1:1문의 또는 메일 문의 부탁드리겠습니다.";
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