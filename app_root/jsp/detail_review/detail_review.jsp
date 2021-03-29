<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="detail_review">
	<!-- header 부분 -->
<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
	<div id="detail_review_sec" data-role="content">
		<div id="main_epil">
			<div id="dr_img"></div>
			<div class="ui-grid-a" id="dr_title">
				<div class="ui-block-a" id="dr_title_name"></div>
				<div class="ui-block-b" id="dr_title_date"></div>
			</div>
			<div class="ui-grid-a" id="dr_rate">
				<div class="ui-block-a" id="stargi1">
					<select class="dr_rating" id="dr_rating" name="dr_rating" autocomplete="off">
						<option value="1">1</option>
						  <option value="2">2</option>
						  <option value="3">3</option>
						  <option value="4">4</option>
						  <option value="5">5</option>
					</select>
				</div>
				<div class="ui-block-b" id="dr_rate_text"></div>
			</div>
			<div id="dr_content">
				<div id="dr_content_title"></div>
				<div id="dr_content_subject"></div>
			</div>
		</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>


