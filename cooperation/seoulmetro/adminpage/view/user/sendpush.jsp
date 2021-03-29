<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/cooperation/seoulmetro/adminpage/importhead.jsp" %>
<!DOCTYPE html>
<html>
<link type="text/css" rel="stylesheet" href="/cooperation/seoulmetro/adminpage/resource/css/user.css?ver=1.0.1" />
<script type="text/javascript" src="/cooperation/seoulmetro/adminpage/resource/js/active/sendpush.js?ver=1.0.3" ></script>
<body>
	<nav class="middle_wapper sendpush_wapper">
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/header.jsp" %>
	<nav class="middle sendpush">
		<p class="ft_34 ft_medium ml_big_title">푸시 전송</p>
		<p class="ft_17 ft_l_gray_b ml_small_title">원하는 대상에게 원하는 내용으로 푸시 전송이 가능합니다.</p>
		
		<div class="ml_input_box">
			<select class="ft_16 ft_l_black" id="push_obj">
				<option disabled="disabled" value="">대상 선택</option>
				<option selected="selected" value="M">서울메트로 소속 아티스트</option>
			</select>
			<select class="ft_16 ft_l_black" id="push_limit">
				<option disabled="disabled" value="" selected="selected">월 공연 횟수</option>
				<option value="9999">전체</option>
				<option value="3">3회 미만</option>
				<option value="5">5회 미만</option>
				<option value="7">7회 미만</option>
			</select>
			<input class="ft_16" type="text" id="push_title" placeholder="푸시 제목 입력">
			<input class="ft_16" type="text" id="push_content" placeholder="푸시 내용 입력">
		</div>
		
		<p class="ft_20 ft_white ft_medium bg_purple ml_btn cursorpointer" id="send_push_btn">보내기</p>
	</nav>
	</nav>
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/footer.jsp" %>
</body>
</html>