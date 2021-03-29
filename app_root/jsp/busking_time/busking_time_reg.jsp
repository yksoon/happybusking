<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<%@include file="/importhead2.jsp" %>

<div data-role="page" id="busking_time_reg" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
    
        <!-- content 부분 -->	
        <div id="busking_time_reg_content" data-role="content">
            <div class="btr">
                <img src="/img/busking_time/busking_time_img.png" class="btr_img">
                <div class="btr_intro_container">
                    <div class="btr_intro_1">
                        <p>어떤 방식으로<br>아티스트를 모집할까요?</p>
                    </div>
                    <div class="btr_intro_2">
                        <p>내 조건에 맞는 <br>아티스트를 찾아보세요.</p>
                    </div>
                </div>
            </div>
            <%-- <div class="ui-grid-b btr_recruitment" id="busking_time_open_recruitment" onclick="go_reg_busking_time_all()">
                <div class="title_left">
                    <div class="title_left_text">
                        <p><span class="title_point">일괄</span><span> 모집 등록</span></p>
                        <p class="title_sub">평일 일정, 주말 일정, 등 일괄 등록</p>
                    </div>
                </div>
                <div class="title_right">
                    <img class="title_arrow" src="/img/common/show_btn.svg">
                </div>
            </div> --%>
            <div class="ui-grid-b btr_recruitment" style="border: none;" id="busking_time_close_recruitment" onclick="go_reg_busking_time_each()">
                <div class="title_left">
                    <div class="title_left_text">
                        <p><span class="title_point">개별</span><span> 모집 등록</span></p>
                        <p class="title_sub">공연할 아티스트가 확정된 경우</p>
                    </div>
                </div>
                <div class="title_right">
                    <img class="title_arrow" src="/img/common/show_btn.svg">
                </div>
            </div>
            <div class="ui-grid-b notice_wrap">
                <div class="notice">
                    <p class="p_notice notice_title">알림</p>
                    <p class="p_notice notice_content">해피버스킹은 공연이 필요한 카페 등 사업자 공간과 공연자를 매칭시켜주는 시스템 제공자로서, 해당 당사자간의 공연모집 및 공연으로 발생한 문제에 대한 책임을 지지 않습니다.</p>
                </div>
            </div>
        </div>
	<%-- <%@include file="/app_root/jsp/footer/footer.jsp" %> --%>
</div>
