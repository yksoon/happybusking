<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./importhead.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
 @import url(https://cdn.jsdelivr.net/gh/theeluwin/NotoSansKR-Hestia@master/stylesheets/NotoSansKR-Hestia.css);

*{
	font-family: 'Noto Sans Korean', sans-serif;
	font-size: 14px;
	padding: 0;
	margin: 0;
}

ul{
	list-style: none;
}

ul > li {
	float: left;
}

.top{
	position: fixed;
    top: 0;
    left: 50%;
    transform: translate(-50%, 0);
    width: 1200px;
    text-align: center;
    justify-content: center;
}

.flex{
	display: flex;
}

.menuitem {
    padding: 20px 20px;
    min-width: 199px;
    background-color: #fff;
    cursor: pointer;
    color: #545456;
    letter-spacing: -0.5px;
    border-right: 1px solid #e8e8e8;
    font-size: 15px;
}

.menuon{
	background-color: #5b2bec;
    color: #ffffff;
    font-weight: 700;
}

.middle{
	margin-top: 60px;
}

.page {
	display: none;
    width: 1200px;
    margin: 0 auto;
}

.pageon{
	display: block;
}

.page img {
    width: 100%;
}

</style>
<script type="text/javascript" src="./resource/js/active/index.js?ver=1.0.1" ></script>
</head>
<body>
	<nav class="top flex">
		<ul>
			<li class="menuitem menuon" id="page1">앱 설치 및 회원가입</li>
			<li class="menuitem" id="page2">아티스트 되기</li>
			<li class="menuitem" id="page3">팀/솔로 등록 - 팀 등록일 경우</li>
			<li class="menuitem" id="page4">팀/솔로 등록 - 솔로 등록일 경우</li>
			<li class="menuitem" id="page5">메트로 아티스트 모집 신청</li>
		</ul>
	</nav>
	<nav class="middle">
		<div class="page page1 pageon">
			<img src="./resource/img/1.jpg">
		</div>
		<div class="page page2">
			<img src="./resource/img/2.jpg">
		</div>
		<div class="page page3">
			<img src="./resource/img/3(1).jpg">
		</div>
		<div class="page page4">
			<img src="./resource/img/4.jpg">
		</div>
		<div class="page page5">
			<img src="./resource/img/5.jpg">
		</div>
	</nav>
</body>
</html>