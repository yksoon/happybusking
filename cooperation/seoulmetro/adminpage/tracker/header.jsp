<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String hUrl = request.getRequestURI();
	hUrl = hUrl.substring(hUrl.lastIndexOf("/") + 1, hUrl.length());
%>
<header>
	<%if(hUrl.equals("") || hUrl.equals("index.jsp")){ %>
	<nav class="h_top_wapper">
		<div class="h_top flex">
			<div class="ht_left">
				<img>
			</div>
			<div class="ht_right">
				<p class="ft_white ft_18 ft_medium cursorpointer goNotice">공지사항</p>
				<p class="ft_white ft_18 ft_medium cursorpointer goMetroArtist">메트로아티스트</p>
				<p class="ft_white ft_18 ft_medium cursorpointer goScheduleManage">일정관리</p>
				<p class="ft_white ft_18 ft_medium cursorpointer goEvaluationInfo">평가정보</p>
				<p class="ft_white ft_18 ft_medium cursorpointer goServeyResults">설문결과</p>
				<p class="ft_white ft_18 ft_medium cursorpointer goSendPush">푸시전송</p>
				<img class="cursorpointer hLoginChk goLogin" src="/img/homepage/common/login.png">
			</div>
		</div> 
	</nav>
	<%} else {%>
	<nav class="h_top_wapper h_other">
		<div class="h_top flex">
			<div class="ht_left">
				<img>
			</div>
			<div class="ht_right">
				<p class="ft_white ft_18 ft_medium cursorpointer goNotice">공지사항</p>
				<p class="ft_white ft_18 ft_medium cursorpointer goMetroArtist">메트로아티스트</p>
				<p class="ft_white ft_18 ft_medium cursorpointer goScheduleManage">일정관리</p>
				<p class="ft_white ft_18 ft_medium cursorpointer goEvaluationInfo">평가정보</p>
				<p class="ft_white ft_18 ft_medium cursorpointer goServeyResults">설문결과</p>
				<p class="ft_white ft_18 ft_medium cursorpointer goSendPush">푸시전송</p>
				<img class="cursorpointer hLoginChk goLogin" src="/img/homepage/common/login.png">
			</div>
		</div>
	</nav>
	<nav class="h_bottom_wapper bg_navy">
		<div class="h_bottom flex" id="h_bottom">
			<p class="ft_l_gray ft_14 cursorpointer goHome">HOME</p>
			<img src="/img/homepage/common/sub_next.png">
		</div>
	</nav>
	<%} %>
	<%if(!hUrl.equals("") &&!hUrl.equals("index.jsp") && !hUrl.equals("login.jsp") && !hUrl.equals("sendpush.jsp") && !hUrl.equals("noticelist.jsp")){%>
	<nav class="h_search_wapper">
		<div class="h_search">
			<span class="ft_24 ft_bold">아티스트 검색</span><img src="/img/homepage/common/search1.png">
			<div class="hs_box">
				<input class="ft_l_gray_b ft_14" data-role="none" type="text" id="h_search_text" placeholder="검색할 아티스트명을 입력해주세요.">
				<p class="hsb_btn hsb_btn_a bg_purple ft_14 ft_white cursorpointer" id="h_search_btn">아티스트 검색</p>
				<p class="hsb_btn hsb_btn_b ft_14 ft_l_black cursorpointer" id="h_clear_btn">리스트 초기화</p>
			</div>
		</div>
	</nav>
	<%}%>
	<%if(hUrl.equals("noticelist.jsp")){%>
	<nav class="h_search_wapper">
		<div class="h_search">
			<span class="ft_24 ft_bold">공지사항 검색</span><img src="/img/homepage/common/search1.png">
			<div class="hs_box">
				<input class="ft_l_gray_b ft_14" data-role="none" type="text" id="h_search_text" placeholder="검색할 공지사항 제목을 입력해주세요.">
				<p class="hsb_btn hsb_btn_a bg_purple ft_14 ft_white cursorpointer" id="h_search_btn">공지사항 검색</p>
				<p class="hsb_btn hsb_btn_b ft_14 ft_l_black cursorpointer" id="h_clear_btn">리스트 초기화</p>
			</div>
		</div>
	</nav>
	<%} %>
</header>