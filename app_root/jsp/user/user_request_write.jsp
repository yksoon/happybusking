<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="user_request_write">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
	<div id="user_request_write_cont_sec" data-role="content" style="text-align:center; padding: 0px 15px;">
		<div class="urw_title">문의 구분</div>
		<select id="urw_type">
			<option value="건의/개선사항">건의/개선사항</option>
			<option value="오류신고">오류신고</option>
			<option value="사업제휴">사업제휴</option>
			<option value="Q&A">Q&#38;A</option>
		</select>
		
		<div class="non_member_div">
			<div class="urw_title">문의 ID</div>
			<input type="text" id="urw_id"></input>
			
			<div class="urw_title">문의 비밀번호</div>
			<input type="text" id="urw_pw"></input>
		</div>
		
		<div class="urw_title">문의 제목</div>
		<textarea rows="2" cols="" id="urw_title_area"></textarea>
		
		<div class="urw_title">문의 내용</div>
		<textarea rows="7" cols="" id="urw_content_area"></textarea>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>