<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<%@include file="/importhead2.jsp" %>

<div data-role="page" id="busking_time_reg_all" >

	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
        <div class="custom_select_popup" id="busking_time_select_popup">
		</div>
    <!-- content 부분 -->
    <div id="busking_time_reg_all_content" data-role="content">
        <div class="ra_title_div">
            <p><span class="ra_title">공연 일정 등록</span><span class="ra_subtitle">(평일 일정, 주말 일정, 등 일괄 등록)</span></p>

            <div class="ra_date weekday">
                <div class="ra_date_title weekday_title">
                    평일 일정을 일괄 등록하시겠어요?
                </div>
                <div class="ra_date_chk weekday_chk">
                    <div class="btra_item weekday_mon" id="weekday_mon">월</div>
                    <div class="btra_item weekday_tue" id="weekday_tue">화</div>
                    <div class="btra_item weekday_wed" id="weekday_wed">수</div>
                    <div class="btra_item weekday_thu" id="weekday_thu">목</div>
                    <div class="btra_item weekday_fri" id="weekday_fri">금</div>
                </div>
                <div class="all_chk_div">
                    <div class="btra_item_all all_chk">
                        <div class="all_chk_img"></div><span class="all_chk_span">일괄등록</span>
                    </div>
                </div>
            </div>

            <div class="ra_date weekend">
                <div class="ra_date_title weekend_title">
                    주말 일정을 일괄 등록하시겠어요?
                </div>
                <div class="ra_date_chk weekend_chk">
                    <div class="btra_item weekend_sat" id="weekend_sat">토</div>
                    <div class="btra_item weekend_sun" id="weekend_sun">일</div>
                </div>
                <div class="all_chk_div">
                    <div class="btra_item_all all_chk">
                        <div class="all_chk_img"></div><span class="all_chk_span">일괄등록</span>
                    </div>
                </div>
            </div>

            <div class="ra_date holiday">
                <div class="ra_date_title holiday_title">
                    휴일이 있나요?
                </div>
                <div class="ra_date_chk holiday_chk">
                    <div class="btra_item weekday_mon" id="holiday_mon">월</div>
                    <div class="btra_item weekday_tue" id="holiday_tue">화</div>
                    <div class="btra_item weekday_wed" id="holiday_wed">수</div>
                    <div class="btra_item weekday_thu" id="holiday_thu">목</div>
                    <div class="btra_item weekday_fri" id="holiday_fri">금</div>
                    <div class="btra_item weekend_sat" id="holiday_sat">토</div>
                    <div class="btra_item weekend_sun" id="holiday_sun">일</div>
                </div>
            </div>

            <div class="ra_date is_next">
                <div class="ra_date_title is_next_title">
                    다음에도 이번달과 같이 반복 적용하시겠어요?
                </div>
                <div class="ra_date_chk is_next_chk">
                    <div class="btra_item is_next_1month" id="is_next_1month">1달</div>
                    <div class="btra_item is_next_3month" id="is_next_3month">3달</div>
                    <div class="btra_item is_next_1year" id="is_next_1year">1년</div>
                </div>
            </div>
        </div>



        <div class="ra_title_div perform_fee">
            <div>
                <p><span class="ra_title">공연비</span></p>
            </div>
            <div class="perform_fee_subtitle_div">
                <p><span class="perform_fee_subtitle">공연비</span></p>
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

    <footer data-role="footer" data-position="fixed" data-tap-toggle="false" id="footer">
        <div class="common_InsertBtnForm btr_footer" id="btr_footer">
            등록완료
        </div>
    </footer>
</div>