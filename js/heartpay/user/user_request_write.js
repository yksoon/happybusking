$(document).on('pageinit', '#user_request_write', function(){
	if(userLogin_chk() == false){
		$('.non_member_div').show();
	} else {
		$('.non_member_div').hide();
	}
});

$(document).on('click', '#urw_success_btn', function(){
	var urwType = changeQuotes($('#urw_type').val());
	var urwTitle = changeQuotes($('#urw_title_area').val());
	var urwContent = changeQuotes($('#urw_content_area').val());
	
	//비회원일경우
	var urwID = $('#urw_id').val().replace(/ /gi, '');
	var urwPW = $('#urw_pw').val().replace(/ /gi, '');

	if(userLogin_chk() == false){
		if(urwID == ''){
			alert('문의 ID를 입력해주세요.');
			return;
		}
		
		if(urwPW == ''){
			alert('문의 비밀번호를 입력해주세요.');
			return;
		}
	}
	
	if(urwTitle == ''){
		alert('제목을 입력해주세요.');
		return;
	}
	
	if(urwContent == ''){
		alert('내용을 입력해주세요.');
		return;
	}
	
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/user/user_request_write.jsp',
		data : {
			urwType: urwType,
			urwTitle: urwTitle,
			urwContent: urwContent,
			urwID: urwID,
			urwPW: urwPW
		},
		async : false,
		dataType: "xml",
		beforeSend: function(){
			$.mobile.loading( 'show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
		},
		complete: function(){
			$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
			history.go(-1);
		}
	});
});