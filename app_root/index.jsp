<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%-- <%@include file="/service_include.jsp" %>    --%>    
<%@ include file="/importhaed.jsp" %>
<!DOCTYPE html>
<html>
<!-- 카카오지도 API -->
<%-- tjf --%>
<script type="text/javascript">
    if (!navigator.userAgent.toLowerCase().match('chrome')) {
        document.write("<script src='/cordova/cordova.js'><\/script>");
    }
</script>
<script>
//www 자동으로 붙이기 자바스크립트 소스
/* var host = location.host.toLowerCase(); 
var currentAddress = location.href; 
if (host.indexOf("www")== -1) { 
	currentAddress = currentAddress.replace("//","//www."); 
	location.href = currentAddress; 
} */
</script>
<body>
<div data-role="page" id="index">
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- 헤더  -->
		<header data-role="header" id="index_header">
			<div class="ui-block-a">
				<img id="ih-logo" src="/img/index/v2/logo-white.svg" style="width:52px; margin-top:4px; margin-right:1px;">
			</div>
			
			<div class="ui-block-b">
				<%
					if (USER_NO.equals("null")) {
				%>
				<img id="ih-mypage" src="/img/index/v2/mypage1-white.svg" style="width:28px;" onclick="goMyInfo();">
				<%
				   } else {
				%>
				<img id="ih-mypage" src="/img/index/v2/mypage2-white.svg" style="width:28px;" onclick="goMyInfo();">
				<% } %>
			</div>
		
			<div class="ui-block-c">
				<a id="header_panel_btn" href="#panel"><img id="hi-panel" src="/img/index/v2/menu-white.svg" style="width:28px;"></a>
			</div>
			<div id="side_panel_btn">
				<img src="/img/index/btn.png">
			</div>
		</header>
		 <!-- 이미지 자세히보기 팝업 -->
		<div id="manual_popup">
            <div id="manual_content">
                <div id="manual_pfsc_ing_body">
                    <ul id="manual_pfsc_ing_ul">
                    </ul>
                </div>
                <%-- <div id="manual_img_selecter_div">
                    <ul id="manual_img_selecter">
                    </ul>
                </div> --%>
            </div>        
		</div>
		<div data-role="content" id="index_content">
			<nav class="ic-perform-container">
				<!-- <img class="ip-bg" src="/img/v2/main_bg__.svg" /> -->
				<div id="index_pfsc_ing">
					<div class="icp-header">
						<div class="icp-title">공연일정</div>
						<%-- <div class="icp-all-view" onclick="go_perform_schedule();">
							<p class="icp-all-view-text">더보기</p>
						</div>  --%>
					</div>
				</div>
				<div class="ic-body" id="index_pfsc_ing_body">
					<ul id="index_pfsc_ing_ul">
						<!-- 공연 일정 js에서 추가 -->
						<!-- <li class="icb-item">
							<div class="icb-item-container">
								<div class="icb-image">
									<img src=""/>
									<p class="icb-dday">D-1</p>
								</div>
								<div class="icb-tname">디즈니</div>
								<div class="icb-title">디즈니 필름 콘서트 겨울왕국</div>
							</div>
						</li> -->
					</ul>
				</div>
			</nav>
		
		<nav class="index_icon_menu">
			<div class="index_icon_item" onclick="goNoticeList();">
				<div class="index_icon_box">
					<img class="iib_icon" src="/img/index/v3_20210324/index_notice.svg"/>
					<img class="iib_n_icon" id="iib_new_board" src="/img/index/iconmenu/new.png"/>
				</div>
				<p class="iib_text">공지사항</p>
			</div>
			<div class="index_icon_item" onclick="go_team_board('자유');">
				<div class="index_icon_box">
					<img class="iib_icon" src="/img/index/v3_20210324/index_comunity.svg"/>
					<img class="iib_n_icon" id="iib_new_apply" src="/img/index/iconmenu/new.png"/>
				</div>
				<p class="iib_text">커뮤니티</p>
			</div>
			<div class="index_icon_item" onclick="go_contract_list();">
				<div class="index_icon_box">
					<img class="iib_icon" src="/img/index/v3_20210324/index_contract.svg"/>
					<img class="iib_n_icon" id="iib_new_bz" src="/img/index/iconmenu/new.png"/>
				</div>
				<p class="iib_text">공연이력</p>
			</div>
			<div class="index_icon_item" onclick="goQrRequest();">
				<div class="index_icon_box">
					<img class="iib_icon" src="/img/index/v3_20210324/index_QR.svg"/>
					<img class="iib_n_icon" id="iib_new_rt" src="/img/index/iconmenu/new.png"/>
				</div>
				<p class="iib_text">배너신청</p>
			</div>
			<div class="index_icon_item_2" id="iib_panel">
				<a href="#panel">
				<div class="index_icon_box bg_none">
					<img class="iib_icon" src="/img/index/iconmenu/all_1.svg"/>
				</div>
				</a>
			</div>
		</nav>
		
		<%-- <nav class="index_icon_menu">
			<div class="index_icon_item" onclick="go_team_board('자유');">
				<div class="index_icon_box">
					<img class="iib_icon" src="/img/index/iconmenu/1new_arti_1.svg"/>
					<img class="iib_n_icon" id="iib_new_board" src="/img/index/iconmenu/new.png"/>
				</div>
				<p class="iib_text">새 글</p>
			</div>
			<div class="index_icon_item" onclick="goPublicBuskingInfoList();">
				<div class="index_icon_box">
					<img class="iib_icon" src="/img/index/iconmenu/2recruit_1.svg"/>
					<img class="iib_n_icon" id="iib_new_apply" src="/img/index/iconmenu/new.png"/>
				</div>
				<p class="iib_text">모집정보</p>
			</div>
			<div class="index_icon_item" onclick="goBuskingzoneList();">
				<div class="index_icon_box">
					<img class="iib_icon" src="/img/index/iconmenu/3busking_zn_1.svg"/>
					<img class="iib_n_icon" id="iib_new_bz" src="/img/index/iconmenu/new.png"/>
				</div>
				<p class="iib_text">버스킹존</p>
			</div>
			<div class="index_icon_item" onclick="goShareItemList();">
				<div class="index_icon_box">
					<img class="iib_icon" src="/img/index/iconmenu/4rental_1.svg"/>
					<img class="iib_n_icon" id="iib_new_rt" src="/img/index/iconmenu/new.png"/>
				</div>
				<p class="iib_text">렌탈/공유</p>
			</div>
			<div class="index_icon_item_2" id="iib_panel">
				<a href="#panel">
				<div class="index_icon_box bg_none">
					<img class="iib_icon" src="/img/index/iconmenu/all_1.svg"/>
				</div>
				</a>
			</div>
		</nav> --%>

<!--
        <nav>
            <div>
                <button onclick="go_reg_store()">상업공간등록</button>

                <button onclick="go_reg_busking_time_each()">버스킹타임등록</button>

                <button onclick="go_test_kakaomap()">카카오지도(test)</button>

                <button onclick="go_image_working()">사진등록(test)</button>

                <button onclick="go_complete_page()">완료페이지(test)</button>

                <button onclick="go_store_list()">공연 리스트(test)</button>

                <button onclick="go_contract_list()">계약/신청 이력(test)</button>
            </div>
        </nav>
-->

		<nav class="index-btn-container">
			<div class="ibc-btn ibc-left" onclick="go_store_list();">
				<img src="/img/index/v3_20210324/index_cafe.png" /> 
				<div class="ibc-text">
					<p class="ibc-title">
						카페&버스킹존
						<!-- <img src="/img/index/v2/right-arrow-small-white.svg"/> -->
					</p>
					<p class="ibc-subtitle">공연모집부터 공연신청까지</p>
				</div>
			</div>
			<div class="ibc-btn ibc-right" onclick="goPublicBuskingInfoList();">
				<img src="/img/index/v3_20210324/index_public.png" />
				<div class="ibc-text">
					<p class="ibc-title">
						공공/지자체공연
						<!-- <img src="/img/index/v2/right-arrow-small-white.svg"/> -->
					</p>
					<p class="ibc-subtitle">다양한 모집 정보 확인</p>
				</div>
			</div>
		</nav>
		
		<%-- <nav class="index-btn-container">
			<div class="ibc-btn ibc-left" onclick="go_pfr_search();">
				<img src="/img/v2/request___.png" /> 
				<div class="ibc-text">
					<p class="ibc-title">
						공연요청
						<!-- <img src="/img/index/v2/right-arrow-small-white.svg"/> -->
					</p>
					<p class="ibc-subtitle">아티스트를 찾고 있다면</p>
				</div>
			</div>
			<div class="ibc-btn ibc-right" onclick="goRegRecruit();">
				<img src="/img/v2/recruit___.png" />
				<div class="ibc-text">
					<p class="ibc-title">
						공모등록
						<!-- <img src="/img/index/v2/right-arrow-small-white.svg"/> -->
					</p>
					<p class="ibc-subtitle">모집공고 관리를 간편하게</p>
				</div>
			</div>
		</nav> --%>
		
		
		<div class="ic-artist-container">
			<div class="ica-header">
				<p class="ica-title">팀/솔로</p>
				<div class="ica-all-btn" onclick="go_artist_ranking();">
					<p class="ica-all-text">더보기</p>
				</div>
			</div>
			
			<div id="index_chart_container">
				<!-- 아티스트 랭킹 js에서 추가 -->
				<!-- <div class="index_chart_item" id="index_chart_body_1">
					<div class="ici-left">
						<p class="ici-rank">1</p>
						<img class="ici-image" src="/img/test/309007000005.jpg">
						<div class="ici-text-box">
							<p class="ici-tname">싹쓰리</p>
							<p class="ici-genre">K-POP</p>
						</div>
					</div>
					<div class="ici-right">
						<img class="ici-icon" src="/img/index/v2/more-menu-gray.svg"/>
					</div>
				</div> -->
			</div>
		</div>
		
		
	
		<div class="licenseeInfoContent">			
			<div id="license_border" > </div>
			<div id="licensetitle">
				<pre>사업자 정보 확인</pre>
				<img src="/img/common/showingup_btn.png">
			</div>
			<div id="licensebody">
				<p>(주)가치누리</p>
				<!-- <p>대표이사 : 박준영 | 사업장등록번호 : 409-81-66509</p>
				<p>[07333]서울시 영등포구 여의대방로67길 9, 두일빌딩 407호</p> -->
				<p>고객센터 상담 가능 시간 : 평일 10:00 ~ 17:00(주말, 공휴일 제외)</p>
				<p>TEL. 02-780-2330</p>
				<p>E-MAIL. contact@happybusking.com</p>
				<p>Copyrightⓒ Gachinuri All Rights Reserved</p>
			</div>
			<ul class="licenseTitle" style="  margin-top: 5px; margin-bottom: 5px; ">
				<li>
					<p onclick="go_app_useInfoTerms();">개인정보취급방침</p>
				</li>
				<li> <p onclick="go_app_useTerms();" >이용약관</p> </li>
				<li style=" /* width: 33px; */ margin-right: unset;">
				<p onclick="go_app_contact();">문의하기</p>
				</li>
			</ul>
		</div>
		
		<!-- 어플 처음 실행시 앱 소개 팝업으로 띄워주기 -->
 		<div data-history="false" data-role="popup" id="coachMarkPopup">
			<!-- 1페이지 -->
			<div class="cmp_page" id="cmp_page_1">
				<p class="cmp_page_bigtitle">아티스트<br>고유 QR배너 제공</p>
				<div class="cmp_page_1_body">
					<img class="cmp_page_1_mainimage" src="/img/coachmark/qrfunction/1.png">
					<span class="cmp_page_1_maintext coachMarkFont cmp_accent">X배너</span>
				</div>
				<div class="cmp_page_1_content coachMarkFont">
					아티스트와 소통하고 모바일팁박스로 연결되는<br>
					아트스트 QR배너를 제공해드립니다
				</div>
				<div class="cmp_page_1_footer_image">
					<span class="coachMarkFont">주요 기능 보기</span>
					<img src="/img/coachmark/arrow.png">
				</div>
			</div> 
			<!-- 2페이지 -->
			<div class="cmp_page" id="cmp_page_2" style="display: none">
				<p class="cmp_page_bigtitle">주요기능</p>
				<p class="cmp_page_smalltitle coachMarkFont">주요 서비스 메뉴</p>
				
				<div class="cmp_page_body">
					<div class="cmp_page_left_container">
						<img src="/img/coachmark/mainfunction/mainfunction3.png">
						<div class="cmp_plc_text_container" id="cmp_plc_text_1">
							<span class="cmp_plc_imagetitle coachMarkFont">응원봉</span>
							<span class="cmp_plc_imagesubtitle">스마트폰 응원봉</span>
						</div>
						<div class="cmp_plc_text_container" id="cmp_plc_text_2">
							<span class="cmp_plc_imagetitle coachMarkFont">영상업로드</span>
							<span class="cmp_plc_imagesubtitle">공연 영상 업로드</span>
						</div>
						<div class="cmp_plc_text_container" id="cmp_plc_text_3">
							<span class="cmp_plc_imagetitle coachMarkFont">공연의뢰</span>
							<span class="cmp_plc_imagesubtitle">공연의뢰 맞춤검색</span>
						</div>
					</div>
					<div class="cmp_page_right_container">
						<img class="cmp_prc_tipbox" src="/img/coachmark/mainfunction/mainfunction2.png">
						<span class="cmp_prc_tipbox_text coachMarkFont">아티스트에게<br><span class="cmp_accent coachMarkFont">모바일 팁</span>후원</span>
					</div>
					<div class="cmp_page_bottom_container">
						<img class="cmp_pbc_image" src="/img/coachmark/mainfunction/mainfunction1.png">
						<span class="cmp_pbc_title coachMarkFont" id="cmp_pbc_text_1">아티스트<br>전체목록보기</span>
						<span class="cmp_pbc_title coachMarkFont" id="cmp_pbc_text_2">공연일정<br>전체목록보기</span>
						<span class="cmp_pbc_title coachMarkFont" id="cmp_pbc_text_3"><span class="cmp_accent coachMarkFont">QR</span>스캔으로<br>아티스트 정보 확인</span>
					</div>
				</div>
			</div>
			<!-- 3페이지 -->
			<div class="cmp_page" id="cmp_page_3" style="display: none">
				<p class="cmp_page_bigtitle">관람자기능</p>
				<p class="cmp_page_smalltitle coachMarkFont">관람자 주요 서비스 메뉴</p>
				
				<div class="cmp_page_body">
					<div class="ui-grid-a cmp_page_container">
						<div class="ui-block-a">
							<img src="/img/coachmark/spectatorfunction/1.png">
							<p class="cmp_pc_title coachMarkFont cmp_accent">아티스트</p>
							<p class="cmp_pc_subtitle">아티스트 목록 확인</p>
						</div>
						<div class="ui-block-b">
							<img src="/img/coachmark/spectatorfunction/2.png">
							<p class="cmp_pc_title coachMarkFont cmp_accent">공연의뢰</p>
							<p class="cmp_pc_subtitle">공연의뢰 맞춤검색</p>
						</div>
						
						<div class="ui-block-a">
							<img src="/img/coachmark/spectatorfunction/3.png">
							<p class="cmp_pc_title coachMarkFont cmp_accent">공연일정</p>
							<p class="cmp_pc_subtitle">아티스트 일정 확인</p>
						</div>
						<div class="ui-block-b">
							<img src="/img/coachmark/spectatorfunction/4.png">
							<p class="cmp_pc_title coachMarkFont cmp_accent">영상업로드</p>
							<p class="cmp_pc_subtitle">공연 영상 업로드</p>
						</div>
						
						<div class="ui-block-a">
							<img src="/img/coachmark/spectatorfunction/5.png">
							<p class="cmp_pc_title coachMarkFont cmp_accent">QR스캔</p>
							<p class="cmp_pc_subtitle">아티스트 정보 확인</p>
						</div>
						<div class="ui-block-b">
							<img src="/img/coachmark/spectatorfunction/6.png">
							<p class="cmp_pc_title coachMarkFont cmp_accent">응원봉</p>
							<p class="cmp_pc_subtitle">스마트폰 응원봉</p>
						</div>
					</div>
				</div>
			</div>
			<!-- 4페이지 -->
			<div class="cmp_page" id="cmp_page_4" style="display: none">
				<p class="cmp_page_bigtitle">아티스트 기능</p>
				<p class="cmp_page_smalltitle coachMarkFont">아티스트 주요 서비스 메뉴</p>
				
				<div class="cmp_page_body">
					<div class="ui-grid-a cmp_page_container">
						<div class="ui-block-a">
							<img src="/img/coachmark/artistfunction/1.png">
							<p class="cmp_pc_title coachMarkFont cmp_accent">아티스트시작</p>
							<p class="cmp_pc_subtitle">아티스트/팀 등록</p>
						</div>
						<div class="ui-block-b">
							<img src="/img/coachmark/artistfunction/2.png">
							<p class="cmp_pc_title coachMarkFont cmp_accent">공연등록</p>
							<p class="cmp_pc_subtitle">공연 일정 등록 가능</p>
						</div>
						
						<div class="ui-block-a">
							<img src="/img/coachmark/artistfunction/3.png">
							<p class="cmp_pc_title coachMarkFont cmp_accent">장비공유</p>
							<p class="cmp_pc_subtitle">버스킹 장비 공유</p>
						</div>
						<div class="ui-block-b">
							<img src="/img/coachmark/artistfunction/4.png">
							<p class="cmp_pc_title coachMarkFont cmp_accent">커뮤니티</p>
							<p class="cmp_pc_subtitle">팀 모집, 자유게시판 등</p>
						</div>
						
						<div class="ui-block-a">
							<img src="/img/coachmark/artistfunction/5.png">
							<p class="cmp_pc_title coachMarkFont cmp_accent">버스킹존공유</p>
							<p class="cmp_pc_subtitle">버스킹존 정보 공유</p>
						</div>
						<div class="ui-block-b">
							<img src="/img/coachmark/artistfunction/6.png">
							<p class="cmp_pc_title coachMarkFont cmp_accent">모바일팁박스</p>
							<p class="cmp_pc_subtitle">아티스트에게<br>모바일 팁 후원</p>
						</div>
					</div>
				</div>
			</div>
			
			<div class="cmp_footer">
				<div class="cmp_footer_btn cmp_footer_prev" id="cmp_prev_btn">
					<img src="/img/coachmark/back.png">
					<p>이전</p>
				</div>
				<div class="cmp_footer_btn cmp_footer_next" id="cmp_next_btn">
					<img src="/img/coachmark/next.png">
					<p>다음</p>
				</div>
				<div class="cmp_footer_btn cmp_footer_close" id="cmp_close_btn">
					<img src="/img/coachmark/close.png">
					<p>닫기</p>
				</div>
			</div>
		</div>
	
		<div id="indexEventPopup" style="display: none; position: fixed; top: 0; left: 0; bottom: 0; right: 0; z-index: 3; background-color: rgba(0, 0, 0, 0.7); overflow-x: hidden; overflow-y: scroll;">
			<img id="iep_image" style="width: 84%; margin-top: 20px;">
			<img id="iep_image_2" src="/img/index/mpopup2.png" style="width: 84%; margin-top: 15px; margin-bottom: 15px;" onclick="goFestivalApply();">
			
			<div style="display: flex; justify-content: space-between; height: 40px; line-height: 40px; color: #ffffff; width: 84%; margin: 0 auto;">
			<div class="iep_always_close_btn">
				<input data-role="none" type="checkbox" id="indexEventPopupChk" style="display: inline-block;">
				<label for="indexEventPopupChk" style="display: inline-block;">다시 보지 않기</label>
			</div>
			<div id="indexEventPopupClose" >
				<img style="width: 14px;" src="/img/common/close.png">
				닫기
			</div>
		</div>
		</div>
		
		<div data-history="false" data-role="popup" id="indexEventPopup2">
			<img id="iep_image">
			<div class="ui-grid-a">
				<div class="ui-block-a iep_always_close_btn">
					<input type="checkbox" id="indexEventPopup2Chk">
					<label for="indexEventPopup2Chk">다시 보지 않기</label>
				</div>
				<div class="ui-block-b iep_close_btn">
					<img id="indexEventPopup2Close" src="/img/common/close.png">
					닫기
				</div>
			</div>
		</div>
		
		<div class="recruit-popup" id="recruit-popup">
			
		</div>
		
		</div>		
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
		<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->	
		<script>
		document.addEventListener('deviceready', onDeviceReady, false);
		
		function onDeviceReady(){
			document.addEventListener("backbutton", onBackKeyDown, false);
			var splashChk = sessionStorage.getItem('splashChk');		
			var varUA = navigator.userAgent.toLowerCase();
			if(splashChk != 'Y' && (varUA.indexOf('iphone') > -1 || varUA.indexOf('iad') > -1 || varUA.indexOf('ipod') > -1)){
				navigator.splashscreen.show();
				setTimeout(function(){
					sessionStorage.setItem('splashChk', 'Y');
					navigator.splashscreen.hide();
				}, 1000);
			}
			
			if(<%= USER_NO %> != null){
				/******************************************************
				* FCM Device Token 가져오기 
				*******************************************************/
				FCMPlugin.getToken(function(token) {
					FCMPlugin.subscribeToTopic('jtech');
					
					//AJAX 로딩 표시
					var url = "/service/token/token.jsp";
					var data = "token=" + token;
					url = encodeURI(url);
					
					$.ajax({
						type: "GET",//url: "JSON/test.json",
						cache: false,
						url: url,
						data: data,
						contentType: "application/xml; charset=utf-8",
						dataType: "xml",
						timeout: 30000,
						success: function (data) {
							
							var ROOT = $(data).find("ROOT");
							var DATA = $(ROOT).find('DATA');
							if(DATA.length == 0){
								$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });		
								return;
							}
							
							$(DATA).each(function(i) {
								//XML 컬럼들 
								var RESULT = $(this).find("RESULT").text();
								var MESSAGE = $(this).find("MESSAGE").text();
								
								
								if(RESULT == "true"){
									$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
									console.log(MESSAGE);	
								}else if(RESULT == "false"){
									$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
									console.log(MESSAGE);	
								}
							
							}).promise().done(function (){
								$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
							});
							
							
						}, // end success
						error: function (xhr, message, errorThrown) {
							
						} // end error 
					});				
				}, function(err) {
					console.log('error retrieving token: ' + err);
					
				});
			}
				
				/******************************************************
				* Push Message 창 표시 
				*******************************************************/
				FCMPlugin.onNotification(function(data) {
					//var parse = JSON.stringify(data);
					var json = JSON.parse(JSON.stringify(data));
					var key = json.key;
					var value = json.value;
					if(data.wasTapped){
				      // 앱 실행중이 아닐 때 여기 들어옴 (백그라운드 프로세스 없음으로 설정해야됨!)
				      // 앱을 탭해서 들어왔다
						if(key == "/app_root/jsp/perform_request/user_perform_requestList.jsp"){
						      infoBox(value, goPage);
				 			  function goPage(){
							    	  $.mobile.changePage(key, {transition : 'none'});
							   }	
						}
						else if(key == "perform_reg"){
							infoBox("새로 등록된 공연 정보를 확인하시겠습니까?", goPage);
				 			  function goPage(){
									detail_perform_no(value);
							}	
						}
						else if(key == "perform_cancle"){
							infoBox("공연 취소 사유를 확인하시겠습니까?", goPage);
				 			  function goPage(){
									detail_perform_no(value);
							}	
						}
						else if(key == "board_reply_write"){
							infoBox("새 댓글이 등록되었습니다. 댓글을 확인 하시겠습니까?", goPage);
				 			  function goPage(){
									team_board_view_load(value);
							}	
						}
						else if(key == "board_rereply_write"){
							infoBox("새 답글이 등록되었습니다. 답글을 확인 하시겠습니까?", goPage);
				 			  function goPage(){
									team_board_view_load(value);
							}	
						}
						else if(key == "artist_perform_requestList"){
							infoBox("새로운 공연 의뢰가 들어왔습니다 !! 지금 확인 하시겠습니까?", goPage);
				 			  function goPage(){
				 				 go_artist_performRequestList();
							}	
						}
						else if(key == "support"){
							infoBox("누군가 후원을했습니다. 지금 확인 하시겠습니까?", goPage);
							function goPage(){
								go_thanks_people();
							}
						}
						else if(key == "pbiapply"){
							infoBox(" 설정하신 조건에 맞는 버스커 모집 공고가 등록되었습니다.\n지금 확인 하시겠습니까?", goPage);
							function goPage(){
								goPublicBuskingInfoList();
							}
						} 
						else if(key == "danger"){
							alert(value);
						}
						else if(key == "newboard"){
							function goPage(){
								go_team_board('1');
							}
						}
						else{
							toHome();
						}
				    }else{
				      //앱 실행중일 때 여기 들어옴
				      //앱이 실행중에 푸시가 왔따
				    	if(key == "/jsp/perform_request/user_perform_requestList.jsp"){ 
						      infoBox(value, goPage);
				 			  function goPage(){
							     loadPage('perform_request/user_perform_requestList.jsp');
							   }				      
					  	 }
						 else if(key == "board_reply_write"){
							infoBox("새 댓글이 등록되었습니다. 댓글을 확인 하시겠습니까?", goPage);
				 			  function goPage(){
									team_board_view_load(value);
							}	
						}
						else if(key == "board_rereply_write"){
							infoBox("새 답글이 등록되었습니다. 답글을 확인 하시겠습니까?", goPage);
				 			  function goPage(){
									team_board_view_load(value);
							}	
						}
						else if(key == "perform_reg"){
							infoBox("새로 등록된 공연 정보를 확인하시겠습니까?", goPage);
				 			  function goPage(){
									detail_perform_no(value);
							}	
						}
						else if(key == "perform_cancle"){
							infoBox("공연 취소 사유를 확인하시겠습니까?", goPage);
				 			  function goPage(){
									detail_perform_no(value);
							}	
						}
						else if(key == "artist_perform_requestList"){
							infoBox("새로운 공연 의뢰가 들어왔습니다 !! 지금 확인 하시겠습니까?", goPage);
				 			function goPage(){
				 				 go_artist_performRequestList();
							}	
						} else if(key == "support"){
							infoBox("누군가 후원을했습니다. 지금 확인 하시겠습니까?", goPage);
							function goPage(){
								go_thanks_people();
							}
						} else if(key == "pbiapply"){
							infoBox(" 설정하신 조건에 맞는 버스커 모집 공고가 등록되었습니다.\n지금 확인 하시겠습니까?", goPage);
							function goPage(){
								goPublicBuskingInfoList();
							}
						} else if(key == "danger"){
							alert(value);
						} 
				    }
				},function(msg) {
					console.log('onNotification callback successfully registered: ' + msg);
					//alert("FCM MSG: " + msg);
				},function(err) {
					console.log('Error registering onNotification callback: ' + err);
					//alert("FCM ERR: " + err);
				});
			
		}
		</script>	
</div>

</body>
</html>

 