<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="perform_request_refuse_msg">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div data-role="content" style="text-align:center; padding: 0; border-top:1px solid #eee;">
			<div id="prq_refuse_title">
				거절 사유
			</div>
			<div id="prq_refuse_body">
				<textarea rows="" cols="" id="prq_refuse_area"></textarea>
			</div>
		</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>