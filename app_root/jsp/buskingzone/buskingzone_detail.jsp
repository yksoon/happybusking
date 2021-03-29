<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<meta charset="UTF-8">

<div data-role="page" id="buskingzone_detail">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->		
	<div id="buskingzone_detail_content" data-role="content">
		<div id="bdc_pfsc_ing_body">
			<ul id="bdc_pfsc_ing_ul">
				
			</ul>
		</div>
		<ul id="bdc_img_selecter">
		</ul>
		<div class="ui-grid-c bdc_body">
			<div class="ui-block-a bdc_body_block">
				<div class="ui-grid-a">
					<div class="ui-block-a bdc_title_block"><p class="bdc_body_title"></p></div>
					<div class="ui-block-b bdc_btn_block"><p class="bdc_getdirection_btn">길찾기</p></div>
				</div>
			</div>
			<div class="ui-block-b bdc_body_block">
				<img src="/img/buskingzone/location.svg">
				<p class="bdc_body_text" id="bdc_body_location"></p>
			</div>
			<div class="ui-block-c bdc_body_block">
				<img src="/img/buskingzone/hp.svg">
				<a class="bdc_body_text bdc_body_url" id="bdc_body_url"></a>
			</div>
			<div class="ui-block-d bdc_body_block">
				<img src="/img/buskingzone/call.svg">
				<p class="bdc_body_text" id="bdc_body_contact"></p>
			</div>
		</div>
		<div class="bdc_content">
			<p class="bdc_content_title">상세정보</p>
			<p class="bdc_content_subject"></p>
		</div>
		<div class="bdc_footer">
			<i class="fa fa-user"></i> <pre id="bdc_footer_name"></pre> 님의 공유입니다. <span id="bdc_del_btn">글삭제</span>
		</div>
		<div id="map">
		</div>
		<div class="bdc_reply_div">
			<div class="bdc_reply_header">
				<p class="bdc_rh_title">댓글</p>
				<img id="bdc_reply_reflash" src="/img/board/reply_refresh.svg">
				<div class="ui-grid-a bdc_uil_inputbox">
					<div class="ui-block-a bdc_uil_inputdiv">
						<input class="bdc_uil_input" id="bdc_reply_content" placeholder="공연에대한 댓글을 남겨주세요">
					</div>
					<div class="ui-block-b bdc_uil_btn">
						<div id="bdc_re_insertbtn"> <img src="/img/common/re_write.svg"></div>
					</div>
				</div>
			</div>
			<p class="bdc_re_total_container">총 <a id="bdc_total_count"></a>개</p>
			<div class="bdc_reply" id="bdc_reply_body">
				
			</div>
			<!-- <div class="pd_reply_viewmore">
				<div class="pd_r_vm_btn">댓글 더보기</div>
			</div> -->
		</div>
	</div>
	<input type="hidden" id="bz_no">
	<input type="hidden" id="user_no" value="<%=USER_NO %>">
	<input type="hidden" id="bz_place">
	<input type="hidden" id="bz_x">
	<input type="hidden" id="bz_y">
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>