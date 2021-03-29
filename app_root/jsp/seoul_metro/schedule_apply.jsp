<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="schedule_apply_page">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->		
	<div id="sap_content" data-role="content">
		<div class="common_form_header_title">
			공연 일정 신청
		</div>
		<div class="common_form_main_title">
			팀선택
		</div>
		<div class="sap_area_select" id="sap_team_select">
		</div>
		<div class="common_form_main_title">
			장소선택
		</div>
		<div class="sap_area_select" id="sap_area_select">
		</div>
		<div class="common_form_main_title">
			일정선택
		</div>
		<div class="sap_calendar_info">
			<div class="sci_item sci_pos">
				<span></span><p>신청가능</p>
			</div>
			<div class="sci_item sci_impos">
				<span></span><p>신청마감</p>
			</div>
		</div>
		<div class="sci_calendar_box">
			<div class="pb-calendar" id="pb-calendar"></div>
		</div>
		<div class="common_form_main_title">
			시간선택
		</div>
		<div class="common_form_default_select_div sa_date_box">
			<select id="sci_stime">
				<option selected="selected" disabled="disabled" value="">날짜를 먼저 선택해주세요</option>
			</select>
			<select id="sci_etime">
				<option selected="selected" disabled="disabled" value="">날짜를 먼저 선택해주세요</option>
			</select>
		</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>
