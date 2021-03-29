<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="join" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
	<div data-role="content">
		<div class="common_form_main_title">
			이메일<span class="common_form_essential_input">*</span>
		</div>
		<div class="common_form_input_div">
			<!-- <div class="common_form_input_div_left"> -->
				<input type="text" id="join_Email" name="join_Email" placeholder="이메일을 입력해주세요.">
			<!-- </div> -->
			<!-- <div class="common_form_input_div_right" id="join_certBtn">
				인증하기
			</div> -->
		</div>
		<p class="common_form_under_title">※보안정책으로 인해 gmail은 비밀번호 찾기가 불가능합니다.</p>
		
		<!-- <div id="join_certNo_div">
			<div class="common_form_main_title">
				인증번호 확인<span class="common_form_essential_input">*</span>
			</div>
			<div class="common_form_input_div common_flex_container">
				<div class="common_form_input_div_left">
					<input type="text" id="join_certNo" name="join_certNo" placeholder="이메일에 전송된 인증번호 입력">
				</div>
				<div class="common_form_input_div_right" id="join_certNoBtn">
					인증번호 확인
				</div>
			</div>
		</div> -->
		
		<div class="common_form_main_title">
			비밀번호<span class="common_form_essential_input">*</span>
		</div>
		<div class="common_form_input_div">
			<input type="text" id="join_PW" name="join_PW" placeholder="비밀번호를 입력해주세요.">
		</div>
		
		<div class="common_form_main_title">
			닉네임<span class="common_form_essential_input">*</span>
		</div>
		<div class="common_form_input_div">
			<input type="text"id="join_Nicname" name="join_Nicname" placeholder="활동할 닉네임을 입력해주세요.(최대 8글자)">
		</div>	
		
		<div class="common_form_main_title">
			이용약관
		</div>
		
		
		<div class="common_terms_container">
			<div class="common_terms_all_check common_flex_container">
				<input type="checkbox" id="j_total_checkbox" data-role="none">
				<label for="j_total_checkbox">아래 약관에 모두 동의합니다</label>
			</div>
			<div class="common_terms_check common_flex_container">
					<input type="checkbox" id="j_useAgree_checkbox" data-role="none">
					<label for="j_useAgree_checkbox">이용약관 동의(필수)</label>
					<div class="common_terms_view_more" id="terms_of_service_view">보기</div>
			</div>
			<div class="common_terms_check common_flex_container">
					<input type="checkbox" id="j_info_checkbox" data-role="none">
					<label for="j_info_checkbox">개인정보 처리 및 취급방침 동의(필수)</label>
					<div class="common_terms_view_more" id="personal_info_view">보기</div>
			</div>
			<div class="common_terms_check common_flex_container">
					<input type="checkbox" id="j_useGPS_checkbox" data-role="none">
					<label for="j_useGPS_checkbox">위치기반 서비스 이용약관(필수)</label>
					<div class="common_terms_view_more" id="location_based_service_view">보기</div>
			</div>
		</div>
	</div>
	
	<!-- 약관 자세히보기 팝업 통합 -->
	<div data-role="popup" class="common_trems_popup_container" id="terms_popup">
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>