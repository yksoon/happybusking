<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="share_item_list">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
	<div id="share_item_list_sec" data-role="content" style="text-align:center; padding: 0;">
		<div class="ui-grid-a sil_content" id="sil_content">
			<!-- 리스트부분  -->
		</div>
		<div class="sil_btn_div">
			<div class="sil_refresh_btn"><img src="/img/board/refresh.svg"></div>
			<div class="sil_write_btn" onclick="goShareItemReg();"><img src="/img/board/write.svg"></div>
		</div>
	</div>
	
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>
