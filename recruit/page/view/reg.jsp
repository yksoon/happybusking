<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/recruit/importhead.jsp"%>
<%@include file="/service_include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/recruit/resource/css/reg.css?ver=1.0.7" />
<script type="text/javascript" src="/recruit/resource/js/function/reg-func.js?ver=1.0.9" ></script>
<script type="text/javascript" src="/recruit/resource/js/active/reg.js?ver=1.0.9" ></script>
<link type="text/css" rel="stylesheet" href="/css/heartpay/custom_select_box/genre_select.css?ver=1.0.0" />
<script type="text/javascript" src="/js/heartpay/custom_select_box/custom_select_box_func.js?ver=1.0.0" ></script>
<script type="text/javascript" src="/js/heartpay/custom_select_box/genre_select.js?ver=1.0.0" ></script>
</head>
<body onload="onLoad();">
	<%@include file="/recruit/page/web/w-header.jsp" %>
		<nav class="wrapper">
		<nav class="body">
		<%@include file="/recruit/page/common/p-header.jsp" %>
		<%@include file="/recruit/page/common/popup.jsp" %>
		<nav class="p-pt reg-warpper">
			<input type="hidden" id="user_no" value=<%=USER_NO %> />
			<p class="ft-lgray ft-12 subtitle">* 공고 이미지</p>
			<input type="text" class="ft-black ft-14" id="change-image" data-role="none" readonly="readonly" placeholder="이미지를 선택해주세요.">
			<input type="file" id="image" data-role="none" accept="image/*">
			
			<p class="ft-lgray ft-12 subtitle">* 공고 제목</p>
			<input type="text" class="ft-black ft-14" id="title" data-role="none" placeholder="공고 제목을 입력해주세요.">
			
			<p class="ft-lgray ft-12 subtitle">* 접수 기간</p>
			<div class="flex twice-box">
				<input type="text" class="ft-black ft-14 w-48" id="asdate" data-role="none" value="2020" maxlength="10" onkeyup="dateFormatChange(this);" />
				<input type="text" class="ft-black ft-14 w-48" id="aedate" data-role="none" value="2020" maxlength="10" onkeyup="dateFormatChange(this);" />
			</div>
			
			<p class="ft-lgray ft-12 subtitle">* 행사 기간</p>
			<div class="flex twice-box">
				<input type="text" class="ft-black ft-14 w-48" id="psdate" data-role="none" value="2020" maxlength="10" onkeyup="dateFormatChange(this);" />
				<input type="text" class="ft-black ft-14 w-48" id="pedate" data-role="none" value="2020" maxlength="10" onkeyup="dateFormatChange(this);" />
			</div>
			
			<p class="ft-lgray ft-12 subtitle">장르</p>
			<input type="hidden" id="select_genre">
			<input type="hidden" id="main_genre" data-role="none">
			<input type="text" class="ft-black ft-14" id="text_genre" data-role="none" placeholder="장르를 선택해주세요." readonly="readonly">
			
			<p class="ft-lgray ft-12 subtitle">인원</p>
			<div class="flex twice-box">
				<input type="text" class="ft-black ft-14 w-48" id="personnel_min" data-role="none" placeholder="최소 인원" onkeyup="addComma(this);">
				<input type="text" class="ft-black ft-14 w-48" id="personnel" data-role="none" placeholder="최대 인원" onkeyup="addComma(this);">
			</div>
			
			<div class="ft-lgray ft-12 subtitle retitle">
				공연비
				<div class="flex chk-container">
					<input type="checkbox" data-role="none" id="no_pay"><label class="ft-14 ft-gray" for="no_pay" style="margin-right: 10px;">없음</label>
					<input type="checkbox" data-role="none" id="transportation"><label class="ft-14 ft-gray" for="transportation">교통비 지원</label>
				</div>
			</div>
			<div class="flex twice-box">
				<input type="text" class="ft-black ft-14 w-48"  id="pay" data-role="none" placeholder="최소 공연비" onkeyup="addComma(this);">
				<input type="text" class="ft-black ft-14 w-48"  id="pay_max" data-role="none" placeholder="최대 공연비" onkeyup="addComma(this);">
			</div>
			
			<!-- <p class="title">모집 사이트</p>
			<input type="text" id="site" data-role="none" placeholder="사이트 주소를 입력해주세요."> -->
			
			<p class="ft-lgray ft-12 subtitle">담당자</p>
			<input type="text" class="ft-black ft-14" id="manager" data-role="none" placeholder="담당자를 입력해주세요.">
			
			<p class="ft-lgray ft-12 subtitle">연락처</p>
			<input type="text" class="ft-black ft-14" id="tel" data-role="none" placeholder="전화번호를 입력해주세요." maxlength="13" onkeyup="telFormatChange(this);">
			<input type="text" class="ft-black ft-14" id="email" data-role="none" placeholder="이메일을 입력해주세요.">
			
			<p class="ft-lgray ft-12 subtitle">* 주소</p>
			<div class="flex addrbox">
				<input type="text" class="ft-black ft-14" id="address" data-role="none" placeholder="주소를 입력해주세요.">
				<p class="bg-purple ft-white ft-16 ft-bold" id="addr-search" onclick="searchAddrFromText();">검색</p>
			</div>
			<input type="text" class="ft-black ft-14" id="detailaddress" data-role="none" placeholder="상세 주소를 입력해주세요.">
			<div id="map"></div>
			
			<!-- <p class="ft-lgray ft-12 subtitle">공연장소 사진업로드 <span class="ft-gray ft-12">최대 10장</span></p> -->
			<div class="bg-gray ft-white ft-16 ft-bold add-btn" id="add-hall-btn">공연장 이미지 추가</div>
			<input type="file" data-role="none" id="add-hall" style="display: none;" multiple="multiple" accept="image/*"/>
			<div class="flex img-container">
				<div class="bg-white img-box hall-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box hall-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box hall-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box hall-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box hall-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
			</div>
			<div class="flex img-container">
				<div class="bg-white img-box hall-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box hall-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box hall-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box hall-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box hall-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
			</div>
			
			<!-- <p class="ft-lgray ft-12 subtitle">메뉴, 상품사진 업로드 <span class="ft-gray ft-12">최대 10장</span></p> -->
			<div class="bg-gray ft-white ft-16 ft-bold add-btn" id="add-product-btn">메뉴/상품 이미지 추가</div>
			<input type="file" data-role="none" id="add-product" style="display: none;" multiple="multiple" accept="image/*"/>
			<div class="flex img-container">
				<div class="bg-white img-box product-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box product-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box product-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box product-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box product-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
			</div>
			<div class="flex img-container">
				<div class="bg-white img-box product-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box product-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box product-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box product-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
				<div class="bg-white img-box product-box">
					<img class="rimg hidden" />
					<img class="cancel" src="/recruit/resource/img/common/cancel-gray.svg"/>
				</div>
			</div>
			
			
			<p class="ft-lgray ft-12 subtitle">* 상세내용</p>
			<textarea data-role="none" class="ft-black ft-14" id="content" placeholder="상세 모집요강을 입력해주세요."></textarea>
			
			<div class="bg-purple ft-white btn ft-16 ft-bold" id="apply" onClick="handlerPbiApply();">
				등록 완료
			</div>
			
			<input type="hidden" id="lat">
			<input type="hidden" id="lng">
			<div class="loading-popup" id="apply-popup">
				<div class="apply-container bg-white">
					<div class="ap-top" onclick="handlerApplyPopupClose();"><img id="ap-close" src="/recruit/resource/img/common/close-gray.png" /></div>
					<div class="ap-body">
						<p class="ft-black ft-18 ft-bold">등록 완료</p>
						<p class="ft-lgray ft-14 ap-content">모집공고가 해피버스킹 앱에 등록되었습니다.</p>
						<div class="bg-purple ft-white ft-16 ft-bold btn" onclick="goMyPbi();">확인</div>
					</div>
				</div>
			</div>
			<div id="genre_select_popup" ></div>
		</nav>
		<%@include file="/recruit/page/common/footer.jsp" %>
		</nav>
		<%@include file="/recruit/page/web/explanation.jsp" %>
	</nav>
</body>
</html>