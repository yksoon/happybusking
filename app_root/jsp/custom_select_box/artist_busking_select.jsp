 <!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="artist_busking_select">
    <div class="abs_body" id="abs_body">
        <div class="abs_body_content">

            <%-- ---------------------------------------------- --%>
            <div class="abs_top_container">
                <div class="abs_title">
                    <%-- <p>11월 3일 공연 신청</p> --%>
                </div>
                <div class="abs_close"  onclick="abs_close_popup()">
                    <img src="/img/custom_select_box/close_popup.svg" class="abs_close_img" />
                </div>
            </div>
            <%-- ----------------------------------------------------- --%>

            <div class="abs_card_container">
                <%-- <div class="abs_card_img_container">
                    <div class="abs_card_img_box">
                        <img id="#" class="abs_card_img" src="#">
                    </div>
                </div>
                <div class="abs_card">
                    <div class="abs_card_top_container">
                        <div class="abs_card_title">
                            <p>라이브 카페 로드</p>
                        </div>
                        <div class="abs_card_confirm">
                            <p>공간 정보 ></p>
                        </div>
                    </div>
                    <div class="abs_card_time">
                        <p>12:41 - 14:41</p>
                    </div>
                    <div class="abs_card_contract">
                        <p>신청 가능</p>
                    </div>
                </div> --%>
            </div>

            <%-- -------------------------------------------- --%>

            <div class="abs_team_card_container">
                <div class="abs_card_img_container">
                    <div class="abs_card_img_box">
                    </div>
                </div>
                <div class="abs_team_container">
                    <div class="abs_team">
                        <%-- <div class="abs_team_left_container">
                            <div class="abs_card_img_box">
                                <img id="#" class="abs_card_img" src="#">
                            </div>
                        </div>
                        <div class="abs_team_right_container">
                            <div class="abs_team_name_con">
                                <p class="abs_team_name">서울하늘</p>
                                <p class="abs_team_change">팀 변경</p>
                            </div>
                            <div class="abs_team_chk_con">
                                <div class="abs_chk_container" style="margin-bottom: 0;">
                                    <input type="checkbox" name="abs_team_check" id="abs_team_check_1" data-role="none">
                                    <label for="abs_team_check_1"></label>
                                </div>                    
                            </div>
                        </div> --%>
                    </div>

                    <div class="abs_hr"></div>

                    <div class="abs_member">

                        <%-- <div class="abs_member_section">
                            <div class="abs_team_left_container">
                                <div class="abs_card_img_box">
                                    <img id="#" class="abs_card_img" src="#">
                                </div>
                            </div>
                            <div class="abs_team_right_container">
                                <div class="abs_team_name_con">
                                    <p class="abs_member_name">서울</p>
                                </div>
                                <div class="abs_team_chk_con">
                                    <div class="abs_chk_container" style="margin-bottom: 0;">
                                        <input type="checkbox" name="abs_team_check" id="abs_team_check_1" data-role="none">
                                        <label for="abs_team_check_1"></label>
                                    </div>                    
                                </div>
                            </div>
                        </div> --%>

                        <%-- <div class="abs_member_section">
                            <div class="abs_team_left_container">
                                <div class="abs_card_img_box">
                                    <img id="#" class="abs_card_img" src="#">
                                </div>
                            </div>
                            <div class="abs_team_right_container">
                                <div class="abs_team_name_con">
                                    <p class="abs_member_name">하늘</p>
                                </div>
                                <div class="abs_team_chk_con">
                                    <div class="abs_chk_container" style="margin-bottom: 0;">
                                        <input type="checkbox" name="abs_team_check" id="abs_team_check_1" data-role="none">
                                        <label for="abs_team_check_1"></label>
                                    </div>                    
                                </div>
                            </div>
                        </div> --%>

                    </div>

                    <div class="abs_hr"></div>

                    <div class="abs_price_wrap">
                        <%-- <div class="abs_price_container">
                            <div class="abs_price_title">
                                <p>공연료</p>
                            </div>
                            <div class="abs_price">
                                <p>100,000 원</p>
                            </div>
                        </div> --%>
                    </div>

                </div>
            </div>

            <%-- ----------------------------------------------------- --%>

            <div class="abs_notice_container">
                <div class="abs_card_img_container">
                    <div class="abs_card_img_box">
                    </div>
                </div>
                <div class="abs_notice">
                    <p>고용보험 진행을 보다 편리하게 하기 위해 사업주님이 정해놓으신 금액의 1/n으로 설정해놓았습니다.</p>
                    <p>(짝수 인원 팀에 한함)</p>
                    <p style="margin-top: 9px;">실제 용역 계약서에 들어갈 각 팀원별 공연비를 기재해 주세요</p>
                </div>
            </div>

        </div>
    </div>
	<div class="common_InsertBtnForm abs_footer" id="abs_footer">
		공연 신청
	</div>
</div>