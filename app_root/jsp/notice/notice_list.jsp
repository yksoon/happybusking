<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/importhaed.jsp" %>

<div data-role="page" id="notice_list">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id="notice_list_content" data-role="content" style="text-align:center;">
			<div id="notice_list_contianer">
				
			</div>
			<div id="main_cont"></div>
		</div>
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>