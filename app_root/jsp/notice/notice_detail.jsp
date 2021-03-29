<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/importhaed.jsp" %>

<div data-role="page" id="notice_detail">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id="notice_detail_content" data-role="content">
			<div class="ui-grid-a ndc_title_container">
				<div class="ui-block-a ndc_title_content">
					<p class="ndc_title"></p>
				</div>
				<div class="ui-block-b ndc_title_content">
					<p class="ndc_tc_text ndc_date">2019-06-18 14:17</p>
					<p class="ndc_tc_text ndc_vcount">조회수: 0</p>
				</div>
			</div>
			<div class="ndc_content_container" id="ndc_content_container">
				
			</div>
			<div class="ndc_reply_conatiner">
				<div class="ndc_rc_title">댓글</div>
				<img id="ndc_rc_reflash" src="/img/board/reply_refresh.svg">
				<div class="ui-grid-a ndc_rc_inputcontainer">
					<div class="ui-block-a ndc_rc_inputbox">
						<input type="text" id="nt_reply" placeholder="댓글을 입력해주세요.(100자 이내)">
					</div>
					<div class="ui-block-b ndc_rc_btn">
						<div id="ndc_rc_insertbtn">
							<img src="/img/common/re_write.svg">
						</div>
					</div>
				</div>
			</div>
			<div class="ndc_reply_total_container">
				총 <span id="ndc_rtc_count"></span>개
			</div>
			<div class="ndc_reply_body_contianer" id="ndc_reply_body_contianer">
				<div class="ndc_rbc_no_text">해당 공지사항에 댓글이 없습니다.</div>
			</div>
		</div>
		<input type="hidden" value="<%=USER_NO %>" id="uno">
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>