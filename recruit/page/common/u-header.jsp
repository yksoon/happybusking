<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="/recruit/resource/css/header.css?ver=1.1.2" />
   
<nav class="header bg-white">
	<div class="flex header-top">
		<div class="hleft logo" onclick="goMyPbi();">
			<img src="/recruit/resource/img/header/logo-black-2.svg">
		</div>
		<div class="hright myicon" onclick="goMyPage();">
			<img src="/recruit/resource/img/header/login-black.svg">
		</div>
	</div>
	<div class="u-header">
		<!-- <div class="bg-white ft-purple ft-16 go-recruit-info hidden" onclick="goRecruitInfoPopup();">공고 공연예술가 모집 플랫폼이란?</div> -->
		<div class="flex bg-purple btn go-reg-btn" onclick="goReg();">
			<img src="/recruit/resource/img/common/add-white-1.svg"/>
			<p class="ft-white ft-16 ft-bold">새 공모 등록하기</p>
		</div>
	</div>
	<!-- <div class="flex header-menu">
		<div class="menu on" id="npreg" onclick="goReg();">
			<p>공고등록</p>	
		</div>
		<div class="menu" id="npmypbi" onclick="goMyPbi();">
			<p>내모집공고</p>
		</div>
		<div class="menu" id="npapplicant" onclick="">
			<p>신청자목록</p>
		</div>
	</div> -->
</nav>