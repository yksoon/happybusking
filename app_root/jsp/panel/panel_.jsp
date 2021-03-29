<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<!-- css  -->
<link rel="stylesheet" href="/css/heartpay/panel/panel.css?ver1.0.3" />

<!-- 세션 호출-->
<%@include file="/service_include.jsp"%>

<!--패널 -->
<div data-role="panel" id="panel" data-display="push" data-position-fixed="true" data-dismissible="false">
	<div class="ui-grid-a" id="panel_login_div" >
		<%
			if (USER_NO.equals("null")) {
		%>
		<div class="ui-block-a">
			<a>로그인을 해주세요</a>
		</div>
		<div class="ui-block-b">
			<div class="panel_user_btn" id="start_login">
				로그인
			</div>
		</div>
		<%
			} else {
		%>
		<div class="ui-block-a">
			<a><%=NICKNAME%></a>
		</div>
		<div class="ui-block-b">
			<div class="panel_user_btn" id="start_logout">
				로그아웃
			</div>
		</div>
		<%
			}
		%>
	</div>	
	
	<!-- 이벤트 관련 부분  -->
	<div class="panel_menu_first ui-grid-a" onclick= "goFestivalApply();" >
		<div class="ui-block-a">
			<span>공연모집 신청서 작성</span>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a" onclick="goNoticeList();">
		<img class="panel_first_menu_icon" src="/img/index_main/p_notice.svg">
		<div class="ui-block-a">
			<img class="new_image" id="notice_new_image" src="/img/common/New.svg">
			<pre>공지사항</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	
	<!-- 공통부분   -->
	<div class="panel_menu_first ui-grid-a" id="panel_mypage_menu">
		<img class="panel_first_menu_icon" src="/img/index_main/p_mypage.svg">
		<div class="ui-block-a">
			<pre>마이페이지</pre>
		</div>
		<div class="ui-block-b">	
			<img src="/img/common/show_btn.svg">
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_mypage_menu panel_off" onclick="go_user_update();">
		<div class="ui-block-a">
			<pre> - 내 정보</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_mypage_menu panel_off" onclick="go_artist_update();">
		<div class="ui-block-a">
			<pre> - 내 아티스트 정보</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_mypage_menu panel_off" onclick="go_interest_team_list();">
		<div class="ui-block-a">
			<pre> - 관심 아티스트</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_mypage_menu panel_off" onclick="user_performance_record();">
		<div class="ui-block-a">
			<pre> - 내가 본 공연</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_mypage_menu panel_off" onclick="go_user_performRequestList();">
		<div class="ui-block-a">
			<pre> - 공연 요청 조회</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_mypage_menu panel_off" onclick="go_support_list();">
		<div class="ui-block-a">
			<pre> - 후원 내역 조회</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_mypage_menu panel_off" onclick="go_bw_list();">
		<div class="ui-block-a">
			<pre> - 게시글 작성 내역</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_mypage_menu panel_off" onclick="go_artist_performRequestList();">
		<div class="ui-block-a">
			<pre> - 공연 요청 현황 보기</pre>
		</div>
		<div class="ui-block-b">
		</div>
		</div>
	<div class="panel_menu_first ui-grid-a" onclick="goPublicBuskingInfoList();">
		<img class="panel_first_menu_icon" src="/img/index_main/p_schedule.svg">
		<div class="ui-block-a">
			<img class="new_image" id="pbi_new_image" src="/img/common/New.svg">
			<pre>버스킹 모집 일정</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	
	<%if (ARTIST_CHK == null || ARTIST_CHK.equals("Y")) { %>
	<div class="panel_menu_first ui-grid-a" id="panel_spactator_menu">
		<img class="panel_first_menu_icon" src="/img/index_main/p_audience.svg">
		<div class="ui-block-a">
			<pre>관람자 메뉴</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg">
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_spactator_menu panel_off" onclick="go_perform_schedule();">
		<div class="ui-block-a">
			<pre> - 전체 공연일정</pre>
		</div>
		<div class="ui-block-b">
			<!-- <img src="/img/common/show_btn.svg"> -->
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_spactator_menu panel_off" onclick="go_artist_ranking();">
		<div class="ui-block-a">
			<pre> - 전체 아티스트</pre>
		</div>
		<div class="ui-block-b">
			<!-- <img src="/img/common/show_btn.svg"> -->
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_spactator_menu panel_off" onclick="go_artist_become();">
		<div class="ui-block-a">
			<pre> - 아티스트 되기</pre>
		</div>
		<div class="ui-block-b">
			<!-- <img src="/img/common/show_btn.svg"> -->
		</div>
	</div>
	
	<%} else { %>
	<div class="panel_menu_first ui-grid-a" id="panel_spactator_menu">
		<img class="panel_first_menu_icon" src="/img/index_main/p_audience.svg">
		<div class="ui-block-a">
			<pre>관람자 메뉴</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/showing_btn1.svg">
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_spactator_menu panel_on" onclick="go_perform_schedule();">
		<div class="ui-block-a">
			<pre> - 전체 공연일정</pre>
		</div>
		<div class="ui-block-b">
			<!-- <img src="/img/common/show_btn.svg"> -->
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_spactator_menu panel_on" onclick="go_artist_ranking();">
		<div class="ui-block-a">
			<pre> - 전체 아티스트</pre>
		</div>
		<div class="ui-block-b">
			<!-- <img src="/img/common/show_btn.svg"> -->
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_spactator_menu panel_on" onclick="go_artist_become();">
		<div class="ui-block-a">
			<pre> - 아티스트 되기</pre>
		</div>
		<div class="ui-block-b">
			<!-- <img src="/img/common/show_btn.svg"> -->
		</div>
	</div>
	<%} %>	
	<!-- ------- -->
	<%if (ARTIST_CHK == null || ARTIST_CHK.equals("N")) { %>
	<!-- 로그인 안했거나, 아티스트가 아닌 경우 -->
	<div class="panel_menu_first ui-grid-a" id="panel_artist_menu" >
		<img class="panel_first_menu_icon" src="/img/index_main/p_artist.svg">
		<div class="ui-block-a">
			<pre>아티스트 메뉴</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg">
		</div>
	</div>
	
	<div class="panel_menu ui-grid-a panel_artist_menu panel_off" onclick="go_pbi_condition();">
		<div class="ui-block-a">
			<pre> - 맞춤공연 조건설정</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
		
	<div class="panel_menu ui-grid-a panel_artist_menu panel_off" id="pamCommunity">
		<div class="ui-block-a">
			<pre> - 버스커 커뮤니티</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg">
		</div>
	</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamCommunity" onclick="go_team_board('자유');">
				<div class="ui-block-a pannel_community">
				<img class="new_image free_new_image" src="/img/common/New.svg">
				<pre>자유게시판</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamCommunity" onclick="go_team_board('팀원모집');">
				<div class="ui-block-a pannel_community">
				<img class="new_image teamapply_new_image" src="/img/common/New.svg">
				<pre>팀원모집</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamCommunity" onclick="go_team_board('함께공연');">
				<div class="ui-block-a pannel_community">
				<img class="new_image together_new_image" src="/img/common/New.svg">
				<pre>함께공연</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		
	<div class="panel_menu ui-grid-a panel_artist_menu panel_off" onclick="goBuskingOath();" id="pam_1">
		<div class="ui-block-a">
			<pre> - 버스커 선서</pre>
		</div>
		<div class="ui-block-b">
			<!-- <img src="/img/common/show_btn.svg"> -->
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_artist_menu panel_off" id="pamTeam">
		<div class="ui-block-a">
			<pre> - 팀·솔로 등록 / 수정</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg">
		</div>
	</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamTeam" onclick="go_team_create();">
				<div class="ui-block-a">
				<pre>신청하기</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamTeam" onclick="go_team_create_status();">
				<div class="ui-block-a">
				<pre>현황 보기 / 수정</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamTeam" onclick="goTeamMediaRegPage();">
				<div class="ui-block-a">
				<pre>사진·동영상 등록 / 수정</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>	
		
	<div class="panel_menu ui-grid-a panel_artist_menu panel_off" onclick="goQrRequest();">
		<div class="ui-block-a" style="position: relative;">
			<img class="hot_image" src="/img/common/hot.svg">
			<pre> - QR배너 신청</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	
	<div class="panel_menu ui-grid-a panel_artist_menu panel_off" id="pamPerform">
		<div class="ui-block-a">
			<pre> - 공연 등록 / 내역</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg">
		</div>
	</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamPerform" onclick="go_perform_reg();">
				<div class="ui-block-a">
				<pre>공연 일정 등록</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamPerform" onclick="go_rating_list();">
				<div class="ui-block-a">
				<pre>내 공연 내역</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		
	<div class="panel_menu ui-grid-a panel_artist_menu panel_off" id="pamSeoulMetro">
		<div class="ui-block-a">
			<pre> - 서울메트로</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg">
		</div>
	</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamSeoulMetro" onclick="goScheduleApply();">
				<div class="ui-block-a">
				<pre>공연 일정 신청</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamSeoulMetro" onclick="goScheduleList();">
				<div class="ui-block-a">
				<pre>내 공연 일정</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
	
	<div class="panel_menu ui-grid-a panel_artist_menu panel_off" onclick="goMyRecruit();">
		<div class="ui-block-a">
			<pre> - 공모 신청 내역</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	
	<div class="panel_menu ui-grid-a panel_artist_menu panel_off" onclick="go_thanks_people();">
		<div class="ui-block-a">
			<pre> - 후원 받은 내역</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<%} else { %>
	<!-- 아티스트인 경우 -->
	<div class="panel_menu_first ui-grid-a" id="panel_artist_menu" >
		<img class="panel_first_menu_icon" src="/img/index_main/p_artist.svg">
		<div class="ui-block-a">
			<pre>아티스트 메뉴</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/showing_btn1.svg">
		</div>
	</div>
	
	<div class="panel_menu ui-grid-a panel_artist_menu panel_on" onclick="go_pbi_condition();">
		<div class="ui-block-a">
			<pre> - 맞춤공연 조건설정</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	
	<div class="panel_menu ui-grid-a panel_artist_menu panel_on" id="pamCommunity">
		<div class="ui-block-a">
			<pre> - 버스커 커뮤니티</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/showing_btn1.svg">
		</div>
	</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamCommunity" onclick="go_team_board('자유');">
				<div class="ui-block-a pannel_community">
				<img class="new_image free_new_image" src="/img/common/New.svg">
				<pre>자유게시판</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamCommunity" onclick="go_team_board('팀원모집');">
				<div class="ui-block-a pannel_community">
				<img class="new_image teamapply_new_image" src="/img/common/New.svg">
				<pre>팀원모집</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamCommunity" onclick="go_team_board('함께공연');">
				<div class="ui-block-a pannel_community">
				<img class="new_image together_new_image" src="/img/common/New.svg">
				<pre>함께공연</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
	
	<div class="panel_menu ui-grid-a panel_artist_menu panel_on" onclick="goBuskingOath();">
		<div class="ui-block-a">
			<pre> - 버스커 선서</pre>
		</div>
		<div class="ui-block-b">
			<!-- <img src="/img/common/show_btn.svg"> -->
		</div>
	</div>
	<div class="panel_menu ui-grid-a panel_artist_menu panel_on" id="pamTeam">
		<div class="ui-block-a">
			<pre> - 팀·솔로 등록 / 수정</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg">
		</div>
	</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamTeam" onclick="go_team_create();">
				<div class="ui-block-a">
				<pre>등록하기</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamTeam" onclick="go_team_create_status();">
				<div class="ui-block-a">
				<pre>현황 보기 / 수정</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamTeam" onclick="goTeamMediaRegPage();">
				<div class="ui-block-a">
				<pre>사진·동영상 등록 / 수정</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>	
		
	<div class="panel_menu ui-grid-a panel_artist_menu panel_on" onclick="goQrRequest();" id="pam_3">
		<div class="ui-block-a" style="position: relative;">
			<img class="hot_image" src="/img/common/hot.svg">
			<pre> - QR배너 신청</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	
	<div class="panel_menu ui-grid-a panel_artist_menu panel_on" id="pamPerform">
		<div class="ui-block-a">
			<pre> - 공연 등록 / 내역</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg">
		</div>
	</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamPerform" onclick="go_perform_reg();">
				<div class="ui-block-a">
				<pre>공연 일정 등록</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamPerform" onclick="go_rating_list();">
				<div class="ui-block-a">
				<pre>내 공연 내역</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
	
	<div class="panel_menu ui-grid-a panel_artist_menu panel_on" id="pamSeoulMetro">
		<div class="ui-block-a">
			<pre> - 서울메트로</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg">
		</div>
	</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamSeoulMetro" onclick="goScheduleApply();">
				<div class="ui-block-a">
				<pre>공연 일정 신청</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
		<div class="panel_sub_menu ui-grid-a panel_off pamSeoulMetro" onclick="goScheduleList();">
				<div class="ui-block-a">
				<pre>내 공연 일정</pre>
			</div>
			<div class="ui-block-b">
			</div>
		</div>
	
	<div class="panel_menu ui-grid-a panel_artist_menu panel_on" onclick="goMyRecruit();">
		<div class="ui-block-a">
			<pre> - 공모 신청 내역</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	
	<div class="panel_menu ui-grid-a panel_artist_menu panel_on" onclick="go_thanks_people();">
		<div class="ui-block-a">
			<pre> - 후원 받은 내역</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	
	<%} %>	
	<div class="panel_menu_first ui-grid-a" onclick="goTipboxList();">
		<img class="panel_first_menu_icon" src="/img/index_main/p_tipbox.svg">
		<div class="ui-block-a">
			<pre>모바일 팁박스</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a" onclick="go_pfr_search();">
		<img class="panel_first_menu_icon" src="/img/index_main/p_request.svg">
		<div class="ui-block-a">
			<pre>공연요청</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a" onclick="goBuskingzoneList();">
		<img class="panel_first_menu_icon" src="/img/index_main/p_bzone.svg">
		<div class="ui-block-a">
			<img class="new_image" id="bz_new_image" src="/img/common/New.svg">
			<pre>버스킹존</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a" onclick="goShareItemList();">
		<img class="panel_first_menu_icon" src="/img/index_main/p_equipment.svg">
		<div class="ui-block-a">
			<img class="new_image" id="si_new_image" src="/img/common/New.svg">
			<pre>공연 장비 공유</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a" onclick="go_app_contact();">
		<img class="panel_first_menu_icon" src="/img/index_main/p_qna.svg">
		<div class="ui-block-a">
			<pre>제휴·Q&#38;A·건의</pre>
		</div>
		<div class="ui-block-b">
		</div>
	</div>
	
	<div class="panel_menu_first ui-grid-a" onclick="go_happybusking_info();">
		<div class="ui-block-a">
			<div class="panel_app_info">앱 정보</div>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	
	<%if (ARTIST_CHK != null && ARTIST_CHK.equals("A")) {  %>
	<div class="panel_menu_first ui-grid-a"  onclick="goTestMap();">
		<div class="ui-block-a">
			<pre style="color: #888888;">파일업로드 테스트</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a" onclick="goPublicBuskingInfoWrite();">
		<div class="ui-block-a">
			<pre style="color: #888888;">버스킹 모집 일정 등록</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a"  onclick="go_pbi_condition();">
		<div class="ui-block-a">
			<pre style="color: #888888;">맞춤공연설정 테스트</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a" onclick="sendSinglePushMessage();">
		<div class="ui-block-a">
			<pre style="color: #888888;">개별 푸시 메시지</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a" onclick="goNaverLoginPage();">
		<div class="ui-block-a">
			<pre style="color: #888888;">간편로그인 테스트</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a" onclick="goKakaoLoginPage();">
	<!-- onclick="location.href='javascript:loginWithKakao()';" -->

		<div class="ui-block-a">
			<pre style="color: #888888;">카카오로그인 테스트</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a" onclick="goFacebookLoginPage();">
		<div class="ui-block-a">
			<pre style="color: #888888;">페이스북로그인 테스트</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a"  onclick="kakaoPaymentTest();">
		<div class="ui-block-a">
			<pre style="color: #888888;">카카오페이 테스트</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a"  onclick="goTelTest();">
		<div class="ui-block-a">
			<pre style="color: #888888;">전화번호 테스트</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a"  onclick="goArtistPush();">
		<div class="ui-block-a">
			<pre style="color: #888888;">아티스트 전체 푸시</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a"  onclick="sendMetroApplyPushMessage();">
		<div class="ui-block-a">
			<pre style="color: #888888;">메트로 공지 푸시</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	<div class="panel_menu_first ui-grid-a"  onclick="createRandomNum();">
		<div class="ui-block-a">
			<pre style="color: #888888;">번호 생성 테스트</pre>
		</div>
		<div class="ui-block-b">
			<img src="/img/common/show_btn.svg"> 
		</div>
	</div>
	<%} %>
</div>