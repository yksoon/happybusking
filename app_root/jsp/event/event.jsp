<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="event_page">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->		
	<div id="event_sec" data-role="content">
		<img src="/img/event/contest.jpg">
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>
