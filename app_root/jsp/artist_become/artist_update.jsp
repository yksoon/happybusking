<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="artist_update">	
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<%@include file="/app_root/jsp/common/resize_image.jsp" %>
	<div id = "artist_update_sec" data-role="content" style="text-align:center; padding: 0; height: auto !important;">
		<div class="custom_select_popup" id="genre_select_popup">
		</div>
		
		<div class="common_form_header_title">
			아티스트 정보 입력
		</div>
		
		<div class="common_form_main_title">
			프로필 이미지 등록
		</div>
		<div class="common_form_imagebox" id="artist_update_img">
			<img id="img_preview"/>
			<input type="hidden" id="img_name"/>
		</div>
		<input type="file" data-role="none" id="artist_img" name="artist_img" accept="image/*">
		
		<div class="common_form_main_title">
			개인 활동명 (팀멤버 or 솔로)
		</div>
		<div class="common_form_input_div">
			<input type="text" class="artist_update_text" id="artist_name" name="artist_name" placeholder="팀명은 '팀등록' 페이지에 별도 기재">
		</div>
		
		<div class="common_form_main_title">
			소개
		</div>
		<div class="common_form_input_div">
			<textarea rows="2" cols="2" class="artist_update_text" id="artist_intro" name="artist_intro" placeholder="소개를 입력해주세요"></textarea>
		</div>
		
		<div class="common_form_main_title">
			핸드폰 번호
		</div>
		<div class="common_form_input_div">
			<input type="text" class="artist_update_text" id="artist_phone" name="artist_phone" placeholder="핸드폰 번호를 입력해주세요.(- 제외)" maxlength="13">
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
			<input type="text" class="artist_update_text" id="artist_use_tool" name="artist_use_tool" placeholder="사용하는 악기와 도구를 입력해주세요.ex)보컬">
		</div>
		
		<div class="common_form_main_title">
			SNS 주소(선택사항)
		</div>
		<div class="auc_sns_container">
			<div class="common_form_input_div auc_sns_list">
				<input type="text" class="artist_update_text" id="artist_sns" name="artist_sns" placeholder="ex) https://www.facebook.com/happybusking.hb.1">
			</div>
		</div>
		<input type="hidden" id="artist_sns_total">
		<div id="auc_sns_add_btn">
			<img src="/img/team/img_add.svg">
			SNS 추가
		</div>
		<input type="hidden" id="user_no" value="<%=USER_NO %>">
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>