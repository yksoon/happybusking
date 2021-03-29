<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pbireg/importhead.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
*{
	font-size: 14px;
}
.indexWrapper {
	width: 780px;
	margin: 0 auto;
}

.loading-popup {
    position: fixed;
    top: 0;
    left: 0;
    z-index: 10;
    width: 100vw;
    height: 100vh;
    background-color: rgba(0, 0, 0, 0.5);
    display: none;
}

.loading-background {
    position: relative;
    width: 250px;
    height: 250px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    background-color: #f6f6f6;
    border-radius: 15px;
}

.loading-background img {
    margin-top: 95px;
}

.loading-background p {
    margin-top: 15px;
}

.item{
	padding: 20px;
	border-bottom: 1px solid #d9d9d9;
}

.title{
	font-size: 16px;
	font-weight: bold;
}

@media all and (max-width: 768px){
	.indexWrapper {
	    margin: 0 auto;
	    width: auto;
	}

}

</style>
<link id="jqm_css" type="text/css" rel="stylesheet" media="screen and (max-width:788px)" href="/css/jquery-mobile/jquery.mobile-1.4.5.min.css" />
<link type="text/css" rel="stylesheet" href="/css/heartpay/common/common.css?ver=1.0.0" />
<link type="text/css" rel="stylesheet" href="/css/heartpay/index/index.css?ver=1.0.0" />
<link type="text/css" rel="stylesheet" href="/css/heartpay/custom_select_box/genre_select.css?ver=1.0.0" />
<script type="text/javascript" src="/pbireg/resource/js/active/index.js?ver=1.0.9" ></script>
<script type="text/javascript" src="/pbireg/resource/js/active/list.js?ver=1.0.0" ></script>
<script type="text/javascript" src="/js/heartpay/custom_select_box/custom_select_box_func.js?ver=1.0.0" ></script>
<script type="text/javascript" src="/js/heartpay/custom_select_box/genre_select.js?ver=1.0.0" ></script>
</head>
<body>
	<nav class="header"></nav>
	<nav class="indexWrapper">
		<div id="list">
		</div>		
	</nav>
	<div class="loading-popup" id="loading">
		<div class="loading-background">
			<img src="/img/common/loading.gif">
			<p id="popup_text">로딩중입니다.</p>
		</div>
	</div>
</body>
</html>