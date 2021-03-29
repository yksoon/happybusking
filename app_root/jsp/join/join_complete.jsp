<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="join_complete">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id="join_complete_content" data-role="content" style="text-align:center;">
			<img class="jcc_img" src="/img/join/done.svg">
			<p class="jcc_body_main_text">회원가입 완료!</p>
			<p class="jcc_body_sub_text"><span id="join_nickname"></span>님, 안녕하세요</p>
			
			<p class="jcc_footer_text jcc_footer_text_first">아티스트로 등록하려면</p>
			<p class="jcc_footer_text"><b>아티스트 되기</b> 버튼을 눌러주세요.
			
			<div class="jcc_btn_div">
				<div class="jcc_btn" id="jcc_artist_btn">아티스트 되기</div>
				<div class="jcc_btn" id="jcc_owner_btn">사업주 되기</div>
				<div class="jcc_btn" id="jcc_after_btn">나중에</div>
			</div>
			
		</div>
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>