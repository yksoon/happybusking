<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="team_board_update">	

	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div data-role="content">
			<input type="hidden" id="board_no">
			
			<div class="common_form_main_title">
			게시글 구분
			</div>
			<div class="common_form_default_select_div">
				<select name="team-board-update-select" id="team-board-update-select">
					<option value="1">자유</option>
					<option value="2">팀모집</option>
					<option value="3">함께공연</option>
				</select>
			</div>
			<div class="common_form_main_title">
			제목
			</div>
			<div class="common_form_input_div">
				<textarea id="board_update_title_area" rows="2" cols="" placeholder="제목을 입력해주세요.(최대 80자)"></textarea>
			</div>
			<div class="common_form_main_title">
			내용
			</div>
			<div class="common_form_input_div">
				<textarea id="board_update_subject_area" rows="7" cols="" placeholder="내용을 입력해주세요.(최대 1000자)"></textarea>
			</div>
		</div>
		
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>