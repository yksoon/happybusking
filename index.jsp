<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="/js/jquery/jquery-1.11.3.min.js"></script>

<%
	String userAgent = request.getHeader("user-agent");
	if (userAgent.indexOf("Android") > -1 || userAgent.indexOf("iPhone") > -1) {
%>
<script type="text/javascript" src="/js/homepage/m_homepage.js?ver=1.0.1"></script>
<%
	} else {
%>
<script type="text/javascript" src="/js/homepage/homepage.js?ver=1.0.2"></script>
<%
	}
%>
<link type="text/css" rel="stylesheet"
	href="/css/homepage/homepage2.css?ver=1.0.1"
	media="only screen and (min-width: 1281px)" />
<link type="text/css" rel="stylesheet" href="/css/homepage/homepage.css?ver=1.0.1"
	media="only screen and (min-width: 641px) and (max-width: 1280px)" />
<link type="text/css" rel="stylesheet"
	href="/css/homepage/m_homepage.css?ver=1.0.1"
	media="only screen and (max-width: 640px)" />

<script type="text/javascript">
	function showISEOULUPopup() {
		window.open('/homepagePopup.jsp', 'homepagePopup',
				'width=810, height=535');
	}
</script>

<head>
<title>버스킹의 모든것 ! 해피버스킹</title>
</head>
<body>
	<!--  onload="showISEOULUPopup();" -->
	<!-- 이벤트 소개 배너 -->
	<div class="hpage_event_banner">
		<div class="hpage_event_banner_container">
			<img class="hpe_close_btn" src="img/homepage/event/close_btn.png">
			<img class="hpe_move_btn" src="img/homepage/event/contest_btn2.png">
		</div>
	</div>
	<!-- 이벤트 소개 팝업 -->
	<div class="hpage_event_popup">
		<div class="hpage_event_popup_container">
			<img class="hep_main_img" src="/img/homepage/event/contest_pop_4.jpg">
			<img class="hap_close_img" id="hap_close_btn"
				src="/img/homepage/event/close_btn.png">
		</div>
	</div>
	<!-- 구글 QR 팝업 -->
	<div class="hpage_google_qr_popup">
		<div class="hpage_event_popup_container">
			<img class="hep_main_img" src="/img/homepage/google_store_qr.png">
			<img class="hap_close_img" id="gsq_close_btn"
				src="/img/homepage/event/close_btn.png">
		</div>
	</div>
	<!-- 애플 QR 팝업 -->
	<div class="hpage_apple_qr_popup">
		<div class="hpage_event_popup_container">
			<img class="hep_main_img" src="/img/homepage/apple_store_qr.png">
			<img class="hap_close_img" id="asq_close_btn"
				src="/img/homepage/event/close_btn.png">
		</div>
	</div>
	<!-- 버스커 선서 팝업 -->
	<div class="hpage_busker_oath_popup">
		<div class="hpage_event_popup_container2">
			<img class="hep_main_img" src="/img/homepage/busker_oath_bg.jpg">
			<div class="oath_text">
				<p class="oath_title">올바른 버스킹 문화 만들기 캠페인</p>
				<p class="oath_bigtitle">버스커선서</p>
				<p class="oath_content oath_content_first">나는 관객에게 존중과 감사의 마음을
					드리겠습니다.</p>
				<p class="oath_content">나는 준비된 공연 만을 대중에게 선보이겠습니다.</p>
				<p class="oath_content">나는 나의 예술이 소음이 되지 않도록 주의하겠습니다.</p>
				<p class="oath_content">나는 시각적, 행위적 공해를 일으키는 공연은 하지 않겠습니다.</p>
				<p class="oath_content">나는 공연장소를 독식하거나 무리한 경쟁을 하지 않겠습니다.</p>
				<p class="oath_content">나는 타 버스커의 공연을 존중하며, 폄하하지 않겠습니다.</p>
				<p class="oath_content">나는 주변 상인의 입장을 헤아리며, 배려하겠습니다.</p>
				<p class="oath_content">나는 공연 후 주변 환경 정리를 철저히 하겠습니다.</p>
				<p class="oath_content">나는 관객의 안전에도 각별히 신경을 쓰겠습니다.</p>
				<p class="oath_content">나는 행인들의 통행을 방해하는 공연은 하지 않겠습니다.</p>
				<p class="oath_content2">이상의 서약을 나의 자유 의사로 나의 명예를 받들겠습니다.</p>

				<p class="source_text">
					본 선서문은 배포가 가능하나 <br> <span class="source_text_line">"출처
						: 해피버스킹(happybusking.com)"</span> 을 기재해주세요.
				</p>

			</div>
		</div>
		<img class="hap_close_img" id="hbo_close_btn"
			src="/img/homepage/event/close_btn.png">
	</div>
	<!-- PC 웹페이지 사이드바 -->
	<div class="hpage_sidebar_container">
		<div class="hps_container">
			<img src="/img/homepage/logo.png">
		</div>
		<div class="hps_menu_container">
			<div class="hps_menu_title hps_menu_select_title" id="hps_menu_0">
				<span>앱 다운로드</span>
			</div>
			<div class="php_image_menu" onclick="goRecruit();">
				<img style="width: 100.5%; cursor: pointer;" src="/img/homepage/recruit-menu-4.png" />	
			</div>
			<div class="hps_menu_title" id="hps_menu_1">
				<span>공통 기능</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_2">
				<span>아티스트</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_3">
				<span>관람자</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_4">
				<span>제휴 문의</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_5">
				<span>버스커 선서</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_6" style="display: none;">
				<span>동영상 콘테스트</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_7_en">
				<div class="hps_menu_7_en">
					English site<span class="hps_menu_7_en_img"><img
						src="/img/homepage/eng.png"
						style="padding-left: 2px; width: 20px; margin-left: 7px;"></span>
				</div>
			</div>
		</div>
		<div class="hps_footer_container">
			<select class="hps_family_select">
				<option selected="selected">패밀리사이트</option>
				<option value="bizworks">비즈웍스</option>
			</select>
			<div class="hps_footer_btn_container">
				<div class="hps_footer_btn" id="hps_footer_btn_app">
					<img src="/img/homepage/appicon.png">
				</div>
				<!-- <div class="hps_footer_btn" id="hps_footer_btn_mail">
					<img src="/img/homepage/mail.png">
				</div> -->
				<div class="hps_footer_btn" id="hps_footer_btn_eng">
					<img src="/img/homepage/lang.png">
				</div>
			</div>
		</div>
	</div>

	<!-- 모바일 웹페이지 헤더 -->
	<div class="hpage_header">
		<div class="hpage_header_logo">
			<img id="hph_logo_btn" src="/img/homepage/mobile/logo_mobile.png">
			<img id="hph_menu_btn" src="/img/homepage/mobile/menu_mobile.png">
		</div>
	</div>
	<div class="hpage_header_container">
		<div class="hph_menu_title" id="hps_menu_1">
			<span>앱 다운로드</span>
		</div>
		<div class="php_image_menu" onclick="goRecruit();">
			<img src="/img/homepage/recruit-menu-4.png" />	
		</div>
		<div class="hph_menu_title" id="hps_menu_2">
			<span>소개</span>
		</div>
		<div class="hph_menu_title" id="hps_menu_3">
			<span>아티스트</span>
		</div>
		<div class="hph_menu_title" id="hps_menu_4">
			<span>관람자</span>
		</div>
		<div class="hph_menu_title" id="hps_menu_5">
			<span>제휴 문의</span>
		</div>
		<div class="hph_menu_title" id="hps_menu_6">
			<span>버스커 선서</span>
		</div>
	</div>

	<!-- 바디부분 -->
	<div class="hpage_footer">
		<img src="/img/homepage/img/1_scroll.png">
	</div>
	<div class="hpage">
		<div class="hpage_body_container">
			<div class="hpage_body" id="hpage1">
				<p class="hpage_body_title">아티스트와 관객의 소통 플랫폼</p>
				<p class="hpage_body_subtitle">해피버스킹의 다양한 기능을 소개합니다</p>
				<div class="hpage1_btn_container">
					<img id="hpage_google_btn" src="/img/homepage/img/google_btn.png">
					<img id="hpage_apple_btn" src="/img/homepage/img/apple_btn.png">
				</div>
			</div>
			<div class="hpage_info_body" id="hpage2">
				<div class="hpage_main_container">
					<div class="hpage_base_container">
						<p class="hpage_mc_title">공통 기능</p>
						<p class="title_line"></p>
						<div class="hpage_left_container">
							<div class="hpage_left_first">
								<img src="/img/homepage/v3/common/cm_sp_1.png">
							</div>
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">QR-Banner Request</p>
							<p class="hpage_main_title">아티스트 고유 QR배너 제공</p>
							<p class="hpage_content">해피버스킹은 아티스트별 고유 QR배너를 제공합니다.</p>
							<p class="hpage_content">공연중인 아티스트의 배너에 삽입된 QR을 스캔하여 아티스트 정보도
								보고 공연 의뢰 및 모바일 팁박스 결제를 통하여 아티스트를 후원할 수 있습니다.</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_common_1">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Performance Request</p>
							<p class="hpage_main_title">공연 요청</p>
							<p class="hpage_content">공연요청 위한 맞춤검색 서비스를 지원합니다.</p>
							<p class="hpage_content">지역별, 장르별 , 예산별로 조건에 맞는 아티스트를 검색할 수
								있습니다.</p>
						</div>
						<div class="hpage_right_container_2">
							<img src="/img/homepage/v3/common/cm_sp_2.png">
						</div>
					</div>
				</div>
				<div class="hpage_sub_container bg_purple">
					<div class="hpage_base_container">
						<div class="hpage_left_container">
							<img src="/img/homepage/v3/common/cm_sp_3.png">
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">BuskinZone Information</p>
							<p class="hpage_main_title">버스킹존 정보</p>
							<p class="hpage_content">누구나 버스킹이 가능한 장소 정보를 등록 할 수 있습니다.</p>
							<p class="hpage_content">주소를 입력하여 등록 할 수도 있고 주소를 모를 경우 지도에서
								해당 위치를 클릭 하면 주소가 자동으로 검색되어 등록 할 수 있습니다.</p>
							<p class="hpage_content">조작 가능한 지도와 대중교통 정보는 해피버스킹 앱이 자동으로
								등록합니다.</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_common_2">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Busking Event Information</p>
							<p class="hpage_main_title">버스킹 행사정보</p>
							<p class="hpage_content">버스킹 행사 정보를 버스커가 직접 찾지 않아도 현재 모집,
								진행중인 모든 행사 정보를 상세히 볼 수 있는 공간입니다.</p>
							<p class="hpage_content">행사 일정과 접수 일정을 한눈에 볼 수 있어 유용합니다.</p>
						</div>
						<div class="hpage_right_container_2">
							<img src="/img/homepage/v3/common/cm_sp_4.png">
						</div>
					</div>
				</div>
				<div class="hpage_sub_container bg_purple">
					<div class="hpage_base_container">
						<div class="hpage_left_container">
							<img src="/img/homepage/v3/common/cm_sp_5.png">
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">Sharing Performance Equipment</p>
							<p class="hpage_main_title">공연장비 공유</p>
							<p class="hpage_content">해피버스킹 회원이 소유하고 있는 음향, 영상, 악기, 기타 유휴
								공연장비를 공유(렌탈) 할 수 있는 공간입니다.</p>
							<p class="hpage_content">지역별, 분야별, 가격별로 검색이 가능하며, 전문 렌탈 업체도
								제약 없이 장비를 등록 할 수 있습니다.</p>
						</div>
					</div>
				</div>
			</div>
			<div class="hpage_info_body" id="hpage3">
				<div class="hpage_main_container">
					<div class="hpage_base_container">
						<p class="hpage_mc_title">아티스트 주요기능</p>
						<p class="title_line"></p>
						<div class="hpage_right_container" style="">
							<img src="/img/homepage/v3/art_sp_0.png">
						</div>
						<div class="hpage_left_container"
							style="padding-top: 10%; color: #fff;">
							<p class="hpage_sub_title">Customized performance information</p>
							<p class="hpage_main_title">맞춤공연정보 알람 서비스</p>

							<p class="hpage_content">1. 뉴스,블로그, 지역신문, 지자체/공공기관 등 공연예술가
								모집정보를 제공합니다.</p>
							<p class="hpage_content">2. 한번의 페이, 일자, 지역, 장르 조건 설정으로 내 조건에
								맞는 모집정보만 알람으로 제공합니다.</p>
							<p class="hpage_content">3. 모집 공고문에 포함되어있지 않은 페이등 구체적 정보를
								주체측에 확인 후 일관된 포맷으로 제공합니다.</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container bg_purple">
					<div class="hpage_base_container">
						<div class="hpage_left_container">
							<img src="/img/homepage/v3/art_sp_1.png">
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">QR-Banner Request</p>
							<p class="hpage_main_title">QR코드 신청</p>
							<p class="hpage_content">공연장에 비치하여 버스커를 알릴 수 있는 QR코드가 인쇄된 X배너 신청 메뉴입니다.</p>
							<p class="hpage_content">배너 사이즈는 40mm x 120mm와 60 x 180mm 두가지 종류가 있으며, 원하는 사이즈를 선택할 수 있습니다.</p>
						</div>
					</div>
				</div>

				<div class="hpage_sub_container" id="hpage_sc_artist_1">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Team·Solo Register/Fix</p>
							<p class="hpage_main_title">팀·솔로 등록/수정</p>
							<p class="hpage_content">팀 및 솔로 등록은 회원가입과 아티스트 등록을 완료 한 후 이용이
								가능하며, 앱에 노출되기 위해서는 반드시 등록해야 합니다.</p>
							<p class="hpage_content">등록 한 이후 팀의 멤버 등 정보가 변경 된 경우 수정도
								가능합니다.</p>
						</div>
						<div class="hpage_right_container_2">
							<img src="/img/homepage/v3/art_sp_2.png">
						</div>
					</div>
				</div>
				<div class="hpage_sub_container bg_purple">
					<div class="hpage_base_container">
						<div class="hpage_left_container">
							<img src="/img/homepage/v3/art_sp_3.png">
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">Performance Register/Fix</p>
							<p class="hpage_main_title">공연 등록/수정</p>
							<p class="hpage_content">공연을 예정중인 버스커가 직접 일정을 등록하는 메뉴입니다.</p>
							<p class="hpage_content">일정을 등록하게되면 공연장소 지도 및 대중교통 정보를 자동으로
								등록 제공합니다.</p>
							<p class="hpage_content">공연장소는 주소를 입력하는 방식과 지도에서 클릭하여 주소를
								확인하는 두 가지 방식을 제공합니다.</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_artist_2">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Support History</p>
							<p class="hpage_main_title">후원 내역 조회</p>
							<p class="hpage_content">모바일 팁 박스를 통해 후원된 내역을 조회할 수 있는 메뉴
								입니다.</p>
							<p class="hpage_content">내역 조회를 통하여 후원한 관객 및 날짜, 금액 등의 정보를
								확인할 수 있습니다.</p>
						</div>
						<div class="hpage_right_container_2">
							<img src="/img/homepage/v3/art_sp_4.png">
						</div>
					</div>
				</div>
				<div class="hpage_sub_container bg_purple">
					<div class="hpage_base_container">
						<div class="hpage_left_container">
							<img src="/img/homepage/v3/art_sp_5.png">
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">Busker Community</p>
							<p class="hpage_main_title">버스커 커뮤니티</p>
							<p class="hpage_content">* 자유게시판 : 버스커들의 다양한 이야기와 정보를 등록,
								공유하는 게시판 입니다.</p>
							<p class="hpage_content">* 팀원모집 게시판 : 팀원을 모집하는 게시판이며,아티스트로
								등록된 버스커는 다수의 팀에 등록이 가능합니다.</p>
							<p class="hpage_content">* 함께공연 게시판 : 팀 또는 솔로 버스커들이 연합하여 공연을
								하고자 할 때 정보를 공유하는 게시판 입니다.</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_artist_3">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Perform Request History</p>
							<p class="hpage_main_title">의뢰 내역 조회</p>
							<p class="hpage_content">회원들이 공연 요청을 통해 공연을 의뢰한 내역을 조회하는 메뉴
								입니다.</p>
							<p class="hpage_content">공연요청장소 날짜 등의 정보를 확인할 수 있으며, 의뢰한 공연이
								가능한 경우 '수락' 버튼을 클릭하면 공연 요청 회원에게 수락여부가 앱으로 전송되며, 회원이 최종 선택 시
								공연의뢰가 확정됩니다.</p>
						</div>
						<div class="hpage_right_container_2">
							<img src="/img/homepage/v3/art_sp_6.png">
						</div>
					</div>
				</div>
			</div>
			<div class="hpage_info_body" id="hpage4">
				<div class="hpage_main_container">
					<div class="hpage_base_container">
						<p class="hpage_mc_title">관람자 주요기능</p>
						<p class="title_line"></p>
						<div class="hpage_left_container">
							<img src="/img/homepage/v3/aud_sp_1.png">
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">QR Scan</p>
							<p class="hpage_main_title">QR 스캔</p>
							<p class="hpage_content">버스커 QR배너는 해피버스킹에서 제공한 버스커 고유 QR코드가
								삽입된 X배너이며, 해피버스킹 앱의 'QR신청' 메뉴를 통하여 신청하실 수 있습니다.</p>
							<p class="hpage_content">공연장에 비치한 X배너 QR코드를 관객이 스캔하면 공연중인
								버스커에 대한 다양한 정보를 볼 수 있습니다.</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_artist_1">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Mobile tipbox</p>
							<p class="hpage_main_title">모바일 팁박스</p>
							<p class="hpage_content">공연장 X배너의 QR코드 스캔 또는 아티스트 검색을 통해 좋아하는
								버스커에게 후원할 수 있습니다.</p>
							<p class="hpage_content">모바일 팁은 해피버스킹 앱을 이용한 간편 결제로 다양한 방식의
								결제를 제공합니다.</p>
						</div>
						<div class="hpage_right_container_2">
							<img src="/img/homepage/v3/aud_sp_2.png">
						</div>
					</div>
				</div>
				<div class="hpage_sub_container bg_purple">
					<div class="hpage_base_container">
						<div class="hpage_left_container">
							<img src="/img/homepage/v3/aud_sp_3.png">
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">Artist</p>
							<p class="hpage_main_title">아티스트</p>
							<p class="hpage_content">아티스트 정보는 QR코드 스캔 또는 메뉴 트리를 이용하여 확인할
								수 있으며 앱에서 팀명, 지역별, 장르별로 편리하게 검색할 수 있습니다.</p>
							<p class="hpage_content">아티스트 소개/사진 및 동영상/공연일정/공연후기 등 다양한 정보를
								제공하며, 회원이 '좋아요' 설정을 통해 해당 아티스트를 '찜'하게 되면 언제든지 찜한 아티스트의 새소식을 받아 볼
								수 있습니다.</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_artist_2">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Performance Schedule</p>
							<p class="hpage_main_title">공연 일정</p>
							<p class="hpage_content">버스커별 공연일정을 확인하는 메뉴로 날짜별, 지역별, 장르별로
								관심있는 공연을 검색할 수 있습니다.</p>
							<p class="hpage_content">교통안내 탭에있는 지도를 통해 공연장을 쉽게 확인할 수 있으며,
								대중교통 정보도 제공하고 있습니다.</p>
							<p class="hpage_content">공연후기 탭에서는 관람한 공연에 대한 후기를 남길 수 있습니다.
							</p>
						</div>
						<div class="hpage_right_container_2">
							<img src="/img/homepage/v3/aud_sp_4.png">
						</div>
					</div>
				</div>
				<div class="hpage_sub_container bg_purple">
					<div class="hpage_base_container">
						<div class="hpage_left_container">
							<img src="/img/homepage/v3/aud_sp_5.png">
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">Performance Request</p>
							<p class="hpage_main_title">공연 요청</p>
							<p class="hpage_content">공연 날짜별, 지역별, 장르별, 예산별로 맞춤형 공연 요청을
								신청할 수 있습니다.</p>
							<p class="hpage_content">다수의 버스커에게 동시에 공연 요청이 가능하며, 요청을 받은
								버스커가 공연 가능여부를 앱을 통하여 확정하면 요청자가 최종적으로 버스커를 선택하여 공연이 이루어 지게 됩니다.</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_artist_3">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Cheer Stick</p>
							<p class="hpage_main_title">스마트 응원봉</p>
							<p class="hpage_content">공연 중인 버스커에게 무한 힐을 발사하여 버스커를 흥분의 도가니로
								몰아 넣을 수 있는 공연 스킬을 극대화 시키는 효과를 제공합니다.</p>
							<p class="hpage_content">깜빡임 템포 조절이 가능한 다채로운 응원봉이 화면에 표시되며 
								스마트폰을 마구 흔들면 후레쉬 점멸과 함께 박수 환호성이 폭렬합니다.</p>
						</div>
						<div class="hpage_right_container_2">
							<img src="/img/homepage/v3/aud_sp_6.png">
						</div>
					</div>
				</div>
			</div>
			<div class="hpage_body bg_purple" id="hpage5">
				<p class="hpage_body_title">건의 사항 / 제휴 문의</p>
				<p class="hpage_body_subtitle">
					해피버스킹은 여러분의 소중한 의견을 귀담아 듣겠습니다<br>앱에 대한 건의사항이나 제휴를 원하시면 등록해주세요.
				</p>
				<input type="text" id="question_title" placeholder="제목"><br>
				<textarea rows="" cols="" id="question_content" placeholder="내용"></textarea>
				<br> <input type="text" id="request_email"
					placeholder="회신받을 이메일">
				<div class="hpage5_btn">
					<p id="hpage5_send_btn">등록하기</p>
				</div>
			</div>
			<div class="hpage_company_information_container" id="m_hpage_hcic">
				<p class="hcic_title">(주)가치누리</p>
				<p class="hcic_content">
					<!-- (주)비즈웍스 대표이사: 박준영 사업자등록번호 : 409-81-66509<br>
										[07333]서울시 영등포구 여의대방로67길 9, 두일빌딩 407호<br> -->
					TEL. 02-780-2330 (평일 10:00~17:00, 주말·공휴일 휴무) | FAX. 02-6007-1280 |
					Mail. contact@happybusking.com
				</p>
				<p class="hcic_footer">Copyrightⓒ Gachinuri All Rights Reserved</p>
			</div>
		</div>
	</div>

</body>
</html>

