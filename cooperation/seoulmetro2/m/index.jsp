<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<%@include file="./importhead.jsp" %> 
<title>METRO &amp; HAPPYBUSKING</title>
</head>
<body oncontextmenu='return false' ondragstart='return false'>
	<%@include file="./panel.jsp" %> 
	<%@include file="./header.jsp" %>
	<nav> 
		<div class="index_wapper">
			<div class="iw_top_container">
				<div class="iwc_image_container">
					<img class="iwcic_busker_image" id="now_team_image" src="" alt="image loading">
					<img class="iwcic_shape_image" src="./img/index_bg.png">
				</div>
				<div class="iwc_info_container">
					<div class="iwcic_wapper" style="cursor: pointer;" id="now_team_url">
						<p class="iwcic_title pb_gra_point">지금 공연중인 버스커는?</p>
						<p class="iwcic_content" id="now_team_name"></p>
						<p class="iwcic_sub_content gray_point" id="now_team_info"></p>
						<div class="iwcic_plus_btn pb_gra_point"><img src="./img/icon/more.svg"></div>
					</div>
				</div>
				<nav class="body__content">
					<div class="bc__title">제11회 서울교통공사<br>국제지하철영화제</div>
					<a href="https://www.smiff.kr/metro/2020/online2020.html"><img class="bc__content_image" src="./img/v2/img1.png"/></a>
					<div class="bc__content_title">움직이는 영화관, 90초의 상상력이 펼쳐진다!</div>
					<div class="bc__conetnt">우리의 일상을 담아내는 공간, 지하철!<br>지하철이 ‘영화’를 만나 문화 공간으로 재구성되는 특별한 이벤트</div>
				</nav>
				<nav class="body__content body__content--b">
					<div class="bc__title">
						국제지하철영화제<br>온라인 투표
						<div class="bc__title__share"><img src="./img/v2/share.png"/></div>
					</div>
					<div class="bc__content_image_box">
						<div class="bc__cib__title">90초, 지하철을 즐겨라!<br>내손으로 선정하는 최고의 90초 영화!</div>
						<a href="https://www.smiff.kr/metro/2020/vote.html"><div class="bc__cib__btn">투표하기<img src="./img/v2/small_more.png"/></div></a>
					</div>
					<div class="bc__conetnt bc__conetnt--b">온라인과 모바일을 통해서도 “SMIFF 2020” 즐기고!<br>직접 수상작도 뽑고! 경품까지 받을 수 있는 일석 삼조!<br>온라인 관객 투표에 참여해주세요!</div>
				</nav>
				<nav class="body__content body__content--c">
					<div class="bc__title">
						서울교통공사<br>신입사원 채용
						<div class="bc__title__share">
						<img src="./img/v2/share.png"/>
						</div>
					</div>
					<img class="bc__content_image bc__content_image--b" src="./img/v2/img3.png">
					<a href="http://seoulmetro.incruit.com/main/main.asp"><div class="bc__content_detail_btn"><span>채용 관련 자세히 보기</span><img src="./img/v2/small_more.png"/></div></a>
					<div class="bc__conetnt bc__conetnt--b">행복한 시민, 신뢰받는기업, 글로벌 No.1 서울 교통공사가 열정과 역량을 갖춘 인재를 아래와 같이 공개 모집합니다.</div>
				</nav>
				<nav class="body__content body__content--d">
					<div class="bc__title bc__title--b">서울교통공사 소식</div>
					<a href="http://www.seoulmetro.co.kr/kr/board.do?menuIdx=546"><img class="bc__content_image bc__content_image--b" src="./img/v2/img4.png"></a>
					<div class="bc__conetnt bc__conetnt--b">우리가 함께하는 시간이 모여 일상은 더 행복해집니다.<br>더 편리하게, 늘 안전하게, 서울교통공사가 도시를 움직입니다.</div>
				</nav> 
				<nav class="body__footer">
					<div class="bf__title">서울교통공사(Seoul Metro) 더 알아보기</div>
					<div class="df__content">
						<img class="df__content__insta_icon" src="./img/v2/instagram.png" />
						<div class="df__content__insta_link">
							<a href="https://www.instagram.com/seoulmetro.official/"><span>인스타그램 바로가기</span></a>
							<img src="./img/v2/small_more.png" />
						</div>
						<div class="df__content__copyright">
							04806 서울특별시 성동구 천호대로 346<br>대표전화: 1577-1234<br>Copyright 2017.<br>서울교통공사 All right reserved.
						</div>
					</div>
				</nav> 
			</div>
		</div>
	</nav> 
</body>
</html>