<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="tipbox_list_page">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id="tipbox_list_sec" data-role="content">
			<div id="tbl_body">
				
			</div>
			<div id="main_cont"></div>
		</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>