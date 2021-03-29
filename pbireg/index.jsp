<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pbireg/importhead.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
*{
	font-size: 14px;
}
.indexWrapper {
	width: 780px;
	margin: 0 auto;
}

input, textarea {
	border: 1px solid #d9d9d9;
	width: 100%;
	height: 50px;
}

input[type=text], input[type=number]{
	text-indent: 15px;
}

input[type=date] {
    text-align: center;
    background-color: #ffffff;
}

input[type="file"]{
	display: none;
}

textarea{
	height: 500px;
    resize: none;
    margin-bottom: 50px;
}

.flex {
	display: flex;
}

.title {
    font-size: 15px;
    margin-top: 20px;
    margin-bottom: 5px;
}

.title span {
    font-size: 15px;
    color: #8753c7;
}

#map{
	width: 100%;
	height: 500px;
	margin-top: 10px;
}

.btn {
    width: 150px;
    text-align: center;
    font-size: 15px;
    height: 50px;
    line-height: 3.5em;
    background-color: #8753c7;
    color: #ffffff;
    cursor: pointer;
}

.btn_b {
    width: 250px;
    text-align: center;
    font-size: 15px;
    height: 50px;
    line-height: 3.5em;
    background-color: #8753c7;
    color: #ffffff;
    cursor: pointer;
    margin: 0 auto;
    margin-top: 20px;
}

.loading-popup {
    position: fixed;
    top: 0;
    left: 0;
    z-index: 10;
    width: 100vw;
    height: 100vh;
    background-color: rgba(0, 0, 0, 0.5);
    display: none;
}

.loading-background {
    position: relative;
    width: 250px;
    height: 250px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    background-color: #f6f6f6;
    border-radius: 15px;
}

.loading-background img {
    margin-top: 95px;
}

.loading-background p {
    margin-top: 15px;
}

@media all and (max-width: 768px){
	.indexWrapper {
	    margin: 0 auto;
	    padding: 15px;
	    width: auto;
	}
	
	input, textarea {
		border: 1px solid #d9d9d9;
		width: 100%;
		height: 50px;
	}
	
	input[type=text]{
		text-indent: 15px;
	}
	
	input[type=date] {
	    text-align: center;
	    width: 48%;
	    background-color: #ffffff;
	}
	
	input[type="file"]{
		display: none;
	}
	 
	.datebox{
		justify-content: space-between;
	}
	
	textarea{
		height: 300px;
	    resize: none;
	    margin-bottom: 50px;
	}
	
	.flex {
		display: flex;
	}
	
	.title {
	    font-size: 15px;
	    margin-top: 20px;
	    margin-bottom: 5px;
	}
	
	#map{
		width: 100%;
		height: 300px;
		margin-top: 10px;
	}
	
	.btn {
	    width: 150px;
	    text-align: center;
	    font-size: 15px;
	    height: 50px;
	    line-height: 3.5em;
	    background-color: #8753c7;
	    color: #ffffff;
	    cursor: pointer;
	}
	
	.btn_b {
	    text-align: center;
	    font-size: 15px;
	    height: 50px;
	    line-height: 3.5em;
	    background-color: #8753c7;
	    color: #ffffff;
	    cursor: pointer;
  		  margin-top: 20px;
	}
	
	input[type=checkbox] {
	    width: 15px;
	    margin: 0;
	    padding: 0;
	}
	label {
	    line-height: 48px;
	    margin: 0px 15px 0px 2px !important;
	}

	.header{
		display: flex;
		justify-content: flex-end;
	}
	
	#listbtn{
		width: 80px;
		height: 35px;
		line-height: 35px;
		margin-right: 20px;
		background-color: #898989;
		color: #ffffff;
	}
}

</style>
<link id="jqm_css" type="text/css" rel="stylesheet" media="screen and (max-width:788px)" href="/css/jquery-mobile/jquery.mobile-1.4.5.min.css" />
<link type="text/css" rel="stylesheet" href="/css/heartpay/common/common.css?ver=1.0.0" />
<link type="text/css" rel="stylesheet" href="/css/heartpay/index/index.css?ver=1.0.0" />
<script type="text/javascript" src="/pbireg/resource/js/active/index.js?ver=1.1.1" ></script>
<link type="text/css" rel="stylesheet" href="/css/heartpay/custom_select_box/genre_select.css?ver=1.0.0" />
<script type="text/javascript" src="/js/heartpay/custom_select_box/custom_select_box_func.js?ver=1.0.0" ></script>
<script type="text/javascript" src="/js/heartpay/custom_select_box/genre_select.js?ver=1.0.0" ></script>
</head>
<body>
	<nav class="header">
		<p id="listbtn">리스트로</p>
	</nav>
	<nav class="indexWrapper">
		<!-- <p class="title">신청서 양식 파일</p>
		<input type="text" id="change-appfile" data-role="none" readonly="readonly" placeholder="신청서 양식 파일을 선택해주세요." onclick="changeFile();">
		<input type="file" id="appfile" data-role="none"> -->
		
		<p class="title"><span>*</span>공고 이미지</p>
		<input type="text" id="change-image" data-role="none" readonly="readonly" placeholder="이미지를 선택해주세요.">
		<input type="file" id="image" data-role="none" accept="image/*">
		
		<p class="title"><span>*</span>공고 제목</p>
		<input type="text" id="title" data-role="none" placeholder="공고 제목을 입력해주세요.">
		
		<p class="title"><span>*</span>접수 기간</p>
		<div class="flex datebox">
			<input type="text" class="dateinput" id="asdate" data-role="none" value="2020" maxlength="10">
			<input type="text" class="dateinput" id="aedate" data-role="none" value="2020" maxlength="10">
		</div>
		
		<p class="title"><span>*</span>행사 기간</p>
		<div class="flex datebox">
			<input type="text" class="dateinput" id="psdate" data-role="none" value="2020" maxlength="10">
			<input type="text" class="dateinput" id="pedate" data-role="none" value="2020" maxlength="10">
		</div>
		
		<p class="title">장르</p>
		<input type="hidden" id="select_genre">
		<input type="hidden" id="main_genre" data-role="none">
		<input type="text" id="text_genre" data-role="none" placeholder="장르를 입력해주세요." readonly="readonly">
		
		<p class="title">인원</p>
		<div style="display:flex">
			<input type="text" id="personnel_min" data-role="none" placeholder="최소 인원을 입력해주세요.">
			<input type="text" id="personnel" data-role="none" placeholder="최대 인원을 입력해주세요.">
		</div>
		
		<p class="title">공연비</p>
		<div style="display:flex">
			<input type="checkbox" data-role="none" id="no_pay"><label>없음</label>
			<input type="checkbox" data-role="none" id="transportation"><label>교통비 지원</label>
		</div>
		<div style="display:flex">
			<input type="text" id="pay" data-role="none" placeholder="최소 공연비를 입력해주세요.">
			<input type="text" id="pay_max" data-role="none" placeholder="최대 공연비를 입력해주세요.">
		</div>
		
		<!-- <p class="title">모집 사이트</p>
		<input type="text" id="site" data-role="none" placeholder="사이트 주소를 입력해주세요."> -->
		
		<p class="title">담당자</p>
		<input type="text" id="manager" data-role="none" placeholder="담당자를 입력해주세요.">
		
		<p class="title">연락처</p>
		<input type="text" id="tel" data-role="none" placeholder="전화번호를 입력해주세요." maxlength="13">
		<input type="text" id="email" data-role="none" placeholder="이메일을 입력해주세요.">
		
		<p class="title"><span>*</span>주소</p>
		<div class="flex addrbox">
			<input type="text" id="address" data-role="none" placeholder="주소를 입력해주세요.">
			<p class="btn" id="addr-search" onclick="searchAddrFromText();">검색</p>
		</div>
		<input type="text" id="detailaddress" data-role="none" placeholder="상세 주소를 입력해주세요.">
		<div id="map"></div>
		
		<p class="title"><span>*</span>상세</p>
		<textarea data-role="none" id="content" placeholder="상세 모집요강을 입력해주세요."></textarea>
		
		<div class="btn_b" id="apply" onClick="pbiApply();">
			등록 완료
		</div>
		
		<input type="hidden" id="lat">
		<input type="hidden" id="lng">
	</nav>
	<div id="genre_select_popup" ></div>
	<div class="loading-popup" id="loading">
		<div class="loading-background">
			<img src="/img/common/loading.gif">
			<p>등록중입니다.</p>
		</div>
	</div>
</body>
</html>