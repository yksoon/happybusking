<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<meta charset="UTF-8">

<div data-role="page" id="app_info">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div data-role="content" style="text-align:center; padding: 0;">
			<p class="appInfoTitle">해피버스킹 앱 정보</p>	
			<div class="ui-grid-a appInfoGrid" onclick="go_app_introduce();">
				<div class="ui-block-a appInfoBlockA">
					<p>소개</p>
				</div>
				<div class="ui-block-b appInfoBlockB">
					<p><img src="/img/common/show_btn.svg"></p>
				</div>
			</div>
			<div  class="ui-grid-a appInfoGrid" onclick="go_app_useTerms();">
				<div class="ui-block-a appInfoBlockA">
					<p>이용약관</p>
				</div>
				<div class="ui-block-b appInfoBlockB">
					<p><img src="/img/common/show_btn.svg"></p>
				</div>
			</div>
			<div class="ui-grid-a appInfoGrid" onclick="go_app_useInfoTerms();">
				<div class="ui-block-a appInfoBlockA">
					<p>개인정보취급방침</p>
				</div>
				<div class="ui-block-b appInfoBlockB">
					<p><img src="/img/common/show_btn.svg"></p>
				</div>
			</div>
		</div>
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>


