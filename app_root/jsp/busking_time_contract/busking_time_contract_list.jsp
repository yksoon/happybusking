<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<%@include file="/importhead2.jsp" %>
<div data-role="page" id="busking_time_contract_list" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
        <!-- content 부분 -->	
        <div id="busking_time_contract_list_content" data-role="content">

            <div class = "btcl_top_container">

                <div class="btcl_date_select_container">
                    <div class="btcl_year_select">
                        <select id="btcl_year_select">
                        </select>
                    </div>
                    <div class="btcl_month_select">
                        <select id="btcl_month_select">
                        </select>
                    </div>
                    <img src="/img/panel_v2/down.svg" class="btcl_down_arrow"/>
                </div>
                <div class="btcl_confirm_category_container">
                    <select id="btcl_category_select">
                        <option seleted>전체</option>
                    </select> 
                    <img src="/img/panel_v2/down.svg" class="btcl_down_arrow"/> 
                </div>

            </div>

            <div class="btcl_mid_container">



            </div>

            <input type="hidden" id="user_no" value="<%=USER_NO %>">
        </div>
</div> 


                <%-- <div class="btcl_mid_date_container">
                    <div class="btcl_day">
                        <p>12일</p>
                    </div>
                    <div class="btcl_dayofweek">
                        <p>금요일</p>
                    </div>
                </div> --%>

                <%-- <div class="btcl_card_container">
                    <div class="btcl_card_img_container">
                        <div class="btcl_card_img_box">
                            <img src="/img/busking_time/busking_time_img.png" class="btcl_card_img" />
                        </div>
                    </div>
                    <div class="btcl_card">
                        <div class="btcl_card_top_container">
                            <div class="btcl_card_title">
                                <p>서울하늘</p>
                            </div>
                            <div class="btcl_card_confirm">
                                <p>공연 승인</p>
                            </div>
                        </div>
                        <div class="btcl_card_time">
                            <p>19:00 - 20:00</p>
                        </div>
                        <div class="btcl_card_contract">
                            <p>계약 대기</p>
                        </div>
                    </div>
                </div> --%>

                <%-- <div class="btcl_card_container">
                    <div class="btcl_card_img_container">
                        <div class="btcl_card_img_box">
                            <img src="/img/busking_time/busking_time_img.png" class="btcl_card_img" />
                        </div>
                    </div>
                    <div class="btcl_card">
                        <div class="btcl_card_top_container">
                            <div class="btcl_card_title">
                                <p>서울하늘</p>
                            </div>
                            <div class="btcl_card_confirm">
                                <p>공연 승인</p>
                            </div>
                        </div>
                        <div class="btcl_card_time">
                            <p>19:00 - 20:00</p>
                        </div>
                        <div class="btcl_card_contract">
                            <p>계약 대기</p>
                        </div>
                    </div>
                </div> --%>

                <%-- <div class="btcl_mid_date_container">
                    <div class="btcl_day">
                        <p>12일</p>
                    </div>
                    <div class="btcl_dayofweek">
                        <p>금요일</p>
                    </div>
                </div>

                <div class="btcl_card_container">
                    <div class="btcl_card_img_container">
                        <div class="btcl_card_img_box">
                            <img src="/img/busking_time/busking_time_img.png" class="btcl_card_img" />
                        </div>
                    </div>
                    <div class="btcl_card">
                        <div class="btcl_card_top_container">
                            <div class="btcl_card_title">
                                <p>서울하늘</p>
                            </div>
                            <div class="btcl_card_confirm">
                                <p>공연 승인</p>
                            </div>
                        </div>
                        <div class="btcl_card_time">
                            <p>19:00 - 20:00</p>
                        </div>
                        <div class="btcl_card_contract">
                            <p>계약 대기</p>
                        </div>
                    </div>
                </div>

                <div class="btcl_card_container">
                    <div class="btcl_card_img_container">
                        <div class="btcl_card_img_box">
                            <img src="/img/busking_time/busking_time_img.png" class="btcl_card_img" />
                        </div>
                    </div>
                    <div class="btcl_card">
                        <div class="btcl_card_top_container">
                            <div class="btcl_card_title">
                                <p>서울하늘</p>
                            </div>
                            <div class="btcl_card_confirm">
                                <p>공연 승인</p>
                            </div>
                        </div>
                        <div class="btcl_card_time">
                            <p>19:00 - 20:00</p>
                        </div>
                        <div class="btcl_card_contract">
                            <p>계약 대기</p>
                        </div>
                    </div>
                </div>

                <div class="btcl_card_container">
                    <div class="btcl_card_img_container">
                        <div class="btcl_card_img_box">
                            <img src="/img/busking_time/busking_time_img.png" class="btcl_card_img" />
                        </div>
                    </div>
                    <div class="btcl_card">
                        <div class="btcl_card_top_container">
                            <div class="btcl_card_title">
                                <p>서울하늘</p>
                            </div>
                            <div class="btcl_card_confirm">
                                <p>공연 승인</p>
                            </div>
                        </div>
                        <div class="btcl_card_time">
                            <p>19:00 - 20:00</p>
                        </div>
                        <div class="btcl_card_contract">
                            <p>계약 대기</p>
                        </div>
                    </div>
                </div> --%>