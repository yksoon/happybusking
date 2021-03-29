<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/importhaed.jsp" %>
<div data-role="page" id="kakao_map_test">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->	
		<div data-role="content">
			<a href="tel:02-780-2330">02-780-2330</a>
			<br><br>
			<a href="tel:010-9876-9481">010-9876-9481</a>
		</div>
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>