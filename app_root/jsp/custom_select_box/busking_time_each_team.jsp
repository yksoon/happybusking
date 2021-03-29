 <!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="busking_time_each_team">
    <div class="btet_body" id="btet_body">
        <div class="btet_body_content">
            <div class="btet_header">
                <div class="btet_top_container">
                    <div class="btet_body_title_container" id="select_date">
                        <p class="btet_body_title" id="select_date">공연팀 선택</p>
                    </div>
                    <div class="btet_body_cancel_container" id="btet_back">
                        <div class="btet_body_cancel_img"></div>
                    </div>
                </div>

                <div class="btet_search_container">
                    <div class="ui-block-a btet_search_img_block" id="a_ranking_search_img">
                        <img class="search-input-icon" src="/img/busking_time/search_1.svg">
                    </div>
                    <div class="ui-block-b btet_search_input_block">
                        <input type="text" class="search-input-text" name="btet_search_date" id="btet_search_date" placeholder="팀명으로 검색">
                    </div>
                    <div class="ui-block-c btet_search_cancel_block" id="btet_cancle">
                        <img src="/img/busking_time/cancel.svg">
                    </div>
                </div>
            </div>

			<div id="a_ranking_content_2">

			</div>


        </div>
    </div>
	<div class="common_InsertBtnForm btet_footer" id="btet_footer">
		확인
	</div>
</div>