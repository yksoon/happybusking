<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="myrecruit" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
	<div data-role="content" id="myRecruitContent">
		<div class="mr-container" id="mr-list">
			<div class="mr-item">
				<p class="mri-title">2020 유니브엑스포 서울, 영롱(YOUNGLONG)2020 유니브엑스포 서울, 영롱(YOUNGLONG)</p>
				<p class="mri-tname">Stupeo(스투페오)</p>
				<p class="mri-date">2020년 6월 29일 신청완료</p>
				<div class="mri-btn-container">
					<div class="mri-btn mri-unp">결과 미발표</div>
					<div class="mri-btn mri-cancel">신청취소</div>
				</div>
			</div>
			<div class="mr-item">
				<p class="mri-title">2020 유니브엑스포 서울, 영롱(YOUNGLONG)2020 유니브엑스포 서울, 영롱(YOUNGLONG)</p>
				<p class="mri-tname">Stupeo(스투페오)</p>
				<p class="mri-date">2020년 6월 29일 신청완료</p>
				<div class="mri-btn-container">
					<div class="mri-btn mri-pass">합격</div>
					<div class="mri-btn mri-notcancel">취소불가</div>
				</div>
			</div>
			<div class="mr-item">
				<p class="mri-title">선유도 버스킹</p>
				<p class="mri-tname">신청팀명</p>
				<p class="mri-date">2020년 6월 29일 신청완료</p>
				<div class="mri-btn-container">
					<div class="mri-btn mri-fail">불합격</div>
					<div class="mri-btn mri-notcancel">취소불가</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>