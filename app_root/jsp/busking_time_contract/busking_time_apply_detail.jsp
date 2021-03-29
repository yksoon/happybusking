<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="busking_time_apply_detail" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
            <div class="custom_btad_popup" id="custom_btad_popup">
		    </div>
        <!-- content 부분 -->	
        <div class="artist_busking_cancel_popup" id="artist_busking_cancel_popup"></div>
        <div class="contract_cancel_popup" id="contract_cancel_popup"></div>
        <div id="busking_time_apply_detail_content" data-role="content" style="margin-bottom: 0;">
            <div class="btad_top_container">
                <div class="btad_team_name_title">
                    <%-- <p>서울하늘</p> --%>
                </div>
                <div class="btad_artist_info">
                    <%-- <div class="btad_artist_info_click">
                        <p>아티스트 정보 ></p>
                    </div> --%>
                </div>
            </div>

            <div class="btad_basic_info_container">
                <div class="btad_info_title btad_basic_info_title">
                    <p>기본 정보</p>
                </div>
                <div class = "btad_info_table btad_basic_info_table">
                    <%-- <table>
                        <tr>
                            <th>팀/솔로명</th>
                            <td>서울하늘</td>
                        </tr>
                        <tr>
                            <th>장르</th>
                            <td>발라드</td>
                        </tr>
                        <tr>
                            <th>멤버</th>
                            <td>서울, 하늘</td>
                        </tr>
                        <tr>
                            <th>활동지역</th>
                            <td>서울</td>
                        </tr>
                        <tr>
                            <th>영상</th>
                            <td>영상 보기</td>
                        </tr>
                        <tr>
                            <th>소개</th>
                            <td>안녕하세요. 서울하늘입니다.</td>
                        </tr>                                                                                                                  
                    </table> --%>
                </div>
            </div>

            <div class="btad_apply_info_container">
                <div class="btad_info_title btad_apply_info_title">
                    <p>신청 정보</p>
                </div>
                <div class = "btad_info_table btad_apply_info_table">
                    <%-- <table>
                        <tr>
                            <th>신청 날짜</th>
                            <td>2020년 11월 11일</td>
                        </tr>
                        <tr>
                            <th>신청 시간</th>
                            <td>19:00 - 20:00</td>
                        </tr>
                        <tr>
                            <th>공연비</th>
                            <td>100,000원</td>
                        </tr>                                                                                                                
                    </table> --%>
                </div>
            </div>

            <div class="btad_perform_info_container">
                <%-- <div class="btad_info_title btad_perform_info_title">
                    <p>공연 정보</p>
                </div>
                <div class="btad_perform_info_notice">
                    <p>공연을 잘 마치셨다면 공연종료를 클릭해주세요.</p>
                    <p>사업주에게 공연비 지급 요청 메세지가 전달됩니다.</p>
                </div>
                <div class="btad_perform_info_notice_2">
                    <p>팀원중 한명이라도 종료버튼을 누르면 팀원 모두 자동 종료 처리됩니다.</p>
                </div>
                <div class="btad_perform_info_endPerform_btn">
                    공연종료
                </div> --%>
            </div>

            <div class="btad_bank_info_container">
                <%-- <div class="btad_bank_info_container_2">
                    <div class="btad_info_title btad_perform_info_title">
                        <p>입금 계좌 정보</p>
                    </div>
                    <div class = "btad_info_table btad_bank_info_table">
                        <table>
                            <tr>
                                <th>입금계좌</th>
                                <td>00000000 (국민)</td>
                            </tr>
                            <tr>
                                <th>예금주</th>
                                <td>홍길동</td>
                            </tr>
                            <tr>
                                <th>공연비</th>
                                <td>100,000원 (0.8% 공제된 금액)</td>
                            </tr>                                                                                                                
                        </table>


                        <p class="btad_bank_info_not_p">공연 종료(최대 3일) 후 입금 계좌 정보가 생성됩니다.</p>
                    </div>
                </div> --%>
            </div>


            <div class = "btad_contract_status_container">
                <%-- <div class="btad_info_title btad_contract_status_title">
                    <p>계약 상태</p>
                </div>
                <div class="btad_contract_team_name_container">
                    <p class="btad_contract_team_name">서울하늘</p>
                    <div class="btad_contract_status_label">계약진행</div>
                </div>
                <div class="btad_info_table btad_contract_table">
                    <table class="btad_contract_table_2">
                        <tr>
                            <th>서울</th>
                            <td>10,000원</td>
                            <td style="width: 85px;">
                                <div class="btad_btn_container" style="margin-bottom: 0;">
                                    <input type="checkbox" name="btad_contract_check" id="btad_contract_check_1" data-role="none" value="모집완료">
                                    <label for="btad_contract_check_1"></label>
                                    <span class = "btad_contract_check_span">서명 완료</span>
                                </div>  
                            </td>
                        </tr>
                        <tr>
                            <th>서울</th>
                            <td>10,000원</td>
                            <td style="width: 85px;">
                                <div class="btad_btn_container" style="margin-bottom: 0;">
                                    <input type="checkbox" name="btad_contract_check" id="btad_contract_check_1" data-role="none" value="모집완료">
                                    <label for="btad_contract_check_1"></label>
                                    <span class = "btad_contract_check_span">서명 완료</span>
                                </div>  
                            </td>
                        </tr>                        
                    </table>
                    <div class="btad_total_price_container">
                        <div class="btad_total_price_title">총 공연비</div>
                        <div class="btad_total_price">100,000 원</div>
                    </div>
                </div> --%>

                <%-- <div class="btad_info_title btad_contract_status_title">
                    <p>계약 상태</p>
                </div>
                <div class="btad_contract_team_name_container">
                    <p class="btad_contract_team_name">서울하늘</p>
                    <div class="btad_contract_status_label">계약진행</div>
                </div>
                <div class="btad_info_table btad_contract_table">
                    <table class="btad_contract_table_2">
                        <tr>
                            <th>
                                <div class="btad_btn_container" style="margin-bottom: 0; float: none;">
                                    <input type="checkbox" name="btad_contract_check" id="btad_contract_check_1" data-role="none" value="모집완료">
                                    <label for="btad_contract_check_1"></label>
                                    <span class = "btad_contract_check_span btad_art_name">서울</span>
                                </div>                             
                            </th>
                            <td>
                                <input class="btad_personal_price_input" type="text" value="50,000 원" placeholder="금액입력" data-role="none" />
                            </td>
                            <td style="width: 72px;">
                                <div class="btad_btn_container" style="margin-bottom: 0;">
                                    <span class = "btad_contract_check_span">서명 완료</span>
                                </div>  
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div class="btad_btn_container" style="margin-bottom: 0; float: none;">
                                    <input type="checkbox" name="btad_contract_check" id="btad_contract_check_1" data-role="none" value="모집완료">
                                    <label for="btad_contract_check_1"></label>
                                    <span class = "btad_contract_check_span btad_art_name">하늘</span>
                                </div>
                            </th>
                            <td >
                                <input class="btad_personal_price_input" type="text" value="50,000 원" placeholder="금액입력" data-role="none" />
                            </td>
                            <td style="width: 72px;">
                                <div class="btad_btn_container" style="margin-bottom: 0;">
                                    <span class = "btad_contract_check_span">서명 완료</span>
                                </div>  
                            </td>
                        </tr>                        
                    </table>
                    <div class="btad_total_price_container">
                        <div class="btad_total_price_title">총 공연비</div>
                        <div class="btad_total_price">100,000 원</div>                     
                    </div>
                    <div class="btad_total_price_container  btad_remain_price_con">
                        <div class="btad_total_price_title">잔여 공연비</div>
                        <div class="btad_total_price btad_remain_price">30,000 원</div>                     
                    </div>
                </div> --%>





            </div>
            <input type="hidden" id="user_no" value="<%=USER_NO %>">
        </div>
    <footer data-role="footer" data-position="fixed" data-tap-toggle="false" id="footer">
    <div class="btad_footer">
        <%-- <div class="btad_footer_reject" id="btad_footer_reject" onclick="go_complete_reject_busking()">
            공연거절
        </div>
        <div class="btad_footer_accept" id="btad_footer_accept">
            공연승인
        </div> --%>
    </div>
    </footer>
</div>