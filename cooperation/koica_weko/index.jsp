<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<%@include file="./importhead.jsp" %>
<link type="text/css" rel="stylesheet" href="<%=commonImportPath %>/koica/css/index.css" />
<link type="text/css" rel="stylesheet" href="<%=commonImportPath %>/koica/css/product.css" />
<script type="text/javascript" src="<%=commonImportPath %>/koica/js/index_09269000.js" ></script>
<title>KOICA &amp; HAPPYBUSKING</title>
</head>
<body oncontextmenu='return false' ondragstart='return false'>
	<%@include file="./view/header.jsp" %>
	<%@include file="./view/panel.jsp" %>
	<nav>
		<div class="index_wapper">
			<div class="iw_top_container">
				<div class="iwc_image_container">
					<img class="iwcic_busker_image" id="now_team_image" src="./img/test/team/3.jpg">
					<img class="iwcic_shape_image" src="./img/index_bg.png">
				</div>
				<div class="iwc_info_container">
					<div class="iwcic_wapper" style="cursor: pointer;" id="now_team_url" onclick="location.href='https://www.happybusking.com/app/appresult.jsp?team_no=3'">
						<p class="iwcic_title pb_gra_point" style="font-size: 12px;">지금 공연중인 버스커는?</p>
						<p class="iwcic_content"><span id="now_team_name">어쿠스틱소울</span><img src="./img/icon/who.svg"></p>
						<p class="iwcic_sub_content gray_point" id="now_team_info">울산통기타사랑 기타동호회에서 활동하고 있는 어쿠스틱밴드입니다.</p>
						<!-- <div class="iwcic_search">
							<input type="text" readonly="readonly" placeholder="지금 공연하는 아티스트가 더 궁금하다면?">
							<img src="./img/icon/search.svg">
						</div> -->
						<div class="iwcic_plus_btn pb_gra_point"><img src="./img/icon/more.svg"></div>
					</div>
				</div>
			</div>
			
			<div class="iw_middel_container">
				<div class="iwmc_container_box">
					<!-- 2019sdg.com 페이지에 있는 행사개요부분 아예 삽입. 포스터도 삽입, 랜딩페이지 공유 -->
					<p class="iwmc_title">KOICA 국민서포터즈 WeKO DAY</p>	
					
					<p class="iwmc_sub_title"><span>KOICA 국민서포터즈 Weko!?</span></p>
					<ul>
						<li class="gray_point">WeKO는 전 국민, 전 연령층에게 KOICA와 해외봉사단, ODA(공적개발원조), SDGs(지속가능발전목표) 등을 쉽게 알리기 위해 선발된 120명의 KOICA 홍보대사입니다.</li>
						<li class="gray_point">WeKO는 앞으로 국제개발협력에 대한 대국민 인지도를 높이기 위한 다양한 온/오프라인 홍보활동과 함께 SNS 콘텐츠를 제작, 홍보하고 각종 행사를 통해 홍보 프로그램 운영 서포터 등 다양한 활동으로 찾아가겠습니다.</li>
					</ul>
					
					<p class="iwmc_sub_title"><span>행사개요</span></p>
					<ul>
						<li class="gray_point">KOICA 국민 서포터즈 1기 연합 홍보</li>
						<li class="gray_point">KOICA 국민 서포터즈 1기 120명 전체가 한자리에 모여 전국민 대상 홍보 진행</li>
						<li class="gray_point">서포터즈들의 다양한 홍보 활동과 이벤트를 통해 국민들에게 KOICA와 ODA에 대해서 홍보</li>
					</ul>
					
					<!-- <img class="iwmc_cb_main_img" src="./img/test/index/1.png">
					
					<p class="iwmc_cb_title">2019 평화&amp;SDG 세계시민 축제</p> -->
					
					<!-- <p class="iwmc_cb_content gray_point">
					외교부와 KOICA가 9월 21일부터 9월 22일까지 국회의사당 잔디광장에서 개최하는 '2019 평화 &amp; SDG 세계시민축제'에 여러분을 초대합니다.</p>
					<p class="iwmc_cb_content gray_point">
					'2019 평화 &amp; SDG 세계시민축제'는 '2019 평화 & SDG 국제행동주간'(9.20-9/27)계기에 맞추어 개최되는 행사입니다.
					세계와 함께하는 대한민국의 평화, SDG, ODA 실천을 알리는 범국민 축제로, 다양한 개발협력 파트너들의 참여를 통한 체험활동과 K-POP 아이돌 가수와 함께하는 콘서트도 함께 진행 될 예정입니다.</p> -->
					
					<p class="iwmc_sub_title"><span>행사 프로그램 구성</span></p>
					<div class="pinch_box" id="pb1" style="margin-bottom: 40px;">
						<div class="index_imagebox" id="imagebox_1">
							<img src="./img/test/index_1/12.png">
						</div>
					</div>
				<!-- <div class="iwmc_cb_image_box">
						이부분에 부대행사 이미지 넣어주세요!
						<div class="iwmc_cb_ib_content">
							<img src="./img/test/index/2.png">
							<p>희망자전거 퍼레이드</p>
						</div>
						<div class="iwmc_cb_ib_content">
							<img src="./img/test/index/3.png">
							<p>버스킹</p>
						</div>
					</div> -->
					
					<p class="iwmc_sub_title"><span>행사장소 및 배치도</span></p>
					<ul class="iwmc_sub_ul">
						<li class="gray_point">행사장소</li>
					</ul>
					<div class="pinch_box" id="pb2">
						<div class="index_imagebox" id="imagebox_2">
							<img src="./img/test/index_1/4.png">
						</div>
					</div>
					<ul class="iwmc_sub_ul" style="margin-top: 50px;">
						<li class="gray_point">배치도</li>
					</ul>
					<div class="pinch_box" id="pb3">
						<div class="index_imagebox" id="imagebox_3">
							<img src="./img/test/index_1/10.png">
						</div>
					</div>
					<!-- <ul>
						<li class="gray_point">걱정을 없애주는 과테말라 걱정인형 만들기</li>
						<li class="gray_point">도미니카 공화국 열정의 카니발 가면 만들기</li>
						<li class="gray_point">가나 아딘크라 에코백 만들기</li>
						<li class="gray_point">평화를 부탁해, 평화 팔찌 만들기</li>
						<li class="gray_point">플라스틱 빨대로 행잉화분 만들기</li>
						<li class="gray_point">외 20여개 체험 프로그램(체험비 무료)</li>
					</ul>
					
					<p class="iwmc_imp_text">* 체험학습 확인서 발급(학생대상)</p>
					<p class="iwmc_imp_text">* 참가자 전원 기념품 제공(소진시까지)</p>
					
					<p class="iwmc_cb_content gray_point">
					지속가능한 개발협력을 위한 이번 행사에 여러분의 적극적인 참여를 부탁드립니다.</p> -->
				</div>
				<p class="container_line"></p>
				
				<!-- <div class="iwmc_container_box">
					<div class="iwmc_cb_top" style="cursor: pointer;" onclick="location.href='https://koicasdg.modoo.at/?link=1gsyh7c7'">
						<img class="iwmc_cb_profile_img" src="./img/test/corps/worldf.png">
						<p class="iwmc_cb_prfile"><span class="gray_point">2019 평화 &amp; SDG 축제@</span></p>
					</div>
				</div>
				<div class="iwmc_cb_bottom" style="cursor: pointer;" id="koica_share">
					<img src="./img/icon/share.svg">
					<span class="gray_point">내용 공유하기</span>
				</div>
				<p class="container_line"></p> -->
				
				
				<div class="iwmc_container_box">
					<p class="iwmc_title">KOICA 소개</p>
					
					<div class="iwmc_cb_item" style="cursor: pointer;" onclick="location.href='http://www.koica.go.kr/koica_kr/index.do'">
						<img class="iwmc_cbi_bg" src="./img/test/index/5.png">
						<div class="iwmc_cbi_content">
							<p class="white_point">글로벌 사회적 가치를 실천하며, 누구도 소외받지 않는,<br>
							사람 중심의 평화와 번영을 위한 상생의 개발협력<br>
							대한민국 개발협력 대표기관은 KOICA가 함께합니다.</p>
							
							<span class="white_point">바로가기 ></span>
						</div>
					</div>
				</div>
				<p class="container_line"></p>
				
				<div class="iwmc_container_box" style="padding-bottom: 70px;">
					<p class="iwmc_title">KOICA 소식</p>
					<div class="iwmc_ul_container_2" style="padding-top: 0px; margin-bottom: 0px;">
						<div class="iwmc_uc_item_2" style="cursor: pointer; background-color: #fff;" onclick="location.href='http://www.koica.go.kr/koica_kr/999/subview.do'">
							<p class="iwmc_ui2_big_title">Together KOICA</p>
							<p class="iwmc_ui2_small_title gray_point">글로벌 사회적 가치를 실천하는<br>대한민국 개발협력 대표기관</p>
							<img src="./img/test/corps/koica2.png">
						</div>
					</div>
				</div>
				
				<div class="iwmc_container_box_2">
					<p class="iwmc_title white_point">KOICA 더 알아보기</p>
					<!-- KOICA SNS 링크 -->
					<!-- 네이버 블로그, 페이스북, 인스타그램, 유튜브 -->
					<ul>
						<li>
							<div class="iwmc_cb2_item" style="cursor: pointer;" onclick="location.href='https://blog.naver.com/prkoica'">
								<img src="./img/icon/sns/sns3.png"><span>네이버 블로그</span>
							</div>
						</li>
						<li>
							<div class="iwmc_cb2_item" style="cursor: pointer;" onclick="location.href='https://www.facebook.com/officialKOICA'">
								<img src="./img/icon/sns/sns2.png"><span>페이스북</span>
							</div>
						</li>
						<li>
							<div class="iwmc_cb2_item" style="cursor: pointer;" onclick="location.href='https://instagram.com/officialkoica'">
								<img src="./img/icon/sns/sns4.png"><span>인스타그램</span>
							</div>
						</li>
						<li>
							<div class="iwmc_cb2_item" style="cursor: pointer;" onclick="location.href='https://www.youtube.com/user/officialKOICA'">
								<img src="./img/icon/sns/sns5.png"><span>유튜브</span>
							</div>
						</li>
					</ul>
				</div>
				
			</div>
		</div>
		<div class="popup_mask"></div>
		<div class="share_popup">
			<div class="sp_share_header">
				<p>공유하기</p>
				<img id="sp_close" src="./img/icon/close2.png" style="cursor: pointer; ">
			</div>
			<div class="sp_share_url_box">
				<input id="sp_url" type="text" value="https://koicasdg.modoo.at/?link=1gsyh7c7">
				<p id="sp_url_copy">URL복사</p>
			</div>
		</div>
	</nav> 
</body>
</html>