<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="artist_ranking">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id="artist_ranking_content" data-role="content" style="text-align:center;">
			<input type="hidden" id="user_no" value="<%=USER_NO %>">
			<div id="a_ranking_content">
				
			</div>
		</div>
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>