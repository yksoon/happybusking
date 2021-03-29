<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

        
<%@include file="/importhaed.jsp" %>
<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>



<div data-role="page" id="facebooklogin">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
	<div data-role="content">
	<button onClick="refresh()">refresh</button>
	<div id="fb-root"></div>
	<div class="fb-login-button" data-width="" data-size="large" data-button-type="continue_with" data-auto-logout-link="false" data-use-continue-as="false"></div>
	
	<div id="status">
	</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div> --%>