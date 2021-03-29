<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/recruit/importhead.jsp"%>
<%@include file="/service_include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/recruit/resource/css/applicant.css?ver=1.0.6" />
<script type="text/javascript" src="/recruit/resource/js/function/applicant-func.js?ver=1.0.5" ></script>
<script type="text/javascript" src="/recruit/resource/js/active/applicant-detail.js?ver=1.0.7" ></script>

</head>
<body  onload="onLoad();">
	<%@include file="/recruit/page/web/w-header.jsp" %>
	<nav class="wrapper">
		<nav class="body">
		<%@include file="/recruit/page/common/p-header.jsp" %>
		<%@include file="/recruit/page/common/popup.jsp" %>
		<nav class="p-pt applicant-detail-warpper">
			<p class="ft-black ft-20 ft-bold" id="ad-title"></p>
			<table id="ad-info">
				<tr>
					<th class="bg-lgray ft-gray ft-12 ft-bold">신청자</th>
					<td class="bg-white ft-14" id="name"></td>
				</tr>
				<tr>
					<th class="bg-lgray ft-gray ft-12 ft-bold">팀명</th>
					<td class="bg-white ft-14" id="tname"></td>
				</tr>
				<tr>
					<th class="bg-lgray ft-gray ft-12 ft-bold">팀 대표 HP</th>
					<td class="bg-white ft-14" id="tel"></td>
				</tr>
				<tr>
					<th class="bg-lgray ft-gray ft-12 ft-bold">장르</th>
					<td class="bg-white ft-14" id="genre"></td>
				</tr>
				<tr>
					<th class="bg-lgray ft-gray ft-12 ft-bold">생년월일</th>
					<td class="bg-white ft-14" id="birth"></td>
				</tr>
				<tr>
					<th class="bg-lgray ft-gray ft-12 ft-bold">월 공연 횟수</th>
					<td class="bg-white ft-14" id="count"></td>
				</tr>
				<tr>
					<th class="bg-lgray ft-gray ft-12 ft-bold">팀대표 E-mail</th>
					<td class="bg-white ft-14" id="email"></td>
				</tr>
				<tr>
					<th class="bg-lgray ft-gray ft-12 ft-bold">활동지역</th>
					<td class="bg-white ft-14" id="area"></td>
				</tr>
				<tr>
					<th class="bg-lgray ft-gray ft-12 ft-bold">팀소개</th>
					<td class="bg-white ft-14" id="info"></td>
				</tr>
				<tr>
					<th class="bg-lgray ft-gray ft-12 ft-bold">팀 소개 영상</th>
					<td class="bg-white ft-14" id="url"></td>
				</tr>
			</table>
			
			<nav class="hidden" id="ad">
				<div class="flex ad-btn-container">
					<input type="number" class="bg-white ft-16 w-48" id="score" placeholder="점수입력 (ex.100)"/> 
					<div class="bg-purple ft-white ft-16 ft-bold w-48" id="score-apply" onclick="handlerScoreAplly();">점수 등록</div>
				</div>
			</nav>
			<nav class="hidden" id="sd">
				<div class="bg-purple ft-white ft-16 ft-bold btn" id="send">합격 통보하기</div>
			</nav>
		</nav>
		<%@include file="/recruit/page/common/footer.jsp" %>
		</nav>
		<%@include file="/recruit/page/web/explanation.jsp" %>
	</nav>
</body>
</html>