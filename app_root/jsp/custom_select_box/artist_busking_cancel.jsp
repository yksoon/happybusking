 <!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="artist_busking_cancel">
    <div class="abc_body" id="abc_body">
        <div class="abc_body_content">

            <%-- ---------------------------------------------- --%>
            <div class="abc_top_container">
                <div class="abc_title">
                    <%-- <p>11월 3일 공연 신청</p> --%>
                </div>
                <div class="abc_close"  onclick="abc_close_popup()">
                    <img src="/img/custom_select_box/close_popup.svg" class="abc_close_img" />
                </div>
            </div>
            <%-- ----------------------------------------------------- --%>

            <div class="abc_card_container">
                <%-- <div class="abc_card_img_container">
                    <div class="abc_card_img_box">
                        <img id="#" class="abc_card_img" src="#">
                    </div>
                </div>
                <div class="abc_card">
                    <div class="abc_card_top_container">
                        <div class="abc_card_title">
                            <p>라이브 카페 로드</p>
                        </div>
                        <div class="abc_card_confirm">
                            <p>공간 정보 ></p>
                        </div>
                    </div>
                    <div class="abc_card_time">
                        <p>12:41 - 14:41</p>
                    </div>
                    <div class="abc_card_contract">
                        <p>신청 가능</p>
                    </div>
                </div> --%>
            </div>

            <%-- -------------------------------------------- --%>

            <div class="abc_team_card_container">
                <div class="abc_card_img_container">
                    <div class="abc_card_img_box">
                    </div>
                </div>
                <div class="abc_team_container">
                    <div class="abc_team">
                        <%-- <div class="abc_team_left_container">
                            <div class="abc_card_img_box">
                                <img id="#" class="abc_card_img" src="#">
                            </div>
                        </div>
                        <div class="abc_team_right_container">
                            <div class="abc_team_name_con">
                                <p class="abc_team_name">서울하늘</p>
                                <p class="abc_team_change">팀 변경</p>
                            </div>
                            <div class="abc_team_chk_con">
                                <div class="abc_chk_container" style="margin-bottom: 0;">
                                    <input type="checkbox" name="abc_team_check" id="abc_team_check_1" data-role="none">
                                    <label for="abc_team_check_1"></label>
                                </div>                    
                            </div>
                        </div> --%>
                    </div>

                    <div class="abc_hr"></div>

                    <div class="abc_member">

                        <%-- <div class="abc_member_section">
                            <div class="abc_team_left_container">
                                <div class="abc_card_img_box">
                                    <img id="#" class="abc_card_img" src="#">
                                </div>
                            </div>
                            <div class="abc_team_right_container">
                                <div class="abc_team_name_con">
                                    <p class="abc_member_name">서울</p>
                                </div>
                                <div class="abc_team_chk_con">
                                    <div class="abc_chk_container" style="margin-bottom: 0;">
                                        <input type="checkbox" name="abc_team_check" id="abc_team_check_1" data-role="none">
                                        <label for="abc_team_check_1"></label>
                                    </div>                    
                                </div>
                            </div>
                        </div> --%>

                        <%-- <div class="abc_member_section">
                            <div class="abc_team_left_container">
                                <div class="abc_card_img_box">
                                    <img id="#" class="abc_card_img" src="#">
                                </div>
                            </div>
                            <div class="abc_team_right_container">
                                <div class="abc_team_name_con">
                                    <p class="abc_member_name">하늘</p>
                                </div>
                                <div class="abc_team_chk_con">
                                    <div class="abc_chk_container" style="margin-bottom: 0;">
                                        <input type="checkbox" name="abc_team_check" id="abc_team_check_1" data-role="none">
                                        <label for="abc_team_check_1"></label>
                                    </div>                    
                                </div>
                            </div>
                        </div> --%>

                    </div>

                    <div class="abc_hr"></div>

                    <div class="abc_price_wrap">
                        <%-- <div class="abc_price_container">
                            <div class="abc_price_title">
                                <p>공연료</p>
                            </div>
                            <div class="abc_price">
                                <p>100,000 원</p>
                            </div>
                        </div> --%>
                    </div>

                </div>
            </div>

            <%-- ----------------------------------------------------- --%>

            <div class="abc_notice_container">
                <div class="abc_card_img_container">
                    <div class="abc_card_img_box">
                    </div>
                </div>
                <div class="abc_notice">
                    <p>고용보험 진행을 보다 편리하게 하기 위해 사업주님이 정해놓으신 금액의 1/n으로 설정해놓았습니다.</p>
                    <p style="margin-top: 9px;">실제 용역 계약서에 들어갈 각 팀원별 공연비를 기재해 주세요</p>
                </div>
            </div>

        </div>
    </div>
	<div class="common_InsertBtnForm abc_footer" id="abc_footer">
		신청취소
	</div>
</div>