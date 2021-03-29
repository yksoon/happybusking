<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/cooperation/seoulmetro/adminpage/importhead.jsp" %>
<!DOCTYPE html>
<html>
<link type="text/css" rel="stylesheet" href="/cooperation/seoulmetro/adminpage/resource/css/metroartist.css?ver=1.0.0" />
<script type="text/javascript" src="/cooperation/seoulmetro/adminpage/resource/js/active/metroartistdetail.js?ver=1.0.2" ></script>
<body>
	<nav class="middle_wapper metroartistdetail_wapper">
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/header.jsp" %>
	<nav class="middle metroartistdetail">
		<p class="ft_20 ft_medium detail_title">소속 아티스트 정보</p>
		<table class="detail_table">
			<tr>
				<th class="ft_15 bg_r_gray dt_th">팀명</th><td class="ft_15 dt_td" id="md_tname"></td>
				<th class="ft_15 bg_r_gray dt_th">팀대표 생년월일</th><td class="ft_15 dt_td" id="md_birth"></td>
			</tr>
			<tr>
				<th class="ft_15 bg_r_gray dt_th">팀대표 HP</th><td class="ft_15 dt_td" id="md_phone"></td>
				<th class="ft_15 bg_r_gray dt_th">팀대표 E-MAIL</th><td class="ft_15 dt_td" id="md_email"></td>
			</tr>
			<tr>
				<th class="ft_15 bg_r_gray dt_th">장르</th><td class="ft_15 dt_td" id="md_genre"></td>
				<th class="ft_15 bg_r_gray dt_th">활동지역</th><td class="ft_15 dt_td" id="md_area"></td>
			</tr>
			<tr>
				<th class="ft_15 bg_r_gray dt_th">월 공연 횟수</th><td class="ft_15 dt_td" id="md_count"></td>
			</tr>
			<tr><th colspan="4" class="ft_15 bg_r_gray dt_th">팀 소개</th></tr>
			<tr>
				<td colspan="4" class="ft_15 dt_content" id="md_content">
				</td>
			</tr>
			<tr>
				<th class="ft_15 bg_r_gray dt_th">팀 소개 영상</th><td colspan="3" class="ft_15 ft_blue dt_td dt_video" id="md_video"></td>
			</tr> 
		</table>
		<p class="ft_14 bg_purple ft_white cursorpointer detail_btn go_back_btn">목록으로</p>
	</nav>
	</nav>
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/footer.jsp" %>
</body>
</html>