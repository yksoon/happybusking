<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">

<%@include file="/importhaed.jsp" %>
<%@include file="/importhead3.jsp" %>

<div data-role="page" id="busking_store_reg_complete_content" >
	<!-- header 부분 -->
	<%-- <%@include file="/app_root/jsp/header/header.jsp"%> --%>
	<%-- panel 부분 --%>
    <%-- <%@include file="/app_root/jsp/panel/panel.jsp" %> --%>

    <%-- body부분 --%>
    <div id="busking_store_reg_complete_content" data-role="content" >

        <div class="icon-exit" onclick="toHome()">
            <img src="/img/reg_store/pop_close.svg"/>
        </div>   

        <div class="icon-shape-circle">
            <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" viewBox="0 -20 80 80">
                <g id="done_ck" transform="translate(-114 -254)">
                    <rect id="사각형_2121" data-name="사각형 2121" width="78" height="78" transform="translate(114 254)" fill="none"/>
                    <path id="패스_1122" data-name="패스 1122" d="M59.557,12576.536l17.642,20.288,37.919-39.551" transform="matrix(0.996, -0.087, 0.087, 0.996, -1029.359, -12227.278)" fill="none" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="6"/>
                </g>
            </svg>
        </div>

        <p class="txt-title">공간 등록 완료</p>
        <div class="ui-line-a"></div>
        <p class="txt-contents-b">상업공간 및 버스킹 공간 등록이 완료되었습니다.</p>
        <div class="ui-line-b"></div>

        <p class="txt-middle-b">공연모집 일정을 등록해 보세요</p>

        <div class="connect_btn_b" onclick="">공연 모집 등록</div>
           
        <div class="confirm_btn" onclick="toHome()">확인</div>

    </div>

</div>