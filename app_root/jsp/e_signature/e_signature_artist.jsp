<!DOCTYPE html>
<%@page import="db.dbconn" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <meta charset="UTF-8">
        <%@include file="/importhaed.jsp" %>
                <%-- page 부분 --%>
                    <div data-role="page" id="e_signature_artist">
                        <!-- header 부분 -->
                        <%@include file="/app_root/jsp/header/header.jsp" %>
                            <%@include file="/app_root/jsp/panel/panel.jsp" %>
                                <!-- content 부분 -->
                                <div id="e_signature_artist_content" data-role="content"
                                    style="text-align:center; padding: 0px 15px 0px 15px; height: 100% !important;">

                                    <div class="esa_auth_container">

                                        <div class="esa_auth_title">
                                            <p>본인 인증</p>
                                        </div>

                                        <div class="esa_name_container">
                                            <div class="esa_mini_title esa_name_title">
                                                <p>실명</p>
                                            </div>
                                            <div class="esa_name_input_container">
                                                <input type="text" class="esa_name_input" id="esa_name_input"
                                                    data-role="none" placeholder="실명 입력" />
                                            </div>
                                        </div>

                                        <div class="esa_registration_num_container">
                                            <div class="esa_mini_title esa_registration_num_title">
                                                <p>주민등록번호</p>
                                            </div>
                                            <div class="esa_registration_num">
                                                <input type="number" inputmode="numeric" pattern="[0-9]*" maxlength="6"
                                                    class="esa_registration_num_input esa_registration_num_first"
                                                    id="esa_registration_num_first" data-role="none"
                                                    oninput="maxLengthCheck(this)" />
                                                <div class="esa_registration_hipen">-</div>
                                                <input type="password" inputmode="numeric" pattern="[0-9]*"
                                                    maxlength="7"
                                                    class="esa_registration_num_input esa_registration_num_sec"
                                                    id="esa_registration_num_sec" data-role="none" />
                                            </div>
                                        </div>

                                        <div class="esa_adress_container">
                                            <div class="esa_mini_title esa_adress_title">
                                                <p>주소</p>
                                            </div>
                                            <div class="esa_adress_1_container">
                                                <input type="text" class="esa_post_no" id="esa_post_no"
                                                    placeholder="주소를 입력하세요" data-role="none" readonly />
                                                <div class="esa_search_adress"
                                                    onclick="esa_open_execDaumPostcode('addr_layer')">
                                                    주소검색
                                                </div>
                                            </div>
                                            <div class="esa_adress_2_container">
                                                <input type="text" class="esa_adress" id="esa_adress"
                                                    placeholder="상세주소를 입력하세요" data-role="none" />
                                            </div>
                                        </div>

                                    </div>

                                    <div class="esa_perform_container">

                                        <div class="esa_auth_title">
                                            <p>공연 정보</p>
                                        </div>

                                        <div class="esa_perform_date_container">
                                            <div class="esa_mini_title esa_perform_date_title">
                                                <p>공연날짜</p>
                                            </div>
                                            <div class="esa_perform_date_input_container">
                                                <input type="text" class="esa_perform_date" id="esa_perform_date"
                                                    data-role="none" readonly />
                                            </div>
                                        </div>

                                        <div class="esa_perform_time_container">
                                            <div class="esa_mini_title esa_perform_time_title">
                                                <p>공연시간</p>
                                            </div>
                                            <div class="esa_perform_time_input_container">
                                                <input type="text" class="esa_perform_time" id="esa_pt_start_hour"
                                                    data-role="none" readonly />
                                                <input type="text" class="esa_perform_time" id="esa_pt_start_min"
                                                    data-role="none" readonly style="margin-left: 6px;" />
                                                <div class="esa_perform_time_hipen">
                                                    ~
                                                </div>
                                                <input type="text" class="esa_perform_time" id="esa_pt_end_hour"
                                                    data-role="none" readonly />
                                                <input type="text" class="esa_perform_time" id="esa_pt_end_min"
                                                    data-role="none" readonly style="margin-left: 6px;" />
                                            </div>
                                        </div>

                                    </div>

                                    <div class="esa_bank_container">
                                        <div class="esa_auth_title">
                                            <p>계좌 정보</p>
                                        </div>
                                        <div class="esa_bank_name_container">
                                            <div class="esa_mini_title esa_bank_name_title">
                                                <p>입금 은행</p>
                                            </div>
                                            <div class="esa_bank_name_select_container">
                                                <select name="esa_bank_name_select" id="esa_bank_name_select"
                                                    class="esa_bank_name_select" data-role="none">
                                                    <option value="no_select" selected>은행선택</option>
                                                    <option value="KB국민은행">KB국민은행</option>
                                                    <option value="신한은행">신한은행</option>
                                                    <option value="하나은행">하나은행</option>
                                                    <option value="우리은행">우리은행</option>
                                                    <option value="IBK기업은행">IBK기업은행</option>
                                                    <option value="NH농협은행">NH농협은행</option>
                                                    <option value="KDB산업은행">KDB산업은행</option>
                                                    <option value="SC제일은행">SC제일은행</option>
                                                    <option value="카카오뱅크">카카오뱅크</option>
                                                    <option value="케이뱅크">케이뱅크</option>
                                                    <option value="한국CITI은행">한국CITI은행</option>
                                                    <option value="BNK부산은행">BNK부산은행</option>
                                                    <option value="DGB대구은행">DGB대구은행</option>
                                                    <option value="BNK경남은행">BNK경남은행</option>
                                                    <option value="Sh수협은행">Sh수협은행</option>
                                                    <option value="JB광주은행">JB광주은행</option>
                                                    <option value="JB전북은행">JB전북은행</option>
                                                    <option value="제주은행">제주은행</option>
                                                </select>
                                            </div>
                                            <div class="esa_bank_number_container">
                                                <div class="esa_mini_title esa_bank_number_title">
                                                    <p>계좌 번호</p>
                                                </div>
                                                <div class="esa_bank_number_input_container">
                                                    <input type="number" inputmode="numeric" pattern="[0-9]*"
                                                        class="esa_bank_number_input" placeholder="계좌번호를 입력하세요(-제외)"
                                                        id="esa_bank_number_input" data-role="none" />
                                                </div>
                                            </div>
                                            <div class="esa_bank_user_container">
                                                <div class="esa_mini_title esa_bank_user_title">
                                                    <p>예금주</p>
                                                </div>
                                                <div class="esa_bank_user_input_container">
                                                    <input type="text" class="esa_bank_user_input"
                                                        id="esa_bank_user_input" placeholder="예금주를 입력하세요"
                                                        data-role="none" />
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <!-- 주소찾기 팝업 -->
                                    <div id="addr_layer"
                                        style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
                                        <img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png"
                                            id="btnCloseLayer"
                                            style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1"
                                            onclick="closeDaumPostcode('addr_layer')" alt="닫기 버튼">
                                    </div>

                                    <div class="esa_midline">
                                        <!------------------ 가운데 회색 선 ----------------->
                                    </div>

                                    <div class="esa_low_container">
                                        <div class="esa_sign_container">
                                            <p>아래 패드에</p>
                                            <p>서명하세요</p>
                                        </div>
                                        <div class="esa_sign_title">
                                            <p>전자 계약 서명</p>
                                            <img class="eas_refresh" id="esa_refresh"
                                                src="/img/e_signature/refresh.svg" />
                                        </div>
                                        <div class="esa_sign_wrapper">
                                            <canvas id="esa_signature-pad" class="esa_signature-pad"></canvas>
                                        </div>
                                    </div>

                                    <input type="hidden" id="user_no" value="<%=USER_NO %>">

                                </div>

                                <footer data-role="footer" data-position="fixed" data-tap-toggle="false" id="footer">
                                    <div class="common_InsertBtnForm esa_footer" id="esa_footer">
                                        서명완료
                                    </div>
                                </footer>

                    </div>