<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="schedule_list_page">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->		
	<div id="slp_content" data-role="content">
		<div class="slp_header">
			<p class="slph_deep">전체</p>
			<p>날짜순</p>
		</div>
		<div class="slp_body" id="slp_list">
			
		</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>
