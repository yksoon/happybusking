<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<%@include file="/importhead2.jsp" %>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Signature</title>
    <style>
     .wrapper {
  position: relative;
  width: 100%;
  height: 200px;
  -moz-user-select: none;
  -webkit-user-select: none;
  -ms-user-select: none;
  user-select: none;
}
.signature-pad {
  position: absolute;
  left: 0;
  top: 0;
  width:100%;
  height:200px;
  background-color: white;
  border: 1px solid black;
}
    </style>
</head>
<body>
    <div class="wrapper">
        <img id="sign_img" class="signature-pad" src="">
    </div>
	<div>
		<button id="get_sign">서명 가져오기</button>
		<button id="back" onclick="toBack()">뒤로</button>
	<div>
</body>

<script>
function toBack() {
	var url = '/app_root/jsp/test/drawing_test.jsp';
	location.href = url;

	$.mobile.loading('show', {
        text: '로딩중...',
        textVisible: false,
        theme: 'z',
        html: ""
    });
}
var image = "";
document.getElementById('get_sign').addEventListener('click', function () {
	$.ajax({
					type: "POST",//url: "JSON/test.json",
					cache: false,
					url: '/service/test_sign/sign_test_get.jsp',
					//data : data,
					data : {
						image: image,
                    },
                    contentType: "application/xml; charset=utf-8",
					dataType: "xml",
					timeout: 30000,
					success: function (data) {
						var ROOT = $(data).find("ROOT");
						var DATA = $(ROOT).find('DATA');
						if(DATA.length == 0){
                            $.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                            image = data;
							$("#sign_img").attr("src", image);
							console.log(image);
							return;
						}
						var image_src = $(DATA[0]).find('IMAGE').text();
						console.log(image_src);
						$("#sign_img").attr("src", image_src);
						
					}, // end success
					error: function (xhr, message, errorThrown) {
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						return;
						//hideLoading();
					}, // end error
					complete: function(){
						$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
                    }
                });
});
//$(document).ready(function() {
// 	$.ajax({
// 					type: "POST",//url: "JSON/test.json",
// 					cache: false,
// 					url: '/service/test_sign/sign_test_get.jsp',
// 					//data : data,
// 					data : {
// 						image: image,
//                     },
//                     contentType: "application/xml; charset=utf-8",
// 					dataType: "xml",
// 					timeout: 30000,
// 					success: function (data) {
// 						var ROOT = $(data).find("ROOT");
// 						var DATA = $(ROOT).find('DATA');
// 						if(DATA.length == 0){
//                             $.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
//                             image = data;
// 							$("#sign_img").attr("src", image);
// 							console.log(image);
// 							return;
// 						}
// 						var image_src = $(DATA[0]).find('IMAGE').text();
// 						console.log(image_src);
// 						$("#sign_img").attr("src", image_src);
						
// 					}, // end success
// 					error: function (xhr, message, errorThrown) {
// 						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
// 						return;
// 						//hideLoading();
// 					}, // end error
// 					complete: function(){
// 						$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
//                     }
//                 });
//});
/*
$(document).on('pageinit', '#sign_view', function(){
				$.ajax({
					type: "POST",//url: "JSON/test.json",
					cache: false,
					url: '/service/test_sign/sign_test_get.jsp',
					//data : data,
					data : {
						image: image,
                    },
                    contentType: "application/xml; charset=utf-8",
					dataType: "xml",
					timeout: 30000,
					success: function (data) {
						var ROOT = $(data).find("ROOT");
						var DATA = $(ROOT).find('DATA');
						if(DATA.length == 0){
                            $.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                            image = data;
							$("#sign_img").attr("src", image);
							console.log(image);
							return;
						}
						console.log(DATA);
					}, // end success
					error: function (xhr, message, errorThrown) {
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						return;
						//hideLoading();
					}, // end error
					complete: function(){
						$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
                    }
                });
*/
// document.getElementById('back').addEventListener('click', function () {
//     loadPage('/test/drawing_test.jsp');
// });
</script>