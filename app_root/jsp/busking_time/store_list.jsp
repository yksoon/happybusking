<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<%-- page 부분 --%>
<div data-role="page" id="store_list">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
        <div class="custom_sl_popup" id="custom_sl_popup">
		</div>
        <%-- <div class="custom_sl_myperform_popup" id="custom_sl_myperform_popup">
		</div> --%>
		<!-- content 부분 -->		
	<div id = "store_list_content" data-role="content" style="text-align:center; padding: 0; height: 100% !important;">


        <div class="store_list_header_menu_container ui-grid-b">
            <%-- <div class="store_list_menu ui-block-a">
                <div class="sl_header_tab" style="border-bottom: 3px solid #8354C8; font: normal normal bold 15px/45px SpoqaHanSans; color: #8354C8;" >
                전체
                </div>
            </div>
            <div class="store_list_menu ui-block-b">
                <div class="sl_header_tab" onclick="go_sl_area()">
                지역
                </div>
            </div>
            <div class="store_list_menu ui-block-c">
                <div class="sl_header_tab" onclick="go_sl_month()">
                    월별
                </div>
            </div>
            <div class="store_list_menu ui-block-d">
                <div class="sl_header_tab" onclick="go_sl_genre()">
                    장르
                </div>
            </div> --%>
        </div>

        <div class="sl_header_second_menu_container">
            <div class="sl_header_second_menu_contant">

            </div>
        </div>
		
        <div class ="sl_top_container">
            <%-- <div class="common_terms_check common_flex_container">
            <input type="checkbox" name="my_perform_chk" id="my_perform_chk" data-role="none" value="1">
            <label for="my_perform_chk"></label> --%>
            <%-- <span class = "my_perform_chk_span">내 공연 보기</span><span style="display: flex; align-items: center;"><img src="/img/busking_time/sl_down_arrow.svg" class="sl_down_arrow"/></span> --%>
            <span class = "my_perform_chk_span">내 공연 보기</span>
            <span>
            <select class="my_perform_sel" id="my_perform_sel" data-role="none">
                <option value="sl_no_sel" selected>선택안함</option>
                <option value="sl_all_sel">내공연</option>
                <option value="sl_recruiting">모집중</option>
                <option value="sl_recruited">모집완료</option>
            </select>
            </span>
        </div>

        <div class="sl_content_container">

        </div>

        <div class="sl_perform_reg_btn" id="sl_reg_perform_btn">
        <img src="/img/busking_time/reg_perform_icon.svg" class="sl_perform_reg_btn_img" />
        </div>

        <input type="hidden" id="user_no" value="<%=USER_NO %>">

        <div id="store_list_myperform" style="display: none;">
            <div class="slm_body" id="slm_body">
                <div class="slm_body_content">
                    <div class="slm_btn_container">
                        <input type="radio" name="my_perform_radio" id="my_perform_chk_1" data-role="none" value="내공연">
                        <label for="my_perform_chk_1"></label>
                        <span class = "my_perform_chk_span">내 공연</span>
                    </div>
                    <div class="slm_btn_container">
                        <input type="radio" name="my_perform_radio" id="my_perform_chk_2" data-role="none" value="모집중">
                        <label for="my_perform_chk_2"></label>
                        <span class = "my_perform_chk_span">모집중 공연</span>
                    </div>
                    <div class="slm_btn_container" style="margin-bottom: 0;">
                        <input type="radio" name="my_perform_radio" id="my_perform_chk_3" data-role="none" value="모집완료">
                        <label for="my_perform_chk_3"></label>
                        <span class = "my_perform_chk_span">모집완료 공연</span>
                    </div>
                </div>
            </div>
        </div>
	</div>
</div>