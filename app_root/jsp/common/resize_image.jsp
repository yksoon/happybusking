<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav id="resize-image-container">
	<img id="ric-img" />
	
	<div class="ric-btn-container">
		<div class="ric-btn" id="ric-cancel">취소</div>
		<div class="ric-btn" id="ric-save">편집 완료</div>	
	</div>	
	<nav id="loading-container">
		<div class="loading-box">
			<img src="/img/common/loading.gif" />
			<p id="loading-message">
				
			</p>
		</div>
	</nav>
</nav>


