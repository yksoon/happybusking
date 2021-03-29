<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr"
	pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%-- 쿠키 암호화 위한 AES128Util import --%>

<%@ page import="src.util.*"%>
<%--<%@include file="/service_include.jsp"%>--%>



<%
	/*******************************************
	* 로그인 
	*******************************************/

	String sql = "";
    String sql0 = "";
    String sql0_1 = "";
    String sql1 = "";
    
    String sql2 = "";
    String sql3 = "";
    String sql4 = "";
    
    String sql_uuid = "";
    
	Connection conn = null;
	Statement pstmt = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs = null;
	ResultSet rs0 = null;
	ResultSet rs0_1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	
	boolean result = false;
	String msg = "";
	String chk_status = "L";
	
	int cnt = 0;
	
	int see_chk = 0;
	
	String pf_chk_userNo = "";

	//로그인 Parameter
	String user_id = ParamUtil.getString(request, "user_id", "");
	String user_pw = ParamUtil.getString(request, "user_pw", "");
	String name = URLDecoder.decode(ParamUtil.getString(request, "nickname", ""), "UTF-8");
	String birth = ParamUtil.getString(request, "birth", "");
	String gender = ParamUtil.getString(request, "gender", "M");
	String token = ParamUtil.getString(request, "token", "");
	String login_chk = ParamUtil.getString(request, "login_chk", "");	
	String uuid = "";
	
	Cookie[] cookies0 = request.getCookies();
	
	if(cookies0 != null){
		for(Cookie c0 : cookies0){
			if(c0.getName().equals("device_uuid")){
				uuid = c0.getValue();
			}
		}
	}
%>
<ROOT>
<%
if(user_id == null || user_id == "" || user_id.equals("")){
	chk_status = "F";
%>	
		<DATA> 
			<LOGINCHK>1</LOGINCHK> 
			<STATUS><%=chk_status%></STATUS>
			<CNT>0</CNT>
 		</DATA> 
</ROOT>
<%	
}else{ 

 	try {

 		conn = dbconn.dbconnect();
 		pstmt = conn.createStatement();
 		
 		//이메일 로그인이 아닐 시에만 자동 회원가입
 		if(!login_chk.equals("F")){
 	 		sql0 = "SELECT COUNT(*) AS CNT"+ "\r\n" +
 	 				"FROM USER" + "\r\n" + 
 	 				"WHERE USER_ID = '" + user_id +"'" + "\r\n" + 
 	 				  "AND LOGIN_CHK = 'N'" + "\r\n";
 	 		
 	 		rs0 = pstmt.executeQuery(sql0);
 	 		
 	 		if(rs0.next()){
 	 			cnt = rs0.getInt("CNT");
 	 			
 	 			if(cnt == 0){
 	 				sql0_1 = "SELECT COUNT(*) AS CNT" + "\r\n" +
 	 							"FROM USER" + "\r\n" +
 	 							"WHERE USER_ID = '" + user_id + "'\r\n"+
 	 							"AND LOGIN_CHK = 'E'";
 	 				
 	 				rs0_1 = pstmt.executeQuery(sql0_1);
 	 				
 	 				if(rs0_1.next()){
 	 					int cnt2 = rs0_1.getInt("CNT");
						
 	 					if(cnt2 == 0){
 	 						SimpleDateFormat tnoSdf = new SimpleDateFormat("yyMMddkkmmss");
							Date nowdate = new Date();
							int randNum = ((int)(Math.random()*9998)+1);
							String newuno = tnoSdf.format(nowdate) + String.format("%04d", randNum);

 	 	 	 				sql1 = "INSERT INTO" + "\r\n" +  
 	 	 	 						"USER(USER_ID, NICKNAME, BIRTH, GENDER, TOKEN, LOGIN_CHK, USER_NO)" +
 	 	 	 						"VALUES(?, ?, ?, ?, ?, ?, ?)" + "\r\n"; 
 	 	 	 				
 	 	 	 				pstmt2 = conn.prepareStatement(sql1);
 	 	 	 				
 	 	 	 				pstmt2.setString(1, user_id);
 	 	 	 				pstmt2.setString(2, name);
 	 	 	 				pstmt2.setString(3, birth);
 	 	 	 				pstmt2.setString(4, gender);
 	 	 	 				pstmt2.setString(5, token);
 	 	 	 				pstmt2.setString(6, login_chk);
 	 	 	 				pstmt2.setString(7, newuno);
 	 	 	 				
 	 	 	 				
 	 	 	 				pstmt2.executeUpdate();
 	 	 	 				
 	 	 					chk_status = "J";
 	 	 					
 	 					} else {
 	 						chk_status = "O";
 	 					}
 	 				}
 	 				
					
 	 			}				
				sql = "SELECT * ," + "\r\n" +
						"(SELECT COUNT(*) FROM TEAM_MEMBER WHERE USER_NO = U.USER_NO AND MEMBER_REQ_STATUS = '1') AS CNT," + "\r\n" +
						"(SELECT ARTIST_NAME FROM ARTIST WHERE USER_NO = U.USER_NO) AS ARTIST_NAME" + "\r\n" +
						"FROM USER U" + "\r\n" + 
						"WHERE USER_ID = '" + user_id + "'" + "\r\n" +
						  "AND LOGIN_CHK ='N'" + "\r\n";

				rs = pstmt.executeQuery(sql);
				
 	 		}
 		}
 		else{
 			//이메일 로그인이라면
 			user_pw = SecuritySha.SHA256(user_pw);	//패스워드 암호화
 			
 			sql = "SELECT * ," + "\r\n" +
 	 				"(SELECT COUNT(*) FROM TEAM_MEMBER WHERE USER_NO = U.USER_NO AND MEMBER_REQ_STATUS = '1') AS CNT," + "\r\n" +
 	 				"(SELECT ARTIST_NAME FROM ARTIST WHERE USER_NO = U.USER_NO) AS ARTIST_NAME" + "\r\n" +
 	 				"FROM USER U" + "\r\n" + 
 	 				"WHERE USER_ID = '" + user_id + "'" + "\r\n" +
 	 				"AND USER_PW = '" + user_pw + "'" + "\r\n" +
 	 				  "AND LOGIN_CHK ='" + login_chk + "'" + "\r\n";

 	 		rs = pstmt.executeQuery(sql);
 		}
 		
 		if (rs.next()) {
			
 			/*  세션 저장
 			session.setAttribute("USER_ID",ConvertUtil.toStr(rs.getString("USER_ID")));
 			*/

 			if (ConvertUtil.toStr(rs.getString("USER_ACTIVE")).equals("Y") == true) {
 				//로그인 성공시 DB에 UUID 값 저장
				sql_uuid = "UPDATE USER" + "\r\n" +
 							"SET UUID = '" + uuid + "'\r\n" +
							"WHERE USER_ID = '" + user_id + "'\r\n";
							
				pstmt.executeQuery(sql_uuid);
 				
 				session = request.getSession(true);
 				session.setAttribute("USER_NO", ConvertUtil.toStr(rs.getString("USER_NO")));
 				session.setAttribute("USER_ID", ConvertUtil.toStr(rs.getString("USER_ID")));
 				session.setAttribute("NICKNAME", ConvertUtil.toStr(rs.getString("NICKNAME")));
 				session.setAttribute("USER_ACTIVE", ConvertUtil.toStr(rs.getString("USER_ACTIVE")));
 				session.setAttribute("ARTIST_CHK", ConvertUtil.toStr(rs.getString("ARTIST_CHK")));
 				session.setAttribute("BIRTH", ConvertUtil.toStr(rs.getString("BIRTH")));
 				session.setAttribute("GENDER", ConvertUtil.toStr(rs.getString("GENDER")));
 				session.setAttribute("ARTIST_NAME", ConvertUtil.toStr(rs.getString("ARTIST_NAME")));
 				session.setAttribute("DEVICE_UUID", ConvertUtil.toStr(rs.getString("UUID")));
 				session.setAttribute("LOGIN_CHK", ConvertUtil.toStr(rs.getString("LOGIN_CHK")));
 				session.setAttribute("BUSKER_OATH", ConvertUtil.toStr(rs.getString("BUSKER_OATH")));
				

 				//세션 유지 시간
 				session.setMaxInactiveInterval(1 * 60);

 				//세션 유지 확인
 				String sid = (String) session.getAttribute("USER_ID");
 				//System.out.println(sid);

 				//자동 로그인
 				String key = "abcdefghijklmnop";
 				AES128Util aes = new AES128Util(key);

 				String user_no = String.valueOf(ConvertUtil.toStr(rs.getString("USER_NO")));
 				String nickname = URLEncoder.encode(ConvertUtil.toStr(rs.getString("NICKNAME")), "UTF-8");
 				String artist_chk = ConvertUtil.toStr(rs.getString("ARTIST_CHK"));
 				String busker_oath = ConvertUtil.toStr(rs.getString("BUSKER_OATH"));
				
 				pf_chk_userNo = user_no;
 				
 				//쿠키 암호화
 				user_no = aes.encrypt(user_no);
 				user_id = aes.encrypt(user_id);

 				//쿠키생성
 				Cookie c = new Cookie("user_no", user_no);
 				Cookie c2 = new Cookie("user_id", user_id);
 				Cookie c4 = new Cookie("nickname", nickname);
 				Cookie c6 = new Cookie("artist_chk", artist_chk);
 				Cookie c8 = new Cookie("login_chk", login_chk);
 				Cookie c10 = new Cookie("busker_oath", busker_oath); 

 				//쿠키 유효기간 (60일)
 				c.setMaxAge(60 * 24 * 60 * 60);
 				c2.setMaxAge(60 * 24 * 60 * 60);
 				c4.setMaxAge(60 * 24 * 60 * 60);
 				c6.setMaxAge(60 * 24 * 60 * 60);
 				c8.setMaxAge(60 * 24 * 60 * 60);
 				c10.setMaxAge(60 * 24 * 60 * 60);

 				//쿠키 path 지정
 				c.setPath("/");
 				c2.setPath("/");
 				c4.setPath("/");
 				c6.setPath("/");
 				c8.setPath("/");
 				c10.setPath("/");

 				response.addCookie(c);
 				response.addCookie(c2);
 				response.addCookie(c4);
 				response.addCookie(c6);
 				response.addCookie(c8);
 				response.addCookie(c10);

 				sid = aes.encrypt(sid);

 				Cookie c7 = new Cookie("sid", sid);
 				c7.setMaxAge(60 * 24 * 60 * 60);
 				c7.setPath("/");
 				response.addCookie(c7);
 				
 				
 				String seeTeam = "";

				cookies0 = request.getCookies();
				try{
					if(cookies0 != null){
						for(Cookie c0 : cookies0){
						if(c0.getName().equals("see_teamNo")){/* 관람한 팀 /시간 쿠키 */
							seeTeam = c0.getValue();
								//System.out.println("로그인쪽 관람한 팀과 시간 체크 : " + seeTeam);
							}
						}
					}
				}
				catch(Exception e){
					e.printStackTrace();
				}
				
				if(!seeTeam.equals("")){
					String[] array_team_performDate = seeTeam.split(",");
					
					//System.out.println("내가 봤던 공연 수 : " + array_team_performDate.length);
					for(int i=0; i<array_team_performDate.length; i++){
						String[] QrPerformDate = array_team_performDate[i].split("@");
						
						String pfTeamNo = aes.decrypt(QrPerformDate[0]);
						String pfDate = QrPerformDate[1];
						
						//시간으로 해당 공연있는지 체크
				 		sql2 = "SELECT PF_NO, COUNT(*) AS CNT FROM PERFORM" + "\r\n" +
				 				"WHERE TEAM_NO = '" + pfTeamNo + "'" + "\r\n" +
				 				  "AND DATE_FORMAT('" + pfDate + "', '%Y-%m-%d %H:%i')"  + "\r\n" + 
				 			  "BETWEEN DATE_FORMAT(CONCAT(PF_DATE, ' ' , PF_TIME), '%Y-%m-%d %H:%i')" + "\r\n" +
				 				  "AND DATE_FORMAT(CONCAT(PF_EDATE, ' ' , PF_ETIME), '%Y-%m-%d %H:%i')" + "\r\n" + 
				 				  "AND PF_CANCLE = 0" + "\r\n";
				 		
				 		rs2 = pstmt.executeQuery(sql2);
				 		
				 		if (rs2.next()) {
				 			see_chk = rs2.getInt("CNT");
				 			//해당 공연 있을 때
				 			if(see_chk == 1){
				 				int pfNumber = rs2.getInt("PF_NO");
				 				
				 				//내가 본 공연쪽에 등록되어있는지 체크
				 				sql3 = "SELECT COUNT(*) AS UPR_CHK FROM USER_PERFORM_RECORD" + "\r\n" +
						 				"WHERE USER_NO ='" + pf_chk_userNo + "'" + "\r\n" + 
						 				   "AND PF_NO =" + pfNumber + "\r\n";
				 				
						 		rs3 = pstmt.executeQuery(sql3);
						 		
						 		if (rs3.next()) {
						 			int uPerformRecordChk = rs3.getInt("UPR_CHK");
						 			//내가 본 공연쪽에 없을 때
						 			if(uPerformRecordChk == 0){
						 				
						 				//내가 본 공연 테이블에 등록
						 				sql4 = "INSERT INTO" + "\r\n" +  
						 						"USER_PERFORM_RECORD(USER_NO, PF_NO)" +
						 						"VALUES('{userNo}'," + pfNumber +" )" + "\r\n"; 
						 				
						 				sql4 = sql4.replace("{userNo}", pf_chk_userNo);
										
										pstmt.executeUpdate(sql4);
						 			}
						 		}
				 			}
				 		}
					}
					 // 특정 쿠키(see_teamNo) 삭제하기
 				    Cookie kc = new Cookie("see_teamNo", null);
				    kc.setMaxAge(0);
				    kc.setPath("/");
				    response.addCookie(kc); 
				}
 			}
			%>	
			<DATA> 
			<LOGINCHK>1</LOGINCHK> 
			<STATUS><%=chk_status%></STATUS>
			<CNT><%=ConvertUtil.toInteger(rs.getInt("CNT"))%></CNT>
 			</DATA> 
		<%			
 		}
 		else{
 			if(!chk_status.equals("O")){
 	 			chk_status = "f";
 			}
 			%>
 			<DATA> 
			<LOGINCHK>0</LOGINCHK> 
			<STATUS><%=chk_status%></STATUS>
			<CNT>0</CNT>
 			</DATA> 
 			<%
 		}
 	
	%> 
	</ROOT>
	<%
	} catch (Exception e) {
		e.getStackTrace();
	}

%>

<%
	try {
		rs.close();
		rs0.close();
		rs2.close();
	} catch (Exception ex) {
	}
	try {
		pstmt.close();
	} catch (Exception ex) {
	}
	try {
		conn.close();
	} catch (Exception ex) {
	}
}
%>