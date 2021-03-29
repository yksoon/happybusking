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
* 로그아웃
*******************************************/
Connection conn = null;
PreparedStatement pstmt = null;


String user_no = USER_NO;
String type = ParamUtil.getString(request, "type", "");
//System.out.println("type : " + type);

String msg = "";
//세션제거
session.invalidate();

//전체 쿠키 삭제
Cookie[] cookies = request.getCookies();

%>

<%

if(cookies != null){
	//로그아웃일때
	if(type.equals("o")){
		conn = dbconn.dbconnect();
		
		String sql = "UPDATE USER " + "\r\n" +
						"SET FCM_TOKEN = '', UUID = ''" + "\r\n" +
						"WHERE USER_NO = " + user_no;
		
		//System.out.println(sql);
		
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	
		msg ="로그아웃 되었습니다.";
	}
	else if(type.equals("du")){
		msg ="다른 기기에서 로그인 되었습니다.";
	}
	else if(type.equals("d")){
		//회원 탈퇴시
		msg = "탈퇴 되었습니다.\n이용해주셔서 감사합니다.";
		
	}
	else{
		msg = "0";
	}
	
	String cName = "";
	
	for(int i = 0; i < cookies.length; i++){
		cName = cookies[i].getName();
		
		if(cName.equals("artist_chk") || cName.equals("login_chk") || cName.equals("nickname") || cName.equals("user_id") || cName.equals("user_no") || cName.equals("busker_oath") || cName.equals("aimg") || cName.equals("owner_chk")){
			//쿠키의 유효시간을 0으로 설정하여 만료시킨다
			cookies[i].setMaxAge(0);
			cookies[i].setPath("/");
			
			//응답 헤더에 추가한다
			response.addCookie(cookies[i]);
		}
	}
}

%>
<ROOT>
	<DATA>
		<MESSAGE><%=msg%></MESSAGE>
	</DATA>
</ROOT>

