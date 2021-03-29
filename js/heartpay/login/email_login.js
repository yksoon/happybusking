$(document).on('pageinit', '#login', function() {
	var device_uuid = '';
	
	//출시때는 주석 풀어야함
	/*if(navigator.userAgent.indexOf('Mobile') != -1){
		//모바일인 경우
		device_uuid = device.uuid;
	} else {
		//데스크탑인 경우
		device_uuid = '';
	}*/
	
	setCookie('device_uuid', device_uuid, 60); /* tinfo_sh_chk=off, 60일 뒤 만료됨 */
});


$(document).on('click', '#loginBtn', function() {
	var user_id = $('#user_id').val();
	var user_pw = $('#user_pass').val();
	
	var user_login_chk = '';
	
	if(user_id == '' || user_id == null){
		alert('아이디를 입력해주세요.');
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/login/user_login_chk.jsp',
		data : {
			user_id : user_id
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		async : false,
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var LOGIN_CHK = $(this).find('LOGIN_CHK').text();
				
				user_login_chk = LOGIN_CHK;
				
				if(LOGIN_CHK == 'N'){
					alert('해당 아이디는 네이버로 가입된 아이디입니다.\n네이버 로그인으로 로그인해주세요.');
					return;
				} else if(LOGIN_CHK == 'F'){
					alert('해당 아이디는 페이스북으로 가입된 아이디입니다.\n페이스북 로그인으로 로그인해주세요.');
					return;
				} else if(LOGIN_CHK == 'K'){
					alert('해당 아이디는 카카오로 가입된 아이디입니다.\n카카오 로그인으로 로그인해주세요.');
					return;
				}
			});
		}
	});
	
	if(user_login_chk == ''){
		alert('아이디 또는 비밀번호를 확인해주세요.');
		return;
	}
	
	if(user_login_chk != 'E')
	{
		return;
	}
	
	if(user_pw == '' || user_pw == null){
		alert('비밀번호를 입력해주세요.');
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		url: '/service/login/login.jsp',
		data : {
			user_id : user_id,
			user_pw : user_pw,
			login_chk : 'E'
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		async : false,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			getAimg();
			
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
						var url = '/app_root/index.jsp?nlc=L&cnt='+CNT;
						$.mobile.changePage(url, {transition : "none"});
					}else if(STATUS == 'J'){
						var url = '/app_root/index.jsp?nlc=J&cnt='+CNT;
						$.mobile.changePage(url, {transition : "none"});								
					}
				}
				else{
					alert('아이디 또는 비밀번호를 확인해주세요.');
					$('#user_pass').val('');
					$('#user_pass').focus();
					return;
				}
			});
		},
		error: function (xhr, message, errorThrown) {
		} // end error 
	});		
});

$(document).on('keyup', '#user_pass', function(e){
	if(e.keyCode === 13){
		$('#loginBtn').click();
	}
});