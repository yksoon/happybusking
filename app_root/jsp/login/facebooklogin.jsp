<!--<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
        
<%@include file="/importhaed.jsp" %>
<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<script type="text/javascript" src="/js/heartpay/login/facebooklogin.js" ></script>
<script>

// facebooklogin.jsp 부분 javascript 내용
function facebookLogin(){
	// facebook login URL BLOCKED error 때문에 uri뒤에 _oauth/facebook?close 붙여줌 'https://test.happybusking.com:441/app_root/_oauth/facebook?close'
	// https://test.happybusking.com:441/app_root/jsp/login/facebookloginloading.jsp
	var uri = encodeURI('https://test.happybusking.com:441/app_root/jsp/login/facebookloginloading.jsp');
	window.location = encodeURI("https://www.facebook.com/dialog/oauth?client_id=974326732910806&redirect_uri="+uri+"&response_type=token");
}
</script>

<div data-role="page" id="facebooklogin">
	// header 부분
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	// content 부분
	<div data-role="content">
		<div onclick ="facebookLogin()"><span class="btn-login-facebook"><button>페이스북으로 로그인</button></span></div>
	<div id="status"></div>
	</div>	
	<%@include file="/app_root/jsp/footer/footer.jsp" %>	
</div>

-->