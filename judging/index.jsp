<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	@import url(https://cdn.jsdelivr.net/gh/theeluwin/NotoSansKR-Hestia@master/stylesheets/NotoSansKR-Hestia.css);
	*{
		font-family: 'Noto Sans Korean', sans-serif;
		padding: 0;
		margin: 0;
		letter-spacing: -0.8px;
	}
	.index-wrapper{
		width: 100vw;
		height: 100vh;
		position: relative;
	} 
	.name-container {
	    display: flex;
	    transform: translate(-50%, -50%);
	    left: 50%;
	    top: 50%;
	    position: absolute;
	}
	.name-container > p{
		margin-right: 3%;
	}
	
	input {
	    margin-left: 10px;
	    padding: 15px;
	    width: 350px;
	    border: none;
	    border-bottom: 1px solid #898989;
	}
	
	button {
		margin-left: 10px;
		width: 100px; 
	}
	
	.popup{
		width: 100vw;
	    height: 100vh;
	    position: fixed;
	    top: 0;
	    left: 0;
	    background-color: rgba(0, 0, 0, 0.5);
	    display: none;
	}
	
	#loading-popup #loading{
		width: 10%;
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    border-radius: 15px;
	}
</style>
<title>해피버스킹 - 서울메트로 심사</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body onload="onLoad();">
	<nav class="index-wrapper">
		<nav class="popup" id="loading-popup">
			<img id="loading" src="/judging/resource/img/loading.gif" />
		</nav>
		<div class="name-container">
			<table>
				<tr>
					<td rowspan="3">심사자 계정</td>
					<td><input type="text" id="email" placeholder="이메일을 입력해주세요."></td>
					<td rowspan="3">
						<button id="prev-login-btn">인증번호 받기</button>
						<button id="login-btn" style="display: none;">로그인</button>
					</td>
				</tr>
				<tr>
					<td>
						<input type="password" id="pw" placeholder="비밀번호를 입력해주세요.">
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" id="num" style="display: none;" placeholder="인증번호를 입력해주세요.">
					</td>
				</tr>
			</table>
		</div>
	</nav>
</body>
<script type="text/javascript">
	function onLoad(){
		sessionStorage.removeItem('name');	
	}
	
	$(document).on('click', '#prev-login-btn', function(){
		const email = $('#email').val();
		const pw = $('#pw').val();
		
		let chk = false;
		
		if(email === null || email === '') {
			alert('심사자 이메일 입력해주세요.');
			$('#email').focus();
			return;
		} else if(pw === null || pw === '') {
			alert('심사자 비밀번호를 입력해주세요.');
			$('#pw').focus();
			return;
		}
		$('#loading-popup').show();
		
		$.ajax({
	        type: "GET",
	        async: false,
	        cache: false,
	        url: '/judging/resource/service/login.jsp',
	       	data: {
	       		email: email,
	       		pw: pw,
	       	},
	        contentType: "application/xml; charset=utf-8",
	        dataType: "xml",
	        timeout: 30000,
	        success: function(data) {
	        	var ROOT = $(data).find('ROOT');
	        	var DATA = $(ROOT).find('DATA');
	        	
	        	$(DATA).each(function(i){
	        		var CNT = $(this).find('CNT').text();
	        		
	        		if(parseInt(CNT) > 0) chk = true;
	        	});
	        }
		});
		
		if(!chk){
			alert('이메일 또는 비밀번호가 다릅니다.\n다시 한번 확인해주세요.');
			return;
		} else {
			const res = pushEmail(email);
			
			if(!res){
				alert('인증 메일 발송에 실패했습니다. 다시 시도해주세요.');
				$('#loading-popup').hide();
				return;
			} else {
				alert('인증 메일이 발송되었습니다. 입력 후 로그인해주세요.');
				$('#loading-popup').hide();
				$('#num').show();
				$('#num').val('');
				$('#num').focus();
				$('#login-btn').show();
				return;
			}
		}
	});
	
	$(document).on('click', '#login-btn', function(){
		const email = $('#email').val();
		const pw = $('#pw').val();
		const num = $('#num').val();
		let chk = false;
		
		if(email === null || email === '') {
			alert('심사자 이메일 입력해주세요.');
			$('#email').focus();
			return;
		} else if(pw === null || pw === '') {
			alert('심사자 비밀번호를 입력해주세요.');
			$('#pw').focus();
			return;
		} else if(num === null || num === '') {
			alert('인증번호를 입력해주세요.');
			$('#num').focus();
			return;
		}
		
		$.ajax({
	        type: "GET",
	        async: false,
	        cache: false,
	        url: '/judging/resource/service/login.jsp',
	       	data: {
	       		email: email,
	       		pw: pw,
	       	},
	        contentType: "application/xml; charset=utf-8",
	        dataType: "xml",
	        timeout: 30000,
	        success: function(data) {
	        	var ROOT = $(data).find('ROOT');
	        	var DATA = $(ROOT).find('DATA');
	        	
	        	$(DATA).each(function(i){
	        		var CNT = $(this).find('CNT').text();
	        		
	        		if(parseInt(CNT) > 0) chk = true;
	        	});
	        }
		});
		
		if(!chk){
			alert('이메일 또는 비밀번호가 다릅니다.\n다시 한번 확인해주세요.');
			return;
		} else {
			$.ajax({
		        type: "GET",
		        async: false,
		        cache: false,
		        url: '/judging/resource/service/email_chk.jsp',
		       	data: {
		       		email: email,
		       		num: num,
		       	},
		        contentType: "application/xml; charset=utf-8",
		        dataType: "xml",
		        timeout: 30000,
		        success: function(data) {
		        	var ROOT = $(data).find('ROOT');
		        	var DATA = $(ROOT).find('DATA');
		        	
		        	$(DATA).each(function(i){
		        		var CNT = $(this).find('CNT').text();
		        		var NAME = $(this).find('NAME').text();
		        		
		        		//alert(NAME);
		        		
		        		if(parseInt(CNT) > 0) {
		    				sessionStorage.setItem('name', NAME);
		    				location.href = 'pages/list';
		        		}
		        		else {
		    				alert('인증번호가 다릅니다.\n다시 한번 확인해주세요.');
		    				return;
		        		}
		        	});
		        },
		        error: function(err){
		        	alert('문제가 발생했습니다.\n해당 에러가 계속 되면 해피버스킹에 문의해주세요.');
		        	return;
		        }
			});
		}
	});
	
	function pushEmail(email){
		let res = false;
		$.ajax({
	        type: "GET",
	        async: false,
	        cache: false,
	        url: '/service/common/send_email.jsp',
	       	data: {
	       		email: email,
	       		keyState: 'J',
	       	},
	        contentType: "application/xml; charset=utf-8",
	        dataType: "xml",
	        timeout: 30000,
	        complete: function(data) {
	        	res = true;
	        },
	        error: function(err){
	        	res = false;
	        }
		});
		
		return res;
	}
	
	$(document).on('keyup', '#name, #pw, #num', function(e){
		if(e.keyCode === 13) $('#login-btn').click();
	});
</script>
</html>