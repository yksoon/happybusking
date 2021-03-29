<!DOCTYPE html>    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
    <%-- css/js including --%>
    <%@include file="/importhaed.jsp" %>
	<%@include file="/importhead2.jsp" %>
    <%@include file="/importhead3.jsp" %>
<div data-role="page" id="detail_store">
    <!-- header 부분 -->
	<%-- <%@include file="/app_root/jsp/header/header.jsp"%> --%>
	<%-- panel 부분 --%>
    <%@include file="/app_root/jsp/panel/panel.jsp" %>
	  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5caef794e0c0d34ae5082d15d8cbdcc9&amp;libraries=services"></script>
		<!-- content 부분 -->
	<div class="artist_busking_popup" id="artist_busking_popup"></div>
    <div class="artist_busking_cancel_popup" id="artist_busking_cancel_popup"></div>
    <!-- 이미지 자세히보기 팝업 -->
	<div id="team_img_popup"></div>
	<div id="detail_store_content" data-role="none" class="ui-content" role="main">
        <input type="hidden" id="user_no" value="<%=USER_NO%>"/>
		<input type="hidden" id="store_user_no" />
        <input type="hidden" id="latlng" />
		<input type="hidden" id="r_addr" />
        <div class="top_bdc_pfsc_ing_body" id="top_bdc_pfsc_ing_body">
            <div id='bdc_pfsc_ing_body'>
                <a href="#" data-rel="back" class="ui-link"><img class="common_header_backbtn" src="/img/store/back_white.svg"></a>
                <%-- <div id="imge_li_bt_left"></div> --%>
                <ul id="bdc_pfsc_ing_ul">

                </ul>
                <%-- <div id="imge_li_bt_right"></div> --%>
            </div>
                <ul id="bdc_img_selecter">
                </ul>
        </div>
        <div class="store_dtl" id="store_dtl">    
            <div class="store_dtl_title">

                <div class="store_dtl_title_j">
                    <%-- <span class="store_dtl_title_j_s">카페, 디저트</span><br> --%>
                    <span class="store_dtl_title_j_b"><span>
                </div>
                <div class="store_dtl_title_img" id="store_dtl_title_img">
                </div>
            </div>
            <div class="store_menu_line">
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
            <div class="store_dtl_introduce" id="store_dtl_introduce">
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
                <div class="store_dtl_introduce_t_a">
                    위치 정보
                </div>	 
                <div class="store_dtl_introduce_addr">
                    <div class="store_dtl_introduce_addr_l"></div>
                    <div class="store_dtl_introduce_addr_r" onclick="load_search_go()">|길찾기</div>
                </div> 
                <div class="store_dtl_introduce_t_b">
                    영업 시간
                </div>	 
                <div class="store_dtl_introduce_time">
                </div>
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
        <%-- <div id="addr_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
			<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode('addr_layer')" alt="닫기 버튼">
		</div> --%>
	</div>	
</div>