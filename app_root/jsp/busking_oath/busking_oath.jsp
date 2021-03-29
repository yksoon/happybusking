<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="buskingOath" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
	<div data-role="content" id="buskingOathContent" style="text-align: center; padding: 0;">
		<div class="bocTitleContainer">
			<p class="bocSmallTitle">올바른 버스킹 문화 만들기 캠페인</p>
			<p class="bocBigTitle">버스커선서</p>
			<p class="bocUnderLine"></p>
		</div>
		<div class="bocContentContainer">
			<p class="bocNormalContent">나는 관객에게 존중과 감사의 마음을 드리겠습니다.</p>
			<p class="bocNormalContent">나는 준비된 공연 만을 대중에게 선보이겠습니다.</p>
			<p class="bocNormalContent">나는 나의 예술이 소음이 되지 않도록 주의하겠습니다.</p>
			<p class="bocNormalContent">나는 시각적, 행위적 공해가 되는 공연은 하지 않겠습니다.</p>
			<p class="bocNormalContent">나는 공연장소의 독점과 무리한 경쟁을 하지 않겠습니다.</p>
			<p class="bocNormalContent">나는 타 버스커의 공연을 존중하며,폄하하지 않겠습니다.</p>
			<p class="bocNormalContent">나는 주변 상인의 입장을 헤아리며,배려하겠습니다.</p>
			<p class="bocNormalContent">나는 공연 후 주변 환경 정리를 철저히 하겠습니다.</p>
			<p class="bocNormalContent">나는 관객의 안전에도 각별히 신경을 쓰겠습니다.</p>
			<p class="bocNormalContent">나는 행인들의 통행을 방해하는 공연은 하지 않겠습니다.</p>
			<p class="bocBoldContent">이상의 서약을 나의 자유 의사로 나의 명예를 받들어 합니다.</p>
		</div>
		
		<!-- 이미 동의 한 경우  -->
		<div class="bocBtn bocBtnOK">
			이미 동의하였습니다.
		</div>
		<!-- 동의 안한 경우 -->
		<div class="bocBtn bocBtnNotOK">
			<img src="/img/busking_oath/check.svg">
			선서 내용에 모두 동의
		</div>
		
		<p class="bocAfterViewBtn">나중에 다시보기</p>	
		<p class="source_text">본 선서문은 배포가 가능하나 <br> <span class="source_text_line">"출처 : 해피버스킹(happybusking.com)"</span> 을 기재해주세요.</p>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>