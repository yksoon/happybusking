<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/cooperation/seoulmetro/adminpage/importhead.jsp" %>
<!DOCTYPE html>
<html>
<link type="text/css" rel="stylesheet" href="/cooperation/seoulmetro/adminpage/resource/css/user.css?ver=1.0.1" />
<script type="text/javascript" src="/cooperation/seoulmetro/adminpage/resource/js/active/login.js?ver=1.0.0" ></script>
<body>
	<nav class="middle_wapper login_wapper">
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/header.jsp" %>
	<nav class="middle login">
		<p class="ft_34 ft_medium ml_big_title">관리자 로그인</p>
		<p class="ft_17 ft_l_gray_b ml_small_title">해피버스킹 관리자 사이트에 오신 것을 환영합니다.</p>
		
		<div class="ml_input_box">
			<input class="ft_16" type="text" id="id" placeholder="아이디">
			<input class="ft_16" type="password" id="pw" placeholder="비밀번호">
		</div>
		
		<p class="ft_20 ft_white ft_medium bg_purple ml_btn cursorpointer" id="login_btn">로그인</p>
		<p class="ft_14 ft_light ft_gray ml_tel">문의전화 : 02-780-2330</p>
	</nav>
	</nav>
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/footer.jsp" %>
</body>
</html>