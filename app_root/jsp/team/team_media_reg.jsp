<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="team_media_reg">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
	<div id = "team_media_reg_sec" data-role="content">
		<p class="tmr_title">팀선택</p>
		<select class="tmr_tselect" id="tmr_tselect">
			
		</select>
		
		<p class="tmr_title">사진 업로드 (최대 20장)</p>
		<div id="tmr_picture_add_btn">
			<img src="/img/team/img_add.svg">
			사진 추가
		</div>
		
		<div class="ui-grid-c tmr_picture_container">
			<div class="ui-block-a tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_0">
			</div>
			<div class="ui-block-b tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_1">
			</div>
			<div class="ui-block-c tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_2">
			</div>
			<div class="ui-block-d tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_3">
			</div>
			<div class="ui-block-a tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_4">
			</div>
			<div class="ui-block-b tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_5">
			</div>
			<div class="ui-block-c tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_6">
			</div>
			<div class="ui-block-d tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_7">
			</div>
			<div class="ui-block-a tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_8">
			</div>
			<div class="ui-block-b tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_9">
			</div>
			<div class="ui-block-c tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_10">
			</div>
			<div class="ui-block-d tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_11">
			</div>
			<div class="ui-block-a tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_12">
			</div>
			<div class="ui-block-b tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_13">
			</div>
			<div class="ui-block-c tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_14">
			</div>
			<div class="ui-block-d tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_15">
			</div>
			<div class="ui-block-a tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_16">
			</div>
			<div class="ui-block-b tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_17">
			</div>
			<div class="ui-block-c tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_18">
			</div>
			<div class="ui-block-d tmr_picture_block">
				<div class="tmr_picture_del_btn">
					<img src="/img/team/img_del.svg">
				</div>
				<img class="tmr_picture">
				<input class="tmr_picture_file" type="file" id="tmr_picture_19">
			</div>
			<input type="file" id="tmr_image" style="display: none" multiple="multiple" accept="image/*" maxlength="20">
		</div>
		
		<p class="tmr_title">유튜브 동영상 업로드 (최대 10개)</p>
		<div id="tmr_video_add_btn">
			<img src="/img/team/img_add.svg">
			동영상 추가
		</div>
		
		<div class="tmr_video_info">
			<p class="tmr_vi_title">- 동영상 등록 안내사항</p>
			<p class="tmr_vi_content">동영상 개별 URL만 등록 가능합니다.<br>
										유튜브 채널 주소는 등록해도 해피버스킹 앱에서는 노출되지 않습니다.<br><br>
										꼭 ! 동영상 개별 주소를 입력해주세요~
		</div>
		
		<div class="tmr_video_container">
			<div class="tmr_video">
				<input type="text" class="tmr_video_link" placeholder="동영상 링크를 입력해주세요(유튜브 링크만 가능)">
				<textarea rows="3" cols="" class="tmr_video_content" placeholder="동영상 소개를 입력해주세요"></textarea>
			</div>
		</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>