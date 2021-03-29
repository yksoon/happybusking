<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>버스킹 모집 공고 등록 페이지</title>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- lib -->
<!-- daum 주소검색 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 카카오지도 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5caef794e0c0d34ae5082d15d8cbdcc9&libraries=services"></script>

<!-- Firebase App (the core Firebase SDK) is always required and must be listed first -->
	  <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-app.js"></script>
	
	  <!-- Add Firebase products that you want to use -->
	  <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-auth.js"></script>
	  <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-firestore.js"></script>
	  <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-storage.js"></script>

<!-- css -->
<link type="text/css" rel="stylesheet" href="/pbireg/resource/css/common.css?ver=1.0.1" />

<!-- javascript -->
<!-- function -->
<script type="text/javascript" src="/pbireg/resource/js/function/common_func.js?ver=1.0.5" ></script>
<!-- active -->
<script type="text/javascript" src="/pbireg/resource/js/active/common.js?ver=1.0.3" ></script>
</head>