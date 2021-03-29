<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="perform_sc">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id = "perform_sc_sec" data-role="content" style="text-align:center; padding: 0;">
			<div id="perform_sc_content">			
				<!-- <div class="ps-contaner">
					<div class="ps-left">
						<div class="psl-img">
							<div class="psl-img-background">종료</div>
							<img src="/a.png" />
						</div>
						<div class="psl-text">
							<p class="psl-title">펀시티</p>
							<p class="psl-date">일시: 2020-06-20(토) 15:00</p>
							<p class="psl-place">장소: 경기 1층 문봉 조각실 카페</p>
							<p class="psl-genre">보컬,힙합,비보잉보컬,힙합,비보잉보컬,힙합,비보잉보컬,힙합,비보잉보컬,힙합,비보잉</p>
						</div>
					</div>
					<div class="ps-right">
						<img src="/img/common/show_btn.svg">
					</div>
				</div>	 -->
			</div>
			
			<!-- <div id="main_cont"></div> -->
			<div id="cal_mask"></div>
		</div>
		
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div> 