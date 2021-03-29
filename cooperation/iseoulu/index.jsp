<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<%@include file="./importhead.jsp" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5caef794e0c0d34ae5082d15d8cbdcc9&libraries=services"></script>
<link type="text/css" rel="stylesheet" href="<%=commonImportPath %>/iseoulu/css/index_09251118.css" />
<link type="text/css" rel="stylesheet" href="<%=commonImportPath %>/iseoulu/css/product.css" />
<script type="text/javascript" src="<%=commonImportPath %>/iseoulu/js/index.js" ></script>
<title>I HAPPYBUSKING U</title>
</head>
<body oncontextmenu='return false' ondragstart='return false'>
	<%@include file="./view/header.jsp" %>
	<%@include file="./view/panel.jsp" %>
	<nav>
		<div class="index_wapper">
			<div class="iw_top_container">
				<div class="iwc_image_container">
					<div class="iwc_noimage" id="iwc_background">
						<p class="in_text_type_a">지난 공연입니다</p>
						<p class="in_text_type_b">팀/멤버 정보, 사진/동영상</p>
						<p class="in_text_type_b">공연 일정, 모바일 후원</p>
						<!-- <p class="in_text_type_a">이 필요하다면 + 버튼을 눌러 다운로드 해주세요.</p>
						<img class="in_down_image" src="/cooperation/iseoulu/img/main/img.png"> -->
					</div>
					<img class="iwcic_busker_image" id="now_team_image">
					<img class="iwcic_shape_image" src="./img/index_bg.png">
				</div>
				<div class="iwc_info_container">
					<div class="iwcic_wapper" id="now_team_url" style="cursor: pointer;" onclick="location.href='https://www.happybusking.com/app/appresult.jsp?team_no=900998'">
						<p class="iwcic_title pb_gra_point"><img src="./img/icon/who.svg"><span id="iwcic_title_text">지금 공연중인 버스커는?</span></p>
						<p class="iwcic_content"><span id="now_team_name">네오팝스탠다드 X오유</span></p>
						<p class="iwcic_sub_content gray_point" id="now_team_info">‘팝의 새로운 기준’ 이라는 뜻을 담고 있는 네오팝스탠다드는 베이스 죵딘, 신디사이저 OK.T.O.P로 결성되어 2014년 디지털 싱글 ‘Good Time’을 발매하며 데뷔하였습니다. 현재까지 5장의 싱글을 발매하였고 각각의 싱글마다 서로 다른 스타일의 음악을 발표하며 팝으로 대표되는 대중음악의 다양한 장르들을 쉽고 대중적이면서도 결코 가볍지 않게 선보이려 노력하고 있습니다.</p>
						<!-- <div class="iwcic_search">
							<input type="text" readonly="readonly" placeholder="지금 공연하는 아티스트가 더 궁금하다면?">
							<img src="./img/icon/search.svg">
						</div> -->
						<div class="iwcic_plus_btn pb_gra_point"><img src="/cooperation/iseoulu/img/icon/more.svg"></div>
					</div>
				</div>
			</div>
			<div class="iw_middel_container">
			
				<!-- 파트너스 상품 소개 들어가야함 -->
				<p class="iwmc_title">아이서울유<br>브랜드 팝업스토어</p>
				<p class="iwmc_content">
					서울브랜드 아이서울유와 중소기업간 공동 브랜딩한 제품을 11월20일 부터 12월1일까지 12일간 서울 마포구 홍대인근에 위치한 아트아치 갤러리에서『아이서울유파트너스 팝업스토어』오픈
				</p>
				<div class="iwmc_image_container" style=" cursor: pointer;">
					<!-- <img src="/cooperation/iseoulu/img/main/partners2.png" style="border: 1px solid #eee;"> -->
					<!-- <div class="iwmc_ic_text">
						<p>소개</p>
						<p>발자취</p>
						<p>협업유형</p>
					</div> -->
				</div>
				
				<p class="iwmc_content2_t">ㆍ기간 :</p>
				<p class="iwmc_content2">2019.11.20.(수) - 12.1.(일) 10:00-20:00</p>
				<br><p class="iwmc_content2_t">ㆍ장소 :</p>
				<p class="iwmc_content2">아트아치 갤러리(서울 마포구 독막로9길 24)</p>
				
				<div class="pop_content">
					<div class="common_map" id="index_map"></div>					
				</div>
				
				
				<p class="iwmc_title">아이서울유<br>브랜드 소개</p>
				<p class="iwmc_content">
					서울브랜드 I·SEOUL·U는 [너와 나의 서울]<br>가치속에 공존의 서울, 열정의 서울, 여유의<br>서울을 담고 있습니다.
				</p>
				<div class="iwmc_image_container" style=" cursor: pointer;" onclick="location.href='http://brand.seoul.go.kr/front/sub/brand/introduce.do'">
					<img src="/cooperation/iseoulu/img/main/0.png" style="border: 1px solid #eee;">
					<!-- <div class="iwmc_ic_text">
						<p>소개</p>
						<p>발자취</p>
						<p>협업유형</p>
					</div> -->
				</div>
				
				<!-- 파트너스 상품 소개 들어가야함 -->
				<p class="iwmc_title">아이서울유<br>파트너스 상품 소개</p>
				<div class="iwmc_image_container" style=" cursor: pointer;" onclick="location.href='<%=commonUrlPath%>/product/plist.jsp'">
					<img src="/cooperation/iseoulu/img/main/partners.png" style="border: 1px solid #eee;">
					<!-- <div class="iwmc_ic_text">
						<p>소개</p>
						<p>발자취</p>
						<p>협업유형</p>
					</div> -->
				</div>
				
				<p class="iwmc_title">서울은 지금</p>
				<p class="iwmc_content">
					너와 나의 서울, 서울의 다양한 소식과<br>메시지를 전달해드립니다.
				</p>
				<div class="iwmc_image_container" style=" cursor: pointer;" onclick="location.href='http://www.seoul.go.kr/realmnews/in/list.do?tr_code=gnb_news'">
					<img src="/cooperation/iseoulu/img/main/2.jpg">
				</div>
				
				
				<p class="iwmc_title">이달의 행사 및 축제</p>
				<p class="iwmc_content">
					서울의 다양한 행사 및 축제를 경험해보세요.
				</p>
				<div class="iwmc_image_container">
					<img src="/cooperation/iseoulu/img/main/3.jpg" style=" cursor: pointer;" onclick="location.href='http://news.seoul.go.kr/culture/archives/category/art-news_c1/service_art'">
					<p class="sperform_text">서울</p>
				</div>
				<div class="iwmc_image_container">
					<img src="/cooperation/iseoulu/img/main/4.jpg" style=" cursor: pointer;" onclick="location.href='http://news.seoul.go.kr/culture/archives/category/tour-news_c1/policy_tour'">
					<p class="sperform_text">즐기기</p>
				</div>
				
				
				
				<p class="iwmc_title">서울 관광 명소</p>
				<p class="iwmc_content" style="margin-bottom: 15px;">
					서울시에서 추천하는 서울 추천코스, 명소, 맛집 등<br>VISIT SEOUL로 서울 나들이 해보세요.
				</p>
				<div class="iwmc_ul_container">
					<ul class="iwmc_item_slide" id="seoul_place">
						<li>
							<div class="iwmc_uc_item" onclick="location.href='https://korean.visitseoul.net/attractions'">
								<img src="./img/attractions/tourist.png">
								<p>명소</p>
							</div>
						</li>
						<li>
							<div class="iwmc_uc_item" onclick="location.href='https://korean.visitseoul.net/shopping'">
								<img src="./img/attractions/shop.png">
								<p>쇼핑</p>
							</div>
						</li>
						<li>
							<div class="iwmc_uc_item" onclick="location.href='https://korean.visitseoul.net/stay-index'">
								<img src="./img/attractions/house.png">
								<p>숙박</p>
							</div>
						</li>
						<li>
							<div class="iwmc_uc_item" onclick="location.href='https://korean.visitseoul.net/eat'">
								<img src="./img/attractions/restaurant.png">
								<p>음식점</p>
							</div>
						</li>
					</ul>
				</div>
				
				
				<!-- <p class="iwmc_title">파트너스 기업 상품</p> -->
				<%-- <div class="iwmc_item_slide_container">
					<ul class="iwmc_item_slide" id="partners_product">
						<li>
							<div class="pp_item" id="iseoulu_partners_food" style="cursor: pointer;" onclick="location.href='<%=commonUrlPath%>/product/plist.jsp?pCategory=001'">
								<img src="./img/icon/food.svg">
								<p>음식</p>
							</div>
						</li>
						<li>
							<div class="pp_item" id="iseoulu_partners_music" style="cursor: pointer;" onclick="location.href='<%=commonUrlPath%>/product/plist.jsp?pCategory=002'">
								<img src="./img/icon/music.svg">
								<p>음악</p>
							</div>
						</li>
						<li>
							<div class="pp_item" id="iseoulu_partners_fashion" style="cursor: pointer;" onclick="location.href='<%=commonUrlPath%>/product/plist.jsp?pCategory=003'">
								<img src="./img/icon/fashion.svg">
								<p>패션</p>
							</div>
						</li>
						<li>
							<div class="pp_item" id="iseoulu_partners_exhibit" style="cursor: pointer;" onclick="location.href='<%=commonUrlPath%>/product/plist.jsp?pCategory=004'">
								<img src="./img/icon/exhibit.svg">
								<p>전시</p>
							</div>
						</li>
						<li>
							<div class="pp_item" id="iseoulu_partners_cosmetics" style="cursor: pointer;" onclick="location.href='<%=commonUrlPath%>/product/plist.jsp?pCategory=005'">
								<img src="./img/icon/cosmetics.svg">
								<p>화장품</p>
							</div>
						</li>
					</ul>
				</div> --%>
				
				<!-- <p class="iwmc_title_best">서울시 선정 <span>베스트</span> 상품</p> -->
				<!-- <div class="iwmc_item_slide_container best_product_box">
					<ul class="iwmc_item_slide" id="partners_best_product">
						<li>
							<div class="siwcb_item" style="margin: 0px 10px 0px 20px; cursor: pointer; width: auto;">
								<img src="/cooperation/iseoulu/img/test/cosmetics/welkron.jpg">
								<p class="siwcb_title pb_gra_point">웰크론헬스케어</p>
								<p class="siwcb_pname">서울시 영등포구</p>
								<p class="siwcb_info light_gray_point">Blueberry Bage</p>
								<p class="siwcb_price">9,000원 ~</p>
							</div>
						</li>
						<li>
							<div class="siwcb_item" style="margin-left:10px; cursor: pointer; width: auto;">
								<img src="/cooperation/iseoulu/img/test/cosmetics/icosmetics.jpg">
								<p class="siwcb_title pb_gra_point">아이코스메틱</p>
								<p class="siwcb_pname">서울시 영등포구</p>
								<p class="siwcb_info light_gray_point">Blueberry Bage</p>
								<p class="siwcb_price">9,000원 ~</p>
							</div>
						</li>
						<li>
							<div class="siwcb_item" style="margin-left:10px; cursor: pointer; width: auto;">
								<img src="/cooperation/iseoulu/img/test/cosmetics/daenggi.jpg">
								<p class="siwcb_title pb_gra_point">댕기머리</p>
								<p class="siwcb_pname">서울시 영등포구</p>
								<p class="siwcb_info light_gray_point">Blueberry Bage</p>
								<p class="siwcb_price">9,000원 ~</p>
							</div>
						</li>
						<li>
							<div class="siwcb_item" style="margin-left:10px; cursor: pointer; width: auto;">
								<img src="/cooperation/iseoulu/img/test/cosmetics/holdlive.jpg">
								<p class="siwcb_title pb_gra_point">홀드라이브</p>
								<p class="siwcb_pname">서울시 영등포구</p>
								<p class="siwcb_info light_gray_point">Blueberry Bage</p>
								<p class="siwcb_price">9,000원 ~</p>
							</div>
						</li>
						<li>
							<div class="siwcb_item" style="margin: 0px 20px 0px 10px; cursor: pointer; width: auto;"> 
								<img src="/cooperation/iseoulu/img/test/cosmetics/briall.jpg">
								<p class="siwcb_title pb_gra_point">브리올옴므</p>
								<p class="siwcb_pname">서울시 영등포구</p>
								<p class="siwcb_info light_gray_point">Blueberry Bage</p>
								<p class="siwcb_price">9,000원 ~</p>
							</div>
						</li>
					</ul>
				</div>
				<p class="all_product_btn gray_point" style="cursor: pointer;" onclick="location.href='/cooperation/iseoulu/view/product/plist.jsp?pCategory=000'">파트너스 기업 상품 더보기</p> -->
				
			</div>
			<div class="iw_bottom_container">
				<p class="iwbc_title">아이·해피버스킹·유</p>
				<p class="iwbc_content gray_point">아이·해피버스킹·유는 서울브랜드<br>(I SEOUL U)와 해피버스킹의<br>공동 브랜딩을 통해 탄생한 브랜드입니다.</p>
				
				<p class="iwbc_small_title">버스커와 관객의 소통 플랫폼</p>
				<p class="iwbc_title">해피버스킹</p>
				<p class="iwbc_url" style="cursor: pointer;" onclick="location.href='https://www.happybusking.com'"><span>WWW.HAPPYBUSKING.COM</span>></p>
				
				<div class="iwbc_app_container" style="cursor: pointer;" onclick="location.href='https://play.google.com/store/apps/details?id=com.happybusking'">
					<div class="iwbc_app_icon"><img src="/cooperation/iseoulu/img/panel/gg.png"></div>
					<p class="iwbc_app_text">안드로이드 앱 다운로드</p>
				</div>
				<div class="iwbc_app_container" style="cursor: pointer;" onclick="location.href='https://itunes.apple.com/kr/app/해피버스킹/id1436945374?mt=8'">
					<div class="iwbc_app_icon"><img src="/cooperation/iseoulu/img/panel/ap.png"></div>
					<p class="iwbc_app_text">IOS 앱 다운로드</p>
				</div>
			</div>
			<p class="iw_bottom_copyright gray_point">Copyrightⓒ 2009-2019 Bizworks All Rights Reserved</p>
		</div>
	</nav> 
</body>
</html>