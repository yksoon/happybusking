<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/importhaed.jsp" %>
<div data-role="page" id="audience_cheers" style="height: 100%;">
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- <div id="cheers_color"></div> -->
		<div id="audience_cheers_content" data-role="content" style="margin: 0;">
			<div class="ch_img" id="ch_img_1"></div>
			<div class="ch_img" id="ch_img_2"></div>
			<div class="ch_img" id="ch_img_3"></div>
			<div class="ch_img" id="ch_img_4"></div>
			<div class="ch_img" id="ch_img_5"></div>
			<div class="ch_img" id="ch_img_6"></div>
			<div class="ch_img" id="ch_img_7"></div>
			<div class="ch_img" id="ch_img_8"></div>
			<div class="ch_img" id="ch_img_9"></div>
			<div class="ch_img" id="ch_img_10"></div>
			<div class="ch_img" id="ch_img_11"></div>
			<div class="ch_img" id="ch_img_12"></div>
			
			
			<!-- 속도조절 슬라이드바 -->
			<!-- <div id="ac_slider_bar"></div> -->
			<input id="change_speed_bar" type="range" value="3" min="1" max="5">
		</div>
</div>
