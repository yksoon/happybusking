 <!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="store_list_myperform">
    <div class="slm_body" id="slm_body">
        <div class="slm_body_content">
            <div class="slm_btn_container">
                <input type="radio" name="my_perform_chk" id="my_perform_chk_1" data-role="none" value="내공연">
                <label for="my_perform_chk_1"></label>
                <span class = "my_perform_chk_span">내 공연</span>
            </div>
            <div class="slm_btn_container">
                <input type="radio" name="my_perform_chk" id="my_perform_chk_2" data-role="none" value="모집중">
                <label for="my_perform_chk_2"></label>
                <span class = "my_perform_chk_span">모집중 공연</span>
            </div>
            <div class="slm_btn_container" style="margin-bottom: 0;">
                <input type="radio" name="my_perform_chk" id="my_perform_chk_3" data-role="none" value="모집완료">
                <label for="my_perform_chk_3"></label>
                <span class = "my_perform_chk_span">모집완료 공연</span>
            </div>
        </div>
    </div>
</div>