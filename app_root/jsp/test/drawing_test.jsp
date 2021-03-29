
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
  <head>
<%@include file="/importhaed.jsp" %>
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
  <canvas id="signature-pad" class="signature-pad"></canvas>
</div>
<div>
  <button id="save-png">PNG로 저장 (test)</button>
  <%-- <button id="draw">Draw</button>
  <button id="erase">Erase</button> --%>
  <button id="clear">리셋 (test)</button>
  <button id="view" onclick="toView()">서명확인 (test)</button>
</div>
  </body>
</html>
<script src="https://cdn.jsdelivr.net/npm/signature_pad@2.3.2/dist/signature_pad.min.js"></script>
<script>
function toView() {
	var url = '/app_root/jsp/test/drawing_test_view.jsp';
	location.href = url;

	$.mobile.loading('show', {
        text: '로딩중...',
        textVisible: false,
        theme: 'z',
        html: ""
    });
}
var canvas = document.getElementById('signature-pad');

// Adjust canvas coordinate space taking into account pixel ratio,
// to make it look crisp on mobile devices.
// This also causes canvas to be cleared.
function resizeCanvas() {
    // When zoomed out to less than 100%, for some very strange reason,
    // some browsers report devicePixelRatio as less than 1
    // and only part of the canvas is cleared then.
    var ratio =  Math.max(window.devicePixelRatio || 1, 1);
    canvas.width = canvas.offsetWidth * ratio;
    canvas.height = canvas.offsetHeight * ratio;
    canvas.getContext("2d").scale(ratio, ratio);
}

window.onresize = resizeCanvas;
resizeCanvas();

var signaturePad = new SignaturePad(canvas, {
  backgroundColor: 'rgb(255, 255, 255)' // necessary for saving image as JPEG; can be removed is only saving as PNG or SVG
});

document.getElementById('save-png').addEventListener('click', function () {
  if (signaturePad.isEmpty()) {
    return alert("Please provide a signature first.");
  }
  
  var data = signaturePad.toDataURL('image/png');
  var image = data;
  console.log(data);
  //window.open(data);
				$.ajax({
					type: "POST",//url: "JSON/test.json",
					cache: false,
					url: '/service/test_sign/sign_test.jsp',
					//data : data,
					data : {
						image: image,
					},
					dataType: "xml",
					async: false,
					timeout: 30000,
					beforeSend: function(){
						$.mobile.loading( 'show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
					},
					success: function (data) {
						var ROOT = $(data).find("ROOT");
						var DATA = $(ROOT).find('DATA');
						if(DATA.length == 0){
              $.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
							return;
            }
            alert('저장 되었습니다.');
            signaturePad.clear();
					}, // end success
					error: function (xhr, message, errorThrown) {
						alert('잠시후 다시 시도해주세요.');
						return;
						//hideLoading();
					}, // end error
					complete: function(){
						$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
					}
				});
});

// document.getElementById('save-jpeg').addEventListener('click', function () {
//   if (signaturePad.isEmpty()) {
//     return alert("Please provide a signature first.");
//   }

//   var data = signaturePad.toDataURL('image/jpeg');
//   console.log(data);
//   window.open(data);
// });

// document.getElementById('save-svg').addEventListener('click', function () {
//   if (signaturePad.isEmpty()) {
//     return alert("Please provide a signature first.");
//   }

//   var data = signaturePad.toDataURL('image/svg+xml');
//   console.log(data);
//   console.log(atob(data.split(',')[1]));
//   window.open(data);
// });

document.getElementById('clear').addEventListener('click', function () {
  signaturePad.clear();
});

// document.getElementById('draw').addEventListener('click', function () {
//   var ctx = canvas.getContext('2d');
//   console.log(ctx.globalCompositeOperation);
//   ctx.globalCompositeOperation = 'source-over'; // default value
// });

// document.getElementById('erase').addEventListener('click', function () {
//   var ctx = canvas.getContext('2d');
//   ctx.globalCompositeOperation = 'destination-out';
// });

// document.getElementById('view').addEventListener('click', function () {
//     loadPage('test/drawing_test_view.jsp');
// });
</script>