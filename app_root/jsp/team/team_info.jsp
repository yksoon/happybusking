<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@include file="/importhaed.jsp" %>

<meta charset="UTF-8">

<div data-role="page" id="team_info">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->
	<div data-role="content" id="team_info_content">
		<div class="ui-grid-a team_intro_image team_info_image_typea" id="ti_bandImg">
			<div class="team_image_view" id="tiv_btn"></div>
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
							<img class="tic_interest_icon" id="team_interest_icon"
								src="/img/v2/ar_nolike__.svg">
						</div>
						<div class="ui-block-b tic_interest_count" id="ti_bandInterestCount"></div>
					</div>
				</div>
				<div class="support_test_btn" onclick="go_support();"><img src="/img/common/tip_box.svg"></div>
			</div>
		</div>
		<div id="team_middle" style="width: 100%;"></div>
		<div id="team_info_list">
			<div id="ti_intro_title" class="ui-grid-a">
				<div class="ui-block-a">
					<p>소개</p> 
				</div>
				<div class="ui-block-b">
					<span id="tinfo_showBtn" onclick="tinfo_showAll();">전체보기</span>
				</div>
			</div>
			<div id="ti_bandIntro"></div>

			<div id="ti_member_title">멤버</div>
			<div id="ti_member_content">
				<div id="team_member_part" class="ui-grid-a"></div>
			</div>

			<div id="ti_video_title">동영상</div>

			<div id="ti_videoPart" class="ui-grid-a">
				<div class="ui-block-a" style="width: 40%;">
					<img id="ti_videoImg" src="">
					<div id="ti_videoImg_div"></div>

				</div>
				<div class="ui-block-b" style="width: 60%;">
					<p id="ti_videoContent"></p>
				</div>
			</div>
		</div>
		<div id="main_cont"></div>
		<!-- 댓글 -->
		<div class="pd_reply_div">
			<div class="pd_reply">
				<p class="title_re">댓글</p>
				<img id="dt_reply_reflash" onclick="getTeamReplyList();" src="/img/board/reply_refresh.svg">
				<div class="ui-grid-a pd_ui1_inputbox">
					<div class="ui-block-a pd_uil_inputdiv">
						<input class="pd_ui1_input" id="pf_reply_content" placeholder="아티스트에게 댓글을 남겨주세요">
					</div>
					<div class="ui-block-b td_ui1_btn" onclick="handlerTeamReplyAdd();">
						<div id="dt_re_insertbtn"> <img src="/img/common/re_write.svg"></div>
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
			
			<!-- 해당 아티스트 youtube에 업로드 된 동영상 보기  -->
			<img id="icon_show_video" src="/img/team/submenu/icon_show2_btn.svg" onclick="goTeamVideoList();">
			
			
			<!-- 아티스트정보 서브메뉴 아이콘 -->
			<div  data-role="popup"  id="team_info_submenu">
					<div class="ui-grid-a" id="ad_cheers_btn">
						<div class="ui-block-a">모바일 팁박스</div>
						<div class="ui-block-b" onclick="go_support();"><img src="/img/team/submenu/tipbox_btn.svg"></div>
					</div>
					<div class="ui-grid-a" id="camera_show_btn">
						<div class="ui-block-a">응원봉</div>
						<div class="ui-block-b" onclick="go_audience_cheers();"><img src="/img/team/submenu/cheer_btn.svg"></div>
					</div>
					<div class="ui-grid-a" id="support_show_btn">
						<div class="ui-block-a">영상업로드</div>
						<div class="ui-block-b" onclick="go_videoUpload();"><img src="/img/team/submenu/camera_btn.svg"></div>
					</div>
					<div class="ui-grid-a" id="perfrom_req_btn">
						<div class="ui-block-a">공연요청</div>
						<div class="ui-block-b" onclick="go_pfRequest();"><img src="/img/team/submenu/perfrom_req_btn.svg"></div>
					</div>
					<img id="icon_hide_btn" src="/img/team/submenu/icon_hide_btn.svg">
				</div>
			<img id="icon_show_btn" src="/img/team/submenu/icon_show_btn.svg">
			
			<input id="artistNo" type="hidden" value="">
			<input type="hidden" id="user_no" value="<%=USER_NO %>">
			
			<!-- 이미지 자세히보기 팝업 -->
			<div id="team_img_popup">
			</div>
			
			<!-- 이벤트 당첨  -->
			<div class="team_event_popup" id="event_winning_popup">
				<div class="wep_container">
					<div class="wep_close" id="wep_close_btn"><img src="/img/team/cancle2.png"></div>
					<p class="wepc_title">축하합니다, 기프티콘에</p>
					<p class="wepc_title">당첨되셨습니다!</p>
					<img class="wepc_main_image" src="/img/team/gift.png">
					<p class="wepc_content">당첨된 기프티콘은 입력하신</p>
					<p class="wepc_content">휴대폰 번호로 전송됩니다.</p>
					<input type="text" class="wepc_input" id="wepc_phone" data-role="none" placeholder="(-없이) 휴대폰 번호를 입력하세요.">
					<div class="common_terms_check common_flex_container wep_terms_container">
						<input type="checkbox" id="e_info_checkbox" data-role="none">
						<label for="e_info_checkbox">개인정보 처리 및 취급방침 동의(필수)</label>
						<div class="common_terms_view_more" id="personal_info_view">보기</div>
					</div>
					<div class="wep_footer" id="wep_btn">확인</div>
					<input type="hidden" id="wepc_ip">
				</div>
			</div>
			
			<!-- 이벤트 노당첨  -->
			<div class="team_event_popup" id="event_whack_popup">
				<div class="wep_container">
					<p class="wepc_title">꽝! 다음 기회에...</p>
					<img class="wepc_main_image" src="/img/team/cry.png">
					<p class="wepc_content">아쉽지만 당첨되지 않았습니다.</p>
					<p class="wepc_content">다음 공연팀 시간에 참여 부탁드려요ㅠㅠ</p>
					<div class="wep_footer" id="ewp_close_btn">확인</div>
				</div>
			</div>
			
			<!-- 메트로 만족도 팝업 -->
			<div id="metro_popup">
			</div>
	<div data-role="popup" class="common_trems_popup_container" id="terms_popup">
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>
