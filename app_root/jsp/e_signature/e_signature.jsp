<!DOCTYPE html>
<%@page import="db.dbconn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<%-- page 부분 --%>
<div data-role="page" id="e_signature">
    <!-- header 부분 -->
    <%@include file="/app_root/jsp/header/header.jsp" %>
    <%@include file="/app_root/jsp/panel/panel.jsp" %>
    <!-- content 부분 -->
    <div id="e_signature_content" data-role="content" style="text-align:center; padding: 0px 15px 0px 15px; height: 100% !important;">
        <div class="es_top_container">

            <div class="es_title_container">
                <p>사업자 확인</p>
            </div>
            <div class="es_owner_container">
                <div class="es_owner_title">
                    <p>대표자명</p>
                </div>
                <div class="es_owner_name_container">
                    <input type="text" class="es_owner_name_input" id="es_owner_name_input" value="" readonly />
                </div>
            </div>

            <div class="es_business_no_container">
                <div class="es_business_no_title">
                    <p>사업자 번호</p>
                </div>
                <div class="ui-grid-b es_business_no_wrap">
                    <div class="ui-block-a" style="width: 24%;">
                        <input type="text" class="es_business_input es_business_no_1" id="es_business_no_1" value="" readonly />
                    </div>
                    <div class="es_hipen">
                        <p>-</p>
                    </div>
                    <div class="ui-block-b" style="width: 22%;">
                        <input type="text" class="es_business_input es_business_no_2" id="es_business_no_2" value="" readonly />
                    </div>
                    <div class="es_hipen">
                        <p>-</p>
                    </div>
                    <div class="ui-block-c" style="width: 48%;">
                        <input type="text" class="es_business_input es_business_no_3" id="es_business_no_3" value="" readonly />
                    </div>
                </div>
            </div>

            <div class="es_title_container es_delegation_title_container">
                <p>위임 동의</p>
            </div>
            <div class="es_delegation_container">
                <div class="es_delegation_chk_container">
                    <input type="checkbox" name="es_delegation_chk" id="es_delegation_chk" data-role="none" value="1">
                    <label for="es_delegation_chk"></label>
                    <span class = "es_delegation_chk_span">고용 보험 사무 위탁 위임 동의</span>
                </div>
                <div class="es_delegation_detail" id="business_consignment_service_view">
                    <p>자세히보기</p>
                </div>
            </div>
            <div class="es_notie">
                <p>해피 버스킹은 아티스트와 사업주의 상호 협력을 돕습니다</p>
                <p>다만, 계약 문제 발생시 해피버스킹은 책임을 지지 않습니다</p>
            </div>
        </div>
            <div class="es_midline">
                <!------------------ 가운데 회색 선 ----------------->
            </div>
        <div class="es_low_container">
            <div class="es_sign_container">
                <p>아래 패드에</p>
                <p>서명하세요</p>
            </div>
            <div class="es_sign_title">
                <p>전자 계약 서명</p>
                <img class="es_refresh" id="es_refresh" src="/img/e_signature/refresh.svg" />
            </div>
            <div class="es_sign_wrapper">
                <canvas id="es_signature-pad" class="es_signature-pad"></canvas>
            </div>
        </div>
        <input type="hidden" id="user_no" value="<%=USER_NO %>">
        <!-- 약관 자세히보기 팝업 통합 -->
	    <div data-role="popup" class="common_trems_popup_container" id="terms_popup">
    </div>
    <footer data-role="footer" data-position="fixed" data-tap-toggle="false" id="footer">
        <div class="common_InsertBtnForm es_footer" id="es_footer">
            서명완료
        </div>
    </footer>
</div>