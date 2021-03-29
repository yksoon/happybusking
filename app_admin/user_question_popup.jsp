<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="/css/admin/user_question_popup.css" />
<script type="text/javascript" src="/js/jquery/jquery-1.11.3.min.js" ></script>
<script type="text/javascript" src="/js/admin/index.js" ></script>
<script type="text/javascript" src="/js/admin/login.js" ></script>
<script type="text/javascript" src="/js/admin/user_question.js" ></script>
<script type="text/javascript" src="/js/admin/user_question_popup.js" ></script>

<title>문의사항 관리 팝업</title>
</head>
<body>
	<input type="hidden" id="uq_no" name="user_question">
	<input type="hidden" id="uq_type">
	<!-- <input type="hidden" id="uq_state">
	<input type="hidden" id="uq_parent"> -->
	<div class="uqpc_title"></div>
	<div class="uqpc_content"></div><br>
	<textarea rows="" cols="" id="question_reply" placeholder="insert here"></textarea>
	<br>
	<button id="uqpc_button">confirm</button>
</html>