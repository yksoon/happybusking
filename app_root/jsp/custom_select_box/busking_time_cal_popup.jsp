 <!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="busking_time_cal">
    <div class="bts_cal_body" id="bts_cal_body">
        <div class="bts_cal_body_content">

            <div class="bts_cal_body_title_container" id="select_date">
                <%-- <p class="bts_cal_body_title" id="select_date"></p> --%>
            </div>
            <div class="bts_cal_body_cancel_container" id="bts_cal_back">
                <div class="bts_cal_body_cancel_img"></div>
            </div>

            <div class="bts_cal_perform_container" id="bts_cal_perform">
                <div class="bts_cal_perform_cell perform_start">
                    <div class="bts_cal_perform_p_title">
                        <p class="bts_cal_perform_p">공연시작</p>
                    </div>
                    <div class="bts_cal_perform_time start_time" style="color: #8354C8;">
                        <select name="btr_cal_sHour" id="btr_cal_sHour" name="btr_cal_sHour">
				        </select>
                        :
                        <select name="btr_cal_sMin" id="btr_cal_sMin" name="btr_cal_sMin">
				        </select>
                    </div>
                </div>
                <div class="bts_cal_perform_cell perform_end">
                    <div class="bts_cal_perform_p_title">
                        <p class="bts_cal_perform_p">공연종료</p>
                    </div>
                    <div class="bts_cal_perform_time end_time" style="color: #8354C8;">
                        <select name="btr_cal_eHour" id="btr_cal_eHour" name="btr_cal_eHour">
				        </select>
                        :
                        <select name="btr_cal_eMin" id="btr_cal_eMin" name="btr_cal_eMin">
				        </select>
                    </div>                 
                </div>
            </div>

            <div class="bts_cal_bottom_container">
                <%-- <div class="bts_cal_bottom_left">
                    <div class="btra_item selected_team_chk" id="selected_team"></div>
                    <div class="selected_team">정해진 공연팀이 있나요?</div>
                </div> --%>
                <%-- <div class="bts_cal_bottom_right" id="bts_cal_time_add">
                    <p class="bts_cal_add_time_p">시간추가 +</p>
                </div> --%>
            </div>
        </div>
    </div>
	<div class="common_InsertBtnForm bts_cal_footer" id="bts_cal_footer" onclick="bts_cal_footer_btn()">
		확인
	</div>
</div>