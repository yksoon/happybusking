 <!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="busking_detail_pop">
    <div class="bdp_body" id="bdp_body">
        <div class="bdp_body_content">
            <div class="bdp_close">
                <img class="bdp_close_btn" src="/img/custom_select_box/close_popup.svg" onclick="close_btad_popup()" />
            </div>
            <div class="bdp_title">
                <p>아티스트의 서명이 모두</p>
                <p>완료되지 않았습니다</p>
            </div>
            <div class="bdp_message">
                <p>아티스트의 서명이 모두 완료</p>
                <p>되어야 서명이 가능합니다</p>
            </div>
            <div class="bdp_confirm_btn_container">
                <div class="bdp_confirm_btn" id="bdp_confirm_btn" onclick="close_btad_popup()">
                    확인
                </div>
            </div>
            <!--
            <div class="bdp_cancel_btn_container">
                <div class="bdp_cancel_btn" id="bdp_cancel_btn" onclick="close_btad_popup()">
                    나중에
                </div>
            </div>
            -->
        </div>
    </div>
</div>