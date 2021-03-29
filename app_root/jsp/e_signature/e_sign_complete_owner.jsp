<!DOCTYPE html>
<%@page import="db.dbconn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<%-- page 부분 --%>
<div data-role="page" id="e_sign_complete_owner">
    <!-- header 부분 -->
    <%@include file="/app_root/jsp/header/header.jsp" %>
    <%-- <%@include file="/app_root/jsp/panel/panel.jsp" %> --%>
    <!-- content 부분 -->
    <div id="e_sign_complete_owner_content" data-role="content" style="text-align:center; padding: 0px 45px 0px 45px; height: 100% !important;">
        <div class="esco_top_container">
            <div class="esco_icon-shape-circle">
                <svg xmlns="http://www.w3.org/2000/svg" width="39" height="48" style="margin-left: 14px;" viewBox="0 -20 80 80">
                    <g id="done_ck" transform="translate(-114 -254)">
                        <rect id="사각형_2121" data-name="사각형 2121" width="78" height="78" transform="translate(114 254)" fill="none"/>
                        <path id="패스_1122" data-name="패스 1122" d="M59.557,12576.536l17.642,20.288,37.919-39.551" transform="matrix(0.996, -0.087, 0.087, 0.996, -1029.359, -12227.278)" fill="none" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="6"/>
                    </g>
                </svg>
            </div>
        </div>

        <div class="esco_title_container">
            <p>계약서 서명 완료</p>
        </div>

        <div class="esco_line" style="margin-top: 39px;">
        </div>

        <div class="esco_notice_1">
            <p>공연자의 예술인 고용 보험 가입을위한 문화예술용역계약 및 보험 사무대행 위탁 신청이 완료되었습니다</p>
        </div>

        <div class="esco_line" style="margin-top: 20px; background: #F9F9FB 0% 0% no-repeat padding-box;">
        </div>

        <div class="esco_notice_2">
            <p>공연 종료 후 공연자에게 <span>고용보험료(0.8%)를 공제</span> 한 금액을 공연비로 지급해주세요</p>
        </div>

        <div class="esco_notice_3">
            <p>*공연 종료 후 신청 상세보기에 입금 계좌 정보가 생성됩니다.</p>
        </div>

        <div class="esco_confirm_list_btn" id="esco_confirm_list_btn">
            <p>공연 신청/계약 이력</p>
        </div>
    </div>

    <footer data-role="footer" data-position="fixed" data-tap-toggle="false" id="footer">
        <div class="common_InsertBtnForm esco_footer" id="esco_footer" onclick = "toHome();">
            확인
        </div>
    </footer>
</div>