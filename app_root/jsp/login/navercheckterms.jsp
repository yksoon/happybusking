<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

        
<%@include file="/importhaed.jsp" %>
<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<script type="text/javascript" src="/js/heartpay/login/naverlogin.js?ver=1.0.3" ></script>
<div data-role="page" id="facebooklogin">
<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
	<div data-role="content">
		<div class="common_form_main_title">
				이용약관
		</div>
		
		
		<div class="common_terms_container">
			<div class="common_terms_all_check common_flex_container">
				<input type="checkbox" id="n_total_checkbox" data-role="none">
				<label for="n_total_checkbox">아래 약관에 모두 동의합니다</label>
			</div>
			<div class="common_terms_check common_flex_container">
					<input type="checkbox" id="n_useAgree_checkbox" data-role="none">
					<label for="n_useAgree_checkbox">이용약관 동의(필수)</label>
					<div class="common_terms_view_more" id="terms_on_service_view">보기</div>
			</div>
			<div class="common_terms_check common_flex_container">
					<input type="checkbox" id="n_info_checkbox" data-role="none">
					<label for="n_info_checkbox">개인정보 처리 및 취급방침 동의(필수)</label>
					<div class="common_terms_view_more" id="personal_info_view">보기</div>
			</div>
			<div class="common_terms_check common_flex_container">
					<input type="checkbox" id="n_useGPS_checkbox" data-role="none">
					<label for="n_useGPS_checkbox">위치기반 서비스 이용약관(필수)</label>
					<div class="common_terms_view_more" id="location_based_service_view">보기</div>
			</div>
		</div>
	</div>
	<!-- 약관 자세히보기 팝업 통합 -->
	<div data-role="popup" class="common_trems_popup_container" id="terms_popup">
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>