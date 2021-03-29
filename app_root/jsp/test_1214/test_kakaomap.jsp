<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<%@include file="/importhead2.jsp" %>
<div data-role="page" id="test_kakaomap">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>

    <!-- content 부분 -->
    <div id="test_kakaomap_content" data-role="content">
    <div class="common_form_main_title">
        주소
	</div>
    <div class="common_form_under_title">주소검색과 지도에서 선택 모두 가능합니다.</div>
        <div class="map_conainter">
            <div id="map">  <!-- 지도 뿌려주는 div -->
            </div>
        </div>
        <div class="common_form_input_div common_flex_container">
            <div class="common_form_input_div_left">
                <input type="hidden" id="postcode">
                <input type="text" id="address" placeholder="주소를 입력해주세요.">
            </div>
            <div class="common_form_input_div_right" id="addr_sc_btn" onclick="test_open_execDaumPostcode('addr_layer');">
                <p>주소검색</p>
            </div>
            <input type="hidden" id="latlng">
        </div>

        <button class="test_getdirection_btn">길찾기</button>

        <!-- 주소찾기 팝업 레이어 -->
        <div id="addr_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
			<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode('addr_layer')" alt="닫기 버튼">
		</div>
        <input type="hidden" id="user_no" value=<%=USER_NO %>/>
    </div>
    <%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>