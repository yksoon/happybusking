<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="board_write_list">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id = "board_write_list_sec" data-role="content" style="text-align:center; padding: 0;">
		<input type="hidden" id="user_no" value="<%=USER_NO %>">
		  	<div id="bw_body">
		  		
		  	</div>
		  	<div id="main_cont"></div>
	</div>
	
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>