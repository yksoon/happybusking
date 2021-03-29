<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">

<%@include file="/importhaed.jsp" %>
<%@include file="/importhead3.jsp" %>

<div data-role="page" id="complete_cancel_busking" >
	<!-- header 부분 -->
	<%-- <%@include file="/app_root/jsp/header/header.jsp"%> --%>
	<%-- panel 부분 --%>
    <%-- <%@include file="/app_root/jsp/panel/panel.jsp" %> --%>

    <%-- body부분 --%>
    <div id="complete_cancel_busking" data-role="content" >

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

        <p class="txt-title">신청 취소 완료</p>

        <div class="ui-line-a"></div>

        <table class="tab_busking_info">
            <tr>
                <td class="tab_busking_title">아티스트명</td>
                <td class="tab_busking_contents"><span id="">브라운아이드소울</span></td>
            </tr>
            <tr>
                <td class="tab_busking_title">공연 일자</td>
                <td class="tab_busking_contents"><span id="">20.11.03</span></td>
            </tr>
            <tr>
                <td class="tab_busking_title">공연 시간</td>
                <td class="tab_busking_contents"><span id="">19:30-20:00</span></td>
            </tr>
        </table>


        <div class="connect_btn_c" onclick="">공연 신청/계약 이력</div>
           
        <div class="confirm_btn" onclick="toHome()">확인</div>

    </div>

</div>