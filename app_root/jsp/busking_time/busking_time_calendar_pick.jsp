<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>

<div data-role="page" id="busking_time_calendar_pick" >

	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
        <div class="custom_select_popup" id="busking_time_cal_popup">
		</div>
    <!-- content 부분 -->
    <div id="busking_time_calendar_pick_content" data-role="content">
        <div class="cal_title">
            날짜를<br>선택하세요
        </div>
        <div class="select_YM">
            <div class="cal_prev" onclick="prevCalendar()">
                <img src="/img/common/prev_btn.svg" style="width: 100%;" />
            </div>
            <div class="cal_year_mon">
                <div class="common_form_default_select_div ui-block-b year_select_block" id="tbCalendarY">
                    <%-- <select name="sel_year" class="sel_year" id="tbCalendarY">
                    </select> --%>
                </div>
                <div class="common_form_default_select_div ui-block-c mon_select_block" id="tbCalendarM">
                    <%-- <select name="sel_mon" class="sel_mon" id="tbCalendarM">
                    </select> --%>
                </div>
            </div>
            <div class="cal_next" onclick="nextCalendar()">
                <img src="/img/common/next_btn.svg" style="width: 100%;" />
            </div>
        </div>
        <div class="cal_wrap">
            <table id="calendar" align="center" class="calendar_table">
                <tr>
                    <th align="center"><font color ="#AEB1BF">일</td>
                    <th align="center"><font color ="#AEB1BF">월</td>
                    <th align="center"><font color ="#AEB1BF">화</td>
                    <th align="center"><font color ="#AEB1BF">수</td>
                    <th align="center"><font color ="#AEB1BF">목</td>
                    <th align="center"><font color ="#AEB1BF">금</td>
                    <th align="center"><font color ="#AEB1BF">토</td>
                </tr> 
            </table>
            <script language="javascript" type="text/javascript">
                buildCalendar();//
            </script>
        </div>
    </div>

    <footer data-role="footer" data-position="fixed" data-tap-toggle="false" id="footer">
        <div class="common_InsertBtnForm btr_cal_footer" id="cal_pick_footer">
            날짜선택
        </div>
    </footer>
</div>