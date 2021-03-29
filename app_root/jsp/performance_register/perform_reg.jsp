<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>    
<meta charset="UTF-8">
<div data-role="page" id="perform_reg">	
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<%@include file="/app_root/jsp/common/resize_image.jsp" %>
	<div id = "perform_reg_sec" data-role="content" style="text-align:center; padding: 0; height: auto !important;">
		<div class="custom_select_popup" id="genre_select_popup">
		</div>
		<div class="common_form_main_title">
			출연팀선택
		</div>
		<div class="common_form_default_select_div">
			<select name="pr_team" id="pr_team" name="pr_team">
				<option selected disabled hidden value="">팀 이름을 선택해주세요</option>
			</select>
		</div>
		<div class="common_form_main_title">
			공연 프로필 등록
		</div>
		<div id="perform_reg_img_container">
			<div id="pr_reg_background">
				<div id="perform_reg_img">
					<img id="img_preview"/>
					<input type="hidden" id="img_name"/>
				</div>
			</div>
			<input type="file" id="perform_img" name="perform_img" accept="image/*">
		</div>
		<div class="common_form_main_title">
			공연명
		</div>
		<div class="common_form_input_div">
			<input type="text" id="perform_name" name="perform_name" placeholder="공연 제목을 입력해주세요">
		</div>
		<div class="common_form_main_title">
			공연소개
		</div>
		<div class="common_form_input_div">
			<textarea rows="2" cols="" id="perform_intro" name="perform_intro" placeholder="공연 내용에 대한 간단한 소개를 입력해주세요"></textarea>
		</div>
		<div class="common_form_main_title">
			공연 시작 날짜
		</div>
		<div class="ui-grid-d common_form_default_select_div">
			<div class="ui-block-a">
				<select name="pr_sYear" id="pr_sYear" name="pr_sYear">
				</select>
			</div>
			<div class="ui-block-b">
				<select name="pr_sMonth" id="pr_sMonth" name="pr_sMonth">
				</select>
			</div>
			<div class="ui-block-c">
				<select name="pr_sDay" id="pr_sDay" name="pr_sDay">
				</select>
			</div>
			<div class="ui-block-d">
				<select name="pr_sHour" id="pr_sHour" name="pr_sHour">
				</select>
			</div>
			<div class="ui-block-e">
				<select name="pr_sMin" id="pr_sMin" name="pr_sMin">
				</select>
			</div>
		</div>
		<div class="common_form_main_title">
			공연 끝나는 날짜
		</div>
		<div class="ui-grid-d common_form_default_select_div">
			<div class="ui-block-a">
				<select name="pr_eYear" id="pr_eYear" name="pr_eYear">
				</select>
			</div>
			<div class="ui-block-b">
				<select name="pr_eMonth" id="pr_eMonth" name="pr_eMonth">
				</select>
			</div>
			<div class="ui-block-c">
				<select name="pr_eDay" id="pr_eDay" name="pr_eDay">
				</select>
			</div>
			<div class="ui-block-d">
				<select name="pr_eHour" id="pr_eHour" name="pr_eHour">
				</select>
			</div>
			<div class="ui-block-e">
				<select name="pr_eMin" id="pr_eMin" name="pr_eMin">
				</select>
			</div>
		</div>
		<div class="common_form_main_title">
			공연장르
		</div>
		<div class="common_form_select_div">
			<input type="text" id="text_genre" readonly="readonly" placeholder="장르 선택" onclick="viewGenreSelectBox();">
			<input type="hidden" id="select_genre">
			<input type="hidden" id="main_genre">
			<input type="hidden" id="add_genre">
		</div>
		<div class="common_form_main_title">
			공연주소
		</div>
			<div class="common_form_under_title">주소검색과 지도에서 선택 모두 가능합니다.</div>
			<!-- <div class="common_select_map_btn" id="prc_map_btn">지도에서 선택하기</div> -->
			<div class="map_conainter">
				<div id="map">
				</div>
			</div>
			<div class="common_form_input_div common_flex_container">
				<div class="common_form_input_div_left">
					<input type="hidden" id="postcode">
					<input type="text" id="address" placeholder="주소를 입력하세요(ex.판교역로 235)">
				</div>
				<div class="common_form_input_div_right" id="addr_sc_btn" onclick="open_execDaumPostcode('addr_layer')">
					검색
				</div>
			</div>
		<div id="addr_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
		<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode('addr_layer')" alt="닫기 버튼">
		</div>
		<div class="common_form_main_title">
			장소
		</div>
		<div class="common_form_input_div">
			<input type="text" id="perform_place" name="perform_place" placeholder="장소를 입력하세요(ex.올림픽홀)">
		</div>
		<div class="common_form_main_title">
			상세설명
		</div>
		<div class="common_form_input_div">
			<input type="text" id="perform_place_type" name="perform_place_type" placeholder="ex.~건물 뒤">
		</div>
		<div class="common_form_main_title">
			교통편
		</div>
		<div class="common_form_input_div">
			<input type="text" id="perform_traffic" name="perform_traffic" placeholder="ex.버스, 전철">
		</div>
		<input type="hidden" id="user_no" value="<%=USER_NO %>">
		<input type="hidden" id="latlng">
	</div>
	
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>