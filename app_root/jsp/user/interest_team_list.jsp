<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="interest_team_list">	

	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id = "interest_team_list_sec" data-role="content" style="text-align:center; padding: 0;">
		<input type="hidden" id="user_no" value="<%=USER_NO %>">
			<div class="ui-grid-a" style="height: 45px; border-bottom: 1px solid #dfdfdf;">
				<div  class="ui-block-a" style="width: 50%; text-align: left; padding: 5% 0 0 15px; font-size: 15px; font-weight: bold;">
					<p>전체</p>
				</div>
				<div class="ui-block-b"	style="width: 50%; text-align: right; font-size: 12px; padding: 5% 15px 0 0; margin-top: 1%;">
					<span>등록일순</span>
				</div>
			</div>
			<div id="under_line"></div>
			<div id="int_team_list_body">
				
			</div>
		</div>
		
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>