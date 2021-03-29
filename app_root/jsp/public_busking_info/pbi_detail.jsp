<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="pbi_detail">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
	<div id="pbi_detail_sec" data-role="content" style="text-align:center; padding: 0;">
		<div class="pbi_image_popup"><img id="pbiip_img"></div>
		<div id="bdc_pfsc_ing_body">
			<ul id="bdc_pfsc_ing_ul">
				
			</ul>
		</div>
		<ul id="bdc_img_selecter">
		</ul>
		
		<div class="pbi_ds_title" id="pbi_ds_title">
			
		</div>
		<div class="ui-grid-a pbi_ds_content">
			<div class="ui-block-a"><p class="pbi_dsc_title_1">접수기간</p></div>
			<div class="ui-block-b" id="pbi_ds_receipt_date"></div>
			<div class="ui-block-a"><p class="pbi_dsc_title_1">행사일시</p></div>
			<div class="ui-block-b" id="pbi_ds_event_date">)</div>
			<div class="ui-block-a"><p class="pbi_dsc_title_1">장소</p></div>
			<div class="ui-block-b" id="pbi_ds_area"></div>
			<div class="ui-block-a"><p class="pbi_dsc_title_1">장르</p></div>
			<div class="ui-block-b" id="pbi_ds_genre"></div>
			<div class="ui-block-a"><p class="pbi_dsc_title_1">공연비</p></div>
			<div class="ui-block-b" id="pbi_ds_pay"></div>
			<div class="ui-block-a"><p class="pbi_dsc_title_1">교통비</p></div>
			<div class="ui-block-b" id="pbi_transportation"></div>
			<div class="ui-block-a"><p class="pbi_dsc_title_1">인원</p></div>
			<div class="ui-block-b" id="pbi_ds_personnel"></div>
			<div class="ui-block-a"><p class="pbi_dsc_title_1">담당자</p></div>
			<div class="ui-block-b" id="pbi_ds_manager"></div>
			<div class="ui-block-a"><p class="pbi_dsc_title_1">연락처</p></div>
			<div class="ui-block-b" id="pbi_ds_tel"></div>
			<div class="ui-block-a"><p class="pbi_dsc_title_1">이메일</p></div>
			<div class="ui-block-b" id="pbi_ds_email"></div>
			<div class="ui-block-a"><p class="pbi_dsc_title_1">신청서</p></div>
			<div class="ui-block-b" id="pbi_ds_file"></div>
			<div class="ui-block-a"><p class="pbi_dsc_title_2">상세정보</p></div>
			<div id="pbi_ds_detail_content"></div>
		</div>
		<div id="map">
		</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>
