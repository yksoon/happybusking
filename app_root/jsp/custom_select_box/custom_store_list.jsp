 <!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="store_list_pop">
    <div class="slp_body" id="slp_body">
        <div class="slp_body_content">
            <div class="slp_close">
                <img class="slp_close_btn" src="/img/custom_select_box/close_popup.svg" onclick="close_sl_popup()" />
            </div>
            <div class="slp_title">
                <p>상업 공간 및 버스킹공간</p>
                <p>등록이 필요합니다</p>
            </div>
            <div class="slp_message">
                <p>공연 모집 등록은 상업 공간과 버스킹 공간</p>
                <p>등록이 완료되어야 이용 가능합니다</p>
            </div>
            <div class="slp_confirm_btn_container">
                <div class="slp_confirm_btn" id="slp_confirm_btn">
                    상업 공간 등록
                </div>
            </div>
            <div class="slp_cancel_btn_container">
                <div class="slp_cancel_btn" id="slp_cancel_btn" onclick="close_sl_popup()">
                    나중에
                </div>
            </div>
        </div>
    </div>
</div>