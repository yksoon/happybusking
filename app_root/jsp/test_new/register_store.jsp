<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">

<%-- css/js including --%>
<%@include file="/importhaed.jsp" %>
<%@include file="/importhead3.jsp" %>

<%-- page 부분 --%>
<div data-role="page" id="busking_store_reg" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%-- panel 부분 --%>
    <%@include file="/app_root/jsp/panel/panel.jsp" %>
    
    <div id="busking_store_reg_content" data-role="content" >

        <p class="rb_semiTitle">사업자 정보</p>
        <div class="common_form_main_title">
			사업자등록증 사진 첨부
		</div>
		<div class="ui-grid-a common_form_input_div brc_main_image_container">
			<div class="ui-block-a" id="brc_main_image_btn_div">
				<div class="boxing">
                    <img src="/img/reg_store/Blicense_upload.svg" />
                </div>
                <%-- <img src="/img/common/plus_btn.png"> --%>
			</div>
			<div class="ui-block-b" id="brc_main_image_div">
				<img id="bi-main">
                <%-- <img id="bi-main" src="/img/test/noimage.gif"> --%>
			</div>
			<%-- <input type="file" id="buskingzone_image" style="display: none" accept="image/*"> --%>
            <input type="file" id="business_license" style="display: none" accept="image/*">
			<input type="hidden" id="fname" />
		</div>

		<p class="rb_semiTitle">상업 공간 소개</p>
        <div class="common_form_main_title">
			상호명
		</div>
		<div class="common_form_input_div">
			<input type="text" id="business_workname" placeholder="상호명 입력">
		</div>
        <div class="common_form_main_title">
			대표자명
		</div>
        <div class="common_form_input_div">
			<input type="text" id="business_representive" placeholder="대표자명 입력">
		</div>
        <div class="common_form_main_title">
			사업자번호
		</div>
		<div class="common_form_input_div">
			<input type="text" id="business_no" placeholder="사업자 번호 입력">
		</div>
        <div class="common_form_main_title">
			주소
		</div>
		<div class="common_form_input_div common_flex_container">
			<div class="common_form_input_div_left">
				<input type="hidden" id="postcode">
				<input type="text" id="address" placeholder="우편번호">
			</div>
			<div class="common_form_input_div_right" id="brc_addrsearch_btn" onclick="open_execDaumPostcode('addr_layer');">
				<p>주소검색</p>
			</div>
			<input type="hidden" id="latlng">
		</div>
		<div class="common_form_input_div">
			<input type="text" id="address_detail" placeholder="상세주소를 입력해주세요">
		</div>
        <div class="common_form_main_title">
			연락처
		</div>
		<div class="common_form_input_div">
			<input type="text" id="business_phone" placeholder="연락처 입력">
		</div>

        <%-- 버스킹존 등록(buskingzone_reg.jsp)에서 이미지 4개
         등록하는 소스 활용해서 10개로 변경해 추가할 것(공간사진/무대사진/메뉴판) --%>
        <div class="common_form_main_title">
			공간사진
		</div>
		<div class="ui-grid-a common_form_input_div brc_main_image_container">
			<div class="ui-block-a" id="brc_main_image_btn_div">
				<div class="boxing_img_upload">
					<img src="/img/reg_store/img_upload.svg" />
                    (<span id="upload_img_amount">0</span>/10)
                </div>
                <%-- <img src="/img/common/plus_btn.png"> --%>
			</div>
			<div class="ui-block-b" id="brc_main_image_div">
				<img id="bi-main">
                <%-- <img id="bi-main" src="/img/test/noimage.gif"> --%>
			</div>
			<input type="file" id="space_picture" style="display: none" accept="image/*">
			<input type="hidden" id="fname" />
		</div>

        <%-- 버스킹존 등록(buskingzone_reg.jsp)에서 이미지 4개
         등록하는 소스 활용해서 10개로 변경해 추가할 것(공간사진/무대사진/메뉴판) --%>
        <div class="common_form_main_title">
			무대사진
		</div>
		<div class="ui-grid-a common_form_input_div brc_main_image_container">
			<div class="ui-block-a" id="brc_main_image_btn_div">
				<div class="boxing_img_upload">
					<img src="/img/reg_store/img_upload.svg" />
                    (<span id="upload_img_amount">0</span>/10)
                </div>
                <%-- <img src="/img/common/plus_btn.png"> --%>
			</div>
			<div class="ui-block-b" id="brc_main_image_div">
				<img id="bi-main">
                <%-- <img id="bi-main" src="/img/test/noimage.gif"> --%>
			</div>
			<input type="file" id="stage_picture" style="display: none" accept="image/*">
			<input type="hidden" id="fname" />
		</div>
		    
        <div class="common_form_main_title">
			공간소개
		</div>
		<div class="common_form_input_div">
			<input type="text" id="zone_info" placeholder="공간을 소개해주세요">
		</div>
        <div class="common_form_main_title">
			영업시간
		</div>
		<div class="common_form_input_div">
			<input type="text" id="operationhour" placeholder="영업 시간을 입력해주세요(ex)오전 10:00-오후11:00)">
		</div>
        <div class="common_form_main_title">
			홍보 해시태그
		</div>
		<div class="common_form_input_div common_flex_container">
			<div class="common_form_input_div_left">
				<input type="hidden" id="postcode">
				<input type="text" id="hashtag" placeholder="#홍보 해시태그를 추가해주세요">
			</div>
			<%-- 해시태그 추가 버튼 --%>
            <div class="common_form_input_div_right" id="brc_addrsearch_btn" onclick="add_hashtag()">
				<p>추가</p>
			</div>
		</div>
        <%-- 해시태그 생성 영역 --%>
		<div id="area_hashtag"></div>

        <%-- 버스킹존 등록(buskingzone_reg.jsp)에서 이미지 4개
         등록하는 소스 활용해서 10개로 변경해 추가할 것(공간사진/무대사진/메뉴판) --%>
		<div class="common_form_main_title">
			메뉴판 등록
		</div>
		<div class="ui-grid-a common_form_input_div brc_main_image_container">
			<div class="ui-block-a" id="brc_main_image_btn_div">
				<div class="boxing_img_upload">
					<img src="/img/reg_store/img_upload.svg" />
                    (<span id="upload_img_amount">0</span>/10)
                </div>
                <%-- <img src="/img/common/plus_btn.png"> --%>
			</div>
			<div class="ui-block-b" id="brc_main_image_div">
				<img id="bi-main">
                <%-- <img id="bi-main" src="/img/test/noimage.gif"> --%>
			</div>
			<input type="file" id="menu" style="display: none" accept="image/*">
			<input type="hidden" id="fname" />
		</div>

		<p class="rb_semiTitle">버스킹 공간 정보</p>
		<div class="common_form_main_title">
			지원장비
		</div>
		<div class="common_form_input_div">
			<input type="text" id="equipment" placeholder="가지고 계신 음향장비를 입력해주세요">
		</div>
		<div class="common_form_main_title">
			주차
		</div>
        <div class="wide_space_container">
            <div class="common_terms_container_alpha">
                <div class="common_terms_check common_flex_container">
                        <input type="radio" name="parking_chk" id="parking_chk1" data-role="none" checked="checked">
                        <label for="parking_chk1"><span></span><div class="text_label_value">가능</div></label>
                </div>
            </div>

            <div class="common_terms_container_alpha">
                <div class="common_terms_check common_flex_container">
                        <input type="radio" name="parking_chk" id="parking_chk2" data-role="none">
                        <label for="parking_chk2"><span></span><div class="text_label_value">불가능</div></label>
                </div>
            </div>
        </div>
		<div class="common_form_main_title">
			팁박스
		</div>
        <div class="wide_space_container">
            <div class="common_terms_container_alpha">
                <div class="common_terms_check common_flex_container">
                        <input type="radio" name="tipbox_chk" id="tipbox_chk1" data-role="none" checked="checked">
                        <label for="tipbox1"><span></span><div class="text_label_value">공연팁박스</div></label>
                </div>
            </div>
            <div class="common_terms_container_alpha">
                <div class="common_terms_check common_flex_container">
                        <input type="radio" name="tipbox_chk" id="tipbox_chk2" data-role="none">
                        <label for="tipbox2"><span></span><div class="text_label_value">모바일팁박스</div></label>
                </div>
            </div>
        </div>    
		<div class="common_form_main_title">
			장르
		</div>
		<div class="common_form_input_div">
			<input type="text" id="buskingzone_detailaddr" placeholder="장르를 입력해주세요">
		</div>
		<div class="common_form_main_title">영상촬영</div>
        <div class="wide_space_container">
            <div class="common_terms_container_alpha">
                <div class="common_terms_check common_flex_container">
                        <input type="radio" name="video_chk" id="video_chk1" data-role="none" checked="checked">
                        <label for="video_chk1"><span></span><div class="text_label_value">가능</div></label>
                </div>
            </div>
            <div class="common_terms_container_alpha">
                <div class="common_terms_check common_flex_container">
                        <input type="radio" name="video_chk" id="video_chk2" data-role="none">
                        <label for="video_chk2"><span></span><div class="text_label_value">불가능</div></label>
                </div>
            </div>
        </div>
		<p class="rb_semiTitle">약관동의</p>
        <div class="wide_space_container_alpha">
            <div class="common_terms_container">
                <div class="common_terms_check common_flex_container">
                        <input type="radio" id="tm_agree" data-role="none">
                        <label for="tm_agree"><span></span><div class="text_label_value">약관 및 개인정보 활용 동의</div></label>
                        <div class="common_terms_view_more" id="perform_request_service_view">자세히 보기</div>
                </div>
            </div>
        </div>

        <div class="button_registration" onclick="go_complete_store()">등록완료</div>

		<!-- 주소찾기 팝업 레이어 -->
        <div id="addr_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
			<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode('addr_layer')" alt="닫기 버튼">
		</div>
        <!-- 약관 자세히보기 팝업 통합 -->
	    <div data-role="popup" class="common_trems_popup_container" id="terms_popup">
    </div>
</div>