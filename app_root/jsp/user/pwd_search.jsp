<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="pwd_search" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
	<div data-role="content" style="text-align: center; padding: 0;">
		<div style=" padding: 30px 15px;">
			<p class="pwd_search_header">설정한 이메일로 찾기</p>
			<div class="pwd_search_title">
				이메일
			</div>
			<div class="ui-grid-a" id="pwdSearch_Email_div">
				<div class="ui-block-a pwd_search_content" style="width: 75%;">
					<input type="text" class="pwd_search_text" id="pwdSearch_Email" name="pwdSearch_Email" placeholder="이메일을 입력해주세요.">
				</div>
				<div class="ui-block-b pwd_search_content" style="width: 23%; line-height: 2.4; background: #8354c8; border-radius:5px; color: #fff; font-weight: bold; margin-left: 5px; font-size: 13px;">
					<div id="pwdSearch_certBtn">인증하기</div>
				</div>
			</div>
			<div id="pwdSearch_certNo_div">
				<div class="pwd_search_title">
					인증번호 
				</div>
				<div class="ui-grid-a">
					<div class="ui-block-a pwd_search_content" style="width: 75%;">
						<input type="text" class="pwd_search_text" id="pwdSearch_certNo" name="pwdSearch_certNo" placeholder="이메일에 전송된 인증번호를 입력해주세요.">
					</div>
					<div class="ui-block-b pwd_search_content" style="width: 23%; line-height: 2.4; background: #8354c8; border-radius:5px; color: #fff; font-weight: bold; margin-left: 5px; font-size: 13px;">
						<div id="pwdSearch_certNoBtn">인증확인</div>
					</div>
				</div>
			</div>	
		</div>
		<div class="pwdSearchBtnForm" id="pwdSearchBtn">
			비밀번호 찾기
		</div>		
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>