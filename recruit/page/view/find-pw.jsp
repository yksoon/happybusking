<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/recruit/importhead.jsp"%>
<%@include file="/service_include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/recruit/resource/css/find.css?ver=1.0.3" />
<script type="text/javascript" src="/recruit/resource/js/function/find-func.js?ver=1.0.2" ></script>
<script type="text/javascript" src="/recruit/resource/js/active/find.js?ver=1.0.3" ></script>

</head>
<body  onload="onLoad();">
	<%@include file="/recruit/page/web/w-header.jsp" %>
	<nav class="wrapper">
		<nav class="body">
		<%@include file="/recruit/page/common/p-header.jsp" %>
		<%@include file="/recruit/page/common/popup.jsp" %>
		<nav class="find-pw-warpper">
			<p class="ft-25 ft-bold fp-title">설정한 이메일로<br>비밀번호 찾기</p>
			
			<p class="ft-lgray ft-12 subtitle">이메일</p>
			<div class="flex bg-white fp-input-box">
				<input type="text" class="ft-14 mp-input" id="email" data-role="none" placeholder="이메일 입력">
				<p class="bg-white ft-purple ft-14 ft-bold fpi-btn" id="go-id-chk">인증하기</p>
			</div>
			
			<p class="ft-lgray ft-12 subtitle">인증번호</p>
			<div class="flex bg-white fp-input-box">
				<input type="text" class="ft-14 mp-input" id="enumber" data-role="none" placeholder="이메일에 전송된 인증번호를 입력">
				<p class="bg-white ft-purple ft-14 ft-bold fpi-btn" id="go-number-chk">인증확인</p>
			</div>
		</nav>
		<div class="bg-purple ft-16 ft-white ft-bold btn" id="pw-update" >비밀번호 변경</div>
		<%@include file="/recruit/page/common/footer.jsp" %>
		</nav>
		<%@include file="/recruit/page/web/explanation.jsp" %>
	</nav>
</body>
</html>