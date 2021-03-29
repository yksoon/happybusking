<!DOCTYPE html>    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/importhaed.jsp" %>
<div data-role="page" id="artist_perform_requestList">	

	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div data-role="content" style="text-align:center; padding: 0;">
			<div class="ui-grid-a prqListTitleCss">
				<div  class="ui-block-a">
					<p>전체</p>
				</div>
				<div class="ui-block-b">
					<span>최신순</span>
				</div>
			</div>
			<div id="aPRqList_part">

			</div>			
		</div>
		
	<%@include file="/app_root/jsp/footer/footer.jsp" %>

</div>