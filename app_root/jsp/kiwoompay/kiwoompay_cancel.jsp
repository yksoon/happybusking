<%@page import="db.dbconn"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/importhaed.jsp" %>

<div data-role="page" id="kiwoompay_cancel">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id ="kiwoompay_cancel_sec" data-role="content">
			<p>결제 취소했습니다.</p>
		</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>