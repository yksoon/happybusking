function goNaverLoginPage(){
	location.href = "https://www.happybusking.com/app_root/jsp/login/naverlogin.jsp";
}

//****************************************************************************************************************** naverlogin.jsp javascript 코드
var naverLogin = new naver.LoginWithNaverId(
				{
					clientId: "k7GiszePSAXHkYGKSYh3",
					callbackUrl: "https://www.happybusking.com/app_root/jsp/login/naverloginloading.jsp",
					isPopup: false, /* 팝업을 통한 연동처리 여부 */
					loginButton: {color: "green", type: 3, height: 40} /* 로그인 버튼의 타입을 지정 */
				}
);
//****************************************************************************************************************** naverloginloading.jsp javascript 코드
var naverLogin = new naver.LoginWithNaverId(
	{
		clientId: "{k7GiszePSAXHkYGKSYh3}",
		callbackUrl: "{https://www.happybusking.com/app_root/naverloginloading.jsp}",
		isPopup: false,
		callbackHandle: true
/* callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정합니다. */
	}
);
	/* (3) 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */
naverLogin.init();
	/* (4) Callback의 처리. 정상적으로 Callback 처리가 완료될 경우 main page로 redirect(또는 Popup close) */
window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			/* (5) 필수적으로 받아야하는 프로필 정보가 있다면 callback처리 시점에 체크 */
			var email = naverLogin.user.getEmail();
			var nickname = naverLogin.user.getNickName();
			var name = naverLogin.user.getName();
			var uniqId = naverLogin.user.getId();
			sessionStorage.setItem("nId", uniqId);
			sessionStorage.setItem("nName", name);
			sessionStorage.setItem("nNickname", nickname);
			sessionStorage.setItem("nEmail", email);
			//alert(sessionStorage.getItem("nEmail"));
			//alert(sessionStorage.getItem("nNickname"));
			//alert(sessionStorage.getItem("nName"));
			//alert(sessionStorage.getItem("nId"));
			//alert(email);
			//alert(name);
			//alert(nickname);
			//naverlogin();
			if( email == undefined || email == null) {
				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
				/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */             
				naverLogin.reprompt();
				return;
			}
			naverlogin();
			//naverlogin();
				//window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/sample/main.html");
			console.log("email: " + email);
			console.log("name: " + name);
			//window.location.replace("https://www.happybusking.com/app_root/index.jsp");
			//alert(sessionStorage.getItem("nEmail"));
			//alert(sessionStorage.getItem("nName"));
			//alert(email);
			//alert(name);
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
});

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
				var url = '/app_root/index.jsp?nlc=F';
				$.mobile.changePage(url, {transition : "none"});
			}
			
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			$(DATA).each(function() {
				var LOGINCHK = $(this).find('LOGINCHK').text();
				var STATUS = $(this).find('STATUS').text();
				var CNT = $(this).find('CNT').text();
				
				//alert(LOGINCHK); //0
				//alert(STATUS);  //n
				//alert(CNT);  //0
				
				if(LOGINCHK == '1'){
					//alert("2");
					if(STATUS == 'L'){
						getAimg();
						var url = '/app_root/index.jsp?nlc=L&cnt='+CNT;
						$.mobile.changePage(url, {transition : "none"});
					}else if(STATUS == 'J'){
						getAimg();
						var url = '/app_root/index.jsp?nlc=J&cnt='+CNT;
						$.mobile.changePage(url, {transition : "none"});								
					}
					//alert("3");
					//toHome();
				}
				else{
					toHome();
					//alert("4");
					//alert('다시 로그인 해주세요. 만약 해당 현상이 반복된다면 happybuskinginsta 로 문의해주십시오.');
					//$('#user_pass').val('');
					//$('#user_pass').focus();
					//location.href = "https://www.happybusking.com/app_root/jsp/login/navercheckterms.jsp";
					//alert('gocheckterms 회원가입 약관 페이지로 이동);
				}
			});
		},
		error: function (xhr, message, errorThrown) {
			//alert("0");
		} // end error 
	});

};
//******************************************************************************************************************  javascript 코드

$(document).on('change', '#n_total_checkbox', function(){
	if($(this).prop('checked')){
		$('#n_useAgree_checkbox').prop('checked', true);
		$('#n_info_checkbox').prop('checked', true);
		$('#n_useGPS_checkbox').prop('checked', true);
	} else {
		$('#n_useAgree_checkbox').prop('checked', false);
		$('#n_info_checkbox').prop('checked', false);
		$('#n_useGPS_checkbox').prop('checked', false);
	}
});


//회원가입 버튼 클릭시
$(document).on('click', '#n_joinUpdateBtn', function() {
	
	if(!$('#n_useAgree_checkbox').prop('checked')){
		infoTxtBox('이용 약관에 동의해주세요.');
		return;
	}
	
	if(!$('#n_info_checkbox').prop('checked')){
		infoTxtBox('개인정보처리 약관에 동의해주세요.');
		return;
	}
	
	if(!$('#n_useGPS_checkbox').prop('checked')){
		infoTxtBox('위치기반 서비스 이용약관에 동의해주세요.');
		return;
	}
	//데이터 db 최종 업로드
	$.ajax({
		type: "POST",
		url: '/service/join/join.jsp',
		data:{
			user_active: 'Y',
			artist_check: 'N',
			busking_oath: 'N',
			user_id: sessionStorage.getItem("nEmail"),
			nickname: sessionStorage.getItem("nName"),
			login_chk: 'N'
		},
		success: function (data) {
			goJoinComplete(sessionStorage.getItem("nEmail"));
		},
		error: function(a, b, c) {
			toHome();
		}
	});
});