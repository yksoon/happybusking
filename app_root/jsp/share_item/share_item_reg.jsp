<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="share_item_reg">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
	<div id="share_item_reg_sec">
		<div class="common_form_main_title">
			카테고리 선택
		</div>
		<div class="common_form_default_select_div">
			<select id="si_category">
				<option value="음향" selected="selected">음향</option>
				<option value="영상">영상</option>
				<option value="악기">악기</option>
				<option value="기타">기타</option>
			</select>
		</div>
		
		<div class="common_form_main_title">
			물품명
		</div>
		<div class="common_form_input_div">
			<input type="text" name="si_name" id="si_name" placeholder="공유하는 물품명을 입력해주세요.">
		</div>
		
		<div class="common_form_main_title">
			공유 가격
		</div>
		<div class="ui-grid-a sir_price_div">
			<div class="ui-block-a common_form_default_select_div">
				<select id="si_price_unit">
					<option value="1일" selected="selected">1일</option>
					<option value="1시간">1시간</option>
				</select>
			</div>
			<div class="ui-block-b common_form_input_div">
				<input type="text" name="si_price" id="si_price" placeholder="공유가격을 입력해주세요.">
			</div>
		</div>
		
		<div class="common_form_main_title">
			장비 상태
		</div>
		<div class="sir_radio_content">
			<input type="radio" name="si_state" id="si_state_s" value="S급" checked="checked"><label for="si_state_s">S급</label>
			<input type="radio" name="si_state" id="si_state_a" value="A급"><label for="si_state_a">A급</label>
			<input type="radio" name="si_state" id="si_state_b" value="B급"><label for="si_state_b">B급</label>
			<input type="radio" name="si_state" id="si_state_c" value="C급"><label for="si_state_c">C급</label>
		</div>
		
		<div class="common_form_main_title sir_main_image_title">
			대표이미지 등록
		</div>
		<div class="ui-grid-a common_form_input_div sir_main_image_container">
			<div class="ui-block-a" id="sir_main_image_btn_div">
				<img src="/img/common/plus_btn.png">
			</div>
			<div class="ui-block-b" id="sir_main_image_div">
				<img id="mimg" src="/img/test/noimage.gif">
			</div>
			<input type="file" id="sir_main_image" style="display: none" accept="image/*">
		</div>
		
		<div class="common_form_main_title">
			추가 이미지 등록(최대 4장)
		</div>
		<div class="ui-grid-d common_form_input_div sir_sub_image_container">
			<div class="ui-block-a" id="sir_sub_image_btn_div">
				<img src="/img/common/plus_btn.png">
			</div>
			<div class="ui-block-b sir_sub_image_div" id="sir_sub_image_0">
				<img src="/img/test/noimage.gif">
			</div>
			<div class="ui-block-c sir_sub_image_div" id="sir_sub_image_1">
				<img src="/img/test/noimage.gif">
			</div>
			<div class="ui-block-d sir_sub_image_div" id="sir_sub_image_2">
				<img src="/img/test/noimage.gif">
			</div>
			<div class="ui-block-e sir_sub_image_div" id="sir_sub_image_3">
				<img src="/img/test/noimage.gif">
			</div>
			<input type="file" id="sir_sub_image" style="display: none" multiple="multiple" accept="image/*" maxlength="4">
		</div>
		
		<div class="common_form_main_title">
			장비 설명
		</div>
		<div class="common_form_input_div">
			<textarea rows="10" cols="10" name="si_contnet" id="si_content" placeholder="1. 렌탈이 불가능한 날짜가 있으면 꼭! 적어주세요.&#13;&#10;2. 배송방법 택배 선택시 택배비 선후불 여부를 적어주세요."></textarea>
		</div>
		
		<div class="common_form_main_title">
			장비 보유 위치
		</div>
		<div class="ui-grid-a sir_price_div">
			<div class="ui-block-a common_form_default_select_div">
				<select id="sir_main_area">
					<option disabled="disabled" selected="selected" hidden>시도</option>
				</select>
			</div>
			<div class="ui-block-b common_form_default_select_div">
				<select id="sir_sub_area">
					<option disabled="disabled" selected="selected" hidden>군구</option>
				</select>
			</div>
		</div>
		
		<div class="common_form_main_title">
			전달 방식
		</div>
		<div class="sir_radio_content">
			<input type="radio" name="si_delivery" id="si_delivery_a" value="택배배송"><label for="si_delivery_a">택배배송</label>
			<input type="radio" name="si_delivery" id="si_delivery_b" value="퀵배달"><label for="si_delivery_b">퀵배달</label>
			<input type="radio" name="si_delivery" id="si_delivery_c" value="직배송"><label for="si_delivery_c">직배송</label>
			<input type="radio" name="si_delivery" id="si_delivery_d" value="방문수령"><label for="si_delivery_d">방문수령</label>
		</div>
		
		<div class="common_form_main_title sir_contact_title">
			연락처
		</div>
		<div class="common_form_input_div">
			<input type="text" name="si_contact" id="si_contact" placeholder="카톡, 이메일, 휴대폰 등을 입력해주세요.">
		</div>
		<input type="hidden" id="user_no" value="<%=USER_NO %>" />
	</div>
	
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>
