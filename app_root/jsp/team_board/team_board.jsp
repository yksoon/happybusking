<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="team_board">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<div data-role="content" style="padding-top: 20px;">
		  	<div id="team_board_body">
		  		
		  	</div>
		  	<div id="main_cont"></div>
		  	
		  	<!--  -->
		  	<!-- <div id="team_board_banner">
		  		<div class="ui-grid-a">
		  			<div class="ui-block-a" style="width: 100%;">
		  				<img id="board_refresh_btn" src="/img/board/refresh.svg" style="opacity:0.9;">			새로고침 버튼 
		  			</div>
		  			<div class="ui-block-b" style="width: 100%;" onclick="go_team_board_write();">
		  				<img src="/img/board/write.svg" style="opacity:0.9;">			글쓰기 버튼 
		  			</div>
		  		</div>
		  	</div>	 -->	  	
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>