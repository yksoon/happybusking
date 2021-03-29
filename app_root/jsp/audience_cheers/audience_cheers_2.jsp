<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/importhaed.jsp" %>
<div data-role="page" id="audience_cheers" style="height: 100%; background-color: #fff;">
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<div class="ui-panel-wrapper">
		<div id="cheers_btn_1" style="width: 50%; line-height: 3; text-align: center; margin-top: 210px; margin-left: 25%;  background-image: linear-gradient(to left, #464448 0%, #756f75 100%); color:#fff; border-radius:3em; box-shadow: 0px 3px 8px 0px rgba(0,0,0,0.3); font-weight:bold;">수동조작모드</div>
		<div id="cheers_btn_2" style="width: 50%; line-height: 3; text-align: center; margin-top: 30px; margin-left: 25%; background-image: linear-gradient(to left, #8354c8 0%, #c750bf 100%); color:#fff; border-radius:3em;border-radius:3em; box-shadow: 0px 3px 8px 0px rgba(0,0,0,0.3); font-weight:bold;">불꽃축제전자악보</div>
	</div>
</div>
