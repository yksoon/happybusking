<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">

<%-- css/js including --%>
<%@include file="/importhaed.jsp" %>
<%@include file="/importhead3.jsp" %>

<%-- page 부분 --%>
<div data-role="page" id="busking_promotion"  class="background_show1">
    <!-- header 부분 -->
    <%-- <%@include file="/app_root/jsp/header/header.jsp"%> --%>
    <%-- panel 부분 --%>
    <%@include file="/app_root/jsp/panel/panel.jsp" %>
    
    <div id="busking_store_reg_content"  data-role="none" >
        <div class="promotion_bt">
            <div class="promotion_close_button"><img class="close_button_img" src="/img/coachmark/close.png"></div>
        </div>
        <div class="promotion_ti">
            <div id="promotion_txt">당신의 상업공간에 더 많은</div>
            <div id="promotion_txt">고객이 모이게 하세요</div>
        </div>
        <div id="bdc_pfsc_ing_body">
        <img id="fake_img" src="/img/reg_store/promotion_slide3.png" alt="Los Angeles" >
            <ul id="bdc_pfsc_ing_ul">
            </ul>
        </div>
        <div id="bdc_img_selecter_div">
            <ul id="bdc_img_selecter">
            </ul>
        </div>    
        <div class="button_registerStore" onclick="go_form_reg_store()">등록하기</div>
        <div class="promotion_footer">디자인이라는 용어는 지시하다·표현하다·성취하다의 뜻을 라틴어의 데시그나레(designare)에서 유래한다</div>    
    </div>  
</div>