<?xml version="1.0" encoding="utf-8"?>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
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
* 공연의뢰 신청(insert)
*******************************************/
String sql = "";
String sql0 = "";
String sql2 = "";
String sql3 = "";

Connection conn = null;
Statement pstmt = null;
PreparedStatement pstmt2 = null;
ResultSet rs = null;

boolean result = false;
String msg = "";
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		String folderName = "artist" + USER_NO;
		String encType = "UTF-8";
		int size = 5*1024*1024; 
		
		String saveDirectory = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.0\\happybusking\\ROOT\\upload\\artist\\";
		String path = saveDirectory + folderName;
		
		File dir = new File(path);
		
		if(!dir.exists()){
			dir.mkdirs();
		}

		//다중 업로드 처리(중복 방지)
		MultipartRequest multi = new MultipartRequest(request, path, size, encType, new DefaultFileRenamePolicy());
		
		//공연의뢰 신청  Parameter );
		String team_no = multi.getParameter("team_no");
		String name = multi.getParameter("name");
		String hp = multi.getParameter("hp");
		String alltime = multi.getParameter("alltime");
		String addr = multi.getParameter("addr");
		String zipcode = multi.getParameter("zipcode");
		String detail_addr = multi.getParameter("detail_addr");
		String geocode = multi.getParameter("geocode");
		String[] arrayDate_value = multi.getParameterValues("arrayDate");
		String perform_rq_msg = multi.getParameter("perform_rq_msg");
		String eq_sup = multi.getParameter("eq_sup");
		
		
			sql = "SELECT IFNULL(MAX(PF_REQUEST_GRP_NO), 0) AS GRP_NO, T.TEAM_PAY" + "\r\n" +  
					"FROM PERFORM_REQUEST PR" + "\r\n" +
					"JOIN TEAM T ON T.TEAM_NO = PR.TEAM_NO" + "\r\n" +
				   "WHERE PR.TEAM_NO = " + team_no + "\r\n";

			
			rs = pstmt.executeQuery(sql);
			
			int grpNo = 0;
			String tprice = "0";
			int price = 0;
			if(rs.next()){
				grpNo = rs.getInt("GRP_NO");
				grpNo = grpNo + 1;
				tprice = rs.getString("TEAM_PAY");
			}
			
			String[] arrayDate = arrayDate_value[0].split(",");
			
			for(int i=0; i<arrayDate.length; i++){
				//System.out.println("arrayDate : " + arrayDate[i]);
				String[] dateArray = arrayDate[i].split(" ");
				
				String date = dateArray[0];
				//System.out.println("date : " + date);
				
				String[] timeArray = dateArray[1].split("~");
				
				String stime = timeArray[0];
				String etime = timeArray[1];
				
				//System.out.println("stime : " + stime);
				//System.out.println("etime : " + etime);
				
				//String[] itemArray = arrayDate[i].split("@");
				
				if(tprice == null || tprice.equals("")){
					tprice = "0";
				}
				
				price = (int)(Integer.parseInt(tprice) * Double.parseDouble(alltime.split(",")[i]));
				
				//System.out.println(i + "번째 시간 : " + alltime.split(",")[i]);


				/* sql2 = "INSERT INTO" + "\r\n" +  
					"PERFORM_REQUEST(PF_REQUEST_GRP_NO, TEAM_NO, USER_NO, USER_NAME, USER_PHONE, PF_REQUEST_SDATE, PF_REQUEST_STIME, PF_REQUEST_EDATE, PF_REQUEST_ETIME, PF_REQUEST_LATLNG," + "\r\n" +
					"PF_REQUEST_ADDR, PF_REQUEST_ZIPCODE, PF_REQUEST_DETAIL_ADDR, PF_REQUEST_PRICE, PF_REQUEST_REG_DATE, PF_REQUEST_MSG, PF_REQUEST_EQ_SUP)" + "\r\n" +
					"VALUES( " + grpNo + "," + team_no + "," + USER_NO + "," + "'{user_name}'," + "'{user_phone}'," + "'{pf_rq_sdate}'," + "'{pf_rq_stime}'," + "'{pf_rq_edate}'," +  "\r\n" 
					+ "'{pf_rq_etime}',"+ "'{geocode}'," + "'{addr}'," + "'{zipcode}'," + "'{detail_addr}'," + "'{price}'," + "NOW(), '{perform_rq_msg}', '{eq_sup}')" + "\r\n"; */  
			
				sql2 = "INSERT INTO" + "\r\n" +  
						"PERFORM_REQUEST(PF_REQUEST_GRP_NO, TEAM_NO, USER_NO, USER_NAME, USER_PHONE, PF_REQUEST_SDATE, PF_REQUEST_STIME, PF_REQUEST_EDATE, PF_REQUEST_ETIME, PF_REQUEST_LATLNG," + "\r\n" +
						"PF_REQUEST_ADDR, PF_REQUEST_ZIPCODE, PF_REQUEST_DETAIL_ADDR, PF_REQUEST_EQ_SUP, PF_REQUEST_PRICE, PF_REQUEST_REG_DATE, PF_REQUEST_MSG)" + "\r\n" +
						"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
				
				
				pstmt2 = conn.prepareStatement(sql2);
				
				pstmt2.setInt(1, grpNo);
				pstmt2.setString(2, team_no);
				pstmt2.setString(3, USER_NO);
				pstmt2.setString(4, name);
				pstmt2.setString(5, hp);
				pstmt2.setString(6, date);
				pstmt2.setString(7, stime);
				pstmt2.setString(8, date);
				pstmt2.setString(9, etime);
				pstmt2.setString(10, geocode);
				pstmt2.setString(11, addr);
				pstmt2.setString(12, zipcode);
				pstmt2.setString(13, detail_addr);
				pstmt2.setString(14, eq_sup);
				pstmt2.setString(15, tprice);
				pstmt2.setString(16, perform_rq_msg);
						
				pstmt2.executeUpdate();	 
				
				
				result = true;
				msg = "작성하신 내용으로 공연 요청되었습니다.\n아티스트들의 응답을 기다려주세요!";		    		
		    }
			
			if(result){
				sql = "SELECT * FROM TEAM_MEMBER TM" + "\r\n" +
						"JOIN USER U ON U.USER_NO = TM.USER_NO" + "\r\n" +
						"WHERE TEAM_NO = " + team_no + "\r\n" +
						"AND LEADER_CHK = 1";
				
				//System.out.println(sql);
				
				rs = pstmt.executeQuery(sql);
				
				if(rs.next()){
					String token = ConvertUtil.toStr(rs.getString("FCM_TOKEN"));
					
					String data = "새로운 공연 의뢰가 들어왔습니다 !! 지금 확인해보세요 !";
					FirebaseMessagingService.pushFCMNotification(token, 
							"[공연 의뢰 알림]", data, "artist_perform_requestList", data, true);	
				}
			}
 			
	}catch(Exception e){
		result = false;
		msg = "공연 요청에 실패했습니다.잠시후 다시 시도해주세요.\n해당 메시지가 계속 출력되면 1:1문의 또는 메일 문의 부탁드리겠습니다.";
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