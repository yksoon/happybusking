<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="user_request_list">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
	<div id="user_request_list_sec" data-role="content" style="text-align:center; padding: 0;">
		<div id="main_cont" style="display: none;"></div>
		<div id="url_list_container">
			
		</div>
	</div>
	<div class="url_write_btn" onclick="goUserRequestWrite();"><img src="/img/board/write.svg"></div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>