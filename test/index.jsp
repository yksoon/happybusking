<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Firebase App (the core Firebase SDK) is always required and must be listed first -->
	  <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-app.js"></script>
	
	  <!-- Add Firebase products that you want to use -->
	  <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-auth.js"></script>
	  <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-firestore.js"></script>
	  <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-storage.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.7/cropper.min.css">
<style type="text/css">
	img{
		display: block;
		max-width: 100%;	
	}
	#read-loading, #uploading{
		display: none;
	}
	
	#result{
		width: 100vw;
		height: auto;
	}
</style>
<title>이미지 크롭</title>
</head>
<body>
	<div class="container">
		<input type="file" id="file" />
		<input type="file" id="file2" />
		<img id="image"/>
		<div id="read-loading">
			파일을 불러오는중입니다.<br>파일의 크기가 크면 오래 걸릴 수 있습니다. 기다려주세요.
		</div>
		<div id="uploading">
			파일을 저장중입니다.<br>잠시만 기다려주세요.
		</div>
		<img id="result"/>
		<button onclick="save();">save</button>
	</div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.7/cropper.min.js"></script>
	<script src="./index.js?ver=1.1.3"></script>
</body>
</html>