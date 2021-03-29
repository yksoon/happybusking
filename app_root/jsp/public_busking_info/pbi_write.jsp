<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="pbi_write">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
	<div id="pbi_write_sec" data-role="content" style="text-align:center; padding: 0;">
		<p class="pbi_ws_title">공공 버스킹 썸네일 이미지</p>
		<input type="file" id="pbi_thumnail_img">
		
		<p class="pbi_ws_title">공공 버스킹 메인 이미지</p>
		<input type="file" id="pbi_main_img">
		
		<p class="pbi_ws_title">공공 버스킹 행사명</p>
		<input type="text" id="pbi_title">
		
		<p class="pbi_ws_title">공공 버스킹 행사 접수 시작일</p>
		<div class="ui-grid-b pbi_ws_receipt_date">
			<div class="ui-block-a">
				<select id="pbi_receipt_syear">
				</select>
			</div>
			<div class="ui-block-b">
				<select id="pbi_receipt_smonth">
				</select>
			</div>
			<div class="ui-block-c">
				<select id="pbi_receipt_sday">
				</select>
			</div>
		</div>
		<p class="pbi_ws_title">공공 버스킹 행사 접수 종료일</p>
		<div class="ui-grid-b pbi_ws_receipt_date">
			<div class="ui-block-a">
				<select id="pbi_receipt_eyear">
				</select>
			</div>
			<div class="ui-block-b">
				<select id="pbi_receipt_emonth">
				</select>
			</div>
			<div class="ui-block-c">
				<select id="pbi_receipt_eday">
				</select>
			</div>
		</div>
		
		<p class="pbi_ws_title">공공 버스킹 행사 시작일</p>
		<div class="ui-grid-b pbi_ws_receipt_date">
			<div class="ui-block-a">
				<select id="pbi_event_syear">
				</select>
			</div>
			<div class="ui-block-b">
				<select id="pbi_event_smonth">
				</select>
			</div>
			<div class="ui-block-c">
				<select id="pbi_event_sday">
				</select>
			</div>
		</div>
		<p class="pbi_ws_title">공공 버스킹 행사 종료일</p>
		<div class="ui-grid-b pbi_ws_receipt_date">
			<div class="ui-block-a">
				<select id="pbi_event_eyear">
				</select>
			</div>
			<div class="ui-block-b">
				<select id="pbi_event_emonth">
				</select>
			</div>
			<div class="ui-block-c">
				<select id="pbi_event_eday">
				</select>
			</div>
		</div>
		
		<p class="pbi_ws_title">공공 버스킹 장르(ex. 발라드,댄스,힙합)</p>
		<input type="text" id="pbi_genre">
		
		<p class="pbi_ws_title">공연 인원</p>
		<input type="text" id="pbi_personner">
		
		<p class="pbi_ws_title">공연비</p>
		<input type="text" id="pbi_pay">
		
		<p class="pbi_ws_title">공공 버스킹 주소</p>
		<div class="ui-grid-a pbi_ws_postcode">
			<input type="hidden" id="postcode">
			<div class="ui-block-a">
				<input type="text" id="address">
			</div>
			<div class="ui-block-b">
				<p class="pbi_ws_postcode_search" onclick="open_execDaumPostcode('addr_layer');">주소 검색</p>
			</div>
		</div>
		<input type="text" id="pbi_detailaddress">
		<input type="hidden" id="latlng">
		
		<div class="common_map_div" id="map">
			
		</div>
		
		<p class="pbi_ws_title">공공 버스킹 본문내용</p>
		<textarea rows="5" cols="5" id="pbi_content" placeholder="행사개요, 행사 관람 대상, 참가 자격, 신청 절차, 유의사항 등 텍스트로 입력"></textarea>
		
		<div id="addr_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
			<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode('addr_layer')" alt="닫기 버튼">
		</div>
		
		<div class="common_InsertBtnForm" id="pbi_ws_btn">등록완료</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>
