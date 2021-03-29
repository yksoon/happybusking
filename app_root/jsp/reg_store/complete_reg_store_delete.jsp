<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">

<%@include file="/importhaed.jsp" %>
<%@include file="/importhead3.jsp" %>

<div data-role="page" id="complete_reg_store_delete" >
	<!-- header 부분 -->
	<%-- <%@include file="/app_root/jsp/header/header.jsp"%> --%>
	<%-- panel 부분 --%>
    <%-- <%@include file="/app_root/jsp/panel/panel.jsp" %> --%>

    <%-- body부분 --%>
    <div id="complete_reg_store_delete" data-role="content" >

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

        <p class="txt-title">삭제 완료</p>
        <div class="ui-line-a"></div>
        <p class="txt-middle-c">공연 모집 정보가 삭제되었습니다.</p>
        <%-- <div class="ui-line-b"></div> --%>

        <p class="txt-middle-b"></p>

        <div class="connect_btn_b" onclick="goback_store_list()">공연 일정 보기</div>
           
        <div class="confirm_btn" onclick="toHome()">확인</div>

    </div>

</div>