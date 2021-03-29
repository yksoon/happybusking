<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<%-- page 부분 --%>
<div data-role="page" id="store_list_search">	
	<!-- header 부분 -->
    <header data-role="header" data-position="fixed" data-tap-toggle="false" id="header">
	<div class="ui-grid-b" style="width: 100%; height: 45px; background-color: white; display: flex; align-items: center;">
		<div class="ui-block-a" style="width: 15%;">
			<div style="text-align: left;">
				<a href="#" data-rel="back">
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
            </div>
        </div>
        <div class="ui-block-b search_bar">
			<div class="sls_input_div">
                <input type="text" class="sls_search_bar" id="sls_search_bar" value="" placeholder="사업장명으로 검색하기" data-role="none" />
            </div>
            <div class="sls_input_cancel_div" id="sls_input_cancel">
                <%-- <img class="sls_input_cancel_img"  src="/img/store/storeList_search_cancel.svg" /> --%>
            </div>
        </div>
        <div class="ui-block-c" style="width: 17%;">
            <div style="text-align: right;">
                <div data-transition="none" class="sls_cancel" id="sls_cancel">
                    취소
                </div>
            </div>
        </div>
    </div>
    </header>
    <%@include file="/app_root/jsp/panel/panel.jsp" %>	
    <!-- content 부분 -->	
	<div id = "store_list_search_content" data-role="content" style="text-align:center; padding: 0; height: 100% !important;">
        <div class="sls_result_title_container">
            <p>검색결과</p>
        </div>

        <div class="sls_result_content">

            <div class="sls_plz_search">
                <p>검색어를 입력하세요</p>
            </div>

            <%-- <div class="sl_tab_container">
                <div class="sl_tab_container_left">
                    <div class="sl_tab_container_img">
                    </div>
                </div>
                <div class="sl_tab_container_right">
                    <div class="sl_tab_container_right_left">
                        <div class="sl_tab_title_container">
                            <div class="sl_recruitment_status" style="background: #9899AC;">모집마감</div>
                            <p class="sl_store_name">용광순 라이브 카페</p>
                        </div>
                        <div class="sl_addr">서울 종로구</div>
                        <div class="sl_perform_team">공연팀 : 모집중</div>
                        <div class="sl_hashtag_container"><span class="sl_hashtag">#술&nbsp;&nbsp;&nbsp;#무대&nbsp;&nbsp;&nbsp;</span></div>
                    </div>
                    <div class="sl_tab_container_right_right">
                        <div class="sl_perform">
                            <div class="sl_perform_date">01-08</div>
                            <div class="sl_perform_time sl_startime">13:53</div>
                            <div class="sl_perform_time sl_endtime">14:53</div>
                        </div>
                    </div>
                </div>
            </div> --%>

        </div>
    </div>
</div>