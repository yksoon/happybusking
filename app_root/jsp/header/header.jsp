<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<!-- 세션 호출-->
<%
	String pm = request.getRequestURI();
	pm = pm.substring(pm.lastIndexOf("/") + 1, pm.length());
	
	String loginpm = pm.split("#")[0];
	
	String ARTIST_CHK_2 = (String) session.getAttribute("ARTIST_CHK");
	Cookie[] cookies1 = request.getCookies();
	
	if(cookies1 != null){
		for(Cookie c0 : cookies1){
			if(c0.getName().equals("artist_chk")){
				ARTIST_CHK_2 = c0.getValue();
			}
		}
	}
%>
<!-- header 부분 -->
<header data-role="header" data-position="fixed" data-tap-toggle="false" id="header">
	<div class="ui-grid-b"
		style="width: 100%; height: 45px; background-color: white;">
		<div class="ui-block-a" style="width: 25%;">
			<div style="text-align: left;">
			
			<%
				if (pm.equals("user_perform_requestList.jsp") || pm.equals("perform_request_search.jsp") || pm.equals("qrcode_request.jsp") || pm.equals("qrcode_request_list.jsp") ||
						pm.equals("supply_item_list.jsp") || pm.equals("supply_item_request.jsp") || pm.equals("supply_item_state.jsp") || pm.equals("thanks_people.jsp") || pm.equals("support_complete.jsp") ||
						pm.equals("team_create_status.jsp") || pm.equals("team_create.jsp") || pm.equals("rating_list.jsp") || pm.equals("my_info.jsp") || loginpm.equals("naverlogin.jsp") || loginpm.equals("join_complete.jsp") || pm.equals("kiwoompay_complete.jsp") ||
                        pm.equals("busking_time_reg.jsp") || pm.equals("store_list.jsp") || pm.equals("busking_time_reg_each.jsp") || pm.equals("main_store_update.jsp") || pm.equals("store_list.jsp")) {
			%>
				<a href="#" onclick = "toHome();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
			<%
				}else if( pm.equals("team_info.jsp") ) {
			%>
				<a href="#" onclick = "teamInfoBackBtn();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
			<%
				}else if( pm.equals("support_list.jsp") ) {
			%>
				<a href="#" onclick = "support_list_back();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
			<%
				}else if( pm.equals("share_item_list.jsp") ) {
			%>
				<a href="#" onclick = "siBackBtn();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
			<%
				}else if( pm.equals("buskingzone_list.jsp") ) {
			%>
				<a href="#" onclick = "bzBackBtn();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
			<%
				}else if( pm.equals("qrcode_request_complete.jsp") ) {
			%>
				<a href="#" onclick = "qr_request_complete_back();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
			<%
				}else if( pm.equals("perform_reg.jsp") ) {
			%>
				<a href="#" onclick = "go_perform_reg_back();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
			<%
				}else if( pm.equals("busking_oath.jsp") ) {
			%>
				<a href="#" onclick = "goBuskingOathBack();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
			<%
				}else if( pm.equals("team_board.jsp") ) {
			%>
				<a href="#" onclick = "teamBoardBackBtn();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
			<%
				}else if( pm.equals("team_board_view.jsp") ) {
			%>
				<a href="#" onclick = "teamBoardDetailBackBtn();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
			<%
				}else if( pm.equals("artist_become.jsp") ) {
			%>
				<a href="#" onclick = "backArtistBecome();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
			<%-- <%
				}else if( pm.equals("busking_time_reg_all.jsp") || pm.equals("busking_time_reg_each.jsp") ) {
			%>
				<a href="#" onclick = "back_reg_busking_time();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a> --%>
			<%
				}else if( pm.equals("store_list_search.jsp")) {
			%>
				<a href="#" onclick = "function sl_backbtn();"> 
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
			<%
				}else if( pm.equals("e_sign_complete_art.jsp") || pm.equals("e_sign_complete_owner.jsp") || pm.equals("application_perform_complete.jsp") || pm.equals("complete_accept_busking.jsp") || pm.equals("complete_cancel_busking.jsp") || pm.equals("complete_reject_busking.jsp")
                || pm.equals("complete_reg_busking_time.jsp")|| pm.equals("complete_end_busking.jsp")) {
			%>

			<%
				}else {
			%>
				<a href="#" data-rel="back">
					<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
				</a>
				
			<%
				}
			%>
			</div>
		</div>
		<div class="ui-block-b" style="width: 50%;">
			<div style="text-align: center;">
				<p class="common_header_text">
					<%
						if (pm.equals("festival_apply.jsp")) {
					%>
					버스킹 공연 신청서 작성
					<%
						}
					%>
					<%
						if (pm.equals("insert_koica.jsp")) {
					%>
					공연 신청서 작성
					<%
						}
					%>
					<%
						if (pm.equals("join_complete.jsp")) {
					%>
					가입완료
					<%
						}
					%>
					<%
						if (pm.equals("notice_list.jsp") || pm.equals("notice_detail.jsp")) {
					%>
					공지사항
					<%
						}
					%>
					<%
						if (pm.equals("video_upload.jsp")) {
					%>
					영상 업로드
					<%
						}
					%>
					<%
						if (pm.equals("busking_oath.jsp")) {
					%>
					버스커 선서
					<%
						}
					%>
					<%
						if (pm.equals("pbi_list.jsp") || pm.equals("pbi_detail.jsp")) {
					%>
						<%if (ARTIST_CHK_2 != null && ARTIST_CHK_2.equals("Y")) { %>
						 	아티스트 모집정보
						<%} else { %>
							공연/행사 정보
						<%} %>
					<%
						}
					%>
					<%
						if (pm.equals("pbi_write.jsp")) {
					%>
					버스킹 행사 정보 등록
					<%
						}
					%>
					<%
						if (pm.equals("kiwoompay_complete.jsp")) {
					%>
					결제 완료
					<%
						}
					%>
					<%
						if (pm.equals("qrcode_request_complete.jsp")) {
					%>
					결제 완료
					<%
						}
					%>
					<%
						if (pm.equals("qr_request_cancel.jsp")) {
					%>
					결제 취소
					<%
						}
					%>
					
					<%
						if (pm.equals("support_complete.jsp")) {
					%>
					결제 완료
					<%
						}
					%>
					
					<%
						if (pm.equals("perform_reg.jsp")) {
					%>
					공연 일정 등록
					<%
						}
					%>
										
					<%
						if (pm.equals("support.jsp")) {
					%>
					모바일 팁박스
					<%
						}
					%>
					
					<%
						if (pm.equals("team_create.jsp")) {
					%>
					팀/솔로 등록
					<%
						}
					%>
					
					<%
						if (pm.equals("team_create_update.jsp")) {
					%>
					팀/솔로 신청내역
					<%
						}
					%>
					
					<%
						if (pm.equals("team_create_status.jsp")) {
					%>
					팀 정보 보기/수정
					<%
						}
					%>
					
					<%
						if (pm.equals("interest_team_list.jsp")) {
					%>
					관심 아티스트
					<%
						}
					%>
					
					<%
						if (pm.equals("artist_ranking.jsp")) {
					%>
					팀/솔로
					<%
						}
					%>
					
					<%
						if (pm.equals("support_list.jsp")) {
					%>
					후원 내역 조회
					<%
						}
					%>
					
					<%
						if (pm.equals("thanks_people.jsp")) {
					%>
					후원 받은 내역
					<%
						}
					%>
					
					<%
						if (pm.equals("account_change.jsp")) {
					%>
					 게좌 등록/변경
					<%
						}
					%>

					<%
						if (pm.equals("team_info.jsp") || pm.equals("team_perform.jsp")) {
					%>
					팀/솔로 정보
					<%
						}
					%>

					<%
						if (pm.equals("login.jsp")) {
					%>
					
					<%
						}
					%>
					<%
						if (pm.equals("detail_performance.jsp")){
					%>
					공연 정보
					<%
						}
					%>
					<%
						if (pm.equals("detail_review.jsp") || pm.equals("detail_review2.jsp")){
					%>
					공연 후기
					<%
						}
					%>
					<%
						if(pm.equals("performance_schedule.jsp")){
					%>
					공연 일정
					<%
						}
					%>
					<%
						if(pm.equals("performance_alarm.jsp")){
							
					%>
					공연 알람 설정
					<%
						}
					%>
					<%
						if(pm.equals("user_performance_record.jsp")){
							
					%>
					관람한 공연
					<%
						}
					%>
					<%
						if(pm.equals("detail_artist.jsp")){
							
					%>
					멤버 상세
					<%
						}
					%>
					<%
						if(pm.equals("artist_become.jsp")){
							
					%>
					아티스트 등록
					<%
						}
					%>
					<%
						if(pm.equals("artist_update.jsp")){
							
					%>
					아티스트 정보 수정
					<%
						}
					%>
					<%
						if(pm.equals("rating_list.jsp")){
							
					%>
					내 공연 일정
					<%
						}
					%>
					<%
						if(pm.equals("user_write_review.jsp")){
							
					%>
					후기 작성
					<%
						}
					%>		
					<%
						if(pm.equals("team_board.jsp")){
							
					%>
					아티스트 커뮤니티
					<%
						}
					%>	
					<%
						if(pm.equals("team_board_write.jsp")){
							
					%>
					작성하기
					<%
						}
					%>	
					<%
						if(pm.equals("team_board_view.jsp")){
							
					%>
					내용보기
					<%
						}
					%>	
					<%
						if(pm.equals("supply_item_list.jsp") || pm.equals("supply_item_request.jsp") || pm.equals("supply_item_state.jsp")){
							
					%>
					지원 물품
					<%
						}
					%>		
					<%
						if(pm.equals("myinfo.jsp")){
							
					%>
					회원 정보 수정
					<%
						}
					%>	
					<%
						if(pm.equals("perform_cancle_msg.jsp")){
							
					%>
					공연취소
					<%
						}
					%>			
					<%
						if(pm.equals("qrcode_request.jsp") || pm.equals("qrcode_request_list.jsp")){
							
					%>
					QR배너 신청
					<%
						}	
					%>
					<%
						if(pm.equals("perform_request.jsp")){
							
					%>
					공연 요청
					<%
						}	
					%>	
					<%
						if(pm.equals("user_perform_requestList.jsp")){
							
					%>
					내가 요청한 공연
					<%
						}	
					%>	
					<%
						if(pm.equals("artist_perform_requestList.jsp")){
							
					%>
					요청 받은 공연
					<%
						}	
					%>							
					<%
						if(pm.equals("perform_request_detail.jsp")){
							
					%>
					상세보기
					<%
						}	
					%>		
					<%
						if(pm.equals("perform_request_search.jsp")){
							
					%>
					공연 요청
					<%
						}	
					%>		
					<%
						if(pm.equals("team_board_update.jsp")){
							
					%>
					게시글 수정
					<%
						}	
					%>	
					<%
						if(pm.equals("board_write_list.jsp")){
							
					%>
					게시글 작성 내역
					<%
						}	
					%>			
					<%
						if(pm.equals("perform_request_refuse_msg.jsp")){
							
					%>
					요청 거절
					<%
						}	
					%>			
					<%
						if(pm.equals("team_video_view.jsp")){
							
					%>
					영상보기
					<%
						}	
					%>			
					<%
						if(pm.equals("app_info.jsp")){
							
					%>
					앱 정보
					<%
						}	
					%>	
					<%
						if(pm.equals("app_useterms.jsp")){
							
					%>
					이용약관
					<%
						}	
					%>	
					<%
						if(pm.equals("app_useinfoterms.jsp")){
							
					%>
					개인정보취급방침
					<%
						}	
					%>		
					<%
						if(pm.equals("app_contact.jsp")){
							
					%>
					제휴·Q&amp;A·건의
					<%
						}	
					%>	
					<%
						if(pm.equals("login.jsp")){
							
					%>
					로그인
					<%
						}	
					%>	
					<%
						if(pm.equals("join.jsp")){
							
					%>
					회원가입
					<%
						}	
					%>		
					<%
						if(pm.equals("app_intro.jsp")){
							
					%>
					소개
					<%
						}	
					%>	
					<%
						if(pm.equals("pwd_search.jsp")){
							
					%>
					비밀번호 찾기
					<%
						}	
					%>			
					<%
						if(pm.equals("new_pwd.jsp")){
							
					%>
					비밀번호 설정
					<%
						}	
					%>	
					<%
						if(pm.equals("share_item_list.jsp")){
							
					%>
					공연 장비 렌탈
					<%
						}	
					%>	
					<%
						if(pm.equals("share_item_detail.jsp")){
							
					%>
					상세보기
					<%
						}	
					%>		
					<%
						if(pm.equals("share_item_reg.jsp")){
							
					%>
					물품등록
					<%
						}	
					%>	
					<%
						if(pm.equals("buskingzone_list.jsp")){
							
					%>
					버스킹존 공유
					<%
						}	
					%>	
					<%
						if(pm.equals("buskingzone_detail.jsp")){
							
					%>
					버스킹존 상세
					<%
						}	
					%>			
					<%
						if(pm.equals("buskingzone_reg.jsp")){
							
					%>
					버스킹존 등록
					<%
						}	
					%>		
					<%
						if(pm.equals("event.jsp")){
							
					%>
					버스킹 대회
					<%
						}	
					%>		
					<%
						if(loginpm.equals("naverlogin.jsp")){
							
					%>
					회원가입
					<%
						}	
					%>		
					<%
						if(pm.equals("tipbox_list.jsp")){
							
					%>
					모바일 팁박스
					<%
						}	
					%>	
					<%
						if(pm.equals("team_media_reg.jsp")){
							
					%>
					사진 · 동영상 등록/수정
					<%
						}	
					%>	
					<%
						if(pm.equals("user_request_list.jsp")){
							
					%>
					1:1 문의 내역
					<%
						}	
					%>	
					<%
						if(pm.equals("user_request_write.jsp")){
							
					%>
					1:1 문의하기
					<%
						}	
					%>	
					<%
						if(pm.equals("user_request_detail.jsp")){
							
					%>
					답변 보기
					<%
						}	
					%>	
					<%
						if(pm.equals("schedule_apply.jsp")){
							
					%>
					공연 일정 신청
					<%
						}	
					%>
					<%
						if(pm.equals("schedule_list.jsp")){
							
					%>
					내 공연 일정
					<%
						}	
					%>
					<%
						if(pm.equals("pbi_condition.jsp")){
							
					%>
					맞춤 공연 설정
					<%
						}	
					%>
					<%
						if(pm.equals("my_recruit.jsp")){
							
					%>
					공모 신청 내역
					<%
						}	
					%>
                    <%
						if(pm.equals("busking_time_reg.jsp") || pm.equals("busking_time_reg_all.jsp") || pm.equals("busking_time_reg_each.jsp")){
							
					%>
				    공연 모집 등록
					<%
						}	
					%>
                    <%
						if(pm.equals("promotion.jsp")||pm.equals("register_store.jsp")||pm.equals("complete_reg_store.jsp")){
							
					%>
					상업공간 등록
					<%
						}	
					%>
                    <%
						if(pm.equals("busking_time_contract_list.jsp")){
							
					%>
				    공연 신청/계약 이력
					<%
						}	
					%>
                    <%
						if(pm.equals("busking_time_apply_detail.jsp")){
							
					%>
				    신청 상세보기
					<%
						}	
					%>
                    <%
						if(pm.equals("store_list.jsp")){
							
					%>
				    카페&버스킹존
					<%
						}	
					%>
                    <%
						if(pm.equals("register_store_update.jsp")){
							
					%>
					공연일정 수정
					<%
						}	
					%>
                    <%
						if(pm.equals("e_signature_artist.jsp") || pm.equals("e_signature.jsp")){
							
					%>
					전자계약
					<%
						}	
					%>
                    <%
						if(pm.equals("view_contract.jsp")){
							
					%>
					전자계약확인
					<%
						}	
					%>
                    <%
						if(pm.equals("main_store_update.jsp")){
							
					%>
					카페&버스킹존 수정
					<%
						}	
					%>    
				</p>
			</div>
		</div>
		<div class="ui-block-c" style="width: 25%;">
				<%
                if (pm.equals("store_list.jsp")) {
                %>
                <div style="text-align: right; display: flex;">
                <%
                } else {
                %>
                <div style="text-align: right;">
                <%
                }
                %>
				<%
				if (!(pm.equals("login.jsp") || pm.equals("kakaotest.jsp") || pm.equals("busking_time_reg.jsp") || pm.equals("busking_time_reg_all.jsp") || pm.equals("busking_time_reg_each.jsp") || pm.equals("register_store.jsp")
                || pm.equals("busking_time_contract_list.jsp") || pm.equals("busking_time_apply_detail.jsp") || pm.equals("store_list.jsp") || pm.equals("register_store_update.jsp")|| pm.equals("e_sign_complete_art.jsp")|| pm.equals("e_sign_complete_owner.jsp")
                || pm.equals("application_perform_complete.jsp") || pm.equals("complete_accept_busking.jsp") || pm.equals("complete_cancel_busking.jsp") || pm.equals("complete_reject_busking.jsp") || pm.equals("complete_reg_busking_time.jsp") || pm.equals("complete_end_busking.jsp")
                || pm.equals("e_signature_artist.jsp") || pm.equals("e_signature.jsp") || pm.equals("view_contract.jsp") || pm.equals("main_store_update.jsp"))) {
				%>
                <a id="header_panel_btn" href="#panel" data-transition="none">
                    <img class="common_header_panelbtn" src="/img/index_main/h_menu.svg">
                </a>
				<%
				}
				%>
                
                <%-- 메뉴 패널버튼 대신 홈으로 나오는 엑스버튼 (페이지 추가하면 됨) --%>
                <%
                if (pm.equals("busking_time_reg.jsp") || pm.equals("busking_time_reg_all.jsp") || pm.equals("busking_time_reg_each.jsp") || pm.equals("register_store.jsp") || pm.equals("busking_time_contract_list.jsp")
                || pm.equals("busking_time_apply_detail.jsp") || pm.equals("register_store_update.jsp") || pm.equals("e_sign_complete_art.jsp") || pm.equals("e_sign_complete_owner.jsp") || pm.equals("application_perform_complete.jsp")
                || pm.equals("complete_accept_busking.jsp") || pm.equals("complete_cancel_busking.jsp") || pm.equals("complete_reject_busking.jsp") || pm.equals("complete_reg_busking_time.jsp") || pm.equals("complete_end_busking.jsp")
                || pm.equals("e_signature_artist.jsp") || pm.equals("e_signature.jsp") || pm.equals("view_contract.jsp") || pm.equals("main_store_update.jsp")) {
                %>
                <a onclick = "toHome();" data-transition="none">
                    <img class="common_header_homebtn" src="/img/index_main/h_close.svg">
                </a>
                <%
                }
                %>

                <%
                if (pm.equals("store_list.jsp")) {
                    %>
                <a onclick = "sl_toSearch();" data-transition="none">
                    <img class="common_header_homebtn" src="/img/common/h_search.svg">
                </a>                       
                <a onclick = "toHome();" data-transition="none">
                    <img class="common_header_homebtn" src="/img/index_main/h_close.svg">
                </a>                    
                    <%
                }
                %>
				
			</div>
		</div>
		
	</div>
		<%
			if(pm.equals("pbi_list.jsp")){
		%>
			<div class="ui-grid-c header_menu_container" id="pbi_menu" style="text-align: center;">
				<div class="ui-block-a" id="goConditionEvent">
			  		<div class="haeder_menu_div_base">
			  			<span>맞춤</span>
			  		</div>
			  	</div>
				<div class="ui-block-b" id="goAllEvent">
			  		<div class="haeder_menu_div_on">
			  			<span>전체</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-c" id="goAreaEvent">
			  		<div class="haeder_menu_div_base">
			  			<span>지역</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-d" id="goGenreEvent">
			  		<div class="haeder_menu_div_base">
			  			<span>장르</span>
			  		</div>
			  	</div>	 
			</div>
			<div id="pbi_middle">
				<div id="touchFlow2" class="nav_h_type">
					<ul id="pbi_area" style="padding: 0;">
					</ul>
				</div>
				<ul class="main_genre_ul" id="pbi_genre" style="padding: 0;">
				</ul>
				<div id="pbi_search"> 
					<div class="ui-grid-b search-input-text-container"> 
						<div class="ui-block-a" id="pbi_search_img">
							<img class="search-input-icon" src="/img/artist_ranking/ar_search_.svg" />
						</div> 
						<div class="ui-block-b"> 
							<input type="text" data-role="none" class="search-input-text" name="pbi_search_title" id="pbi_search_title" placeholder="행사명으로 검색하기"> 
						</div>
						<div class="ui-block-c search-input-text-cancel" id="pbi_search_cancle">
							취소 
							<!-- <img src="/img/artist_ranking/ar_cancle.svg">  -->
						</div> 
					</div> 
				</div>
				<!-- <div class="date-search-container" id="schedule_search">
					<input type="hidden" name="pbi_search_date" id="pbi_search_date" placeholder="조회 시작일 - 조회 종료일" readonly="readonly">
					<input type="text" data-role="none" class="date-search-input" name="pbi_search_date_2" id="pbi_search_date_2" data-role="none" placeholder="오늘 - 전체" readonly="readonly">
					<img class="date-search-cancel" id="pbi_date_search_cancle" src="/img/v2/cancel.svg" />
				</div> -->
			</div>
		<%
			}
		%>
		<%
			if(pm.equals("performance_schedule.jsp")){
		%>
			<div id="perform_sc_menu" style="text-align: center;">
				
			</div>
			<div id="perform_sc_middle">
				
			</div>
		<%
			}
		%>
		<%
			if(pm.equals("artist_ranking.jsp")){
		%>
			<div class="a_ranking_header" id="a_ranking_menu" style="text-align: center;">
			</div>
			<div id="ar-container">
				<div class="a_ranking_sort" id="a_ranking_sort">
					<div class="ars_container">
						<div class="ars_menu ars_on" id="ars_active">활동순</div>
						<div class="ars_menu" id="ars_like">좋아요순</div>
						<div class="ars_menu" id="ars_old">가입순</div>
						<div class="ars_menu" id="ars_new">최신순</div>
					</div>
				</div>
				<div class="artist_slider" id="a_ranking_area_slidebar">
					<div class="ui-field-contain" style="padding: 0;" >
						<div id="touchFlow4" class="nav_h_type">
							<ul id="ar_sc_area" style="padding: 0;">
							
							</ul>
						</div>
					</div>
				</div>
				<div class="artist_slider" id="a_ranking_genre_slidebar">
					<div class="ui-field-contain" style="padding: 0;" >
						<ul class="main_genre_ul" id="ar_sc_genre" style="padding: 0;">
							
						</ul>
					</div>
				</div>
				<div id="a_ranking_middle">	
				</div>
			</div>
		<%
			}
		%>
		<%
			if(pm.equals("perform_request_search.jsp")){
		%>
			<!-- <div id="prq_search_body">
			
			</div> -->
		<%
			}
		%>
		<%
			if(pm.equals("app_contact.jsp")){
		%>
			<div class="ui-grid-a" id="prq_search_header" style="text-align: center;">
				<div class="ui-block-a" id="goQnA">
			  		<div class="haeder_menu_div_on">
			  			<span>자주 묻는 질문</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-b" id="goPersonalContact">
			  		<div class="haeder_menu_div_base">
			  			<span>1:1 문의</span>
			  		</div>
			  	</div>
			</div>
		<%
			}
		%>
		<%
			if(pm.equals("team_board.jsp")){
		%>
			<div id="team_board_main_menu" style="text-align: center;">
			  	<div class="ui-grid-b">
				  	<div id="Go_allBoard" class="ui-block-a top_menu">
				  		<span>자유</span>
				  	</div>
				  	<div id="Go_recruitmentBoard" class="ui-block-b top_menu">
				 	 	<div class="top_menu_click">
				  		<span>팀원모집</span>
				  		</div>
				  	</div>
				  	<div id="Go_withBoard" class="ui-block-c top_menu">
				  		<span>함께공연</span>
				  	</div>		  				  		
			  	</div>			  		 
		  	</div>
		  	<div id="tb-box">
			  	<div id="team_board_sub_menu" class="page_sub_menu" style="text-align: center;">
			  		<div class="ui-grid-b">
					  	<div id="Go_newBoard" class="ui-block-a sub_menu">
					  		<span>최신순</span>
					  	</div>
					  	<div id="Go_likeBoard" class="ui-block-b sub_menu">
					  		<div class="sub_menu_click">
					  		<span>댓글순</span>
					  		</div>
					  	</div>
					  	<div id="Go_viewBoard" class="ui-block-c sub_menu">
					  		<span>조회수순</span>
					  	</div>		  				  		
				  	</div>	
			  	</div>
			  	<div id="team_board_middle">
					<div id="team_board_search">
						<div class="ui-grid-b search-input-text-container">
							<div class="ui-block-a" id="team_board_search_img">
								<img class="search-input-icon" src="/img/artist_ranking/ar_search_.svg">
							</div>
							<div class="ui-block-b">
								<input type="text" data-role="none" class="search-input-text" name="tb_search_date" id="tb_search_date" placeholder="작성자 또는 제목으로 검색하기">
							</div>
							<div class="ui-block-c search-input-text-cancel" id="team_board_cancle">
								취소
								<!-- <img src="/img/artist_ranking/ar_cancle.svg"> -->
							</div>
						</div>
					</div>
				</div>
		  	</div>
		<%
			}
		%>
		<%
			if(pm.equals("board_write_list.jsp")){
		%>
			<div id="bw_main_menu">
			  	<div class="ui-grid-a header_menu_container">
					<div id="Go_boardList" class="ui-block-a">
					<div class="haeder_menu_div_on">
						<span class="header_menu_text_on">내가 쓴 글</span>
					</div>
				</div>
				<div id="Go_replyList" class="ui-block-b">
					<div class="haeder_menu_div_base">
						<span class="header_menu_text_base">내가 쓴 댓글</span>
					</div>
				</div>
				</div>	  		 
		  	</div> 
		  	<div class="ui-grid-a" id="bw_header">
		  		<div class="ui-block-a" id="bw_header_title">글 제목</div>
		  		<div class="ui-block-b" id="bw_header_sort">최신순</div>
		  	</div>
		<%
			}
		%>
		<%
			if(pm.equals("team_info.jsp")){
		%>
		  	<div class="ui-grid-c header_menu_container">
			  	<div class="ui-block-a" id="Go_AiBtn">
			  		<div class="haeder_menu_div_on">
			  			<span>소개</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-b" id="Go_MediaBtn">
			  		<div class="haeder_menu_div_base">
			  			<span>사진/동영상</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-c" id="Go_PfsBtn">
			  		<div class="haeder_menu_div_base">
			  			<span>공연일정</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-d" id="Go_ReviewBtn">
			  		<div class="haeder_menu_div_base">
			  			<span>공연후기</span>
			  		</div>
			  	</div>  				  		
		  	</div>	
		<%
			}
		%>
		<%
			if(pm.equals("detail_performance.jsp")){
		%>
			<div id="detail_perform_menu">
			  	<div class="ui-grid-b" style='width: 100%; text-align: center; background-color: #fff; height: 40px; border-bottom: 1px solid #eeeeee;'>
				  	<div id="Go_PerInfoBtn" class="ui-block-a">
				  		<span>상세정보</span>
				  	</div>
				  	<div id="Go_AddrInfoBtn" class="ui-block-b">
				  		<span>교통안내</span>
				  	</div>
				  	<div id="Go_PerReviewBtn" class="ui-block-c">
				  		<span id="option_set_button">공연후기</span>
				  	</div>
			  	</div>			  		 
		  	</div>
		<%
			}
		%>
		
		<%
			if(pm.equals("supply_item_list.jsp")){
		%>
			<div class="ui-grid-b header_menu_container">
			  	<div class="ui-block-a" onclick="go_siList()">
			  		<div class="haeder_menu_div_on">
			  			<span>물품전체</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-b" onclick="go_siRequest()">
			  		<div class="haeder_menu_div_base">
			  			<span>물품신청</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-c haeder_menu_div_base" onclick="go_siState()">
			  		<div class="haeder_menu_div_base">
			  			<span>신청현황</span>
			  		</div>
				</div>		  				  		
		  	</div>		
			<div class="ui-grid-b item_list_title">
				<div class="ui-block-a">
					<p>물품목록</p>
				</div>
				<div class="ui-block-b">
					<span style="color: #707070; text-decoration:underline;">모두보기</span>
				</div>
			</div>
		<%
			}
		%>
		
		<%
			if(pm.equals("supply_item_request.jsp")){
		%>
			<div class="ui-grid-b header_menu_container">
			  	<div class="ui-block-a" onclick="go_siList()">
			  		<div class="haeder_menu_div_base">
			  			<span>물품전체</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-b" onclick="go_siRequest()">
			  		<div class="haeder_menu_div_on">
			  			<span>물품신청</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-c haeder_menu_div_base" onclick="go_siState()">
			  		<div class="haeder_menu_div_base">
			  			<span>신청현황</span>
			  		</div>
				</div>		  				  		
		  	</div>	
		<%
			}
		%>
		
		<%
			if(pm.equals("supply_item_state.jsp")){
		%>
			<div class="ui-grid-b header_menu_container">
			  	<div class="ui-block-a" onclick="go_siList()">
			  		<div class="haeder_menu_div_base">
			  			<span>물품전체</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-b" onclick="go_siRequest()">
			  		<div class="haeder_menu_div_base">
			  			<span>물품신청</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-c haeder_menu_div_base" onclick="go_siState()">
			  		<div class="haeder_menu_div_on">
			  			<span>신청현황</span>
			  		</div>
				</div>		  				  		
		  	</div>				
			<div class="ui-grid-a isTitle">
				<div  class="ui-block-a" style="width: 50%; text-align: left; padding: 5% 0 0 15px; font-size: 15px; font-weight: bold;">
					<p>신청내역</p>
				</div>
				<div class="ui-block-b" style="width: 50%; text-align: right; font-size: 12px; padding: 5% 15px 0 0; margin-top: 1%;">
					<span style="color:#707070; text-decoration:underline;">최신순</span>
				</div>
			</div>
		<%
			}
		%>
		
		<%
			if(pm.equals("rating_list.jsp")){
		%>
			<div class ="rating_list_header" id="rating_list_header">
				
			</div>
		  	<div id="rating_list_top">
		  		<div class="ui-grid-a" id="rl_top_header">
		  			<div class="ui-block-a">
		  				<a id="rl_team_name"></a>의<br>
		  				공연 후기 평균 평점
		  			</div>
		  			<div class="ui-block-b">
		  				<div id="raty_total"></div>
		  				<div id="raty_total_score"></div>
		  			</div>
		  		</div>
		  	</div>
	  		<div class="ui-grid-a" id="rating_list_middle">
	  			<div class="ui-block-a">
	  				공연전체
	  			</div>
	  			<div class="ui-block-b">
	  				전체보기
	  			</div>
	  		</div>
		<%
			}
		%>
		
		<%
			if(pm.equals("qrcode_request.jsp")){
		%>
			<div class="ui-grid-a header_menu_container">
			  	<div class="ui-block-a" onclick="goQrRequest()">
			  		<div class="haeder_menu_div_on">
			  			<span>QR신청</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-b" onclick="goQrRequestList()">
			  		<div class="haeder_menu_div_base">
			  			<span>신청내역</span>
			  		</div>
			  	</div>	  				  		
		  	</div>	
		<%
			}
		%>
		
		<%
			if(pm.equals("qrcode_request_list.jsp")){
		%>
				<div class="ui-grid-a header_menu_container">
			  	<div class="ui-block-a" onclick="goQrRequest()">
			  		<div class="haeder_menu_div_base">
			  			<span>QR신청</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-b" onclick="goQrRequestList()">
			  		<div class="haeder_menu_div_on">
			  			<span>신청내역</span>
			  		</div>
			  	</div>	  				  		
		  	</div>		
			<div class="ui-grid-a isTitle">
				<div  class="ui-block-a" style="width: 50%; text-align: left; padding: 5% 0 0 15px; font-size: 15px; font-weight: bold;">
					<p>신청내역</p>
				</div>
				<div class="ui-block-b" style="width: 50%; text-align: right; font-size: 12px; padding: 5% 15px 0 0; margin-top: 1%; color:#707070; text-decoration:underline;">
					<span>최신순</span>
				</div>
			</div>
		<%
			}
		%>
		<%
			if(pm.equals("support_list.jsp")){
		%>
			<div class="spt_list_top">
				<div class="ui-grid-a spt_lt_price_div">
					<div class="ui-block-a spt_lt_price_title">
						<img src="/img/support/support.png"> 총 누적 후원 금액
					</div>
					<div class="ui-block-b spt_lt_price_won">
						<span class="spt_lt_price" id="spt_lt_price">261,260</span>원
					</div>
				</div>
				<p class="spt_lt_search_title">기간별 조회</p>
				<div class="ui-grid-b spt_lt_search_div">
					<div class="ui-block-a spt_lt_search_btn spt_lt_search_select" id="spt_lt_search_onemonth">최근 1개월</div>
					<div class="ui-block-b spt_lt_search_btn" id="spt_lt_search_threemonth">최근 3개월</div>
					<div class="ui-block-c spt_lt_search_btn" id="spt_lt_search_date_btn">
						<select id="spt_lt_search_date">
						</select>
					</div>
				</div>
			</div>
			<div class="ui-grid-a spt_list_middel">
				<div class="ui-block-a spt_lm_left" id="spt_lm_title">2019년 03월</div>
				<div class="ui-block-b spt_lm_right" id="spt_lm_sort">최신순</div>
			</div>
		<%
			}
		%>
		<%
			if(pm.equals("perform_request_search.jsp")){
		%>
			<div class="ui-grid-a header_menu_container">
			  	<div class="ui-block-a">
			  		<div id="Go_ConditionSC" class="haeder_menu_div_on">
			  			<span>조건검색</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-b">
			  		<div id="Go_NameSC" class="haeder_menu_div_base">
			  			<span>이름검색</span>
			  		</div>
			  	</div>	 
		  	</div>	
		<%
			}
		%>
		<%
			if(pm.equals("share_item_list.jsp")){
		%>
			<div class="ui-grid-d header_menu_container">
				<div class="ui-block-a">
			  		<div class="haeder_menu_div_on" id="Go_AllEqu">
			  			<span>전체</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-b">
			  		<div class="haeder_menu_div_base" id="Go_SoundEqu">
			  			<span>음향</span>
			  		</div>
			  	</div>
			  	<div class="ui-block-c">
			  		<div class="haeder_menu_div_base" id="Go_VideoEqu">
			  			<span>영상</span>
			  		</div>
			  	</div>	 
			  	<div class="ui-block-d">
			  		<div class="haeder_menu_div_base" id="Go_InstrumentEqu">
			  			<span>악기</span>
			  		</div>
			  	</div>	 
			  	<div class="ui-block-e">
			  		<div class="haeder_menu_div_base" id="Go_OtherEqu">
			  			<span>기타</span>
			  		</div>
			  	</div>	 
		  	</div>	
	  		<div id="share_item_list_middle">
				<!-- 장비공유 검색부분 -->
		  	</div>
		<%
			}
		%>
		<%
			if(pm.equals("buskingzone_list.jsp")){
		%>
			<div class="bzl_header_container">
			  	<ul id="bzl_header_ul">
			  		
			  	</ul>
		  	</div>	
		  	<div class="ui-grid-b bzl_search_div search-input-text-container">
		  		<div class="ui-block-a bzl_search_img">
	  				<img class="search-input-icon" src="/img/artist_ranking/ar_search_.svg">
		  		</div>
		  		<div class="ui-block-b">
		  			<input type="text" class="search-input-text" id="bzl_search" placeholder="키워드로 검색하기">
		  		</div>
		  		<div class="ui-block-c search-input-text-cancel" id="bzl_search_cancel_btn">
		  			취소
		  			<!-- <img src="/img/artist_ranking/ar_cancle.svg"> -->
		  		</div>
		  	</div>
		<%
			}
		%>
		<%
			if(pm.equals("thanks_people.jsp")){
		%>
			<div class="ui-grid-b header_menu_container" id="thanks_people_menu">
				<div class="ui-block-a">
					<div class="haeder_menu_div_on" id="Go_AllSupport">
						<span>후원전체</span>
					</div>
				</div>
				<div class="ui-block-b">
					<div class="haeder_menu_div_base" id="Go_PayApply">
						<span>지급신청</span>
					</div>
				</div>
				<div class="ui-block-c">
					<div class="haeder_menu_div_base" id="Go_WithdrawList">
						<span>지급내역</span>
					</div>
				</div>
		  	</div>
		<%
			}
		%>
		<%
			if(pm.equals("tipbox_list.jsp")){
		%>
			<div class="ui-grid-b header_menu_container" id="tbl_menu">
				<div class="ui-block-a"  id="Go_AllTipboxList">
					<div class="haeder_menu_div_on">
						<span>전체</span>
					</div>
				</div>
				<div class="ui-block-b" id="Go_AreaTipboxList">
					<div class="haeder_menu_div_base">
						<span>지역</span>
					</div>
				</div>
				<div class="ui-block-c" id="Go_GenreTipboxList">
					<div class="haeder_menu_div_base">
						<span>장르</span>
					</div>
				</div>
		  	</div>
		  	<div class="tbl_slider" id="tbltouchFlow">
		  		<ul class="tbl_slider_ul" id="tbl_slider_area"></ul>
		  	</div>
	  		<ul class="main_genre_ul" id="tbl_slider_genre"></ul>
		  	<div class="ui-grid-b tbl_search_div search-input-text-container">
		  		<div class="ui-block-a tlb_search_img">
	  				<img class="search-input-icon" src="/img/artist_ranking/ar_search_.svg">
		  		</div>
		  		<div class="ui-block-b">
		  			<input type="text" data-role="none" class="search-input-text" id="tlb_search" placeholder="팀명으로 검색하기">
		  		</div>
		  		<div class="ui-block-c search-input-text-cancel" id="tlb_search_cancel_btn">
		  			취소
		  			<!-- <img src="/img/artist_ranking/ar_cancle.svg"> -->
		  		</div>
		  	</div>
		  	<div class="tbl_qr_scan_btn">
		  		<img src="/img/tipbox/tipbox_qrscan.svg"><span>"QR배너 스캔하여 팁 후원"</span>
		  	</div>
		<%
			}
		%>
		<%
			if(pm.equals("my_recruit.jsp")){
		%>
			<div class="mr-header">
				<p class="mr-filter mr-on" id="mr-filter-all">전체</p>
				<p class="mr-filter" id="mr-filter-pass">합격만보기</p>
			</div>
		<%
			}
		%>

        <%-- 공연 모집 등록 head --%>
        <%
			if(pm.equals("busking_time_reg_all.jsp")){
		%>
			<div class="btr_header_container">
			  	<ul id="btl_header_ul">
                    <li class="btr_header_li area_on" value="일괄 등록"><div>일괄 등록</div></li>
                    <li class="btr_header_li" value="개별 등록"><div onclick="go_reg_busking_time_each()">개별 등록</div></li>
			  	</ul>
		  	</div>	
		<%
			}
		%>

        <%-- 공연 모집 등록 head --%>
        <%-- <%
			if(pm.equals("busking_time_reg_each.jsp")){
		%>
			<div class="btr_header_container">
			  	<ul id="btl_header_ul">
                    <li class="btr_header_li" value="일괄 등록"><div onclick="go_reg_busking_time_all()">일괄 등록</div></li>
                    <li class="btr_header_li area_on" value="개별 등록"><div>개별 등록</div></li>
			  	</ul>
		  	</div>	
		<%
			}
		%> --%>
				
	<div id="side_panel_btn">
		<img src="/img/index/btn.png">
	</div>
	
	<!-- <script type="text/javascript">
		duplicate_loginChk();
	</script> -->
</header>
<!-- header 부분 -->
