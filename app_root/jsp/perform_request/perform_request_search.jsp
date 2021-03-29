<!DOCTYPE html>    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="perform_request_search">	

	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id="prq_search_content_div" data-role="content" style="text-align:center; padding: 0;">
			<div id="prq_search_header">
				<div class="prq_sh_csh_content">
					<div class="prq_sh_title_genre">장르 선택</div>
					<input type="text" id="text_genre" onclick="viewGenreSelectBox();" placeholder="장르 선택" readonly="readonly" >
					<input type="hidden" id="select_genre">
					<input type="hidden" id="main_genre">
					<div class="prq_sh_title_area">지역 선택</div>
					<select id="prq_sh_csh_area" required="required">
						<option value="" selected="selected">전체</option>
					</select>
					<div class="prq_sh_title_money">시간당 금액</div>
					<div class="ui-grid-b prq_sh_money_div">
						<div class="ui-block-a">
							<input type="text" id="prq_tsmoney" placeholder="0">
						</div>
						<div class="ui-block-b">
							~
						</div>
						<div class="ui-block-c">
							<input type="text" id="prq_temoney" placeholder="0">
						</div>
					</div>
					
					<div class="prq_sh_tmoney_info">
						<p>[검색 방법]</p>
						<p>공연을 의뢰할 수 있는 예산의 최소금액과 최대금액 입력</p>
						<p>(ex. (1시간 당 지급 금액) 최소 50,000 ~ 최대 120,000) </p>
					</div>
					<div class="prq_sh_title_ts">팀/개인 선택</div>
					<div class="prq_sh_ttype_div">
						<input type="checkbox" id="tteam" checked="checked">
						<label for="tteam" id="prq_sh_ttype_text">팀</label>
						<input type="checkbox" id="tsolo" checked="checked">
						<label for="tsolo" id="prq_sh_ttype_text">개인</label>
					</div>
				</div>
				<div class="prq_sh_tname_input">
					<img src="/img/artist_ranking/ar_search.svg">
					<input type="text" id="prq_tname" placeholder="팀이름 검색">
				</div>
				<div class="common_InsertBtnForm" id="prq_sh_search_btn">검색하기</div>
			</div>
			<div class="prq_sh_title" id="prq_search_result_title">검색 결과</div>
			<div id="prq_search_content">
			
			</div>
			
			<div id="main_cont"></div>
			
		</div>
		
		<div id="genre_select_popup">
		</div>
		
		<!-- 공연 알람 설정 팝업 -->
		<!-- <div data-role="popup" id="get_teaminfo_popup">
			<div id="get_tip_content">
				
			</div>
		</div> -->
		
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>