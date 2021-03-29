<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="buskingzone_reg">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->		
	<div id="buskingzone_reg_content" data-role="content">
		<input type="hidden" id="user_no" value=<%=USER_NO %>/>
		<div class="common_form_main_title">
			버스킹존 이름
		</div>
		<div class="common_form_input_div">
			<input type="text" id="buskingzone_name" placeholder="버스킹존의 장소명을 입력해주세요.(ex. 홍대 놀이터)">
		</div>
		<div class="common_form_main_title">
			버스킹존 대표 이미지(장소사진)
		</div>
		<div class="ui-grid-a common_form_input_div brc_main_image_container">
			<div class="ui-block-a" id="brc_main_image_btn_div">
				<img src="/img/common/plus_btn.png">
			</div>
			<div class="ui-block-b" id="brc_main_image_div">
				<img id="bi-main" src="/img/test/noimage.gif">
			</div>
			<input type="file" id="buskingzone_image" style="display: none" accept="image/*">
			<input type="hidden" id="fname" />
		</div>
		<div class="common_form_main_title">
			추가 이미지 등록(최대 4장)
		</div>
		<div class="ui-grid-d common_form_input_div brc_sub_image_container">
			<div class="ui-block-a" id="brc_sub_image_btn_div">
				<img src="/img/common/plus_btn.png">
			</div>
			<div class="ui-block-b brc_sub_image_div">
				<img src="/img/test/noimage.gif">
			</div>
			<div class="ui-block-c brc_sub_image_div">
				<img src="/img/test/noimage.gif">
			</div>
			<div class="ui-block-d brc_sub_image_div">
				<img src="/img/test/noimage.gif">
			</div>
			<div class="ui-block-e brc_sub_image_div">
				<img src="/img/test/noimage.gif">
			</div>
			<input type="file" id="brc_sub_image" style="display: none" multiple="multiple" accept="image/*" maxlength="4">
		</div>
		<div class="common_form_main_title">
			주소
		</div>
		<div class="common_form_under_title">주소검색과 지도에서 선택 모두 가능합니다.</div>
		<!-- <div class="common_select_map_btn" id="brc_map_btn">지도에서 선택하기</div> -->
		<div class="map_conainter">
			<div id="map">
			</div>
		</div>
		<div class="common_form_input_div common_flex_container">
			<div class="common_form_input_div_left">
				<input type="hidden" id="postcode">
				<input type="text" id="address" placeholder="주소를 입력해주세요.">
			</div>
			<div class="common_form_input_div_right" id="brc_addrsearch_btn" onclick="open_execDaumPostcode('addr_layer');">
				<p>주소검색</p>
			</div>
			<input type="hidden" id="latlng">
		</div>
			
		<div class="common_form_main_title">
			상세주소
		</div>
		<div class="common_form_input_div">
			<input type="text" id="buskingzone_detailaddr" placeholder="상세주소를 입력해주세요.">
		</div>
		<div class="common_form_main_title">
			홈페이지 (필수아님)
		</div>
		<div class="common_form_input_div">
			<input type="text" id="buskingzone_url" placeholder="해당 버스킹존의 홈페이지를 입력해주세요.">
		</div>
		<div class="common_form_main_title">
			전화번호 (필수아님)
		</div>
		<div class="common_form_input_div">
			<input type="text" id="buskingzone_contact" placeholder="해당 버스킹존의 전화번호(고객센터)를 입력해주세요.">
		</div>
		<div class="common_form_main_title">
			상세정보
		</div>
		<div class="common_form_input_div">
			<textarea rows="5" cols="5" id="buskingzone_content" placeholder="주의사항 등 버스킹존의 상세 정보를 입력해주세요."></textarea>
		</div>
		<div id="addr_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
			<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode('addr_layer')" alt="닫기 버튼">
		</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>