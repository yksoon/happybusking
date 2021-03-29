<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="/importhaed.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<div data-role="page" id="user_performance_record">
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<div data-role="content">
	<input type="hidden" id="record_user_no" value="<%=USER_NO%>">
	<div class="user_record_middle">
		<div class="ui-grid-a" style="height: 45px; border-bottom: 1px solid #eeeeee;">
			<div  class="ui-block-a" style="width: 50%; text-align: left; padding: 5% 0 0 15px; font-size: 15px; font-weight: bold;">
				<p>전체</p>
			</div>
			<div class="ui-block-b" style="width: 50%; text-align: right; font-size: 12px; padding: 5% 15px 0 0; margin-top: 1%;">
				<span id="sortname" onclick="#" style="text-decoration:underline; color:#707070;">최신순</span>
			</div>
		</div>
	</div>
	<div id="user_record_content">
	</div>
	<div id="main_cont"></div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>