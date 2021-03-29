<?xml version="1.0" encoding="utf-8"?>
<%@page import="src.util.ParamUtil"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.activation.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>

<%
	String email = ParamUtil.getString(request, "email", "");
	String keyState = ParamUtil.getString(request, "keyState", "");

	int key = (int)(Math.random()*99998)+11111;
	String joinKey = String.valueOf(key);
%>

<%!
  public class MyAuthentication extends Authenticator { //아이디 패스워드 인증받기 함수
  PasswordAuthentication pa;
  public MyAuthentication(){
    pa = new PasswordAuthentication("happybusking","1q2w3e4r~!`1");        
  }
  @Override
  protected PasswordAuthentication getPasswordAuthentication() {
    return pa;
  }
}
%>

<%
try {
	// SMTP 서버 주소
	 String smtpHost = "mail.bizworks.co.kr";

	//받는 사람 정보
	String toEmail = email;

	 //보내는 사람의 정보
	 String fromName = "해피버스킹";
	 String fromEmail = "happybusking@bizworks.co.kr";
	 

	Connection conn = null;
	PreparedStatement pstmt = null;
	
	 try {
	  Properties props = new Properties();
	  props.put("mail.smtp.host", smtpHost);
	  props.put("mail.smtp.auth","true");


	  // 메일 인증
	  Authenticator myauth = new MyAuthentication(); 
	  Session sess=Session.getInstance(props, myauth);


	  InternetAddress addr = new InternetAddress();
	  addr.setPersonal(fromName,"UTF-8");
	  addr.setAddress(fromEmail);


	  Message msg1 = new MimeMessage(sess);
	  msg1.setFrom(addr);         
	  msg1.setSubject(MimeUtility.encodeText("해피버스킹 인증메일", "utf-8","B"));
	  /* msg1.setContent("<a href='http://www.officeai.co.kr/jsp/login/email_chk.jsp?"+AMHO_ID+"'>"+"인증 메일적는곳입니다.","text/html;charset=utf-8"); */
	  if(keyState.equals("J")){
		  msg1.setContent(
				  "<!DOCTYPE html>"+
				  "<html>"+
				  "<head>"+
				  "<meta charset='UTF-8'>"+
				  "<title>OFFICE_AI</title>"+
				  "<link href='http://www.openhiun.com/hangul/nanumbarungothic.css' rel='stylesheet' type='text/css'>"+
				  "<link href='/css/bootstrap/bootstrap.min.css' rel='stylesheet'>"+
				  "<link href='/css/bootstrap/bootstrap-theme.min.css' rel='stylesheet'>"+
				  "<link href='/css/main/main.css' rel='stylesheet'>"+
				  "<script type='text/javascript' src='/js/jquery/jquery-1.11.3.min.js' ></script>"+
				  "<script type='text/javascript' src='/js/bootstrap/bootstrap.min.js' ></script>"+
				  "<script type='text/javascript' src='/js/login/login.js'></script>"+
				  "<script type='text/javascript' src='/js/jquery-modal/jquery.modal.min.js'></script>"+	
				  "<script type='text/javascript' src='/js/login/email_chk.js'></script>"+	
				  "</head>"+
				  "<body>"+
				  "<!-- HEADER 부분  -->"+
				  	"<section class='content'>"+
					"	<div class='jumbotron' style='border:0;'>"+
					"		<div class='container' style='width:674px;'>"+
					"			<img src='http://happybusking.com/img/join/email_chk.png'>"+
					"			<div class='row' style='margin-top: 2%;width : 674px; text-align : center;'>"+
					"				<p style='font-size: 18px; font-weight: bold;'>"+joinKey+"</p>"+
					"			</div>"+
					"		</div>"+		
					"	</div>"+	
					"</section>"+
					"</body>"+
					"</html>"
					,"text/html;charset=utf-8");
	  }
	  else{
		  msg1.setContent(
				  "<!DOCTYPE html>"+
				  "<html>"+
				  "<head>"+
				  "<meta charset='UTF-8'>"+
				  "<title>OFFICE_AI</title>"+
				  "<link href='http://www.openhiun.com/hangul/nanumbarungothic.css' rel='stylesheet' type='text/css'>"+
				  "<link href='/css/bootstrap/bootstrap.min.css' rel='stylesheet'>"+
				  "<link href='/css/bootstrap/bootstrap-theme.min.css' rel='stylesheet'>"+
				  "<link href='/css/main/main.css' rel='stylesheet'>"+
				  "<script type='text/javascript' src='/js/jquery/jquery-1.11.3.min.js' ></script>"+
				  "<script type='text/javascript' src='/js/bootstrap/bootstrap.min.js' ></script>"+
				  "<script type='text/javascript' src='/js/login/login.js'></script>"+
				  "<script type='text/javascript' src='/js/jquery-modal/jquery.modal.min.js'></script>"+	
				  "<script type='text/javascript' src='/js/login/email_chk.js'></script>"+	
				  "</head>"+
				  "<body>"+
				  "<!-- HEADER 부분  -->"+
				  	"<section class='content'>"+
					"	<div class='jumbotron' style='border:0;'>"+
					"		<div class='container' style='width:674px;'>"+
					"			<img src='http://happybusking.com/img/join/password_find.png'>"+
					"			<div class='row' style='margin-top: 2%;width : 674px; text-align : center;'>"+
					"               <input type='number' readonly='readonly' value=" + joinKey + " style='text-align : center;'>" +
					"			</div>"+
					"		</div>"+		
					"	</div>"+	
					"</section>"+
					"</body>"+
					"</html>"
					,"text/html;charset=utf-8");
	  }
	  
			  
			  		
	  
 	 msg1.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
	 
 	 
	 Transport.send(msg1);
		
	//인증번호 DB 저장
	try{
		conn = dbconn.dbconnect();
		
		String sql = "INSERT INTO " + "\r\n" +
						"EMAIL_CHK(EMAIL, CHK_CODE)" + "\r\n" +
						"VALUES(?, ?)";
		
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, joinKey);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}catch(Exception e){
		//System.out.println(e.getMessage());
	}

	 } catch (Exception e) {
	// System.out.println(e);
	 e.printStackTrace();
	  out.println("메일 전송에 실패했습니다. 다시 시도해주세요.");
	  return;
	 }
					
} catch (Exception ex) {
	//System.out.println("rs실패");
}
%>
