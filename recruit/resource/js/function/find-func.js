const sendEmailChk = (email) => {
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/recruit/resource/service/user/get_login_chk.jsp',
		data:{
			email : email
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length === 0){
				alert('가입되지 않은 이메일입니다.');
				return;
			}
			
			$(DATA).each(function() {
				const LOGIN_CHK = $(this).find('LOGIN_CHK').text();
				
				if(LOGIN_CHK === 'N'){
					alert('네이버 간편로그인으로 가입된 이메일입니다.\n네이버 로그인을 진행해주세요.');
					history.go(-1);
					return;
				} else if(LOGIN_CHK === 'F'){
					alert('페이스북 간편로그인으로 가입된 이메일입니다.\n페이스북 로그인을 진행해주세요.');
					history.go(-1);
					return;
				} else if(LOGIN_CHK === 'K'){
					alert('카카오 간편로그인으로 가입된 이메일입니다.\n카카오 로그인을 진행해주세요.');
					history.go(-1);
					return;
				} else {
					$('#email').parents('.fp-input-box').removeClass('bg-white');
					$('#email').parents('.fp-input-box').addClass('bg-ldgray');
					$('#email').addClass('bg-ldgray');
					$('#email').attr('readonly', true);
					sendEmail(email);
				}
			});
		}
	});
}

const sendEmail = (email) => {
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/common/send_email.jsp',
		data:{
			email : email
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete: function(data){
			alert('인증 메일이 전송되었습니다.\n메일을 확인해주세요.');
			$('#enumber').focus();
			return;
		}
	});
}

const handlerEmailNumberChk = (email, number) => {
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/common/email_keyChk.jsp',
		data:{
			email : email,
			email_key: number
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(data){
				const CNT = $(this).find('CNT').text();
				if(CNT === '0'){
					alert('인증번호가 다릅니다.\n인증번호를 확인해주세요.');
					return;
				} else {
					$('#enumber').parents('.fp-input-box').removeClass('bg-white');
					$('#enumber').parents('.fp-input-box').addClass('bg-ldgray');
					$('#enumber').addClass('bg-ldgray');
					$('#enumber').attr('readonly', true);
					
					const html = '<p class="ft-lgray ft-12 subtitle">새 비밀번호</p>'+
								'<div class="flex bg-white fp-input-box">'+
									'<input type="text" class="ft-14 mp-input" id="pw" data-role="none" placeholder="변경할 비밀번호를 입력해주세요.">'+
								'</div>';
					
					$('.find-pw-warpper').append(html);
				}
			});
		},
		error: function(xhr){
			console.log(xhr);
			alert('인증에 실패했습니다.\n해당 메시지가 계속 되면 해피버스킹에 문의 주시기바랍니다.');
			return;
		}
	});
}

const handlerPWChange = (email, pw) => {
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/user/pw_update.jsp',
		data:{
			email : email,
			user_pw: pw
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(data){
				const RESULT = $(this).find('RESULT').text();
				
				if(RESULT === 'false'){
					alert('비밀번호 변경에 실패했습니다.\n해당 메시지가 계속 되면 해피버스킹에 문의 주시기바랍니다.');
					return;
				} else {
					alert('비밀번호가 변경되었습니다.');
					history.go(-1);
					return;
				}
			});
		},
		error: function(xhr){
			console.log(xhr);
			alert('비밀번호 변경에 실패했습니다.\n해당 메시지가 계속 되면 해피버스킹에 문의 주시기바랍니다.');
			return;
		}
	});
}