<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>    
<meta charset="UTF-8">
<div data-role="page" id="perform_request">	
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<div data-role="content">
		<div class="common_form_header_title">
			<span class="common_purple_text" id="perform_req_teamName"></span>에게 공연요청
		</div>
		<div class="perform_req_dateForm">
			<div class="common_form_main_title">
				공연요청 일시
			</div>
			<div class="ui-grid-b common_form_default_select_div">
				<div class="ui-block-a">
					<select name="prq_Year" id="prq_Year" name="prq_Year">
					</select>
				</div>
				<div class="ui-block-b">
					<select name="prq_Month" id="prq_Month" name="prq_Month">
					</select>
				</div>
				<div class="ui-block-c">
					<select name="prq_Day" id="prq_Day" name="prq_Day">
					</select>
				</div>
			</div>
			<div class="ui-grid-d common_form_default_select_div">
				<div class="ui-block-a">
					<select name="prq_sHour" id="prq_sHour" name="prq_sHour">
					</select>
				</div>
				<div class="ui-block-b">
					<select name="prq_sMin" id="prq_sMin" name="prq_sMin">
					</select>
				</div>
				<div class="ui-block-c">
					<p class="perform_req_time_center_text">~</p>
				</div>				
				<div class="ui-block-d">
					<select name="prq_eHour" id="prq_eHour" name="prq_eHour">
					</select>
				</div>
				<div class="ui-block-e">
					<select name="prq_eMin" id="prq_eMin" name="prq_eMin">
					</select>
				</div>
			</div>		
		</div>
		<p class="perform_req_dateBtnPart" id="prq_dateAddBtnArea">
			<span id="prqAddBtn">날짜 등록</span>
		</p>
		<div id="peform_req_addDateForm">
		
		</div>
		<p class="perform_req_dateBtnPart" id="prq_btnArea">
			<span id="prqFinishBtn">완료</span>
		</p>
		<div id="peform_req_insertForm"> 
			<div class="common_form_main_title">
				이름
			</div>
			<div class="common_form_input_div">
				<input type="text" id="perform_rq_name" name="perform_rq_name" placeholder="성함을 입력해주세요">
			</div>
			<div class="common_form_main_title">
				휴대폰번호
			</div>
			<div class="common_form_input_div">
				<input type="text" class="perform_req_text onlyNumberPhone phoneAuto" id="perform_rq_hp" name="perform_rq_hp" placeholder="휴대폰 번호를 입력해주세요(-없이 입력)" maxlength="13">
			</div>

			<div class="common_form_main_title">
				공연 요청 주소
			</div>
			<div class="common_form_under_title">주소검색과 지도에서 선택 모두 가능합니다.</div>
			<!-- <div class="common_select_map_btn" id="prq_map_btn">지도에서 선택하기</div> -->
			<div class="map_conainter">
				<div id="map">
				</div>
			</div>
			<div class="common_form_input_div common_flex_container">
				<div class="common_form_input_div_left">
					<input type="hidden" id="postcode">
					<input type="text" id="address" placeholder="주소를 입력하세요(ex.여의도동)">
				</div>
				<div class="common_form_input_div_right" id="addr_sc_btn" onclick="open_execDaumPostcode('addr_layer')">
					검색
				</div>
			</div>
			<input type="hidden" id="latlng">
			<div id="addr_layer" style="display:none;position:absolute;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
			<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode('addr_layer')" alt="닫기 버튼">
			</div>
			<input type="hidden" id="postcode" name="postcode" placeholder="우편번호를 입력해주세요" readonly="readonly">
			<div class="common_form_main_title">
				공연 장소 상세
			</div>
			<div class="common_form_input_div">
				<input type="text" id="perform_rq_detail_addr" name="perform_rq_detail_addr" placeholder="장소를 입력해주세요">
			</div>
			<div class="common_form_main_title">
				공연 장비 지원 여부
			</div>
			<div class="common_form_input_div">
				<textarea rows="13" cols="3" id="perform_rq_eq_sup"
					placeholder="마이크, 앰프, 악기, 스탠드, 보면대 등 아티스트들에게 지원되는 공연 장비를 상세하게 적어주세요.&#13;&#10;더 상세하게 작성해 주실수록 아티스트의 빠른 응답을 받아보실 수 있습니다.&#13;&#10;&#13;&#10;예시.&#13;&#10;마이크 : AKG 유선 마이크 D5S&#13;&#10;악기 : 일렉기타(야마하 PAC112J), 드럼(Sonido Q-star 6기통 드럼세트)&#13;&#10;앰프 : 야마하 a-s3000 최고급 앰프"></textarea>
			</div>
			<div class="common_form_main_title">
				공연 요청글
			</div>
			<div class="common_form_input_div">
				<textarea rows="3" cols="3" id="perform_rq_msg"
					placeholder="공연 할 장소의 형태, 공연 목적, 전달 메시지, 조건등 아티스트에게 전달할 내용을 입력해주세요."></textarea>
			</div>
			
			<div class="common_terms_container">
				<div class="common_terms_check common_flex_container">
						<input type="checkbox" id="performReq_checkbox" data-role="none">
						<label for="performReq_checkbox">공연 요청 이용약관(필수))</label>
						<div class="common_terms_view_more" id="perform_request_service_view">보기</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
	<!-- 약관 자세히보기 팝업 통합 -->
	<div data-role="popup" class="common_trems_popup_container" id="terms_popup">
	</div>
</div>