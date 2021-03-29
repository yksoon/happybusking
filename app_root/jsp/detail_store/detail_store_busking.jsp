<!DOCTYPE html>    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
    <%-- css/js including --%>
    <%@include file="/importhaed.jsp" %>
    <%@include file="/importhead3.jsp" %>
<div data-role="page" id="detail_store_busking">
    <!-- header 부분 -->
	<%-- <%@include file="/app_root/jsp/header/header.jsp"%> --%>
	<%-- panel 부분 --%>
    <%@include file="/app_root/jsp/panel/panel.jsp" %>
     <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5caef794e0c0d34ae5082d15d8cbdcc9&amp;libraries=services"></script>
		<!-- content 부분 -->		
	<div id="detail_store_content" data-role="content">
        <input type="hidden" id="user_no" value="<%=USER_NO%>"/>
        <input type="hidden" id="store_user_no"/>
		<div id='bdc_pfsc_ing_body'>
            <a href="#" data-rel="back" class="ui-link"><img class="common_header_backbtn" src="/img/store/back_white.svg"></a>
            <%-- <div class="bdc_pfsc_text">*무대사진</div> --%>
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
			<div class="store_dtl_title_but" id="store_dtl_title_but">
			<p class="store_dtl_title_but_text">일정보기<p>
            </div>
		</div>
		<div class="store_menu_line">
		</div>
		<div class="store_dtl_introduce" id="store_dtl_introduce">
			<div class="store_dtl_introduce_t">
				버스킹 공간 정보
			</div>	 
			<div class="store_dtl_introduce_c">
				<div class="store_dtl_introduce_c_aa"><p class="store_dtl_introduce_c_a">지원장비</p><div class="store_dtl_introduce_c_bb" id="store_dtl_equipment"></div></div>
				<div class="store_dtl_introduce_c_a">공연비</div><div class="store_dtl_introduce_c_b" id="store_dtl_offerprice"></div>
				<div class="store_dtl_introduce_c_a">주차</div><div class="store_dtl_introduce_c_b" id="store_dtl_parking_chk"></div>
				<div class="store_dtl_introduce_c_a">팁박스</div><div class="store_dtl_introduce_c_b" id="store_dtl_tipbox"></div>
				<div class="store_dtl_introduce_c_a">장르</div><div class="store_dtl_introduce_c_b" id="store_dtl_genre"></div>
				<div class="store_dtl_introduce_c_a">영상촬영</div><div class="store_dtl_introduce_c_b" id="store_dtl_video_chk"></div>
			</div> 
			
		</div>	
		<%-- <div class="store_dtl_kupon">
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
		</div> --%>
        <div class="store_dtl_butten">
           
        <div>
        <!-- 주소찾기 팝업 레이어 -->
        <div id="addr_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
			<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode('addr_layer')" alt="닫기 버튼">
		</div>
	</div>	
</div>