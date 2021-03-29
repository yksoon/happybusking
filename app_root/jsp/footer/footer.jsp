<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%
	String pm2 = request.getRequestURI();
	pm2 = pm2.substring(pm2.lastIndexOf("/") + 1, pm2.length());
%>
<!-- header 부분 -->
<footer data-role="footer" data-position="fixed" data-tap-toggle="false" id="footer">
	<%
		if(pm2.equals("pbi_condition.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="pbi_condition_apply">설정완료</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("qrcode_request.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="BtnQrRequestGo">
			신청하기
		</div>
		<div class="ui-grid-a qrb_btn_container" style="display: none;">
			<div class="ui-block-a" id="qrb_prev_btn">
				이전
			</div>
			<div class="ui-block-b" id="qrb_success_btn">
				결제하기
			</div>
		</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("schedule_apply.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="insert_schedule_apply">
			신청하기
		</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("festival_apply.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="insert_koica_btn">
			신청하기
		</div>
	<%
		}	
	%>
	<%-- <%
		if(pm2.equals("pbi_detail.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="pbid_btn" onclick="goKoicaInsert();">
			해피버스킹 공연팀 신청하기
		</div>
	<%
		}	
	%> --%>
	<%
		if(pm2.equals("app_contact.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="url_nonmember_btn">
			비회원 문의 확인
		</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("qr_request_cancel.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="qrc_success_btn">
			결제 취소
		</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("user_request_detail.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="urd_ok_btn">
			확인
		</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("user_request_write.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="urw_success_btn">
			문의하기
		</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("team_media_reg.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="tmr_success_btn">
			업로드
		</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("team_create_update.jsp")){
			
	%>
		<!-- 수정완료 버튼 -->
		<div class="common_InsertBtnForm" id="team_update_btn" onclick="team_update_btn();">
			수정하기
		</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("team_create.jsp")){
			
	%>
		<!-- 등록완료 버튼 -->
		<div class="common_InsertBtnForm" id="team_create_btn" onclick="team_create_btn();">
			등록하기
		</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("team_board_update.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="team_board_update_btn">
			수정하기
		</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("team_board_write.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="team_board_write_btn">
			작성하기
		</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("team_board_view.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="tb_reply_view_footer">
			댓글달기
		</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("myinfo.jsp")){
			
	%>
		<div class="common_UpdateBtnForm" id="myinfoLogoutBtn" style="background-color: #aaaaaa;">
			로그아웃
		</div>		
	<%
		}	
	%>	
	<%
		if(pm2.equals("new_pwd.jsp")){
			
	%>
		<div class="pwdSearchBtnForm" id="pwdCangeBtn">
			변경하기
		</div>		
	<%
		}	
	%>	
	<%
		if(pm2.equals("video_upload.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="video_upload_btn">업로드</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("user_write_review.jsp")){
			
	%>
		<div class="common_InsertBtnForm" onclick="sendreview();">작성하기</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("supply_item_request.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="BtnIrInsertGo">
			신청하기
		</div>	
	<%
		}	
	%>	
	<%
		if(pm2.equals("perform_cancle_msg.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="pf_cancle_btn" >일정 취소</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("perform_reg.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="perform_reg_btn">
			등록하기
		</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("perform_request_refuse_msg.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="prq_refuse_btn" >요청 거절</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("perform_request.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="perform_rq_btn">
			요청하기
		</div>
	<%
		}	
	%>	
	<%
		if(pm2.equals("join.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="joinUpdateBtn">
			가입하기
		</div>	
	<%
		}	
	%>	
	<%
		if(pm2.equals("checkterms.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="f_joinUpdateBtn">
			가입하기
		</div>	
	<%
		}	
	%>	
	<%
		if(pm2.equals("navercheckterms.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="n_joinUpdateBtn">
			가입하기
		</div>	
	<%
		}	
	%>	
	<%
		if(pm2.equals("artist_update.jsp")){
			
	%>
		<div class="common_InsertBtnForm artist_update_btn">
			수정하기
		</div>	
	<%
		}	
	%>
	<%
		if(pm2.equals("artist_become.jsp")){
			
	%>
		<div class="common_InsertBtnForm artist_become_btn">
			등록하기
		</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("detail_performance.jsp") || pm2.equals("team_info.jsp")){
			
	%>
		<div class="ui-grid-a dp_footer_btn">
			<div class="ui-block-a common_InsertBtnForm prq_addlist_btn">
				요청 리스트 추가
			</div>
			<div class="ui-block-b prq_goback_btn">
				리스트로 이동
			</div>
		</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("share_item_reg.jsp")){
			
	%>
		<div class="common_InsertBtnForm sir_insert_btn">
			등록하기
		</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("buskingzone_reg.jsp")){
			
	%>
		<div class="common_InsertBtnForm brc_insert_btn">
			등록하기
		</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("support.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="support_success_btn">
			팁박스 결제하기
		</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("support_complete.jsp")){
			
	%>
		<div class="ui-grid-a spt_comp_btn_div spt_success">
			<div class="ui-block-a spt_comp_skipbtn" id="spt_comp_skipbtn">건너뛰기</div>
			<div class="ui-block-b spt_comp_sendtbn" id="spt_comp_sendbtn">보내기</div>
		</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("thanks_people.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="pay_apply_btn">지급신청</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("perform_request_search.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="prq_sh_request_btn" style="display: none;">다음단계</div>
	<%
		}	
	%>
	<%
		if(pm2.equals("support_test.jsp")){
			
	%>
		<div class="common_InsertBtnForm" id="support_success_btn_test">
			후원하기
		</div>
	<%
		}	
	%>
	
	<%
		if(pm2.equals("kakao_map_test.jsp")){
			
	%>
		
		<div class="common_InsertBtnForm" id="pay_test_btn">결제하기</div>
	<%
		}	
	%>
	
	<%
		if(pm2.equals("team_board.jsp")){
			
	%>
		
		<div class="common_InsertBtnForm" onclick="go_team_board_write();">글쓰기</div>
	<%
		}	
	%>

	
	<!-- *************************************************************************************************************** -->
	<div class="ui-grid-d" id="index_menu_list">
		<div class="ui-block-a index_menu"  onclick="go_artist_ranking();">
			<div class="ui-grid-a" >
				<div class="ui-block-a index_menu_img">
					<img class="footer_ar_img" src="/img/test/m_artist.svg">
				</div>
				<div class="ui-block-b index_menu_text footer_ar_txt">팀/솔로</div>
			</div>
		</div>
		<%-- <div class="ui-block-b index_menu" onclick="go_perform_schedule(); "> --%>
		<div class="ui-block-b index_menu" onclick="go_store_list();">
			<div class="ui-grid-a" >
				<div class="ui-block-a index_menu_img ">
					<img class="footer_pfsc_img" src="/img/test/m_schedule.svg">
				</div>
				<div class="ui-block-b index_menu_text footer_pfsc_txt">공연일정</div>
			</div>
		</div>
		<div class="ui-block-c index_menu"  onclick="toHome();">
			<div class="ui-grid-a" >
				<div class="ui-block-a index_menu_img ">
					<img class="footer_home_img" src="/img/test/m_home.svg">
				</div>
				<div class="ui-block-b index_menu_text footer_home_txt">홈</div>
			</div>
		</div>
		<div class="ui-block-d index_menu" onclick="go_audience_cheers();">
			<div class="ui-grid-a">
				<div class="ui-block-a index_menu_img">
					<img src="/img/test/m_cheer.svg">
				</div>
				<div class="ui-block-b index_menu_text">응원봉</div>
			</div>
		</div>
		<div class="ui-block-e index_menu" onclick="qr_scan();">
			<div class="ui-grid-a" >
				<div class="ui-block-a index_menu_img">
					<img src="/img/test/m_qrscan.svg">
				</div>
				<div class="ui-block-b index_menu_text">QR스캔</div>
			</div>
		</div>
	</div>
	<!-- <div class="flex_footer_container">
		<div class="ui-grid-a flex_footer_item">
			<div class="ui-block-a ffi_image">
				<img src="/img/test/m_artist.svg">
			</div>
			<div class="ui-block-b ffi_text">아티스트</div>
		</div>
		<div class="ui-grid-a flex_footer_item">
			<div class="ui-block-a ffi_image ">
				<img src="/img/test/m_schedule.svg">
			</div>
			<div class="ui-block-b ffi_text">공연일정</div>
		</div>
		<div class="ui-grid-a flex_footer_item flex_footer_center">
			홈부분 내용 추가
		</div>
		<div class="ui-grid-a flex_footer_item flex_footer_fake">
		</div>
		<div class="ui-grid-a flex_footer_item">
			<div class="ui-block-a ffi_image">
				<img src="/img/test/m_cheer.svg">
			</div>
			<div class="ui-block-b ffi_text">응원봉</div>
		</div>
		<div class="ui-grid-a flex_footer_item">
			<div class="ui-block-a ffi_image">
				<img src="/img/test/m_qrscan.svg">
			</div>
			<div class="ui-block-b ffi_text">QR스캔</div>
		</div>
	</div> -->
</footer>