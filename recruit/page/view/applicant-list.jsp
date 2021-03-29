<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/recruit/importhead.jsp"%>
<%@include file="/service_include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/recruit/resource/css/applicant.css?ver=1.0.4" />
<script type="text/javascript" src="/recruit/resource/js/active/applicant-list.js?ver=1.1.0" ></script>
<script type="text/javascript" src="/recruit/resource/js/function/applicant-func.js?ver=1.1.1" ></script>

</head>
<body  onload="onLoad();">
	<%@include file="/recruit/page/web/w-header.jsp" %>
	<nav class="wrapper">
		<nav class="body">
		<%@include file="/recruit/page/common/p-header.jsp" %>
		<%@include file="/recruit/page/common/popup.jsp" %>
		<nav class="p-pt applicant-list-warpper">
			<p class=" ft-18 ft-bold" id="al-title">2020 유니브엑스포 서울,영롱(YOUNGLONG)하게 빛나리 공연…</p>
			<div class="flex al-header">
				<p class=" ft-14 ft-bold al-header-title">전체 <span class="ft-purple ft-14 ft-bold" id="al-all-count">322</span></p>
				<select data-role="none" id="filter">
					<option value="" selected>전체</option>
					<option value="n">점수 없음</option>
					<option value="a">점수 있음</option>
				</select>
			</div>
			<table id="al-list">
			</table>
			<div class="middle_pagenum_wapper">
				<div class="middle_pagenum flex" id="paging">
				</div>
			</div>
		</nav>
		<%@include file="/recruit/page/common/footer.jsp" %>
		</nav>
		<%@include file="/recruit/page/web/explanation.jsp" %>
	</nav>
</body>
</html>