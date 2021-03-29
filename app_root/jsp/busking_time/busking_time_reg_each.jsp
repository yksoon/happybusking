<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>

<div data-role="page" id="busking_time_reg_each" >

	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
        <div class="custom_select_popup" id="busking_time_each_popup">
		</div>
    <!-- content 부분 -->
    <div id="busking_time_reg_each_content" data-role="content">

        <div class="re_content_wrap">
            <div class="re_title_div">
                <p><span class="re_title">공연 일시</span></p>
            </div>

            <div class="re_date">
                <div class="subtitle">
                    공연날짜
                </div>
                <div class="re_date_input">
                    <input type="text" class="text_input date" id="re_perfom_date" value="" placeholder="날짜를 선택하세요" readonly />
                </div>
                <div class="subtitle" style="margin-top: 20px;">
                    공연시간
                </div>
                <div class="re_time_input_container">
                    <div class="re_table_parents">
                        <table class="time_input_table">
                            <tr>
                                <td class="time_input">
                                    <input type="text" class="time_input_text" id="start_time_input_hour" value="" inputmode="numeric" readonly />
                                </td>
                                <td class="time">
                                    시
                                </td>
                            </tr>
                        </table>                    
                    </div>
                    <div class="re_table_parents" style="margin-left: 6px;">
                        <table class="time_input_table">
                            <tr>
                                <td class="time_input">
                                    <input type="text" class="time_input_text" id="start_time_input_min" value="" inputmode="numeric" readonly />
                                </td>
                                <td class="time">분</td>
                            </tr>
                        </table>                    
                    </div>
                    <div class="re_table_parents" style="text-align: center; width: 8%; align-items: center; display: flex;">
                        <table style="padding: 0; text-align: center; width: 100%;">
                            <tr>
                                <td style="text-align: center; border: 0px;">~</td>
                            </tr>
                        </table>
                    </div>
                    <div class="re_table_parents">
                        <table class="time_input_table" >
                            <tr>
                                <td class="time_input">
                                    <input type="text" class="time_input_text" id="end_time_input_hour" value="" inputmode="numeric" readonly />
                                </td>
                                <td class="time">시</td>
                            </tr>
                        </table>                    
                    </div>
                    <div class="re_table_parents"  style="margin-left: 6px;">
                        <table class="time_input_table">
                            <tr>
                                <td class="time_input">
                                    <input type="text" class="time_input_text" id="end_time_input_min" value="" inputmode="numeric" readonly />
                                </td>
                                <td class="time">분</td>
                            </tr>
                        </table>                    
                    </div>
                </div>
            </div>
        </div>

        <div class="re_content_wrap">
            <div class="re_title_div" style="margin-top: 41px;">
                <p><span class="re_title">공연비</span></p>
            </div>

            <div class="re_date perform_fee">
                <div class="subtitle">
                    공연비
                </div>
                <div class="perform_fee_table_container">
                    <table class="perform_fee_table">
                        <tr>
                            <th class="money_title">금액</th>
                            <td class="money_input">
                                <input type="text" class="money_input_text" placeholder="공연비를 입력하세요" id="money_input_price" inputmode="numeric" />
                            </td>
                            <td class="money_won">원</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <div class="re_content_wrap">
            <div class="re_title_div" style="margin-top: 41px;">
                <p><span class="re_title">공연팀</span></p>
            </div>

            <div class="re_date re_team_chk_container">
                <div class="common_terms_container_alpha">
                    <div class="common_terms_check common_flex_container">
                        <input type="radio" name="re_team" id="re_team_1" data-role="none" value="1" onchange="setDisplay()">
                        <label for="re_team_1"><span></span><div class="text_label_value">지정 팀 있음</div></label>
                    </div>
                </div>

                <div class="common_terms_container_alpha">
                    <div class="common_terms_check common_flex_container">
                        <input type="radio" name="re_team" id="re_team_2" data-role="none" value="0" onchange="setDisplay()" checked="checked">
                        <label for="re_team_2"><span></span><div class="text_label_value">지정 팀 없음</div></label>
                    </div>
                </div>
            </div>

            <%-- 지정팀 있을시 ON --%>
            <div class="re_team_status" id="re_team_status" style="display: none;">
                <div class="re_date re_team_container">
                    <div class="subtitle">
                        공연팀 선택
                    </div>
                    <div class="re_date_input team_select">
                        <input type="text" class="text_input re_team" id="re_team_input_text" value="" placeholder="팀을 선택하세요" readonly />
                    </div>
                </div>
                
                <!-- 2021.01.08 팀만 선택되도록 변경 -->
                <!--
                <div class="re_date re_member_container">
                    <div class="re_date re_member_container_left">
                        <div class="subtitle">
                            구성원 선택
                        </div>
                        <div class="re_date_input member_select">
                            <input type="text" class="text_input re_member" value="" placeholder="" readonly />
                        </div>
                    </div>

                    <div class="re_date re_member_container_right">
                        <div class="subtitle">
                            공연비
                        </div>
                        <div class="re_date_input member_fee">
                            <input type="text" class="text_input re_team_fee" id = "re_team_fee" value="" placeholder="" readonly />
                        </div>
                    </div>
                </div>
                -->
            <div>
        </div>
        <input type="hidden" id="user_no" value="<%=USER_NO %>">
    </div>
    <footer data-role="footer" data-position="fixed" data-tap-toggle="false" id="footer">
        <div class="common_InsertBtnForm re_footer" id="re_footer">
            공연요청
        </div>
    </footer>
</div>