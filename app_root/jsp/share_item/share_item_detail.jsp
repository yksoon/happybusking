
<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<div data-role="page" id="share_item_detail">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->		
	<div id = "share_item_detail_sec" data-role="content" style="text-align:center; padding: 0;">
		<div id="sid_pfsc_ing_body">
			<ul id="sid_pfsc_ing_ul">
				
			</ul>
		</div>
		<ul id="sid_img_selecter">
		</ul>
		<div class="sid_box">
			<!-- 물음표 누르면 나오는 팝업 -->
			<div class="sid_help_popup">
				<i class="fa fa-question-circle"></i> 공유 가격 알림<br>
				시간 또는 일 단위의 공유가격<br>
				입니다.(ex. 1일에 50,000원)
			</div>
			
			<div class="sid_product_info">
				<i class="fa fa-user"></i><p class="sid_user_name" id="sid_user_name"></p><span id="si_del_btn">글삭제</span>
				<div class="sid_p_name">
					<div class="product_name"><p class="uba_pn_p" id="sid_product_name"></p></div>
				</div>
				<div class="ui-grid-b sid_p_price">
					<div class="ui-block-a product_rank" id="sid_product_rank"></div>
					<div class="ui-block-b product_period" id="sid_product_period"></div>
					<div class="ui-block-c product_price">
						<div class="ui-gird-c">
							<div class="ui-block-a product_price_text" id="sid_product_price_text">59,000</div>
							<div class="ui-block-b won">원</div>
							<div class="ui-block-c question" id="sid_question_btn"><i class="fa fa-question-circle" id="question_circle"></i></div>
						</div>
					</div>
				</div>		
				<div class="ui-grid-a post">
					<div class="ui-block-a">
						<div class="ontheway" id="sid_si_delivery"></div>
					</div>
					<div class="ui-block-b location" id="sid_si_place"></div>
				</div>				
			</div>
		</div>
		<div class="ui-grid-b sid_click_bar">
			<div class="ui-block-a sid_click_bar_a content active" id="cb_content"><span>장비내용</span></div>
			<div class="ui-block-b sid_click_bar_a reply" id="cb_reply"><span>장비댓글</span></div>
			<div class="ui-block-c sid_click_bar_a phone" id="cb_phone"><span>바로연락</span></div>
		</div>
		<div class="sid_info_box">
		
			<div class="sid_ib_equip_info sib_view">
				<p class="sid_ib_ei_text" id="sid_si_content"></p>
	
				<div class="sid_ib_ei_warning">
					<p class="sid_ib_ei_warning_top">※주의사항</p>
					<p>장비반납을 택배나 퀵배달로 할 경우 공유자가 최초 등록한 사진과 같은 부위를 촬영하여 공유자에게 전송한 후 배송을 해야 상호간의 분쟁을 예방 할 수 있습니다.</p>
				</div>
			</div>
			
			<div class="sid_reply_div sib_view hide">
				<div class="sid_reply">
					<div class="ui-grid-a sid_ui1_inputbox">
						<div class="ui-block-a sid_uil_inputdiv">
							<input class="sid_ui1_input" id="si_reply_content" placeholder="공유된 장비에 대한 댓글을 남겨주세요">
						</div>
						<div class="ui-block-b sid_ui1_btn">
							<div id="sid_re_insertbtn"><img src="/img/common/re_write.svg"></div>
						</div>
					</div>
				</div>
				<p class="sid_re_total_container">총 <a id="sid_re_total_count"></a>개</p>
				<div class="sid_reply1" id="sid_reply_body">
					<!-- 댓글 리스트 -->
					
					
				</div>
			</div>
			<div class="sid_phone_div sib_view hide">
				<p class="sid_phone_div" id="sid_si_contact"></p>
			</div>
		</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
	<input type="hidden" id="si_no">
	<input type="hidden" id="user_no" value="<%=USER_NO %>">
</div>
