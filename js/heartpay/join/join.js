function goJoinPage() {
	loadPage('join/join.jsp');
}

//var email_chk;
//var pw_chk;

$(document).on('pageinit', '#join', function(){
	//email_chk = 'N';
	//pw_chk = 'N';
	
	$('#agree_all').click(function(){
		if($('#agree_all').prop('checked')){
			$('input[name=agree_chk]').prop('checked', true).checkboxradio('refresh');
		}else{
			$('input[name=agree_chk]').prop('checked', false).checkboxradio('refresh');
		}
	});
});

$(document).on('change', '#j_total_checkbox', function(){
	if($(this).prop('checked')){
		$('#j_useAgree_checkbox').prop('checked', true);
		$('#j_info_checkbox').prop('checked', true);
		$('#j_useGPS_checkbox').prop('checked', true);
	} else {
		$('#j_useAgree_checkbox').prop('checked', false);
		$('#j_info_checkbox').prop('checked', false);
		$('#j_useGPS_checkbox').prop('checked', false);
	}
});

/*$(document).on('click', '#join_certBtn', function() {
	var email = $('#join_Email').val();
	var email_overlap = 'Y';
	
	if(email == '' || email == null){
		alert('이메일을 입력해주세요.');
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
						email_overlap = 'N';
					}
					
					if(email_overlap == 'Y'){
						infoTxtBox('이미 가입된 이메일입니다.');
						return;
					}
					$('#join_Email').parents('.ui-corner-all').css('background','#c5bfbf');
					$('#join_Email').attr('readonly', 'readonly');
					$('#join_Email_div').find('.ui-block-a').css('width', '100%');
					$('#join_Email_div').find('.ui-block-b').css('display', 'none');
					
					$('#join_certNo_div').show();
					
					//인증번호 보내는 service 코드 추가하기
					$.ajax({
						type: "GET",
						cache: false,
						url: '/service/common/send_email.jsp',
						data:{
							email : email,
							keyState : 'J'
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
});*/

//인증번호 확인 클릭시
/*$(document).on('click', '#join_certNoBtn', function() {
	var email = $('#join_Email').val();
	var certNo = $('#join_certNo').val();
	
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
						$('#join_certNo_div').hide();
					}
				});
			}
		});
	}
});*/

/*//비밀번호 확인 입력시
$(document).on('keyup', '#join_PW2', function() {
	var pw1 = $('#join_PW').val();
	var pw2 = $('#join_PW2').val();
	
	if(pw1 != pw2){
		pw_chk = 'N';
		$('#joinPw_chk').html('비밀번호와 비밀번호 확인이 다릅니다.');
		$('#joinPw_chk').css('color', '#ff0000');
	}
	else{
		pw_chk = 'Y';
		$('#joinPw_chk').html('비밀번호와 비밀번호 확인이 일치합니다.');
		$('#joinPw_chk').css('color', '#19de1f');
	}
});*/

function emailChk(str){
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	if(exptext.test(str)==false){
		//이메일 형식이 올바르지 않을 경우
		alert('메일 형식을 확인해주세요.');
		return false;
	} else {
		return true;
	}
}


//회원가입 버튼 클릭시
$(document).on('click', '#joinUpdateBtn', function() {
	var email_overlap = 'Y';
	//var gender = $('input:radio[name="chk_gender"]:checked').val();
	var join_Email = $('#join_Email').val();
	var join_PW = $('#join_PW').val();
	var join_Nicname = $('#join_Nicname').val();
	//var join_birthday = $('#join_birthday').val();
	//var join_PW2 = $('#join_PW2').val();
	
	if(join_Email == ''){
		alert('이메일을 입력해주세요.');
		$('#join_Email').focus();
		return;
	}else if(!emailChk(join_Email)){
		$('#join_Email').focus();
		return;
	}else if(join_PW == '' || join_PW == null){
		alert('비밀번호를 입력해주세요.');
		$('#join_PW').focus();
		return;
	}
	else if(join_Nicname == '' || join_Nicname == null){
		alert('닉네임을 입력해주세요.');
		$('#join_Nicname').focus();
		return;
	}
	
	
	if(!$('#j_useAgree_checkbox').prop('checked')){
		alert('이용 약관에 동의해주세요.');
		return;
	} else if(!$('#j_info_checkbox').prop('checked')){
		alert('개인정보처리 약관에 동의해주세요.');
	 	return;
	} else if(!$('#j_useGPS_checkbox').prop('checked')){
		alert('위치기반 서비스 이용약관에 동의해주세요.');
		return;
	}
	
	if(join_Nicname.length > 8){
		alert('닉네임은 8글자 까지만 입력가능합니다.');
		$('#join_Nicname').focus();
		return;
	}
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/join/join_chk.jsp',
		data:{
			user_id : join_Email,
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
							user_id: join_Email,
							user_pw: join_PW,
							nickname: join_Nicname,
							login_chk: 'E'
						},
						success: function (data) {
							goJoinComplete(join_Nicname);
						},
						error: function(a, b, c) {
							return;
						}
					});
				}
			});
		}
	});
});
