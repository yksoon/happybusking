<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<%@include file="/importhead3.jsp" %>

<div data-role="page" id="test_artist_become">	
    <%-- resizing 화면 연결 --%>
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
    <%@include file="/app_root/jsp/common/resize_image.jsp" %>

    <div id = "test_artist_become_sec" data-role="content">	
		<div class="common_form_header_title">
			아티스트 정보 입력
		</div>
		
		<div class="common_form_main_title">
			프로필 이미지 등록
		</div>
		<div class="common_form_imagebox" id="test_artist_become_img">
			<img id="img_preview"/>
			<input type="hidden" id="img_name"/>
		</div>

		<input type="file" id="test_artist_img" accept="image/*">
		
		<button class="test_register_picture_btn">등록하기</button>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>