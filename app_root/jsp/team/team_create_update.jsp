<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="team_create_update">	

	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<%@include file="/app_root/jsp/common/resize_image.jsp" %>
		<!-- content 부분 -->		
	<div id = "team_create_update_sec" data-role="content" style="text-align:center; padding: 0; margin-bottom: 35px;">
	<div class="custom_select_popup" id="genre_select_popup">
	</div>
	<form id = "team_create_form" method="post" enctype = "multipart/form-data">
	<input type="hidden" id="user_no" value="<%=USER_NO %>">
	<input type="hidden" id="t_type" name="t_type">
	<input type="hidden" id="team_no" />
		<div class="team_create_title"  style="padding-bottom: 15px; border-top: 1px solid #f3f1f3;">
			팀/솔로 대표 메인사진 등록
		</div>
		<div id="team_create_img">
			<img id="img_preview"/>
			<input type="hidden" id="img_name"/>
		</div>
		<input type="file" id="tcreate_img" name="tcreate_img" accept="image/*">
		<div class="team_create_title">
			팀/솔로명 입력
		</div>
		<div class="team_create_content">
			<input type="text" class="team_create_text" id="t_name" name="t_name" placeholder="팀/솔로로 활동할 이름을 입력해주세요">
		</div>
		<div class="team_create_title">
			소개
		</div>
		<div class="team_create_content">
			<textarea rows="2" cols="2" class="team_create_text" id="t_content" name="t_content" placeholder="소개를 입력해주세요"></textarea>
		</div>
		<div class="team_create_title">
			장르
		</div>
		<div class="common_form_select_div" id="genre-select-box">
			<input type="text" id="text_genre" placeholder="장르 선택" readonly="readonly" onclick="viewGenreSelectBox();">
			<input type="hidden" id="select_genre">
			<input type="hidden" id="main_genre">
			<input type="hidden" id="add_genre">
		</div>
		<div class="team_create_title">
			주활동지역
		</div>
		<div id="area-select-box2">
			<select name="area-select" id="area-select">
			</select>
		</div>
		<div class="team_create_title">
			희망 페이(시간당)
		</div>
		<div class="team_create_content">
			<input type="text" class="team_create_text" id="t_pay" name="t_pay" value="0">
		</div>
		</form>
		
		<div class="team_create_title">
			구성원
		</div>
		<div id="team_member_addBtn">
			추가하기
		</div>
		<!-- 추가되는 멤버 -->		
		<div id="team_member_add_div">
			<div class="ui-grid-a" id="team_member_count">
				<div class="ui-block-a">등록인원:</div>
				<div class="ui-block-b">총 0명</div>
			</div>
			<div class="team_member_content">
				<div id="team_member_content">
					
				</div>
			</div>
		</div>
		
		<!-- 동영상 URL 추가부분 -->
		<div class="team_create_title">대표 동영상 등록(선택사항)</div>
		<div id="team_create_video">
			<div id="tc_video_content">
				<div id="tc_video_intro">
					<textarea rows="5" id="tc_video_textarea" placeholder="동영상 소개를 입력해주세요"></textarea>
				</div>
			</div>
		</div>
		
		<div class="common_form_input_div" style="display: flex; justify-content: space-between;">
			<select id="video_select" data-role="none" style="border: 1px solid #dddddd; border-radius: 5;">
				<option value="url" selected>URL</option>
				<option value="file">파일</option>
			</select>
			<input type="text" data-role="none" style="width: 75vw;" class="team_create_text" id="tc_video_url" name="tc_video_url" placeholder="동영상 링크를 입력해주세요(유튜브 링크만 가능)">
			<input type="file" data-role="none" style="width: 75vw;" class="team_create_text" id="tc_video_file" name="tc_video_file" placeholder="동영상 파일을 선택해주세요." accept="video/*">
		</div>
		
		<div class="common_form_info_conatiner" id="url_warning">
			<p>- 동영상 등록 안내사항</p>
			<p>동영상 개별 URL만 등록 가능합니다.<br>
				<span>유튜브 채널 주소는 등록해도 해피버스킹 앱에서는 노출되지 않습니다.</span></p>
			<p>꼭 ! 동영상 개별 주소를 입력해주세요~</p>
		</div>
		
		<div class="common_form_info_conatiner" id="file_warning" style="display: none;">
			<p>- 동영상 등록 안내사항</p>
			<p>동영상 파일만 등록 가능합니다.<br>
				<span>등록하신 동영상 파일이 해피버스킹 유튜브에 업로드됩니다.</span></p>
		</div>
		<div style="font-size: 12px; margin-top: 34px;"></div>
		<div style="font-size: 12px;">
		</div>
		<div style="font-size: 12px; margin-bottom: 25px;"></div>
		
	</div>
	
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
		<!-- 멤버 추가하기 팝업 -->
	<div data-role="popup" id="team_member_add_popup">
			<div id="tm_add_popup_header">
				<img src="/img/team/cancle2.png" id="tm_add_popup_close">
			</div>
			<div id="tm_add_popup_body">
				<div id="tm_add_search">
					<input type="number" style="text-indent: 31px;" class="team_create_text" id="tm_member_phone" placeholder="휴대폰번호 입력 후 엔터로 검색(-제외)" maxlength="10">
					<div id="tm_search_img"></div>
				</div>
				<div id="tm_add_popup_content">
					
				</div>
				<div id="tm_add_list">
					
				</div>
			</div>
			<div class="ui-grid-a" id="tm_add_popup_footer">
				<div class="ui-block-a" id="tm_member_add_btn">추가하기</div>
			</div>
		</div>
</div>