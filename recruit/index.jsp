<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/recruit/importhead.jsp"%>
<%@include file="/service_include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/recruit/resource/css/mypbi.css?ver=1.1.5" />
<script type="text/javascript" src="/recruit/resource/js/function/mypbi-func.js?ver=1.1.9" ></script>
<script type="text/javascript" src="/recruit/resource/js/active/mypbi.js?ver=1.1.3" ></script>
</head>
<body  onload="onLoad();">
	<%@include file="/recruit/page/web/w-header.jsp" %>
	<nav class="wrapper">
		<nav class="body">
		<%@include file="/recruit/page/common/u-header.jsp" %>
		<%@include file="/recruit/page/common/popup.jsp" %>
		<input type="hidden" id="uno" value="<%=USER_NO %>" />
		<nav class="h-pt mypbi-warpper">
			<div class="hidden" id="n-login">
				<p class="ft-lgray-c ft-20 ft-bold dinfo-title">
					해피버스킹Pick에 대해<br>자세히 알려드립니다
				</p>
				<div class="go-recruit-info" onclick="goRecruitInfoPopup();">
					<img src="/recruit/resource/img/common/info-3.png"/>	
				</div>
				<p class="ft-lgray ft-14" id="login-text">공모등록을 위하여 재로그인이 필요합니다.</p>
			</div>
			<div class="hidden" id="y-login">
				<p class="ft-black ft-18 ft-bold mi-title">내 모집 공고</p>
				<div id="mypbi-list" >
					<!-- <div class="ml-item">
						<div class="flex bg-white mi-body">
							<div class="ml-left">
								<div class="ft-black ft-15 ml-title">
									지역 연계형 청년 예술활동 지원사업 아티스트, 15개의 서울 ~!!~@!$!@$#@!$
								</div>
								<p class="ft-12 ft-lgray ml-date">등록일 : 2020.06.05<span class="ft-12 ft-purple">모집중</span></p>
							</div>
							<div class="ml-right">
								<img src="/recruit/resource/img/common/leftarrow-gray.svg"/>
							</div>
						</div>
						<div class="flex mi-footer">
							<div class="bg-white mi-button">
								<span class="ft-gray ft-15">신청자</span><span class="ft-purple ft-15 ft-bold mi-count">12명</span>
							</div>
							<div class="bg-white mi-button">
								<span class="ft-gray ft-15">채점자</span><span class="ft-purple ft-15 ft-bold mi-count">9명</span>
							</div>
						</div>
					</div> -->
				</div>
				<div class="go-recruit-info hidden" onclick="goRecruitInfoPopup();">
					<img src="/recruit/resource/img/common/info-3.png"/>	
				</div>
				<div class="middle_pagenum_wapper">
					<div class="middle_pagenum flex" id="paging">
					</div>
				</div>
			</div>
		</nav>
		<div class="bg-purple ft-white ft-15 ft-bold go-login" onclick="goLogin();">로그인</div>
		<%@include file="/recruit/page/common/footer.jsp" %>
		</nav>
		<%@include file="/recruit/page/web/explanation.jsp" %>
	</nav>
</body>
</html>