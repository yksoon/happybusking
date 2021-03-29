<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="perform_cancle_msg">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id = "perform_cancle_sec" data-role="content" style="text-align:center; padding: 0; border-top:1px solid #eee;">
			<div id="pf_cancle_title">
				관람자에게 전할 메세지
			</div>
			<div id="pf_cancle_body">
				<textarea rows="" cols="" id="pf_cancle_area"></textarea>
			</div>
		</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>