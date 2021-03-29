const handlerLogin = () => {
	const id = $('#id').val();
	const pw = $('#pw').val();
	
	if(id === ''){
		alert('아이디를 입력해주세요.');
		$('#id').val('');
		$('#id').focus();
		return;
	} else if(pw === ''){
		alert('비밀번호를 입력해주세요.');
		$('#pw').val('');
		$('#pw').focus();
		return;
	}
	
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
}