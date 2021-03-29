$(document).on('click', '#go-id-chk', function(){
	const email = spaceChk($('#email').val());
	
	if(email === ''){
		alert('이메일을 입력해주세요.');
		$('#email').val('');
		$('#email').focus();
		return;
	}
	
	sendEmailChk(email);
});


$(document).on('click', '#go-number-chk', function(){
	const email = spaceChk($('#email').val());
	const number = spaceChk($('#enumber').val());
	
	handlerEmailNumberChk(email, number);
});

$(document).on('click', '#pw-update', function(){
	const email = spaceChk($('#email').val());
	let pw = $('#pw').val();
	
	console.log(pw);
	
	if(pw === undefined || pw === 'undefined'){
		alert('이메일 인증을 먼저 진행해주세요.');
		return;
	}
	
	pw = spaceChk(pw);
	
	if(pw.length < 6 || pw === ''){
		alert('비밀번호는 공백없이 6글자 이상 입력해주세요.');
		$('#pw').focus();
		return;
	}
	
	handlerPWChange(email, pw);
});