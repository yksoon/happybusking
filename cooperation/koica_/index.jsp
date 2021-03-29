<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<%@include file="./importhead.jsp" %>
<body>
<div class="index_wapper">
	<div class="common_header">
		<img class="header_logo" id="header_logo" src="./img/koica_logo.svg">
	</div>
	<div class="common_body">
		<iframe class="media_iframe" src="https://www.youtube.com/embed/ZoW0gq2ft3k" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		
		<div class="cb_middel_container">
			<div class="dbmc_box" id="now_koica_btn">
				<p>지금 KOICA는?</p><img src="./img/plus.svg">
			</div>
			<div class="dbmc_box" id="koica_poll_btn">
				<p>설문조사참여</p><img src="./img/plus.svg">
			</div>
		</div>
		
		<div class="cb_content_container">
			<!-- <div class="cbcc_title">
				헤더 background 추가
			</div> -->
			<p class="cbcc_title">Objective of KOICA</p>
			
			<div class="cbcc_content_box">
				<ul>
					<li>국내외 파트너십 강화로 ODA한류 구현</li>
					<li>글로벌 사회적 가치를 실천하는 개발협력 대표기관</li>
					<li>사람 중심의 평화와 번영을 위한 상생의 개발협력</li>
					<li>성과중심 ODA 사업을 수행하는 선진원조기관</li>
				</ul>
			</div>
		</div>
		
		<div class="cb_artist_info_btn" id="cb_artist_info_btn">지금 공연중인 버스커는?</div>
	</div>
</div>
	
</body>
</html>