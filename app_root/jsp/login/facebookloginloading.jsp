<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
        
<%@include file="/importhaed.jsp" %>
<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<script type="text/javascript" src="/js/heartpay/login/facebooklogin.js?ver=1.0.3" ></script>
<script>
$( document ).on('pageinit', '#facebookloginloading', function() {
	window.fbAsyncInit = function() {
		FB.init({
			appId      : '1273105036213007',
			cookie     : true,  // enable cookies to allow the server to access 
								// the session
			autoLogAppEvents : true,
			xfbml      : true,  // parse social plugins on this page
			version    : 'v3.3' // The Graph API version to use for the call
		});
	
		FB.getLoginStatus(function(response) {
			//statusChangeCallback(response);
			
			if (response.status === 'connected') {      // 페이스북을 통해서 로그인 
				//DisplayResult();
				FB.api('/me?fields=id,name,email', 'GET', function(response2) {
					//document.getElementById('status').innerHTML =  '아이디 ' + response.id + '/ 이메일 ' + response.email + "/ 이름 " + response.name;		
					sessionStorage.setItem("fName", response2.name);
					sessionStorage.setItem("fEmail", response2.email);
	
					facebooklogin();
				  });
			  } else if (response.status === 'not_authorized') {      // 페이스북에는 로그인 했지만, 앱에는 로그인이 되어있지 않다 
				alert('페이스북 로그인을 취소하셨습니다.');
				location.href='/app_root/index.jsp';
			  } else {	  // 페이스북에 로그인 되어있지 않아서, 앱에 로그인이 되어있는지 불확실
				alert('페이스북 로그인을 취소하셨습니다.');
				location.href='/app_root/index.jsp';
			  }
		}, true);
	};
});


function facebooklogin() {
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		url: '/service/login/facebookLogin.jsp',
		data : {
			user_id : sessionStorage.getItem("fEmail"),
			login_chk : 'F'
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				var url = '/app_root/index.jsp?nlc=F';
				$.mobile.changePage(url, {transition : "none"});
			}
			
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			$(DATA).each(function() {
				var LOGINCHK = $(this).find('LOGINCHK').text();
				var STATUS = $(this).find('STATUS').text();
				var CNT = $(this).find('CNT').text();
				
				//alert(sessionStorage.getItem("fEmail"));
				
				getAimg();
				if(LOGINCHK == '1'){
					if(STATUS == 'L'){
						var url = '/app_root/index.jsp?nlc=L&cnt='+CNT;
						$.mobile.changePage(url, {transition : "none"});
					}else if(STATUS == 'J'){
						var url = '/app_root/index.jsp?nlc=J&cnt='+CNT;
						$.mobile.changePage(url, {transition : "none"});								
					}
				}
				else{
					//alert('다시 로그인 해주세요. 만약 해당 현상이 반복된다면 happybuskinginsta 로 문의해주십시오.');
					//$('#user_pass').val('');
					//$('#user_pass').focus();
					location.href = "https://www.happybusking.com/app_root/jsp/login/checkterms.jsp";
					//alert('gocheckterms 회원가입 약관 페이지로 이동);
				}
			});
		},
		error: function (xhr, message, errorThrown) {
		} // end error 
	});

};
</script>

<div data-role="page" id="facebookloginloading">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
	<div data-role="content">
		<img src="/img/login/loading.gif">
	<div id="status"></div>
	</div>	
	<%@include file="/app_root/jsp/footer/footer.jsp" %>	
</div>