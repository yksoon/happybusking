<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="team_board_view">	

	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div data-role="content">
		<input type="hidden" id="user_no" value="<%=USER_NO %>">
		<div class="ui-grid-a" id="team_board_view_title">
			
		</div>
		<div id="team_board_view_content">
		</div>
		
		<!-- 댓글 보는 창  -->
		<div id="team_board_reply_view">
			<div id="tb_reply_view_header">
				<div class="ui-grid-a">
					<div class="ui-block-a" id="tb_reply_view_header_a"></div>
					<div class="ui-block-b" id="tb_reply_view_header_b">
						<img id="reply_refresh" src="/img/board/reply_refresh.svg">
					</div>
				</div>
			</div>
			<div id="tb_reply_view_body">
			
			</div>
		</div>
		
			
		<!-- 댓글 작성 창  -->
		<div id="team_board_reply_write">
			<div id="tb_reply_write_header">
				<div class="ui-grid-a">
					<div class="ui-block-a" id="tb_reply_write_header_a">댓글 작성</div>
					<div class="ui-block-b" id="tb_reply_write_header_b">닫기</div>
				</div>
			</div>
			<div id="tb_reply_write_content">
				<textarea id="tb_reply_write_area" rows="4" cols="" placeholder="댓글을 입력해주세요."></textarea>
			</div>
			<div id="tb_reply_write_btn">댓글등록</div>
		</div>
		
		<!-- 댓글 수정 창  -->
		<div id="team_board_reply_update">
			<div id="tb_reply_update_header">
				<div class="ui-grid-a">
					<div class="ui-block-a" id="tb_reply_update_header_a">댓글 수정</div>
					<div class="ui-block-b" id="tb_reply_update_header_b">닫기</div>
				</div>
			</div>
			<div id="tb_reply_update_content">
				<textarea id="tb_reply_update_area" rows="4" cols=""></textarea>
			</div>
			<div id="tb_reply_update_btn">댓글수정</div>
		</div>
	</div>
	
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>