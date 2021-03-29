<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="artist_become">	
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<%@include file="/app_root/jsp/common/resize_image.jsp" %>
	
	<div id = "artist_become_sec" data-role="content">
		<input type="hidden" id="user_no" value="<%=USER_NO%>"/>
		<div class="custom_select_popup" id="genre_select_popup">
		</div>
		
		<div class="common_form_header_title">
			아티스트 정보 입력
		</div>
		
		<div class="common_form_main_title">
			프로필 이미지 등록
		</div>
		<div class="common_form_imagebox" id="artist_become_img">
			<img id="img_preview"/>
			<input type="hidden" id="img_name"/>
		</div>
		<input type="file" id="artist_img" accept="image/*">
		
		<div class="common_form_main_title">
			개인 활동명 (팀멤버 or 솔로)
		</div>
		<div class="common_form_input_div">
			<input type="text" class="artist_become_text" id="artist_name" name="artist_name" placeholder="팀명은 '팀등록' 페이지에 별도 기재">
		</div>
		
		<div class="common_form_main_title">
			소개
		</div>
		<div class="common_form_input_div">
			<textarea rows="2" cols="2" class="artist_become_text" id="artist_intro" name="artist_intro" placeholder="소개를 입력해주세요"></textarea>
		</div>
		
		<div class="common_form_main_title">
			핸드폰 번호
		</div>
		<div class="common_form_input_div">
			<input type="text" class="artist_become_text" id="artist_phone" name="artist_phone" placeholder="핸드폰 번호를 입력해주세요.(- 제외)" maxlength="13">
		</div>
		
		<!-- <div class="common_form_main_title">
			장르
		</div>
		<div class="common_form_select_div" id="artist-select-box">
			<input type="text" id="artist-select" readonly="readonly" placeholder="장르 선택" onclick="viewGenreSelectBox();">
			<input type="hidden" id="artist_main_genre">
			<input type="hidden" id="add_genre">
		</div> -->
		
		<div class="common_form_main_title">
			담당 파트 / 악기
		</div>
		<div class="common_form_input_div">
			<input type="text" class="artist_become_text" id="artist_use_tool" name="artist_use_tool" placeholder="사용하는 악기와 도구를 입력해주세요.ex)보컬">
		</div>
		
		<div class="common_form_main_title">
			SNS 주소(선택사항)
		</div>
		<div class="abc_sns_container">
			<div class="abc_sns_list common_form_input_div">
				<input type="text" class="artist_become_text" id="artist_sns" name="artist_sns" placeholder="ex) https://www.facebook.com/happybusking.hb.1">
			</div>
		</div>
		<input type="hidden" id="artist_sns_total">
		<div id="abc_sns_add_btn">
			<img src="/img/team/img_add.svg">
			SNS 추가
		</div>
		
		
		<div class="common_terms_container">
			<div class="common_terms_all_check common_flex_container">
				<input type="checkbox" id="a_total_checkbox" data-role="none">
				<label for="a_total_checkbox">아래 약관에 모두 동의합니다</label>
			</div>
			<div class="common_terms_check common_flex_container">
					<input type="checkbox" id="useAgree_checkbox" data-role="none">
					<label for="useAgree_checkbox">이용약관 동의(필수)</label>
					<div class="common_terms_view_more" id="terms_of_service_view">보기</div>
			</div>
			<div class="common_terms_check common_flex_container">
					<input type="checkbox" id="ab_info_checkbox" data-role="none">
					<label for="ab_info_checkbox">개인정보 처리 및 취급방침 동의(필수)</label>
					<div class="common_terms_view_more" id="personal_info_view">보기</div>
			</div>
			<div class="common_terms_check common_flex_container">
					<input type="checkbox" id="ab_pfreq_checkbox" data-role="none">
					<label for="ab_pfreq_checkbox">공연의뢰 이용약관(필수)</label>
					<div class="common_terms_view_more" id="perform_request_service_view">보기</div>
			</div>
		</div>
		
		<input type="hidden" id="atc" value="<%=ARTIST_CHK %>">
	</div>
	<div data-role="popup" id="artist_becomePopup">
		<p class="artist_becomePopupTitle">아티스트로 등록 완료</p>
		<p class="artist_becomePopupExplain">[팀/솔로]-[등록하기]에서 꼭! 신청하셔야 <br>아티스트 목록에 노출됩니다</p>
		<div class="ui-grid-a" id="artist_becomePopup_body">
			<div class="ui-block-a">
				<img src="/img/artist_become/artistBecomeExplainImg3.svg">
			</div>
			<div class="ui-block-b">
				<p class="artist_becomePopupExplain2">팀/솔로 신청하기</p>
				<p>공연 일정 등록 가능</p>
				<p>QR배너 신청 가능</p>
			</div>
		</div>
			
		<p id="artist_becomePopup_skip_btn">나중에 하기</p>
		
		<div class="ui-grid-a" id="artist_becomePopup_footer">
			<div class="ui-block-a" id="artist_becomePopup_request_btn">
				<p>팀 신청</p>
			</div>				
			<div class="ui-block-b" id="artist_becomePopup_solo_btn">
				<p>솔로 신청</p>
			</div>
			<!-- <div class="ui-block-a" id="artist_becomePopup_skip_btn" style="width: 100%;">
				<p style="background-color:#2e2e30;">나중에</p>
			</div> -->
		</div>
	</div>
	<!-- 약관 자세히보기 팝업 통합 -->
	<div data-role="popup" class="common_trems_popup_container" id="terms_popup">
	</div>
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>