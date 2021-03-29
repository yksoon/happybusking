<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<%@include file="./importhead.jsp" %>
<body onload="setItemSlide();">
<div class="index_wapper">
	<div class="common_header">
		<img class="header_logo" id="header_logo" src="./img/isu_logo-01.png">
	</div>
	<div class="common_body">
		<div class="artist_info_container">
			<div class="aic_text_container">
				<p class="aic_text_main" id="team_name">발라듀엣</p>
				<p class="aic_text_sub" id="team_genre">인디</p>
				<p class="aic_text_sub" id="team_perform">2019-07-27 공연</p>
			</div>
			<div class="aic_image_container">
				<div class="aic_image_heart">
					<img src="./img/interesting_icon.svg">
					<p id="interest_cnt">11</p>
				</div>
				<div class="aic_image_tipbox">
					<img src="./img//tip_box.svg">
				</div>
			</div>
			<div class="aic_btn">
				자세히보기
			</div>
		</div>
		<div class="isu_content_container">
			<div class="isu_cc_header">
				<div class="isu_cch_title">내 손안에 서울</div>
				<div class="isu_cch_btn">더보기 ></div>
			</div>
			<div class="isu_cc_list">
				<ul id="isu_ccl_event">
					<li>
						<div class="isu_ccl_item_container">
							<img class="isu_ccl_ic_image" src="./img/isu_1.jpg">
							<div class="isu_ccl_lc_padding">
								<p class="isu_ccl_ic_status ing">진행중</p>
								<div class="isu_ccl_ic_title">“내 손안에 서울 사천만큼 사랑해” 기사 공유 이벤트</div>
								<p class="isu_ccl_ic_date">2019-07-25 ~ 2019-07-31</p>
								<div class="isu_ccl_ic_img_container">
									<div class="isu_ccl_ic_img">
										<img src="./img/interesting_icon.svg">
										<p>1</p>
									</div>
									<div class="isu_ccl_ic_img2">
										<img src="./img/view.jpg">
										<p>1,154</p>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="isu_ccl_item_container">
							<img class="isu_ccl_ic_image" src="./img/isu_2.jpg">
							<div class="isu_ccl_lc_padding">
								<p class="isu_ccl_ic_status end">완료</p>
								<div class="isu_ccl_ic_title">‘잘 생겼다 서울 공간’에서 나만의 V로그 만들기</div>
								<p class="isu_ccl_ic_date">2019-07-04 ~ 2019-07-24</p>
								<div class="isu_ccl_ic_img_container">
									<div class="isu_ccl_ic_img">
										<img src="./img/interesting_icon.svg">
										<p>9</p>
									</div>
									<div class="isu_ccl_ic_img2">
										<img src="./img/view.jpg">
										<p>435</p>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="isu_ccl_item_container">
							<img class="isu_ccl_ic_image" src="./img/isu_3.jpg">
							<div class="isu_ccl_lc_padding">
								<p class="isu_ccl_ic_status end">완료</p>
								<div class="isu_ccl_ic_title">2019 퀴즈이벤트 커밍순!</div>
								<p class="isu_ccl_ic_date">2019-06-05 ~ 2019-06-05</p>
								<div class="isu_ccl_ic_img_container">
									<div class="isu_ccl_ic_img">
										<img src="./img/interesting_icon.svg">
										<p>8</p>
									</div>
									<div class="isu_ccl_ic_img2">
										<img src="./img/view.jpg">
										<p>764</p>
									</div>
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div class="isu_content_container">
			<div class="isu_cc_header">
				<div class="isu_cch_title">서울은 지금</div>
				<div class="isu_cch_btn">더보기 ></div>
			</div>
			<div class="isu_cc_list">
				<ul id="isu_ccl_nowseoul">
					<li>
						<div class="isu_ccl_item_container">
							<img class="isu_ccl_ic_image" src="./img/news1.jpg">
							<div class="isu_ccl_lc_padding">
								<div class="isu_ccl_ic_title">마곡에 강소·벤처기업 R&D센터 구축 민간사업자 공모</div>
								<p class="isu_ccl_ic_date">2019/07/23</p>
							</div>
						</div>
					</li>
					<li>
						<div class="isu_ccl_item_container">
							<img class="isu_ccl_ic_image" src="./img/news2.jpg">
							<div class="isu_ccl_lc_padding">
								<div class="isu_ccl_ic_title">딱 나흘만! 서울식물원 야간개장 24일부터 선착순 예약</div>
								<p class="isu_ccl_ic_date">2019/07/22</p>
							</div>
						</div>
					</li>
					<li>
						<div class="isu_ccl_item_container">
							<img class="isu_ccl_ic_image" src="./img/news3.jpg">
							<div class="isu_ccl_lc_padding">
								<div class="isu_ccl_ic_title">눈부심 없는 서울의 밤, ‘좋은빛상’ 받은 이 건물은?</div>
								<p class="isu_ccl_ic_date">2019/07/19</p>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
	
</body>
</html>