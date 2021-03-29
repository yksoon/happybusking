<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

        
<%@include file="/importhaed.jsp" %>

<div data-role="page" id="login">
<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
<!--	<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>-->
	<script type="text/javascript" src="/js/heartpay/login/facebooklogin.js?ver=1.0.2" ></script>
	<script type="text/javascript" src="/js/heartpay/login/naverlogin.js?ver=1.0.3" ></script>

	<!-- content 부분 -->
	<div data-role="content" style="padding: 20px 40px 0px 40px; text-align: center; ">
 		<div class="ui-grid-a" style="margin-top: 20px;">
			<div class="ui-block-a" style="width: 100%;">
				<input id="user_id" type="text" style="height: 50px; font-size:14px;" placeholder="이메일">
			</div>
			<div class="ui-block-b" style="width: 100%;">
				<input id="user_pass" type="password" style="height: 50px; font-size:14px;" placeholder="비밀번호" >
			</div>
		</div>
		<div class="ui-grid-a" style="margin-top: 15px; font-size: 13px; ">
			<div class="ui-block-a" id="go_joinBtn" onclick="goJoinPage();">
				회원가입
			</div>
			<div class="ui-block-b" id="go_findPWBtn" onclick="goPwdSearch();">
				비밀번호 찾기
			</div>
		</div>
		<div id="loginBtn">
			로그인
		</div>
			<div class="convenience_login" onclick ="facebookLogin()"><span class="btn-login-facebook"><img src="/img/login/btn_facebook.png"></span></div>
			<div id="status"></div>
		<!-- 네이버아이디로로그인 버튼 노출 영역 -->
		<div id="naverIdLogin"></div>
		<div class="convenience_login" onclick ="document.getElementById('naverIdLogin_loginButton').click();"><span class="btn-login-naver"><img src="/img/login/btn_naver.png"></span></div>
		<!-- //네이버아이디로로그인 버튼 노출 영역 -->

		<!-- 네이버아이디로로그인 초기화 Script -->
		<script type="text/javascript">
			var naverLogin = new naver.LoginWithNaverId(
				{
					clientId: "k7GiszePSAXHkYGKSYh3",
					callbackUrl: "https://www.happybusking.com/app_root/jsp/login/naverloginloading.jsp",
					isPopup: false, /* 팝업을 통한 연동처리 여부 */
					loginButton: {color: "green", type: 3, height: 40} /* 로그인 버튼의 타입을 지정 */
				}
			); 
			
			/* 설정정보를 초기화하고 연동을 준비 */
			naverLogin.init();
			
		</script>
		<!-- // 네이버아이디로로그인 초기화 Script -->
		
			<div id="later_Loginbtn">
			홈으로
			</div>
			
		<p id = "login_footerTxt">Copyrightⓒ 2009-2017 Bizworks All Rights Reserved</p>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>
