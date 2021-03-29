<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@include file="/importhaed.jsp" %>
<div data-role="page" id="thanks_people" style="height: 100%;">
<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id = "thanks_people_sec" data-role="content" style="text-align:center; padding: 0; height: auto !important;">
			<input type="hidden" id="user_no" value="<%=USER_NO %>">
		  	<div id="thanks_people_body">
		  		
		  	</div>
		  	
	  	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>