<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/cooperation/seoulmetro/adminpage/importhead.jsp" %>
<!DOCTYPE html>
<html>
<link type="text/css" rel="stylesheet" href="/cooperation/seoulmetro/adminpage/resource/css/metroartist.css?ver=1.0.4" />
<script type="text/javascript" src="/cooperation/seoulmetro/adminpage/resource/js/active/applymanagedetail.js?ver=1.0.5" ></script>
<body>
	<nav class="middle_wapper applymanagedetail_wapper">
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/header.jsp" %>
	<nav class="middle applymanagedetail">
		<p class="ft_20 ft_medium detail_title">신청 관리</p>
		<table class="detail_table">
			<tr>
				<th class="ft_15 bg_r_gray dt_th">신청자</th><td class="ft_15 dt_td" id="ad_name"></td>
				<th class="ft_15 bg_r_gray dt_th">생년월일</th><td class="ft_15 dt_td" id="ad_birth"></td>
			</tr>
			<tr>
				<th class="ft_15 bg_r_gray dt_th">팀명</th><td class="ft_15 dt_td" id="ad_tname"></td>
				<th class="ft_15 bg_r_gray dt_th">월 공연 횟수</th><td class="ft_15 dt_td" id="ad_count"></td>
			</tr>
			<tr>
				<th class="ft_15 bg_r_gray dt_th">팀대표 HP</th><td class="ft_15 dt_td" id="ad_phone"></td>
				<th class="ft_15 bg_r_gray dt_th">팀대표 E-MAIL</th><td class="ft_15 dt_td" id="ad_email"></td>
			</tr>
			<tr>
				<th class="ft_15 bg_r_gray dt_th">장르</th><td class="ft_15 dt_td" id="ad_genre"></td>
				<th class="ft_15 bg_r_gray dt_th">활동지역</th><td class="ft_15 dt_td" id="ad_area"></td>
			</tr>
			<tr><th colspan="4" class="ft_15 bg_r_gray dt_th">팀 소개</th></tr>
			<tr>
				<td colspan="4" class="ft_15 dt_content" id="ad_content">
				</td>
			</tr>
			<tr>
				<th class="ft_15 bg_r_gray dt_th">팀 소개 영상</th><td colspan="3" class="ft_15 ft_blue dt_td dt_video" id="ad_video"></td>
			</tr> 
		</table>
		<input type="hidden" id="ad_teamno">
		<input type="hidden" id="ad_belong">
		<div class="ad_btn_box flex">
			<p class="ft_14 bg_navy ft_white cursorpointer detail_btn" id="y_btn">수락</p>
			<p class="ft_14 bg_r_gray ft_white cursorpointer detail_btn" id="n_btn">거절</p>
		</div>
		<p class="ft_14 bg_purple ft_white cursorpointer detail_btn go_back_btn">목록으로</p>
	</nav>
	</nav>
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/footer.jsp" %>
</body>
</html>