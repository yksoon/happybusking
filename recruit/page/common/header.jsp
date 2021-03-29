<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="/recruit/resource/css/header.css?ver=1.0.7" />
   
<nav class="header bg-white">
	<div class="flex header-top">
		<div class="hleft logo" onclick="goMyPbi();">
			<img src="/recruit/resource/img/header/logo-black-2.svg">
		</div>
		<div class="hright myicon" onclick="goMyPage();">
			<img src="/recruit/resource/img/header/login-black.svg">
		</div>
	</div>
	<div class="flex header-menu">
		<div class="menu on" id="nplogin" onclick="goLogin();">
			<p>로그인</p>	
		</div>
		<div class="menu" id="npjoin" onclick="goJoin();">
			<p>회원가입</p>
		</div>
	</div>
</nav>