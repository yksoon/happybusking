<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@include file="/importhaed.jsp" %>
<div data-role="page" id="rating_list" style="height: 100%;">
<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id = "rating_list_sec" data-role="content" style="text-align:center; padding: 0; height: auto !important;">
			<!-- <div class="scroll-wapper" style="overflow-y: auto; height: 100%; "> -->
	  		<div id="rating_list_bottom">
	  			
	  		</div>
	  	<!-- </div> -->
	  	<input type="hidden" id="user_no" value="<%=USER_NO %>">
  	</div>
  	
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>