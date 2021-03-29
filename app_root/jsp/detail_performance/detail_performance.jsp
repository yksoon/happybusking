<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/importhaed.jsp" %>
    
<div data-role="page" id="detail_perform" style="height: 100%;">
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->	
		<div data-role="content">	
		<input type="hidden" id="user_no" value="<%=USER_NO %>">
		<div class="ui-grid-a team_intro_image" id="ti_bandImg">
			<div class="team_intro_container" id="ti_intro_div">
				<div class="tic_name_text" id="ti_bandName"></div>
				<div class="tic_text_container" id="ti_intro_txt">
					<div>
						<span class="tic_belong_text" id="ti_belong"></span>
						<span class="tic_middle_text">|</span>
						<span class="tic_perform_text" id="ti_bandPerform"></span>
					</div>
						<span class="tic_genre_text" id="ti_bandGenre"></span>
				</div>
				<div class="interest_icon_btn">
					<div class="ui-grid-a">
						<div class="ui-block-a tic_interest_image">
							<img class="tic_interest_icon" id="df_team_interest_icon"
								src="/img/v2/ar_nolike__.svg">
						</div>
						<div class="ui-block-b tic_interest_count" id="ti_bandInterestCount"></div>
					</div>
				</div>
				<div class="support_test_btn" onclick="go_support();"><img src="/img/common/tip_box.svg"></div>
			</div>
		</div>
		<div id="detail_perform_middle">
		</div>
		<div id="detail_perform_tab">
		</div>
		<div id="main_cont">
		</div>
		
		<!-- 댓글 -->
		<div class="pd_reply_div">
			<div class="pd_reply">
				<p class="title_re">댓글</p>
				<img id="pd_reply_reflash" src="/img/board/reply_refresh.svg">
				<div class="ui-grid-a pd_ui1_inputbox">
					<div class="ui-block-a pd_uil_inputdiv">
						<input class="pd_ui1_input" id="pf_reply_content" placeholder="공연에대한 댓글을 남겨주세요">
					</div>
					<div class="ui-block-b pd_ui1_btn">
						<div id="pd_re_insertbtn"> <img src="/img/common/re_write.svg"></div>
					</div>
				</div>
			</div>
			<p class="pd_re_total_container">총 <a id="pd_total_count"></a>개</p>
			<div class="pd_reply1" id="pd_reply_body">
				<!-- 댓글 리스트 -->
			</div>
			<!-- <div class="pd_reply_viewmore">
				<div class="pd_r_vm_btn">댓글 더보기</div>
			</div> -->
		</div>
		
		
		</div>
		<div id="df_image_view_popup" data-role="popup">
			<img id="dfivp_image">
		</div>
		<!-- 공연 알람 설정 팝업 -->
		<div class="ia_popup" id="interest_alarm_popup">
			<div class="ia_popup_wapper">
				<img src="/img/v2/ar_like__.svg" style="width: 7%;">
				<p class="iap_text_a">등록완료</p>
				<p class="iap_text_b">
					관심 아티스트로 등록 되었습니다.<br>
					공연 알람을 설정 하시겠습니까?
				</p>
				<div class="ia_alarm_btn_container">
					<p class="iabtn" id="int_alarm_okBtn">공연 알람 설정</p>
					<p class="iabtn" id="int_alarm_noBtn">나중에</p>
				</div>
			</div>
		</div>
			
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>