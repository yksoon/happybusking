<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/recruit/importhead.jsp"%>
<%@include file="/service_include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/recruit/resource/css/score.css?ver=1.0.6" />
<script type="text/javascript" src="/recruit/resource/js/function/score-func.js?ver=1.1.0" ></script>
<script type="text/javascript" src="/recruit/resource/js/active/score-list.js?ver=1.0.8" ></script>

</head>
<body  onload="onLoad();">
	<%@include file="/recruit/page/web/w-header.jsp" %>
	<nav class="wrapper">
		<nav class="body">
		<%@include file="/recruit/page/common/p-header.jsp" %>
		<%@include file="/recruit/page/common/popup.jsp" %>
		<nav class="p-pt score-list-warpper">
			<p class=" ft-18 ft-bold" id="sl-title"></p>
			<div class="flex sl-header">
				<p class=" ft-14 ft-bold sl-header-title">선택팀 <span class="ft-purple ft-14 ft-bold sl-select-count">0</span></p>
				<select data-role="none" id="filter">
					<option value="" selected>고득점자 순</option>
					<option value="date">신청일 순</option>
				</select>
			</div>
			<table id="sl-list">
				<tr>
					<th class="ft-gray ft-12 ft-bold" style="width: 15%;">선택</th>
					<th class="ft-gray ft-12 ft-bold" style="width: 15%;">점수</th>
					<th class="ft-gray ft-12 ft-bold">팀명</th>
					<th class="ft-gray ft-12 ft-bold" style="width: 20%;">유튜브</th>
				</tr>		
			</table>
			<div class="middle_pagenum_wapper">
				<div class="middle_pagenum flex" id="paging">
				</div>
			</div>
			<div class="bg-purple ft-white ft-16 ft-bold btn" id="all-send" onclick="allSend();">(<span class="ft-white ft-16 ft-bold sl-select-count">0</span>)팀에 합격 통보하기</div>
		</nav>
		<%@include file="/recruit/page/common/footer.jsp" %>
		</nav>
		<%@include file="/recruit/page/web/explanation.jsp" %>
	</nav>
</body>
</html>