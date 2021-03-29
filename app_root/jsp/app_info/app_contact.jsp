<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<meta charset="UTF-8">

<div data-role="page" id="app_contact">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id="app_contact_cont" data-role="content" style="text-align:center; padding: 0;">
			<div id="app_cc_question_container">
				<!-- <p class="appContactTitle">자주 묻는 질문</p>	 -->
			<div class="ui-grid-a appContactGrid">
				<div class="ui-block-a appContactBlockA">
					<p>Q. 솔로일 경우에도 팀/솔로 신청을 해야하나요?</p>
				</div>
				<div class="ui-block-b appContactBlockB">
					<p><img src="/img/common/show_btn.svg"></p>
				</div>
			</div>
			<div class="appContactAns">
				A.<br>네. 솔로일때도 팀/솔로 신청 부분에서 내용을 작성해주셔야 티스트 활동이 가능합니다.
			</div>
			
			<div class="ui-grid-a appContactGrid">
				<div class="ui-block-a appContactBlockA">
					<p>Q. 솔로로 가입되어있어도 팀에 또 가입할 수 있나요?</p>
				</div>
				<div class="ui-block-b appContactBlockB">
					<p><img src="/img/common/show_btn.svg"></p>
				</div>
			</div>
			<div class="appContactAns">
				A.<br>네. 가능합니다.<br>
				실제 본인이 솔로 활동도 하고 팀에 속해서도 활동하고 있는 경우,<br>
				솔로로 등록하고, 팀으로도 등록을 할 수 있고, 다른 팀에 초대받을 수도 있습니다.<br>
				'팀·솔로 등록'에는 개수 제한이 없습니다.
			</div>
			
			<div class="ui-grid-a appContactGrid">
				<div class="ui-block-a appContactBlockA">
					<p>Q. 해피버스킹에 문의하고 싶어요.</p>
				</div>
				<div class="ui-block-b appContactBlockB">
					<p><img src="/img/common/show_btn.svg"></p>
				</div>
			</div>
			<div class="appContactAns">
				A. <br>1:1문의 또는 아래 메일로 문의 주시기 바랍니다. 최대한 빠르게 답변해드리겠습니다.<br>
				contact@happybusking.com
			</div>
			<%
			if (!USER_NO.equals("null")) {
			%>
			<div class="ui-grid-a appContactGrid">
				<div class="ui-block-a appContactBlockA">
					<p>Q. 해피버스킹 계정 삭제는 어떻게 하나요?</p>
				</div>
				<div class="ui-block-b appContactBlockB">
					<p><img src="/img/common/show_btn.svg"></p>
				</div>
			</div>
			<div class="appContactAns">
				<a id="delUser">계정 삭제하기</a>
			</div>

			<!-- <div class="appContactFooter">
				<p>위 내용 이외의 문의사항은<br> 아래 이메일로 보내주시면 빠르게 답변해드리겠습니다.</p>
				<p>contact@bizworks.co.kr</p>
			</div> -->
			<%
			}
			%>		
			</div>
			
			<!-- 1:1문의 -->
			<div id="app_cc_personal_container">
				<div id="main_cont" style="display: none;"></div>
				<div id="url_list_container">
				</div>
				<div class="url_write_btn" onclick="goUserRequestWrite();"><img src="/img/board/write.svg"></div>
			</div>
		</div>
		<input type="hidden" id="user_no" value="<%=USER_NO %>">
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>


