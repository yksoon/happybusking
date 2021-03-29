<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="insert_koica" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
	<div data-role="content">
		<div class="common_form_main_title">
			신청 공연
		</div>
		<div class="common_form_select_div">
			<select name="area-select" id="area-select">
			</select>
		</div>
		<div class="common_form_main_title">
			신청 팀
		</div>
		<div class="common_form_select_div">
			<select name="team-select" id="team-select">
				<option selected disabled value="">팀을 선택해주세요.</option>
			</select>
		</div>
		<div  id="fa_count_box">
			<div class="common_form_main_title">
				월 공연 활동 횟수
			</div>
			<div class="common_form_select_div fa_count_flex">
				<select name="countmin" id="countmin">
					<option selected="selected" disabled value="">최소 횟수</option>
				</select>
				<select name="countmax" id="countmax">
					<option selected="selected" disabled value="">최대 횟수</option>
				</select>
			</div>
		</div>
		<div class="common_form_main_title">
			이름
		</div>
		<div class="common_form_input_div">
			<input type="text" id="name" placeholder="이름을 입력해주세요.">
		</div>
		<div class="common_form_main_title">
			생년월일
		</div>
		<div class="common_form_input_div">
			<input type="text" id="birth" placeholder="ex)1900-11-11(숫자만 입력해주세요.)" maxlength="10">
		</div>
		<div class="common_form_main_title">
			주소
		</div>
		<div class="common_form_input_div common_flex_container">
			<div class="common_form_input_div_left">
				<input type="hidden" id="postcode">
				<input type="text" id="address" placeholder="ex) 여의도동"></input>
			</div>
			<div class="common_form_input_div_right" id="qrRequest_btn" onclick="open_execDaumPostcode('qrRequest_addr_layer')">
				검색
			</div>
		</div>
		<div class="common_form_main_title">
			상세주소
		</div>
		<div class="common_form_input_div">
			<input type="text" id="detailaddr" placeholder="상세주소를 입력해주세요.">
		</div>
		<div id="qrRequest_addr_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
			<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1;" onclick="closeDaumPostcode('qrRequest_addr_layer')" alt="닫기 버튼">
		</div>
		<div class="common_form_main_title">
			이메일
		</div>
		<div class="common_form_input_div">
			<input type="text" id="email" placeholder="이메일을 입력해주세요.">
		</div>
		<div class="common_form_main_title">
			연락처
		</div>
		<div class="common_form_input_div">
			<input type="text" id="tel" placeholder="ex) 010-1234-5678">
		</div>
		
		<div class="common_form_main_title">
			공연 팀명
		</div>
		<div class="common_form_input_div">
			<input type="text" id="tname" placeholder="팀명을 입력해주세요.">
		</div>
		<div class="common_form_main_title">
			장르
		</div>
		<div class="common_form_input_div">
			<input type="text" id="tgenre" placeholder="팀 장르를 입력해주세요.">
		</div>
		<div class="common_form_main_title">
			구성
		</div>
		<div class="common_form_input_div">
			<div class="sir_radio_content" style="padding: 15px 0px; margin: -10px 0px;">
				<input type="radio" name="si_state" id="si_state_s" value="개인" checked="checked"><label for="si_state_s"style="margin-bottom: 15px;" >개인</label>
				<input type="radio" name="si_state" id="si_state_t" value="팀"><label for="si_state_t">팀</label>
				<input type="radio" name="si_state" id="si_state_o" value="기타"><label for="si_state_o">기타</label>
			</div>
			<input type="text" id="ttype" value="개인" placeholder="팀 구성을 입력해주세요.">
		</div>
		<div class="common_form_main_title">
			팀소개
		</div>
		<div class="common_form_input_div">
			<textarea rows="2" cols="2" class="team_create_text" id="tinfo" placeholder="소개를 입력해주세요" style="resize: none;"></textarea>
		</div>
		<div class="common_form_main_title">
			공연영상 URL
		</div>
		<div class="common_form_input_div">
			<input type="text" id="turl" placeholder="팀 공연 영상을 볼 수 있는 URL을 입력해주세요.">
		</div>
		
		<div class="common_form_main_title">
			이용약관
		</div>
		<div class="common_terms_container">
			<div class="common_terms_check common_flex_container">
				<input type="checkbox" id="k_info_checkbox" data-role="none">
				<label for="k_info_checkbox">개인정보 처리 및 취급방침 동의(필수)</label>
				<div class="common_terms_view_more" id="personal_info_view">보기</div>
			</div>
		</div>
	</div>
	
	<!-- 약관 자세히보기 팝업 통합 -->
	<div data-role="popup" class="common_trems_popup_container" id="terms_popup">
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>