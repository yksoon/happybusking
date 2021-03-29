const handlerJoin = () => {
	const id = $('#id').val();
	const pw = $('#pw').val();
	const nickname = $('#nickname').val();
	
	let terms = true;
	
	$('input:checkbox[name=terms]').each(function(){
		if($(this).is(':checked') === false){
			terms = false;
		}
	});
	
	if(id === ''){
		alert('이메일을 입력해주세요.');
		$('#id').focus();
		return;
	} else if(pw === ''){
		alert('비밀번호을 입력해주세요.');
		$('#pw').focus();
		return;
	} else if(nickname === ''){
		alert('닉네임을 입력해주세요.');
		$('#nickname').focus();
		return;
	} else if(!terms){
		alert('필수 약관에 모두 동의해주세요.');
		return;
	}
	
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/join/join_chk.jsp',
		data:{
			user_id : id,
			login_chk : 'E',
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function() {
				var CNT = $(this).find('CNT').text();
				var LOGIN_CHK = $(this).find('LOGIN_CHK').text();
				
				if(CNT == '0'){
					email_overlap = 'N';
				} else {
					email_overlap = 'Y';
				}
				
				if(email_overlap == 'Y'){
					if(LOGIN_CHK == 'E'){
						alert('이미 가입된 이메일입니다.');
						return;
					} else if(LOGIN_CHK == 'F'){
						alert('페이스북으로 가입된 이메일입니다.\n페이스북으로 로그인 해주세요.');
						return;
					} else if(LOGIN_CHK == 'N'){
						alert('네이버로 가입된 이메일입니다.\n네이버로 로그인 해주세요.');
						return;
					} else if(LOGIN_CHK == 'K'){
						alert('카카오로 가입된 이메일입니다.\n카카오로 로그인 해주세요.');
						return;
					}
				} else {
					$.ajax({
						type: "POST",
						url: '/service/join/join.jsp',
						data:{
							user_id: id,
							user_pw: pw,
							nickname: nickname,
							login_chk: 'E'
						},
						success: function (data) {
							$.ajax({
								type: "GET",//url: "JSON/test.json",
								url: '/service/login/login.jsp',
								data : {
									user_id : id,
									user_pw : pw,
									login_chk : 'E'
								},
								contentType: "application/xml; charset=utf-8",
								dataType: "xml",
								timeout: 30000,
								async : false,
								success: function (data) {
									var ROOT = $(data).find('ROOT');
									var DATA = $(ROOT).find('DATA');
									if(DATA.length == 0){
										alert('로그인 실패');
										return;
									}
									
									$(DATA).each(function() {
										var LOGINCHK = $(this).find('LOGINCHK').text();
										var STATUS = $(this).find('STATUS').text();
										var CNT = $(this).find('CNT').text();
										
										if(LOGINCHK == '1'){
											if(STATUS == 'L'){
												goMyPbi();
											}else if(STATUS == 'J'){
												goMyPbi();								
											}
										}
										else{
											alert('아이디 또는 비밀번호를 확인해주세요.');
											$('#pw').val('');
											$('#pw').focus();
											return;
										}
									});
								},
								error: function (xhr, message, errorThrown) {
									console.log(xhr, message, errorThrown);
								} // end error 
							});		
						},
						error: function(a, b, c) {
							console.log(a, b, c);
							return;
						}
					});
				}
			});
		}
	});
}