<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/js/jquery/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/js/admin/withdraw_popup.js" ></script>
<link type="text/css" rel="stylesheet" href="/css/admin/withdraw_popup.css" />

<title>후원금 지급 팝업</title>
</head>
<body>
	<input type="hidden" id="wdno_tno" name="wdno_tno">
	<input type="hidden" id="wdPrice">
	
	<select id="wdOK">
		<option value="1">진행중</option>
		<option value="2">지급완료</option>
		<option value="3">지급거절</option>
	</select>
	<br>
	<textarea rows="" cols="" id="wdRefuseReason" placeholder="거절사유(거절시에만 입력)"></textarea>
	<br>
	<p id="wdBtn">완료</p>
</html>