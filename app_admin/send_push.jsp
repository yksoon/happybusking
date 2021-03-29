<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="/css/admin/notice.css" />
<link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<script type="text/javascript" src="/js/admin/index.js" ></script>
<script type="text/javascript" src="/js/admin/notice.js" ></script>

<link rel="stylesheet" href="/js/dist/summernote.css">
<script type="text/javascript" src="/js/dist/summernote.js"></script>


<title>공지사항 작성 팝업</title>
</head>
<body style="text-align: center;">
	<div class="npc_p_title">푸시 대상</div>
	<select class="npc_p_type" id="ptype">
		<option value="N">전체</option>
		<option value="A">아티스트</option>
		<option value="T">팀</option>
	</select>
	
	<div class="npc_p_title">푸시 제목</div>
	<input type="text" id="ptitle">
	
	<div class="npc_p_title">푸시 내용</div>
	<textarea id="pcontent"></textarea>
	
	<div class="npc_p_btn" id="psendbtn">푸시 보내기</div>
</body>
</html>