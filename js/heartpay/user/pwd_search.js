//비밀번호 찾기
function goPwdSearch(){
	loadPage('user/pwd_search.jsp');
}


$(document).on('click', '#pwdSearch_certBtn', function() {
	var email = $('#pwdSearch_Email').val();
	var email_overlap = 'Y';
	
	if(email == '' || email == null){
		infoTxtBox('이메일을 입력해주세요.');
		return;
	}
	else{
		$.ajax({
			type: "GET",
			cache: false,
			url: '/service/join/join_chk.jsp',
			data:{
				user_id : email,
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
					if(CNT == '0'){
						//가입되지 않은 이메일일 경우
						infoTxtBox('가입되지 않은 이메일입니다.\확인후 다시 입력해주세요.');
						return;
					}
					
/*					if(email_overlap == 'Y'){
						infoTxtBox('이미 가입된 이메일입니다.');
						return;
					}*/
					$('#pwdSearch_Email').parents('.ui-corner-all').css('background','#c5bfbf');
					$('#pwdSearch_Email').attr('readonly', 'readonly');
					$('#pwdSearch_Email_div').find('.ui-block-a').css('width', '100%');
					$('#pwdSearch_Email_div').find('.ui-block-b').css('display', 'none');
					
										
					//인증번호 보내는 service 코드 추가하기
					$.ajax({
						type: "GET",
						cache: false,
						url: '/service/common/send_email.jsp',
						data:{
							email : email,
							keyState : ''
						},
						contentType: "application/xml; charset=utf-8",
						dataType: "xml",
						timeout: 30000,
						success: function(data){
						}
					});
					
					infoTxtBox('이메일에서 인증번호를 확인해주세요.');
				});
			}
		});
	}
});

//인증번호 확인 클릭시
$(document).on('click', '#pwdSearch_certNoBtn', function() {
	var email = $('#pwdSearch_Email').val();
	var certNo = $('#pwdSearch_certNo').val();
	
	if(certNo == '' || certNo == null){
		infoTxtBox('인증번호를 입력해주세요.');
		return;
	}
	else{
		//인증번호 체크하는 service 코드 추가하기
		$.ajax({
			type: "GET",
			cache: false,
			url: '/service/common/email_keyChk.jsp',
			data:{
				email : email,
				email_key : certNo
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success: function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				$(DATA).each(function() {
					var CNT = $(this).find('CNT').text();
					
					if(CNT == '0'){
						infoTxtBox('인증번호를 확인해주세요.');
						return;
					}
					else{
						email_chk = 'Y';
						infoTxtBox('인증이 완료되었습니다.');
						$('#pwdSearch_certNo_div').hide();
						$('#pwdSearchBtn').attr('onclick', 'goNewPwd("' + email + '")');
					}
				});
			}
		});
	}
});

var new_pw_email;
function goNewPwd(email){
	new_pw_email = email;
	loadPage('user/new_pwd.jsp');
}

var new_pw_chk = 'N';
//비밀번호 확인 text filed에 입력시
$(document).on('keyup', '#new_PW2', function() {
	var newPW = $('#new_PW').val();
	var newPW2 = $('#new_PW2').val();
	
	if(newPW != newPW2){
		new_pw_chk = 'N';
		$('#new_pwd_chk').html('비밀번호와 비밀번호 확인이 다릅니다.');
		$('#new_pwd_chk').css('color', '#ff0000');
	}
	else{
		new_pw_chk = 'Y';
		$('#new_pwd_chk').html('비밀번호와 비밀번호 확인이 일치합니다.');
		$('#new_pwd_chk').css('color', '#19de1f');
	}
});

//비밀번호 변경 버튼 클릭시
$(document).on('click', '#pwdCangeBtn', function() {
	var newPW = $('#new_PW').val();
	var newPW2 = $('#new_PW2').val();
	
	if(newPW == '' || newPW == null){
		infoTxtBox('비밀번호를 입력해주세요.');
		return;
	}
	if(newPW2 == '' || newPW2 == null){
		infoTxtBox('비밀번호 확인을 입력해주세요.');
		return;
	}
	
	if(new_pw_chk == 'N'){
		infoTxtBox('비밀번호를 확인해주세요.');
		return;
	}
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/user/pw_update.jsp',
		data: {
			user_pw : newPW,
			email : new_pw_email
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			infoTxtBox('비밀번호가 변경되었습니다.');
			toHome();
		}
	});
});