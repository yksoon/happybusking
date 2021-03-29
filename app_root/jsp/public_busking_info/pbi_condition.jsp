<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="pbi_condition">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<div class="custom_select_popup" id="genre_select_popup"></div>
	<div class="custom_select_popup" id="area_select_popup"></div>
	<!-- content 부분 -->		
	<div id="pbi_condition_sec" data-role="content" style="text-align:center; padding: 0;">
		<div class="pbic_container">
			<div class="pbic_title">
				<p class="pbict_left">
					접수기간
					<span id="apply_info">?</span>
					<a class="pbictl_info apply_info">
						접수 기간 도움말 팝업
					</a>
				</p>
				<div class="pbict_right">
					<input type="checkbox" data-role="none" id="apply_date_chk"><label data-role="none" for="apply_date_chk">전체기간</label>
				</div>	
			</div>
			<div class="pbic_content apply_date_text">
				<div class="pbicc_text">
					<input type="number" data-role="none" class="pbi_adate_input" id="pbi_apply_syear">
					<span>년</span>
				</div>
				<div class="pbicc_text">
					<input type="number" data-role="none" class="pbi_adate_input" id="pbi_apply_smonth">
					<span>월</span>
				</div>
				<div class="pbicc_text">
					<input type="number" data-role="none" class="pbi_adate_input" id="pbi_apply_sday">
					<span>일</span>
				</div>
			</div>
			<div class="pbic_content apply_date_text mt10">
				<div class="pbicc_text">
					<input type="number" data-role="none" class="pbi_adate_input" id="pbi_apply_eyear">
					<span>년</span>
				</div>
				<div class="pbicc_text">
					<input type="number" data-role="none" class="pbi_adate_input" id="pbi_apply_emonth">
					<span>월</span>
				</div>
				<div class="pbicc_text">
					<input type="number" data-role="none" class="pbi_adate_input" id="pbi_apply_eday">
					<span>일</span>
				</div>
			</div>
		</div>
		<div class="pbic_container">
			<div class="pbic_title">
				<p class="pbict_left">
					행사기간
					<span id="perforn_info">?</span>
					<a class="pbictl_info perforn_info">
						행사 기간 도움말 팝업
					</a>
				</p>
				<div class="pbict_right">
					<input type="checkbox" data-role="none" id="perform_date_chk"><label data-role="none" for="perform_date_chk">전체기간</label>
				</div>	
			</div>
			<div class="pbic_content perform_date_text">
				<div class="pbicc_text">
					<input type="number" data-role="none" class="pbi_pdate_input" id="pbi_perform_syear">
					<span>년</span>
				</div>
				<div class="pbicc_text">
					<input type="number" data-role="none" class="pbi_pdate_input" id="pbi_perform_smonth">
					<span>월</span>
				</div>
				<div class="pbicc_text">
					<input type="number" data-role="none" class="pbi_pdate_input" id="pbi_perform_sday">
					<span>일</span>
				</div>
			</div>
			<div class="pbic_content perform_date_text mt10">
				<div class="pbicc_text">
					<input type="number" data-role="none" class="pbi_pdate_input" id="pbi_perform_eyear">
					<span>년</span>
				</div>
				<div class="pbicc_text">
					<input type="number" data-role="none" class="pbi_pdate_input" id="pbi_perform_emonth">
					<span>월</span>
				</div>
				<div class="pbicc_text">
					<input type="number" data-role="none" class="pbi_pdate_input" id="pbi_perform_eday">
					<span>일</span>
				</div>
			</div>
		</div>
		
		<div class="pbic_container">
			<div class="pbic_title">
				<p class="pbict_left">장르</p>
				<div class="pbict_right">
				</div>	
			</div>
			<div class="pbic_content pbic_content_100">
				<input type="hidden" id="select_genre">
				<input type="text" data-role="none" id="text_genre" readonly="readonly" value="전체" onclick="viewGenreSelectBox();">
			</div>
		</div>
		
		<div class="pbic_container">
			<div class="pbic_title">
				<p class="pbict_left">지역</p>
				<div class="pbict_right">
				</div>	
			</div>
			<div class="pbic_content pbic_content_100">
				<input type="hidden" id="select_area">
				<input type="text" data-role="none" id="text_area" readonly="readonly" value="전체" onclick="viewAreaSelectBox();">
			</div>
		</div>
		
		<div class="pbic_container">
			<div class="pbic_title">
				<p class="pbict_left">최소 공연비</p>
				<div class="pbict_right">
				</div>	
			</div>
			<div class="pbic_content pbic_content_100">
				<input type="text" data-role="none" id="pay" placeholder="0">
			</div>
		</div>
		
		<div class="pbic_container">
			<div class="pbic_title">
				<p class="pbict_left">인원</p>
				<div class="pbict_right">
				</div>	
			</div>
			<div class="pbic_content">
				<div class="pbicc_text pbicc_50">
					<span>최소</span>
					<input type="number" data-role="none" id="min_personnel">
					<span>명</span>
				</div>
				<div class="pbicc_text pbicc_50">
					<span>최대</span>
					<input type="number" data-role="none" id="max_personnel">
					<span>명</span>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>
