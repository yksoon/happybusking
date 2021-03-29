<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/recruit/importhead.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
</head>
<body>
<nav>
	<div class="loading-popup" id="loading" style="display: block;">
		<div class="loading-background">
			<img src="/img/common/loading.gif">
			<p id="loading-msg">등록중입니다.</p>
		</div>
	</div>
</nav>
<script>
	var naver_id_login = new naver_id_login("k7GiszePSAXHkYGKSYh3", "https://www.happybusking.com/recruit/page/view/navercheckterms.jsp");
	// 접근 토큰 값 출력
	var token = naver_id_login.oauthParams.access_token;
	
	if(token === undefined || token === 'undefined'){ 
		alert('다시 시도해주세요.');
		var url = 'https://www.happybusking.com/recruit/page/view/login.jsp';
		location.href = url;
	}
	
	// 네이버 사용자 프로필 조회
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	function naverSignInCallback() {
	  sessionStorage.setItem('nEmail',naver_id_login.getProfileData('email'));
	  sessionStorage.setItem('nName',naver_id_login.getProfileData('nickname'));
	  naverlogin();
	}
	
	function naverlogin() {
		$.ajax({
			type: "GET",//url: "JSON/test.json",
			url: '/service/login/naverLogin.jsp',
			data : {
				user_id : sessionStorage.getItem("nEmail"),
				login_chk : 'N'
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success: function (data) {
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				//alert("1234");
				if(DATA.length == 0){
					//alert("1");
					var url = 'https://www.happybusking.com/recruit/';
					location.href = url;
				}
				
				$(DATA).each(function() {
					var LOGINCHK = $(this).find('LOGINCHK').text();
					var STATUS = $(this).find('STATUS').text();
					var CNT = $(this).find('CNT').text();
					
					//alert(LOGINCHK); //0
					//alert(STATUS);  //n
					//alert(CNT);  //0
					
					if(LOGINCHK == '1'){
						var url = 'https://www.happybusking.com/recruit/';
						location.href = url;
					}
					else{
						//alert("4");
						//alert('다시 로그인 해주세요. 만약 해당 현상이 반복된다면 happybuskinginsta 로 문의해주십시오.');
						//$('#user_pass').val('');
						//$('#user_pass').focus();
						location.href = "https://www.happybusking.com/recruit/page/view/navercheckterms.jsp";
						//alert('gocheckterms 회원가입 약관 페이지로 이동);
					}
				});
			},
			error: function (xhr, message, errorThrown) {
				//alert("0");
			} // end error 
		});
	
	};
</script>
</body>
</html>