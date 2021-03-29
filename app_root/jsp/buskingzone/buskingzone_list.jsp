<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="share_busking_list">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
	<div id = "share_busking_list_sec" data-role="content" style="text-align:center; padding: 0; height: 100% !important;">
		<div id="sbl_content_list">
		</div>		
		<!-- <div id="main_cont"></div> -->
	</div>
    <div class="sbl_btn_div">
		<div class="sbl_refresh_btn"><img src="/img/board/refresh.svg" style="opacity: 0.7;"></div>
		<div class="sbl_plus_btn" onclick="goBuskingzoneReg();"><img src="/img/board/write.svg" style="opacity: 0.7;"></div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>
