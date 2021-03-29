<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/recruit/importhead.jsp"%>
<%@include file="/service_include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/recruit/resource/css/mypage.css?ver=1.0.3" />
<script type="text/javascript" src="/recruit/resource/js/function/mypage-func.js?ver=1.0.1" ></script>

</head>
<body  onload="onLoad();">
	<%@include file="/recruit/page/web/w-header.jsp" %>
	<nav class="wrapper">
		<nav class="body">
		<%@include file="/recruit/page/common/p-header.jsp" %>
		<%@include file="/recruit/page/common/popup.jsp" %>
		<nav class="mypage-warpper">
			<p class="ft-25 ft-bold mp-title">기본 정보 수정</p>
			
			<p class="ft-lgray ft-12 subtitle">아이디</p>
			<input type="text" class="bg-lgray ft-14 mp-input" id="id" data-role="none" readonly="readonly">
			
			<p class="ft-lgray ft-12 subtitle">닉네임</p>
			<input type="text" class="ft-14 mp-input" id="nickname" data-role="none" placeholder="닉네임을 입력해주세요.">
			
			<div class="bg-purple ft-16 ft-white ft-bold btn" id="update" onclick="handlerMyPageUpdate();">수정 완료</div>
			
			<div class="bg-gray ft-16 ft-white ft-bold btn" id="logout" onclick="handlerLogout();">로그아웃</div>
		</nav>
		<%@include file="/recruit/page/common/footer.jsp" %>
		</nav>
		<%@include file="/recruit/page/web/explanation.jsp" %>
	</nav>
</body>
</html>