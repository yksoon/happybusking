<%@page import="java.net.URLDecoder"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="src.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
    
    String w_user_no = "";
    String w_sid = "";
    String chk = "";

	String USER_NO = String.valueOf(session.getAttribute("USER_NO"));
	String NICKNAME = (String) session.getAttribute("NICKNAME");
	String USER_ID = (String) session.getAttribute("USER_ID");
	String USER_PASS = (String) session.getAttribute("USER_PASS");
	String USER_ACTIVE = (String) session.getAttribute("USER_ACTIVE");
	String USER_DEL = (String) session.getAttribute("USER_DEL");
	String ARTIST_CHK = (String) session.getAttribute("ARTIST_CHK");
    String OWNER_CHK = (String) session.getAttribute("OWNER_CHK");
	String USER_IMG = (String) session.getAttribute("USER_IMG");
	String AGE = (String)session.getAttribute("AGE");
	String GENDER = (String)session.getAttribute("GENDER");
	String ARTIST_NAME = (String)session.getAttribute("ARTIST_NAME");
	String DEVICE_UUID = (String)session.getAttribute("DEVICE_UUID");
	String LOGIN_CHK = (String)session.getAttribute("LOGIN_CHK");
	String BUSKER_OATH = (String)session.getAttribute("BUSKER_OATH");
	String AIMG = (String)session.getAttribute("AIMG");

	String user_nm = "";
	
	String see_team = "";
	String get_see_team = "";
	

	//쿠키 암호화, 복호화를 위한 클래스
	
	String key = "abcdefghijklmnop";
	AES128Util aes = new AES128Util(key);
	
	Cookie[] cookies0 = request.getCookies();
	try{
		if(cookies0 != null){
			for(Cookie c0 : cookies0){
				if(c0.getName().equals("user_no")){
					USER_NO = c0.getValue();
					
					//쿠키 복호화
					USER_NO = aes.decrypt(USER_NO);
				}
				else if(c0.getName().equals("nickname")){
					NICKNAME = URLDecoder.decode(c0.getValue(), "utf-8");
					user_nm = NICKNAME;
				}
				else if(c0.getName().equals("user_id")){
					USER_ID = c0.getValue();
					
					//쿠키 복호화
					USER_ID = aes.decrypt(USER_ID);
				}
				else if(c0.getName().equals("artist_chk")){
					ARTIST_CHK = c0.getValue();
				}
				else if(c0.getName().equals("owner_chk")){
					OWNER_CHK = c0.getValue();
				}                
				else if(c0.getName().equals("device_uuid")){
					DEVICE_UUID = c0.getValue();
				}
				else if(c0.getName().equals("login_chk")){
					LOGIN_CHK = c0.getValue();
				}
				else if(c0.getName().equals("see_teamNo")){/* 관람한 팀 /시간 쿠키 */
					see_team = c0.getValue();
				}
				else if(c0.getName().equals("busker_oath")){
					BUSKER_OATH = c0.getValue();
				}
				else if(c0.getName().equals("aimg")){
					AIMG = c0.getValue();
				}
			}
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
%>