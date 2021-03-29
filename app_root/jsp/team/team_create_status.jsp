<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="team_create_status">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
	<div id = "team_create_status_sec" data-role="content" style="text-align:center; padding: 0;">
		<input type="hidden" id="user_no" value="<%= USER_NO %>">
		<div id="tc_create_status_container">
			<div class="ui-grid-a team_cs_header">
				<div class="ui-block-a team_cs_name">
				</div>
				<div class="ui-block-b team_cs_go_history">
					신청내역	
				</div>
			</div>
			<div class="team_cs_body">
				
			</div>
		</div>
		
	</div>
	
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>