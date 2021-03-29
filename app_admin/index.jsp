<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="/css/admin/login.css" />
<link type="text/css" rel="stylesheet" href="/css/admin/qr_request.css" />
<link type="text/css" rel="stylesheet" href="/css/admin/user_question.css" />
<link type="text/css" rel="stylesheet" href="/css/admin/homepage_question.css" />
<link type="text/css" rel="stylesheet" href="/css/admin/withdraw.css" />
<link type="text/css" rel="stylesheet" href="/css/admin/user_info.css" />
<link type="text/css" rel="stylesheet" href="/css/admin/team_info.css" />
<link type="text/css" rel="stylesheet" href="/css/admin/festival_apply.css?ver=1.0.1" />
<link type="text/css" rel="stylesheet" href="/css/admin/team_video.css" />
<link type="text/css" rel="stylesheet" href="/css/admin/team_video.css" />

<link type="text/css" rel="stylesheet" href="/css/admin/artist_info.css" media="only screen and (min-width: 781px)"/>
<link type="text/css" rel="stylesheet" href="/css/admin/index.css?ver=1.0.6" media="only screen and (min-width: 781px)"/>
<link type="text/css" rel="stylesheet" href="/css/admin/login.css" media="only screen and (min-width: 781px)"/>
<link type="text/css" rel="stylesheet" href="/css/admin/notice.css" media="only screen and (min-width: 781px)"/>

<link type="text/css" rel="stylesheet" href="/css/admin/mobile/m_artist_info.css" media="only screen and (max-width: 780px)"/>
<link type="text/css" rel="stylesheet" href="/css/admin/mobile/m_index.css?ver=1.0.1" media="only screen and (max-width: 780px)"/>
<link type="text/css" rel="stylesheet" href="/css/admin/mobile/m_login.css" media="only screen and (max-width: 780px)"/>


<script type="text/javascript" src="/js/jquery/jquery-1.11.3.min.js" ></script>
<!-- Firebase App (the core Firebase SDK) is always required and must be listed first -->
<script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-app.js"></script>

<!-- Add Firebase products that you want to use -->
<script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-firestore.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-storage.js"></script>

<script type="text/javascript" src="/js/admin/index.js?ver=1.1.8" ></script>
<script type="text/javascript" src="/js/admin/login.js?ver=1.0.3" ></script>
<script type="text/javascript" src="/js/admin/qr_request.js?ver=1.0.3" ></script>
<script type="text/javascript" src="/js/admin/user_question.js?ver=1.0.1" ></script>
<script type="text/javascript" src="/js/admin/homepage_question.js?ver=1.0.1" ></script>
<script type="text/javascript" src="/js/admin/user_question_popup.js" ></script>
<script type="text/javascript" src="/js/admin/artist_info.js?ver=1.0.1" ></script>
<script type="text/javascript" src="/js/admin/user_info.js?ver=1.0.1" ></script>
<script type="text/javascript" src="/js/admin/team_info.js?ver=1.0.2" ></script>
<script type="text/javascript" src="/js/admin/withdraw.js" ></script>
<script type="text/javascript" src="/js/admin/notice.js" ></script>
<script type="text/javascript" src="/js/admin/festival_apply.js?ver=1.0.1" ></script>
<script type="text/javascript" src="/js/admin/team_video.js?ver=1.0.4" ></script>
<script type="text/javascript" src="/js/admin/user_upload_video.js?ver=1.0.3" ></script>
<script type="text/javascript" src="/js/admin/contract.js?ver=1.0.1" ></script>

<title>해피버스킹 관리자페이지</title>
</head>
<body>
	<div class="admin_page_menu">
		<div class="apm_list apm_loginout_btn" id="apm_login">
			로그인
		</div>
		<div class="apm_list" id="apm_notice">
			공지사항
		</div>
		<div class="apm_list" id="apm_userinfo">
			회원 정보
		</div>
		<div class="apm_list" id="apm_artistinfo">
			아티스트 정보
		</div>
		<div class="apm_list" id="apm_teaminfo">
			팀 정보
		</div>
		<div class="apm_list" id="apm_qrmanagement">
			QR신청 관리
			<img id="new-qr" src="/img/index/iconmenu/new.png" />
		</div>
		<div class="apm_list" id="apm_withdrawmanagement">
			후원금 지급 신청 관리
			<img id="new-w" src="/img/index/iconmenu/new.png" />
		</div>
		<div class="apm_list" id="apm_koica_apply">
			공연 신청 현황
		</div>
		<div class="apm_list" id="apm_uqmanagement">
			유저 문의 관리
			<img id="new-uq" src="/img/index/iconmenu/new.png" />
		</div>
		<div class="apm_list" id="apm_hqmanagement">
			홈페이지 문의 관리
			<img id="new-uq" src="/img/index/iconmenu/new.png" />
		</div>
		<div class="apm_list" id="apm_video">
			동영상 관리
			<img id="new-video" src="/img/index/iconmenu/new.png" />
		</div>
		<div class="apm_list" id="apm_uuv">
			유저 동영상 관리
			<img id="new-uuv" src="/img/index/iconmenu/new.png" />
		</div>
		<div class="apm_list" id="apm_contract">
			고용보험 사업장 관리
			<img id="new-uuv" src="/img/index/iconmenu/new.png" />
		</div>
	</div>
	<div class="admin_page_container" id="admin_page_container">
		 
	</div>
	<nav class="admin_page_footer" id="user_count">
		<p class="apf_block">가입자 : <span id="ucount"></span>명</p>
		<p class="apf_block">아티스트 : <span id="acount"></span>명</p>
		<p class="apf_block">팀 : <span id="tcount"></span>팀</p>
		<p class="apf_block" id="admin_day_count_p"></p>
		<p class="apf_block">앱 누적방문자 : <span id="admin_total_count"></span>명</p>
	</nav>
</body>
</html>