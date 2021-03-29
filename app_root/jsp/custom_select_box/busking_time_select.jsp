 <!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="busking_time_select">
    <div class="bts_body" id="bts_body">
        <div class="bts_body_content">

            <div class="bts_body_title_container" id="select_date">
                <%-- <p class="bts_body_title" id="select_date"></p> --%>
            </div>
            <div class="bts_body_cancel_container" id="bts_back">
                <div class="bts_body_cancel_img"></div>
            </div>

            <div class="bts_perform_container" id="bts_perform">
                <div class="bts_perform_cell perform_start">
                    <div class="bts_perform_p_title">
                        <p class="bts_perform_p">공연시작</p>
                    </div>
                    <div class="bts_perform_time start_time">
                        <p class="bts_perform_time_p">19:30</p>
                    </div>
                </div>
                <div class="bts_perform_cell perform_end">
                    <div class="bts_perform_p_title">
                        <p class="bts_perform_p">공연종료</p>
                    </div>
                    <div class="bts_perform_time end_time">
                        <p class="bts_perform_time_p">20:00</p>
                    </div>                 
                </div>
            </div>

            <div class="bts_bottom_container">
                <div class="bts_bottom_left">
                    <div class="btra_item selected_team_chk" id="selected_team"></div>
                    <div class="selected_team">정해진 공연팀이 있나요?</div>
                </div>
                <div class="bts_bottom_right" id="bts_time_add">
                    <p class="bts_add_time_p">시간추가 +</p>
                </div>
            </div>
        </div>
    </div>
	<div class="common_InsertBtnForm bts_footer" id="bts_footer">
		확인
	</div>
</div>