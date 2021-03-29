<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/importhaed.jsp" %>
<div data-role="page" id="cheers1" style="height: 100%; background-color: black;">
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<canvas id="c"></canvas>
		<div id="cheers_color_1" style="width: 100%; height: 800px; z-index: 2000; position: fixed; top:0;"></div>
</div>
