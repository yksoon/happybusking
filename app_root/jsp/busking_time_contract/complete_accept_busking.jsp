<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">

<%@include file="/importhaed.jsp" %>

<div data-role="page" id="accept_busking_complete" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%-- panel 부분 --%>
    <%-- <%@include file="/app_root/jsp/panel/panel.jsp" %> --%>

    <%-- body부분 --%>
    <div id="accept_busking_complete_content" data-role="content" style="text-align:center; padding: 0px 45px 0px 45px; height: 100% !important;">
        <div class="ab_complete_top_container">
            <div class="ab_complete_icon-shape-circle">
                <svg xmlns="http://www.w3.org/2000/svg" width="39" height="48" style="margin-left: 14px;" viewBox="0 -20 80 80">
                    <g id="done_ck" transform="translate(-114 -254)">
                        <rect id="사각형_2121" data-name="사각형 2121" width="78" height="78" transform="translate(114 254)" fill="none"/>
                        <path id="패스_1122" data-name="패스 1122" d="M59.557,12576.536l17.642,20.288,37.919-39.551" transform="matrix(0.996, -0.087, 0.087, 0.996, -1029.359, -12227.278)" fill="none" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="6"/>
                    </g>
                </svg>
            </div>
        </div>

        <div class="ab_complete_title_container">
            <p>공연 승인 완료</p>
        </div>

        <div class="ab_complete_line" style="margin-top: 39px;">
        </div>

        <div class="ab_complete_notice_1">
            <%-- <p><span>아티스트명</span><span class="ab_complete_info">서울하늘</span></p>
            <p><span>공연 일자</span><span class="ab_complete_info">20.11.03</span></p>
            <p><span>공연 시간</span><span class="ab_complete_info">19:30 - 20:00</span></p> --%>
        </div>

        <div class="ab_complete_line" style="margin-top: 20px; background: #F9F9FB 0% 0% no-repeat padding-box;">
        </div>
<%-- 
        <div class="ab_complete_notice_2">
            <p>등록된 이메일에 계약서 사본이 전송되었습니다</p>
        </div> --%>

        <div class="ab_complete_confirm_list_btn" id="ab_complete_confirm_list_btn" onclick="go_contract_list()">
            <p>공연 신청/계약 이력</p>
        </div>
    </div>
    <footer data-role="footer" data-position="fixed" data-tap-toggle="false" id="footer">
        <div class="common_InsertBtnForm ab_complete_footer" id="ab_complete_footer" onclick = "toHome();">
            확인
        </div>
    </footer>
</div>