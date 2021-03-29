<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>버스킹 공모!</title>
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
<link type="text/css" rel="stylesheet" href="/recruit/resource/css/common.css?ver=1.3.8" />
<link type="text/css" rel="stylesheet" media="screen and (min-width: 768px)" href="/recruit/resource/css/web/w-common.css?ver=1.0.5" />

<!-- javascript -->
<!-- function -->
<script type="text/javascript" src="/recruit/resource/js/common-func.js?ver=1.2.5" ></script>
<!-- active -->
<script type="text/javascript" src="/recruit/resource/js/move-page.js?ver=1.1.7" ></script>
<script type="text/javascript" src="/recruit/resource/js/common.js?ver=1.0.9" ></script>
</head>