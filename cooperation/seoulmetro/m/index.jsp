<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<%@include file="./importhead.jsp" %> 
<link type="text/css" rel="stylesheet" href="<%=commonImportPath %>/seoulmetro/m/css/index.css?ver=1.0.0" />
<script type="text/javascript" src="<%=commonImportPath %>/seoulmetro/m/js/index.js?ver=1.0.0" ></script>
<title>METRO &amp; HAPPYBUSKING</title>
</head>
<body oncontextmenu='return false' ondragstart='return false'>
	<nav> 
		<div class="index_wapper">
			<div class="iw_top_container">
				<div class="iwc_image_container">
					<img class="iwcic_busker_image" id="now_team_image" src="./img/test/team/1588935326991.jpg">
					<img class="iwcic_shape_image" src="./img/index_bg.png">
				</div>
				<div class="iwc_info_container">
					<div class="iwcic_wapper" style="cursor: pointer;" id="now_team_url" onclick="location.href='https://www.happybusking.com/app/appresult.jsp?team_no=2005082004403032'">
						<p class="iwcic_title pb_gra_point">지금 공연중인 버스커는?</p>
						<p class="iwcic_content"><span id="now_team_name">통기타젬스</span><img src="./img/icon/who.svg"></p>
						<p class="iwcic_sub_content gray_point" id="now_team_info">팀명 : 통기타젬스 GEMS. GEM 은 보석 이라는 뜻으로 저희와 관객 모두가 보석 이라는 의미로 GEMS 라 이름을 짓고 활동중인 혼성 통기타 듀엣입니다</p>
						<!-- <div class="iwcic_search">
							<input type="text" readonly="readonly" placeholder="지금 공연하는 아티스트가 더 궁금하다면?">
							<img src="./img/icon/search.svg">
						</div> -->
						<div class="iwcic_plus_btn pb_gra_point"><img src="./img/icon/more.svg"></div>
					</div>
				</div>
			</div>
			<div class="iw_middle_container" style="padding: 15px;">
				<p class="iwmc_title">서울교통공사 메트로아티스트 선발</p>
				<p class="iwmc_sub_title"><span>합격자 발표</span></p>
				<a href="http://www.seoulmetro.co.kr/kr/board.do?menuIdx=546&bbsIdx=2209426"><img src="./img/seoulmetro_info.png" style="margin-top: 15px; width: 100%;"/></a>
			</div>
		</div>
	</nav> 
</body>
</html>