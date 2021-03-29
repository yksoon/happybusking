<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="support_list_page">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id = "support_list_sec" data-role="content">
			<div class="spt_list_body" id="spt_list_body">
			</div>
		</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
	<div data-role="popup" id="support_list_popup">
			<div class="spt_lp_header">
				후원 상세 내역
			</div>
			<div class="spt_lp_body">
				<div class="ui-grid-a spt_lp_body_top">
					<div class="ui-block-a spt_lp_title">후원팀명</div>
					<div class="ui-block-b spt_lp_content" id="spt_lp_tname"></div>
					<div class="ui-block-a spt_lp_title">후원일시</div>
					<div class="ui-block-b spt_lp_content" id="spt_lp_date"></div>
					<div class="ui-block-a spt_lp_title">결제수단</div>
					<div class="ui-block-b spt_lp_content" id="spt_lp_paymethod"></div>
					<div class="ui-block-a spt_lp_title">후원자명</div>
					<div class="ui-block-b spt_lp_content" id="spt_lp_sname"></div>
					<div class="ui-block-a spt_lp_title">연락처</div>
					<div class="ui-block-b spt_lp_content" id="spt_lp_tel"></div>
				</div>
				<div class="ui-grid-a spt_lp_body_bottom">
					<div class="ui-block-a spt_lp_title">후원금액</div>
					<div class="ui-block-b spt_lp_content">
						<span class="spt_lp_price" id="spt_lp_price"></span>
						원
					</div>
					<p class="spt_lp_text">결제완료</p>
				</div>
				<div class="spt_lp_footer">
					<div class="spt_lp_btn" id="spt_lp_btn">확인</div>
				</div>
			</div>
		</div>
</div>