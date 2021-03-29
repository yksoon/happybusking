<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
        
<%@include file="/importhaed.jsp" %>
<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<script type="text/javascript" src="/js/heartpay/login/naverlogin.js?ver=1.0.3" ></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<div data-role="page" id="naverlogin">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
<!--	<div data-role="content">

		<!-- 네이버아이디로로그인 버튼 노출 영역 -->
		<div id="naverIdLogin"></div>
		<!-- //네이버아이디로로그인 버튼 노출 영역 -->

		<!-- 네이버아이디로로그인 초기화 Script -->
		<script type="text/javascript">
				{
			var naverLogin = new naver.LoginWithNaverId(
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

	</div>	-->
	<%@include file="/app_root/jsp/footer/footer.jsp" %>	
</div>
