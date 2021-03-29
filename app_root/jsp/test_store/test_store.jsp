<!DOCTYPE html>    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<%@include file="/importhead3.jsp" %>
<div data-role="page" id="test_store">
	<!-- header 부분 -->
	<%-- <%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %> --%>
		<!-- content 부분 -->		
	<div id="test_store_content" data-role="content">
		<div id='bdc_pfsc_ing_body'>
			<ul id="bdc_pfsc_ing_ul">

			</ul>
		</div>
			<ul id="bdc_img_selecter">	
			</ul>
		<div class="store_dtl_title">

			<div class="store_dtl_title_j">
				<%-- <span class="store_dtl_title_j_s">카페, 디저트</span><br> --%>
				<span class="store_dtl_title_j_b"><span>
			</div>
			<div class="store_dtl_title_img"></div>
		</div>
		<div class="ui-grid-c header_menu_container">
			<%-- <div class="ui-block-a" id="">
				<div class="haeder_menu_div_on">
					<span>소개</span>
				</div>
			</div>
			<div class="ui-block-b" id="">
				<div class="haeder_menu_div_base">
					<span>메뉴</span>
				</div>
			</div>
			<div class="ui-block-c" id="">
				<div class="haeder_menu_div_base">
					<span>일정</span>
				</div>
			</div>
			<div class="ui-block-d" id="">
				<div class="haeder_menu_div_base">
					<span>교통</span>
				</div>  				  		
			</div> --%>
		</div>
		<div class="store_dtl_introduce">
			<div class="store_dtl_introduce_t">
				공간 소개
			</div>	 
			<div class="store_dtl_introduce_c">
				<%-- 안녕하세요 라이브카페로드입니다. 많이 찾아와 주시고
				모든장르환영합니다!
				버스킹도 많이 참여해주세요 --%>
			</div> 
			<div class="store_dtl_introduce_ht_list">
				<%-- <div class="store_dtl_introduce_ht"  onclick="">#라이브카페</div>
				<div class="store_dtl_introduce_ht"  onclick="">#술</div>
				<div class="store_dtl_introduce_ht"  onclick="">#버스킹</div>
				<div class="store_dtl_introduce_ht"  onclick="">#데이트</div>
				<div class="store_dtl_introduce_ht"  onclick="">#데이트</div>
				<div class="store_dtl_introduce_ht"  onclick="">#영등포카페</div> --%>
			</div>
			<div class="store_dtl_introduce_t">
				위치 정보
			</div>	 
			<div class="store_dtl_introduce_addr">
				<div class="store_dtl_introduce_addr_l"></div>
                <div class="store_dtl_introduce_addr_r" onclick="">|길찾기</div>
			</div> 
			<div class="store_dtl_introduce_t">
				영업 시간
			</div>	 
			<div class="store_dtl_introduce_time">
			</div>
		</div>	
		<div class="store_dtl_kupon">
			<div class="store_dtl_introduce_k">
				쿠폰함
			</div>
			<div class="store_dtl_kupon_c">
				<div class="store_dtl_kupon_c_d">
				<br>
					<span class="store_dtl_kupon_c_d_m">5,000원</span><br>
					<span class="store_dtl_kupon_c_d_n">라이브 카페로드 활인</span><br>
					<span class="store_dtl_kupon_c_d_d">사용기간 20-09-01 ~ 20-09-20</span>
				</div>
				<div class="store_dtl_kupon_c_t"  onclick="">쿠폰</div>
			</div>
			<div class="store_dtl_kupon_f"  onclick="">친구에게 공유하고 쿠폰 받기</div>	 
		</div>
        <div class="store_dtl_butten">
            <div class="store_dtl_butten_a" onclick="">공연 수정하기</div>
            <div class="store_dtl_butten_b" onclick="">공연 신청자보기</div>
        <div>
	</div>	
	

</div>