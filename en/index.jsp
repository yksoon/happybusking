<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="/js/jquery/jquery-1.11.3.min.js" ></script>

<%
	String userAgent = request.getHeader("user-agent");
	if(userAgent.indexOf("Android") > -1 || userAgent.indexOf("iPhone") > -1){
%>
	<script type="text/javascript" src="/js/homepage/m_homepage.js" ></script>
<%
	}else{
%>
	<script type="text/javascript" src="/js/homepage/homepage.js" ></script>
<%
	}
%>	
<link type="text/css" rel="stylesheet" href="/css/homepage/en_homepage2.css?ver=1.0.1" media="only screen and (min-width: 1281px)"/>
<link type="text/css" rel="stylesheet" href="/css/homepage/en_homepage.css?ver=1.0.1" media="only screen and (min-width: 641px) and (max-width: 1280px)"/>
<link type="text/css" rel="stylesheet" href="/css/homepage/m_homepage.css?ver=1.0.1" media="only screen and (max-width: 640px)"/>

<head>
	<title>Everything about Busking ! HappyBusking</title>
</head>
<body>
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
			<img class="hap_close_img" id="hap_close_btn" src="/img/homepage/event/close_btn.png">
		</div>
	</div>
	<!-- 구글 QR 팝업 -->	
	<div class="hpage_google_qr_popup">
		<div class="hpage_event_popup_container">
			<img class="hep_main_img" src="/img/homepage/google_store_qr.png">
			<img class="hap_close_img" id="gsq_close_btn" src="/img/homepage/event/close_btn.png">
		</div>
	</div>
	<!-- 애플 QR 팝업 -->	
	<div class="hpage_apple_qr_popup">
		<div class="hpage_event_popup_container">
			<img class="hep_main_img" src="/img/homepage/apple_store_qr.png">
			<img class="hap_close_img" id="asq_close_btn" src="/img/homepage/event/close_btn.png">
		</div>
	</div>
	<!-- 버스커 선서 팝업 -->	
	<!-- 버스커 선서 팝업 -->	
	<div class="hpage_busker_oath_popup" >
		<div class="hpage_event_popup_container2">
			<img class="hep_main_img" src="/img/homepage/busker_oath_bg.jpg">
			<div class="oath_text">
				<p class="oath_title">Campaign for Making Upright Busking Culture</p>
				<p class="oath_bigtitle">Busker Deposition</p>
				<p class="oath_content">I will always respect and appreciate audience.</p>
				<p class="oath_content">I will always show prepared shows only to audience.</p>
				<p class="oath_content">I will stay alert not to make disturbing noise instead of art.</p>
				<p class="oath_content">I will not make visually and actively disturbing performance.</p>
				<p class="oath_content">I will not make over competitive behavior or monopolize busking zone.</p>
				<p class="oath_content">I will respect other buskers’ performance, and will not disparage.</p>
				<p class="oath_content">I will consider and nearby tradespeople’s position.</p>
				<p class="oath_content">I will be extra careful about arrangement of environment.</p>
				<p class="oath_content">I will be extra careful about safety of audience.</p>
				<p class="oath_content">I will not make performance which is disturbing passengers.</p>
				<p class="oath_content2">I will not make performance which is disturbing passengers.</p>
				
				<p class="source_text">This Deposition is distributable but<br>
				<span class="source_text_line">"Copyright : HappyBusking(happybusking.com)"</span> need to be mentioned together.</p>
				
			</div>
		</div>
		<img class="hap_close_img" id="hbo_close_btn" src="/img/homepage/event/close_btn.png">
	</div>
	<!-- PC 웹페이지 사이드바 -->
	<div class="hpage_sidebar_container">
		<div class="hps_container">
			<img src="/img/homepage/logo.png">
		</div>
		<div class="hps_menu_container">
			<div class="hps_menu_title hps_menu_select_title" id="hps_menu_0">
				<span>App Download</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_1">
				<span>Common</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_2">
				<span>Artist</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_3">
				<span>Audience</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_4">
				<span>Cooperation Request</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_5">
				<span>Busker Oath</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_6" style="display:none;">
				<span>Video Contest</span>
			</div>
			<div class="hps_menu_title" id="hps_menu_7_ko">
				<div class="hps_menu_7_ko">Korean site<span class="hps_menu_7_ko_img"><img src="/img/homepage/korean.png" style="width: 23px;margin-left: 7px; padding-left:2px;"></span></div>
			</div>
		</div>
		<div class="hps_footer_container">
			<select class="hps_family_select">
				<option>Family sites</option>
				<option value="bizworks">Bizworks</option>
			</select>
			<div class="hps_footer_btn_container">
				<div class="hps_footer_btn" id="hps_footer_btn_app">
					<img src="/img/homepage/appicon.png">
				</div>
				<!-- <div class="hps_footer_btn" id="hps_footer_btn_mail">
					<img src="/img/homepage/mail.png">
				</div> -->
				<div class="hps_footer_btn" id="hps_footer_btn_kor">
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
			<span>App Download</span>
		</div>
		<div class="hph_menu_title" id="hps_menu_2">
			<span>Introduction</span>
		</div>
		<div class="hph_menu_title" id="hps_menu_3">
			<span>Artist</span>
		</div>
		<div class="hph_menu_title" id="hps_menu_4">
			<span>Audience</span>
		</div>
		<div class="hph_menu_title" id="hps_menu_5">
			<span>Cooperation Request</span>
		</div>
		<div class="hph_menu_title" id="hps_menu_6">
			<span>Busker Oath</span>
		</div>
	</div>
	
	<!-- 바디부분 -->
	<div class="hpage_footer">
		<img src="/img/homepage/img/1_scroll.png">
	</div>
	<div class="hpage">
		<div class="hpage_body_container">
			<div class="hpage_body" id="hpage1">
				<p class="hpage_body_title">Communication Platform for Artist and Audience</p>
				<p class="hpage_body_subtitle">Introducing various functions of HappyBusking</p>
				<div class="hpage1_btn_container">
					<img id="hpage_google_btn" src="/img/homepage/img/google_btn.png">
					<img id="hpage_apple_btn" src="/img/homepage/img/apple_btn.png">
				</div>
			</div>
			<div class="hpage_info_body" id="hpage2">
				<div class="hpage_main_container">
					<div class="hpage_base_container">
						<p class="hpage_mc_title">Common Function</p>
						<p class="title_line"></p>
						<div class="hpage_left_container">
							<img src="/img/homepage/v3/common/cm_sp_1.png">
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">QR-Banner Request</p>
							<p class="hpage_main_title">Provide Artists’ inherent QR-Banner</p>
							<p class="hpage_content">
								HappyBusking Provides inherent QR-Banner for each Artists.
							</p>
							<p class="hpage_content">
								By scanning QR-Code inserted in performing Artist’s banner Audience can see Artist’s information and support Artists through Performance request and Mobile Tip-Box payment.
							</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_common_1">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Performance Request</p>
							<p class="hpage_main_title">Performance Request</p>
							<p class="hpage_content">
								Customized Search available
							</p>
							<p class="hpage_content">
								Regional search, Categorized search, Budgetary search available.
							</p>
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
							<p class="hpage_main_title">BuskingZone Information</p>
							<p class="hpage_content">
								Anyone can register information about places at which people can perform.
							</p>
							<p class="hpage_content">
								Can register inserting address and if not aware of address, also can insert address with auto-searching clicking on map.
							</p>
							<p class="hpage_content">
								Controllable map and Transportation information is auto registered by HappyBusking Application.
							</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_common_2">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Busking Event Information</p>
							<p class="hpage_main_title">Busking Event Information</p>
							<p class="hpage_content">
								Without searching about busking event information, Users can look up detailed busking information ongoing.
							</p>
							<p class="hpage_content">
								Can check event date and application date with a single look.
							</p>
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
							<p class="hpage_main_title">Performance Equipment Sharing</p>
							<p class="hpage_content">
								HappyBusking Users can share(rent) their own musical equipment, musical instruments and recorders not in use.
							</p>
							<p class="hpage_content">
								Regional, Categorized and Budgetary search are all available, and professional rental companies can also register equipment without any restriction.
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="hpage_info_body" id="hpage3">
				<div class="hpage_main_container">
					<div class="hpage_base_container">
						<p class="hpage_mc_title">Main Features for Artists</p>
						<div class="hpage_left_container">
							<img src="/img/homepage/v3/art_sp_1.png">
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">QR-Banner Request</p>
							<p class="hpage_main_title">QR-Banner Request</p>
							<p class="hpage_content">
								Page for Artists to request X-Banner with inherent QR-Code with which Artists can advertise themselves.
							</p>
							<p class="hpage_content">
								Artists can choose between two size options which are 40CM x 120CM and 60CM x 180CM.
							</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_artist_1">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Team·Solo Registration/Fix</p>
							<p class="hpage_main_title">Team·Solo Registration/Fix</p>
							<p class="hpage_content">
								Team·Solo Registration is available after joining and artist registration, and must register to be shown on app.
							</p>
							<p class="hpage_content">
								Can fix after registration when information such as team member change.
							</p>
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
							<p class="hpage_main_title">Performance Registration/Fix</p>
							<p class="hpage_content">
								Menu for Buskers to register their own performance schedule planning.
							</p>
							<p class="hpage_content">
								If registered schedule, performance location map and transportation information is auto registered.
							</p>
							<p class="hpage_content">
								Can register performance location through inserting address or clicking on map.
							</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_artist_2">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Support History</p>
							<p class="hpage_main_title">Donation History</p>
							<p class="hpage_content">
								Users can check donation history through mobile Tip-Box.
							</p>
							<p class="hpage_content">
								Can check audience who made donation, date and donation price.
							</p>
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
							<p class="hpage_main_title">Busker Community
							<p class="hpage_content">
								* Free Board: Board on which Buskers can register and share various stories and information.
							</p>
							<p class="hpage_content">
								* Team-Up Board: Board on which you can find artists you can perform with, and Buskers registered as artist can be registered at multiple teams.
							</p>
							<p class="hpage_content">
								* Perform-Together Board: Board on which team and solo buskers share information when they try to do collaborations.
							</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_artist_3">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Perform Request History</p>
							<p class="hpage_main_title">Perform Request History</p>
							<p class="hpage_content">
							In this menu Users can check the history of performance request through performance request.
							</p>
							<p class="hpage_content">
								Can check the performance request information such as location and date, and if Artists accept performance request by clicking on ‘Accept’ button, acceptance status will be sent to user made request through application, if user made final request agreement then the performance request is completed.
							</p>
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
						<p class="hpage_mc_title">Main features for Audience</p>
						<div class="hpage_left_container">
							<img src="/img/homepage/v3/aud_sp_1.png">
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">QR Scan</p>
							<p class="hpage_main_title">QR-Code Scan</p>
							<p class="hpage_content">
								Busker QR-Banner is X-Banner with inherent Busker QR-Code provided by HappyBusking.
								And also, can apply for this through QR-Request menu of Happy-Busking application.

							</p>
							<p class="hpage_content">
								If Audience scan QR-Code located in busking place, people can see various information about performing busker.
							</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_artist_1">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Mobile tipbox</p>
							<p class="hpage_main_title">Mobile Tip-Box</p>
							<p class="hpage_content">
								People can donate buskers they like through scanning QR-Code of X-Banner or Artist Searching.
							</p>
							<p class="hpage_content">
								Mobile tipping is simple payment through HappyBusking Application, and various payment methods are provided.
							</p>
						</div>
						<div class="hpage_right_container_2">
							<img src="/img/homepage/v3/aud_sp_2.png">
						</div>
					</div>
				</div>
				<div class="hpage_sub_container bg_purple">
					<div class="hpage_base_container">
						<div class="hpage_left_container">
							<img src="/img/homepage/v3/art_sp_3.png">
						</div>
						<div class="hpage_right_container">
							<p class="hpage_sub_title">Artist</p>
							<p class="hpage_main_title">Artist</p>
							<p class="hpage_content">
								Artist information is open and can check through QR-Code Scanning or menu tree and can check search conveniently through Team name, Regional, or Categorized Search.
							</p>
							<p class="hpage_content">
								Various Information such as Artist Introduction/Photo &#38; Video/Performance Schedule/Performance Ratings and comments is provided, and if Users ‘dib’ on the Artist through ‘Like’ setting, the Users can get new information about the artist ‘liked’.
							</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_artist_2">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Performance Schedule</p>
							<p class="hpage_main_title">Performance Schedule</p>
							<p class="hpage_content">
								Performance Schedule is menu in which Users can check Buskers’ performance schedules, and can also search using date, region and genre.
							</p>
							<p class="hpage_content">
								Can easily check performing place through traffic information tab, and also providing traffic information.
							</p>
							<p class="hpage_content">
								On Performance review tab Users can review performance they watched.
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
							<p class="hpage_main_title">Performance Request</p>
							<p class="hpage_content">
								Users can make regional, categorized and budgetary request for customized performance.
							</p>
							<p class="hpage_content">
								Multiple requests to buskers can be made simultaneously, and if buskers accept request, finally perform contract is made by requester’s selection of busker to perform on.
							</p>
						</div>
					</div>
				</div>
				<div class="hpage_sub_container" id="hpage_sc_artist_3">
					<div class="hpage_base_container">
						<div class="hpage_left_container_2">
							<p class="hpage_sub_title">Cheer Stick</p>
							<p class="hpage_main_title">Smart Cheer-Stick</p>
							<p class="hpage_content">
								Smart Cheer-Stick maximize buskers’ performance skill making them excited as hell shooting infinite healing beam.
							</p>
							<p class="hpage_content">
								Flicking tempo controllable cheer stick images with various colors are shown on application and when shaken, shouting sound is made through speaker with flash lights.
							</p>
						</div>
						<div class="hpage_right_container_2">
							<img src="/img/homepage/v3/aud_sp_6.png">
						</div>
					</div>
				</div>
			</div>
			<div class="hpage_body bg_purple" id="hpage5">
				<p class="hpage_body_title">Suggestion / Cooperation request</p>
				<p class="hpage_body_subtitle">HappyBusking will listen to your invaluable opinions.<br>If you have suggestions or Cooperation requests, please register.</p>
				<p class="hpage_body_subtitle">**HappyBusking is looking for Global partners to run Happybusking with local language<br>in their own countries using Happybusking app & Business model.<br>If interested send request here</p>
				
				<input type="text" id="question_title" placeholder="Title"><br>
				<textarea rows="" cols="" id="question_content" placeholder="Contents"></textarea><br>
				<input type="text" id="request_email" placeholder="Email to receive replies.">
				<div class="hpage5_btn">
					<p id="hpage5_send_btn">Register</p>
				</div>
			</div>
			<div class="hpage_company_information_container" id="m_hpage_hcic">
				<p class="hcic_title">Bizworks Co., Ltd.</p>
				<p class="hcic_content">CEO of the Bizworks Co., Ltd.: Park Company Registration Number : 409-81-66509<br>
										[07333]11, Yeouidaebang-ro 67-gil, Yeongdeungpo-gu, Seoul, Republic of Korea<br>
										TEL. 02-780-2328 | FAX. 02-6007-1280 | Mail. contact@bizworks.co.kr</p>
				<p class="hcic_footer">Copyrightⓒ 2009-2017 Bizworks All Rights Reserved</p>
			</div>
		</div>
	</div>
	
</body>
</html>

 