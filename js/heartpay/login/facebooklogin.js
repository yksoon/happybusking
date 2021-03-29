function goFacebookLoginPage(){
	/*loadPage('login/facebooklogin.jsp#loaded');*/
	location.href = "https://www.happybusking.com/app_root/jsp/login/facebooklogin.jsp";
}

function goCheckTermsPage(){
	/*loadPage('login/checkterms.jsp');*/
	location.href = "https://www.happybusking.com/app_root/jsp/login/checkterms.jsp";
}

function goLoginPage(){
	/*loadPage('login/login.jsp');*/
	location.href = "https://www.happybusking.com/app_root/jsp/login/login.jsp";
}

//**************************************************************************************************************************************
//**************************************************************************************************************************************
function facebookLogin(){
	// facebook login URL BLOCKED error 때문에 uri뒤에 _oauth/facebook?close 붙여줌 'https://www.happybusking.com/app_root/_oauth/facebook?close'
	// https://www.happybusking.com/app_root/jsp/login/facebookloginloading.jsp
	var uri = encodeURI('https://www.happybusking.com/app_root/jsp/login/facebookloginloading.jsp');
	window.location = encodeURI("https://www.facebook.com/dialog/oauth?client_id=1273105036213007&redirect_uri="+uri+"&response_type=token&scope=email");
}


//This is called with the results from from FB.getLoginStatus().
function statusChangeCallback(response) {
	alert('1');
  if (response.status === 'connected') {      // 페이스북을 통해서 로그인 
    DisplayResult();
/*  } else if (response.status === 'not_authorized') {      // 페이스북에는 로그인 했지만, 앱에는 로그인이 되어있지 않다 
    document.getElementById('status').innerHTML = 'Please log ' +  'into this app.';
  } else {	  // 페이스북에 로그인 되어있지 않아서, 앱에 로그인이 되어있는지 불확실
    document.getElementById('status').innerHTML = 'Please log ' +   'into Facebook.';*/
  } else {
	alert('No');
  }
  //alert(response.status);
}


// SDK를 비동기적으로 호출
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

function DisplayResult() {
  console.log('Welcome!  Fetching your information.... ');
  FB.api('/me', {fields: 'name,email'}, function(response) {
    console.log('Successful login for: ' + response.name);
    //document.getElementById('status').innerHTML =  '아이디 ' +response .id + '/ 이메일 ' + response.email + "/ 이름 " + response.name;		
	sessionStorage.setItem("fName", response.name);
	sessionStorage.setItem("fEmail", response.email);
  });
}



$(document).on('change', '#f_total_checkbox', function(){
	if($(this).prop('checked')){
		$('#f_useAgree_checkbox').prop('checked', true);
		$('#f_info_checkbox').prop('checked', true);
		$('#f_useGPS_checkbox').prop('checked', true);
	} else {
		$('#f_useAgree_checkbox').prop('checked', false);
		$('#f_info_checkbox').prop('checked', false);
		$('#f_useGPS_checkbox').prop('checked', false);
	}
});


//회원가입 버튼 클릭시
$(document).on('click', '#f_joinUpdateBtn', function() {
	
	if(!$('#f_useAgree_checkbox').prop('checked')){
		infoTxtBox('이용 약관에 동의해주세요.');
		return;
	}
	
	if(!$('#f_info_checkbox').prop('checked')){
		infoTxtBox('개인정보처리 약관에 동의해주세요.');
		return;
	}
	
	if(!$('#f_useGPS_checkbox').prop('checked')){
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
			user_id: sessionStorage.getItem("fEmail"),
			nickname: sessionStorage.getItem("fName"),
			login_chk: 'F'
		},
		success: function (data) {
			goJoinComplete(sessionStorage.getItem("fEmail"));
		},
		error: function(a, b, c) {
			toHome();
		}
	});
});

function facebooklogin() {
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		url: '/service/login/facebookLogin.jsp',
		data : {
			user_id : sessionStorage.getItem("fEmail"),
			login_chk : 'F'
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		async : false,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				var url = '/app_root/index.jsp?nlc=F';
				$.mobile.changePage(url, {transition : "none"});
			}
			
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			$(DATA).each(function() {
				var LOGINCHK = $(this).find('LOGINCHK').text();
				var STATUS = $(this).find('STATUS').text();
				var CNT = $(this).find('CNT').text();
				
				if(LOGINCHK == '1'){
					if(STATUS == 'L'){
						getAimg();
						var url = '/app_root/index.jsp?nlc=L&cnt='+CNT;
						$.mobile.changePage(url, {transition : "none"});
					}else if(STATUS == 'J'){
						getAimg();
						var url = '/app_root/index.jsp?nlc=J&cnt='+CNT;
						$.mobile.changePage(url, {transition : "none"});								
					}
					//getAimg();
					//toHome();
				}
				else{
					alert('다시 로그인 해주세요. 만약 해당 현상이 반복된다면 happybuskinginsta 로 문의해주십시오.');
					//$('#user_pass').val('');
					//$('#user_pass').focus();
					toHome();
				}
			});
		},
		error: function (xhr, message, errorThrown) {
		} // end error 
	});

};