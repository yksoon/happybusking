<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="new_pwd" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
	<div data-role="content" style="text-align: center; padding: 0;">
		<div style=" padding: 30px 15px;">
			<p class="new_pwd_header">새로운 비밀번호를 설정해주세요</p>
			<div class="new_pwd_title">
				비밀번호
			</div>
			<div class="new_pwd_content">
				<input type="password" class="new_pwd_text" id="new_PW" name="new_PW" placeholder="********">
			</div>
			<div class="new_pwd_title">
				비밀번호 확인
			</div>
			<div class="new_pwd_content">
				<input type="password" class="new_pwd_text" id="new_PW2" name="new_PW2" placeholder="********">
			</div>
			<p id="new_pwd_chk"></p>
		</div>
	</div>
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>