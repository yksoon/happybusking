<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<!-- css  -->
<link rel="stylesheet" href="/css/heartpay/panel/panel.css?ver=1.1.5" />

<!-- 세션 호출-->
<%@include file="/service_include.jsp"%>

<!--패널 -->
<div data-role="panel" id="panel" data-display="push" data-shadow="true" data-position-fixed="true" data-dismissible="false" data-theme="none">
	<nav class="p-main">
		<nav class="p-header-container">
			<div class="ph-icon-box">
				<div class="ph-icon" id="ph-home" onclick="toHome();"><img src="/img/panel_v2/home.svg"/></div>
				<a id="p-close" href="#" data-rel="close"><div class="ph-icon" id="ph-close"><img src="/img/panel_v2/close.svg"/></div></a>
			</div>
			<%
				if (USER_NO.equals("null")) {
			%>
			<div class="ph-login-container">
				<img class="ph-picture" src="/img/panel_v2/user.svg"/>
				<div class="ph-login-info">
					<p class="ph-nickname" id="nickname">로그인을 해주세요.</p>
					<div class="ph-l-btn" id="start_login">
						<img class="ph-l-icon" src="/img/panel_v2/login.svg" />
						<span class="ph-l-text">로그인</span>
					</div>
				</div>
			</div>
			<%
				} else {
			%>
			<div class="ph-login-container">
				<% if(AIMG == null || AIMG.equals("")){%>
				<img class="ph-picture" src="/img/panel_v2/user.svg"/>
				<%} else { %>
				<img class="ph-picture" src="<%=AIMG%>"/>
				<%} %>
				<div class="ph-login-info">
					<p class="ph-nickname" id="nickname"><%=NICKNAME%></p>
					<div class="ph-l-btn" id="start_logout">
						<img class="ph-l-icon" src="/img/panel_v2/logout.svg" />
						<span class="ph-l-text">로그아웃</span>
					</div>
				</div>
			</div>
			<%
				}
			%>
			<div class="ph-menu" onclick="goFestivalApply();">
				<img class="pm-front-icon" src="/img/panel_v2/write.svg"/>
				<span class="pm-text">공연모집 신청서 작성</span>
			</div>
		</nav>
		<nav class="p-body-container">
			<div class="pb-menu-container pb-common-box">
				<div class="pb-menu pb-icon-menu" onclick="goNoticeList();">
					<div class="pi-left">
						<span class="pm-text">공지사항</span>
						<img class="pm-back-icon" id="notice_new_image" src="/img/panel_v2/NEW.svg"/>
					</div>
				</div>
				<div class="pb-menu pb-icon-menu" onclick="go_store_list();">
					<div class="pi-left">
						<span class="pm-text">카페&버스킹존</span>
						<img class="pm-back-icon" src="/img/panel_v2/HOT.svg"/>
					</div>
				</div>
				<div class="pb-menu pb-icon-menu" onclick="go_artist_ranking();">
					<div class="pi-left">
						<span class="pm-text">팀·솔로 리스트</span>
					</div>
				</div>
				<div class="pb-menu pb-icon-menu pb-top-menu" id="p-perform">
					<div class="pi-left">
						<span class="pm-text">해피버스킹 멤버 신청</span>
					</div>
					<img class="pm-arrow-icon" src="/img/panel_v2/down.svg" />
				</div>
				<div class="pb-submenu-container p-perform p-off">
					<div class="pbs-menu" onclick="go_artist_become();">
						<div class="pi-left">
							<span class="pbs-text">아티스트 신청</span>
							<img class="pm-back-icon teamapply_new_image" src="/img/panel_v2/NEW.svg"/>
						</div>
					</div>
					<div class="pbs-menu" onclick="go_reg_store();">
						<div class="pi-left">
							<span class="pbs-text">사업주 신청</span>
							<img class="pm-back-icon" id="pbi_new_image" src="/img/panel_v2/NEW.svg"/>
						</div>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="goPublicBuskingInfoList();">
					<div class="pi-left">
						<span class="pm-text">공연팀 모집 정보 (공공/지자체)</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="go_perform_schedule();">
					<div class="pi-left">
						<span class="pm-text">공연 정보</span>
					</div>
				</div>
			</div>

			<%if (OWNER_CHK != null && OWNER_CHK.equals("Y")) { %>
			<div class="pb-menu pb-title-menu" id="p-owner">
				<span class="pt-text">사업자</span>
				<img class="pm-arrow-icon" src="/img/panel_v2/up.svg" />
			</div>
			<div class="pb-menu-container pb-artist-box p-owner">

				<div class="pb-menu pb-icon-menu pb-first-menu" onclick="go_reg_busking_time_each();">
					<div class="pi-left">
						<span class="pm-text">공연팀 모집 등록</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="goQrRequest();">
					<div class="pi-left">
						<span class="pm-text">QR 배너 신청</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="go_contract_list();">
					<div class="pi-left">
						<span class="pm-text">공연 계약/신청 이력</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="main_update_store();">
					<div class="pi-left">
						<span class="pm-text">카페&버스킹존 수정</span>
					</div>
				</div>

			</div>
			<% } %>
			
			
			<%if (ARTIST_CHK != null && ARTIST_CHK.equals("Y")) { %>
			<div class="pb-menu pb-title-menu" id="p-artist">
				<span class="pt-text">아티스트</span>
				<img class="pm-arrow-icon" src="/img/panel_v2/up.svg" />
			</div>
			<div class="pb-menu-container pb-artist-box p-artist">
				<%-- <div class="pb-menu pb-icon-menu pb-first-menu" onclick="go_contract_list();">
					<div class="pi-left">
						<span class="pm-text">공연 계약/신청 이력</span>
					</div>
				</div> --%>
				<div class="pb-menu pb-icon-menu pb-first-menu pb-top-menu" id="p-team">
					<div class="pi-left">
						<span class="pm-text">팀·솔로 등록/수정</span>
					</div>
					<img class="pm-arrow-icon" src="/img/panel_v2/down.svg" />
				</div>
				<div class="pb-submenu-container p-team p-off">
					<div class="pbs-menu" onclick="go_team_create();">
						<span class="pbs-text">등록하기</span>
					</div>
					<div class="pbs-menu" onclick="go_team_create_status();">
						<span class="pbs-text">정보 보기/수정</span>
					</div>
					<div class="pbs-menu" onclick="goTeamMediaRegPage();">
						<span class="pbs-text">사진·동영상 등록/수정</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="go_pbi_condition();">
					<div class="pi-left">
						<span class="pm-text">맞춤공연 조건설정</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu pb-top-menu" id="p-commu">
					<div class="pi-left">
						<span class="pm-text">아티스트 커뮤니티</span>
					</div>
					<img class="pm-arrow-icon" src="/img/panel_v2/down.svg" />
				</div>
				<div class="pb-submenu-container p-commu p-off">
					<div class="pbs-menu" onclick="go_team_board('자유');">
						<span class="pbs-text">자유게시판</span>
						<img class="pm-back-icon free_new_image" src="/img/panel_v2/NEW.svg"/>
					</div>
					<div class="pbs-menu" onclick="go_team_board('팀원모집');">
						<span class="pbs-text">팀원모집</span>
						<img class="pm-back-icon teamapply_new_image" src="/img/panel_v2/NEW.svg"/>
					</div>
					<div class="pbs-menu" onclick="go_team_board('함께공연');">
						<span class="pbs-text">함께공연</span>
						<img class="pm-back-icon together_new_image" src="/img/panel_v2/NEW.svg"/>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="goQrRequest();">
					<div class="pi-left">
						<span class="pm-text">QR배너 신청</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="goBuskingOath();">
					<div class="pi-left">
						<span class="pm-text">버스커 선서</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="goBuskingzoneList();">
					<div class="pi-left">
						<span class="pm-text">거리 버스킹존 정보</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="">
					<div class="pi-left">
						<span class="pm-text">공연 장비 렌탈 - (준비중)</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu pb-top-menu" id="p-metro">
					<div class="pi-left">
						<span class="pm-text">서울메트로</span>
					</div>
					<img class="pm-arrow-icon" src="/img/panel_v2/down.svg" />
				</div>
				<div class="pb-submenu-container p-metro p-off">
					<div class="pbs-menu" onclick="goScheduleApply();">
						<span class="pbs-text">공연 일정 신청</span>
					</div>
					<div class="pbs-menu" onclick="goScheduleList();">
						<span class="pbs-text">내 공연 일정</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="go_thanks_people();">
					<div class="pi-left">
						<span class="pm-text">나의 모바일팁박스</span>
					</div>
				</div>
				
				

				<%-- <div class="pb-menu pb-icon-menu pb-top-menu" id="p-perform_2">
					<div class="pi-left">
						<span class="pm-text">내 공연 등록/리스트</span>
					</div>
					<img class="pm-arrow-icon" src="/img/panel_v2/down.svg" />
				</div>
				<div class="pb-submenu-container p-perform_2 p-off">
					<div class="pbs-menu" onclick="go_perform_reg();">
						<span class="pbs-text">공연 일정 등록</span>
					</div>
					<div class="pbs-menu" onclick="go_rating_list();">
						<span class="pbs-text">내 공연 일정</span>
					</div>
				</div> --%>
				
				<div class="pb-menu pb-icon-menu" onclick="goMyRecruit();">
					<div class="pi-left">
						<span class="pm-text">공모 신청 내역</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="go_contract_list();">
					<div class="pi-left">
						<span class="pm-text">공연 계약/신청 이력</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="go_artist_update();">
					<div class="pi-left">
						<span class="pm-text">아티스트 정보 수정</span>
					</div>
				</div>
			</div>
			<%}%>

			<div class="pb-menu pb-title-menu" id="p-my">
				<span class="pt-text">마이페이지</span>
				<img class="pm-arrow-icon" src="/img/panel_v2/down.svg" />
			</div>
			<div class="pb-menu-container pb-my-box p-my p-off">
				<div class="pb-menu pb-icon-menu pb-first-menu" onclick="go_user_update();">
					<div class="pi-left">
						<span class="pm-text">회원 정보 수정</span>
					</div>
				</div>

				<div class="pb-menu pb-icon-menu" onclick="go_interest_team_list();">
					<div class="pi-left">
						<span class="pm-text">관심 아티스트</span>
					</div>
				</div>
				<div class="pb-menu pb-icon-menu" onclick="user_performance_record();">
					<div class="pi-left">
						<span class="pm-text">관람한 공연</span>
					</div>
				</div>
				<div class="pb-menu pb-icon-menu" onclick="go_user_performRequestList();">
					<div class="pi-left">
						<span class="pm-text">내가 요청한 공연 조회</span>
					</div>
				</div>
				<div class="pb-menu pb-icon-menu" onclick="go_artist_performRequestList();">
					<div class="pi-left">
						<span class="pm-text">요청 받은 공연 조회</span>
					</div>
				</div>
				<div class="pb-menu pb-icon-menu" onclick="go_support_list();">
					<div class="pi-left">
						<span class="pm-text">후원 내역 조회</span>
					</div>
				</div>
				<div class="pb-menu pb-icon-menu" onclick="go_bw_list();">
					<div class="pi-left">
						<span class="pm-text">내가 쓴 글</span>
					</div>
				</div>
			</div>
		</nav>
	</nav>
	<nav class="p-footer-container">
		<div class="pf-icon-box" onclick="go_happybusking_info();">
			<img src="/img/panel_v2/appinfo.svg" />
			<p>앱 정보</p>
		</div>
		<div class="pf-icon-box" onclick="go_app_contact();">
			<img src="/img/panel_v2/qna.svg" />
			<p>제휴·Q&amp;A·건의</p>
		</div>
	</nav>
	<nav class="p-blank">
	</nav>
</div>