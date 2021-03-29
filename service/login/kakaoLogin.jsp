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
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>

<%
/*******************************************
* 카카오톡 로그인 서비스
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

String nickname = "";
String email = "";
String birthday = "";
String gender = "";

boolean result = false;
String msg = "";

String token = ParamUtil.getString(request, "token", "");

System.out.println("token:" + token);


BufferedReader in = null; 
BufferedReader in2 = null; 
try { 
	URL obj = new URL("https://kapi.kakao.com/v2/user/me"); 
	//URL obj = new URL("https://kapi.kakao.com/v1/user/signup"); 
	// 호출할 url 
	HttpURLConnection con = (HttpURLConnection)obj.openConnection(); 
	con.setRequestMethod("POST"); 
	con.setRequestProperty("Accept", "application/json");
	con.setRequestProperty( "Authorization", "Bearer " + token);
	con.setRequestProperty( "Content-type", "application/x-www-form-urlencoded;charset=utf-8" );
	con.setDoInput(true);
	con.setDoOutput(true);
	con.connect();
	
	
	in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8")); 
	String line; 
	StringBuilder buffer = new StringBuilder();
	while((line = in.readLine()) != null) { 
	// response를 차례대로 출력
	 //System.out.println(line); 
	 buffer.append(line);
	} 
	
	line = buffer.toString();
	con.disconnect();
	
    try {


        //System.out.println("=====Members=====");
        
        
        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObj = (JSONObject) jsonParser.parse(line);
        

		JSONObject meminfo = (JSONObject) jsonObj.get("properties");
		
		nickname = meminfo.get("nickname").toString();
        
        
        JSONObject meminfo2 = (JSONObject) jsonObj.get("kakao_account");
        email = meminfo2.get("email").toString();
        birthday = meminfo2.get("birthday").toString();
        gender = meminfo2.get("gender").toString();
        
        /* System.out.println(nickname);
        System.out.println(email);
        System.out.println(birthday);
        System.out.println(gender); */
        
        if(gender.equals("male")){
        	gender = "M";
        	System.out.println(gender);
        }else{
        	gender = "F";
        	System.out.println(gender);
        }
        


    } catch (ParseException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
	

} catch(Exception e) { 
	e.printStackTrace();

 } finally { 
	 if(in != null) 
	 try { in.close(); 
	 } catch(Exception e) { 
	 e.printStackTrace(); 
	 } 
 }
%>


	<ROOT>
		<DATA>
			<NICKNAME><%=nickname%></NICKNAME>
			<EMAIL><%=email%></EMAIL>
			<BIRTHDAY><%=birthday%></BIRTHDAY>
			<GENDER><%=gender%></GENDER>
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