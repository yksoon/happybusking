<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/recruit/importhead.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/recruit/resource/css/join.css?ver=1.0.6" />
<script type="text/javascript" src="/recruit/resource/js/function/join-func.js?ver=1.0.1" ></script>

</head>
<body  onload="onLoad();">
	<%@include file="/recruit/page/web/w-header.jsp" %>
	<nav class="wrapper">
		<nav class="body">
		<%@include file="/recruit/page/common/p-header.jsp" %>
		<%@include file="/recruit/page/common/popup.jsp" %>
		<nav class="h-pt join-warpper">
			<!-- <p class="ft-black ft-16 ft-medium title">해피버스킹 로그인</p> -->
			
			<p class="ft-gray-b ft-12 subtitle">이메일</p>
			<input type="text" data-role="none" class="bg-white ft-black ft-14" id="id" placeholder="이메일(example@happybuksing.com)" onkeyup="spaceBreak(this);"/>
			
			<p class="ft-gray-b ft-12 subtitle">비밀번호</p>
			<input type="text" data-role="none" class="bg-white ft-black ft-14" id="pw" placeholder="비밀번호를 입력해주세요." onkeyup="spaceBreak(this);" maxlength="20"/>
			
			<p class="ft-gray-b ft-12 subtitle">닉네임</p>
			<input type="text" data-role="none" class="bg-white ft-black ft-14" id="nickname" placeholder="닉네임을 입력해주세요." onkeyup="spaceBreak(this);" maxlength="8"/>
			
			<p class="ft-gray-b ft-12 title">이용약관</p>
			<div class="terms-container">
				<div class="flex terms-colum-top bg-lgray">
					<input type="checkbox" id="allchk" data-role="none"/><label class="ft-15 ft-bold" data-role="none" for="allchk">이용 약관에 전체 동의합니다.</label>
				</div>
				<div class="terms-body">
					<div class="flex terms-colum bg-white">
						<input type="checkbox" id="stchk" name="terms" data-role="none"/><label class="ft-gray-b" data-role="none" for="stchk">이용약관 동의(필수)</label>
						<p class="ft-12 ft-purple terms-moreview" onclick="goServiceTerms();">내용 보기</p>
					</div>
					<div class="flex terms-colum bg-white">
						<input type="checkbox" id="itchk" name="terms" data-role="none"/><label class="ft-gray-b" data-role="none" for="itchk">개인정보 처리 및 취급방침 동의(필수)</label>
						<p class="ft-12 ft-purple terms-moreview" onclick="goPersonalInfoTerms();">내용 보기</p>
					</div>
					<div class="flex terms-colum bg-white">
						<input type="checkbox" id="ltchk" name="terms" data-role="none"/><label class="ft-gray-b" data-role="none" for="ltchk">위치기반 서비스 이용약관 동의(필수)</label>
						<p class="ft-12 ft-purple terms-moreview" onclick="goLocationTerms();">내용 보기</p>
					</div>
				</div>
			</div>
			
			<div class="bg-purple ft-white ft-16 ft-bold btn" id="join" onclick="handlerJoin();">등록 완료</div>
		</nav>
		<%@include file="/recruit/page/common/footer.jsp" %>
		</nav>
		<%@include file="/recruit/page/web/explanation.jsp" %>
	</nav>
</body>
</html>