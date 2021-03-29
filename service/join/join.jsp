<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%-- <%@include file="/service_include.jsp" %> --%>



<%
/*******************************************
* 회원가입(insert)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

//현재 날짜 구해서 팀번호 생성
SimpleDateFormat tnoSdf = new SimpleDateFormat("yyMMddkkmmss");
Date nowdate = new Date();
int randNum = ((int)(Math.random()*9998)+1);
String user_no = tnoSdf.format(nowdate) + String.format("%04d", randNum);

//초기화 (0: 중복이 안되어있다)
int count = 0;

//회원가입 Parameter
String user_id = ParamUtil.getString(request, "user_id", "");
String user_pw = ParamUtil.getString(request, "user_pw", "");
String nickname = URLDecoder.decode(ParamUtil.getString(request, "nickname", ""), "UTF-8");
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
	try{
	conn = dbconn.dbconnect();
			
	user_pw = SecuritySha.SHA256(user_pw);
	
	sql = "INSERT INTO" + "\r\n" +  
			"USER(USER_ID, USER_PW, NICKNAME, LOGIN_CHK, USER_NO)" +
			"VALUES(?, ?, ?, ?, ?)" + "\r\n"; 
			
	pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, user_id);
	pstmt.setString(2, user_pw);
	pstmt.setString(3, nickname);
	pstmt.setString(4, login_chk);
	pstmt.setString(5, user_no);
	
	/* 최종적으로 DB로 값이 들어가는 단계(쿼리 실행단계) */
	int result = pstmt.executeUpdate();		
	
	if(result == 1){
		sql = "SELECT * ," + "\r\n" +
	 				"(SELECT COUNT(*) FROM TEAM_MEMBER WHERE USER_NO = U.USER_NO AND MEMBER_REQ_STATUS = '1') AS CNT," + "\r\n" +
	 				"(SELECT ARTIST_NAME FROM ARTIST WHERE USER_NO = U.USER_NO) AS ARTIST_NAME" + "\r\n" +
	 				"FROM USER U" + "\r\n" + 
	 				"WHERE USER_ID = '" + user_id + "'" + "\r\n" +
	 				"AND USER_PW = '" + user_pw + "'" + "\r\n" +
	 				  "AND LOGIN_CHK ='" + login_chk + "'" + "\r\n";

	 	rs = pstmt.executeQuery(sql);
	 	
	 	if(rs.next()){
	 		String sql_uuid = "UPDATE USER" + "\r\n" +
					"SET UUID = '" + uuid + "'\r\n" +
				"WHERE USER_ID = '" + user_id + "'\r\n";
				
		pstmt.executeQuery(sql_uuid);
		
		session = request.getSession(true);
		session.setAttribute("USER_NO", ConvertUtil.toStr(rs.getString("USER_NO")));
		session.setAttribute("USER_ID", ConvertUtil.toStr(rs.getString("USER_ID")));
		session.setAttribute("NICKNAME", ConvertUtil.toStr(rs.getString("NICKNAME")));
		session.setAttribute("USER_ACTIVE", ConvertUtil.toStr(rs.getString("USER_ACTIVE")));
		session.setAttribute("ARTIST_CHK", ConvertUtil.toStr(rs.getString("ARTIST_CHK")));
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

		                                                                                                                                                 user_no = ConvertUtil.toStr(rs.getString("USER_NO"));
		String artist_chk = ConvertUtil.toStr(rs.getString("ARTIST_CHK"));
		String busker_oath = ConvertUtil.toStr(rs.getString("BUSKER_OATH"));
	
		//쿠키 암호화
		user_no = aes.encrypt(user_no);
		user_id = aes.encrypt(user_id);
		nickname = URLEncoder.encode(nickname, "UTF-8");

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
	 	}
		
	%>
		<DATA>
			<RESULT>result</RESULT>
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