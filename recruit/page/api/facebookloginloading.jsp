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
	$(document).ready(function(){
		facebooklogin();
	});
	function facebooklogin() {
		$.ajax({
			type: "GET",//url: "JSON/test.json",
			url: '/service/login/naverLogin.jsp',
			data : {
				user_id : sessionStorage.getItem("fEmail"),
				login_chk : 'F'
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
						location.href = "https://www.happybusking.com/recruit/page/view/facebookcheckterms.jsp";
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