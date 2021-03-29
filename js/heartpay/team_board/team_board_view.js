//답글 버튼 누르면 답글 보임
$(document).on('click', '.tb_reply_content_f', function() {
	var r_index = $(this).parents('.tb_reply_view_content').index('.tb_reply_view_content') + 1;
	$('.tb_comment_view_content'+r_index).show();
	$('#tb_comment_write'+r_index).show();
});

//답글에서 '닫기'버튼 누르면 해당 답글 창 닫아짐
$(document).on('click', '#comment_close', function() {
	var c_class = $(this).parents('#tb_comment_view_content').attr('class');
	var r_index = $(this).parents('.tb_reply_view_cc').index('.tb_reply_view_cc') + 1;
	$('.tb_comment_view_content'+r_index).hide();
	$('#tb_comment_write'+r_index).hide();
});

//댓글달기 버튼 클릭시
$(document).on('click', '#tb_reply_view_footer', function() {
	$('#team_board_reply_view').hide();
	$('#team_board_reply_update').hide();
	$('#team_board_reply_write').show();
});

//댓글 작성 창에서 '댓글등록' 클릭시
$(document).on('click', '#tb_reply_write_btn', function() {
	var tb_r_area = changeQuotes($('#tb_reply_write_area').val());
	var user_no = $('#user_no').val();
	if( tb_r_area == ''){
		infoTxtBox('댓글 내용을 입력해주세요.');
		return;
	}
	
	var url = '/service/team_board/team_board_reply_write.jsp';
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data : {
			board_no : board_no_temp,
			user_no : user_no,
			board_reply_content : tb_r_area
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			console.log("code:"+xhr+"\n"+"message:"+message+"\n"+"error:"+errorThrown);
			return;
		} // end error 
	});
	infoTxtBox('댓글이 작성되었습니다.');
	$('#tb_reply_write_area').val('');
	load_team_board_reply();
	$('#reply_refresh').click();
});

//댓글 작성 창에서 '닫기' 클릭시
$(document).on('click', '#tb_reply_write_header_b', function() {
	$('#team_board_reply_write').hide();
	$('#team_board_reply_view').show();
});

//댓글 수정 창에서 '닫기' 클릭시
$(document).on('click', '#tb_reply_update_header_b', function() {
	$('#team_board_reply_update').hide();
	$('#team_board_reply_view').show();
});

//댓글 수정 창에서 '댓글 수정' 버튼 클릭시
$(document).on('click', '#tb_reply_update_btn', function() {
	var brc = changeQuotes($('#tb_reply_update_area').val());
	var board_reply_no = $('#tb_reply_update_btn').attr('class');
	
	if(brc == ''){
		infoTxtBox('내용을 입력해주세요.');
		return;
	}
	confirmBox('해당 글을 수정하시겠습니까 ? ', goAjax);
	function goAjax(){
		$.ajax({
			type: "GET",//url: "JSON/test.json",
			cache: false,
			url: '/service/team_board/team_board_reply_update.jsp',
			data : {
				board_reply_no : board_reply_no,
				board_reply_content : brc
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success: function (data) {
			} // end success
		});
		
		infoTxtBox('수정이 완료되었습니다.');
		load_team_board_reply();
		$('#reply_refresh').click();
	}
});



//댓글->답글 등록 버튼 클릭시
$(document).on('click', '.tb_commtent_write_btn', function() {
	//var parent_no = $(this).parents('.tb_reply_view_cc').find('.tb_reply_content_f').attr('id');
	var parent_no = $(this).parents('.tb_reply_view_cc').find('.tb_reply_content_f').attr('id');
	var comment_content = changeQuotes($(this).parents('.tb_comment_write').find('.tb_comment_write_area').val());
	var user_no = $('#user_no').val();
	
	if(comment_content == ''){
		infoTxtBox('답글을 입력해주세요.');
		$(this).parents('.tb_comment_write').find('.tb_comment_write_area').focus();
		return;
	}

	var url = '/service/team_board/team_board_reply_write.jsp';
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data : {
			board_no : board_no_temp,
			user_no : user_no,
			parent_no : parent_no,
			board_reply_content : comment_content
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			console.log("code:"+xhr+"\n"+"message:"+message+"\n"+"error:"+errorThrown);
			return;
		} // end error 
	});
	infoTxtBox('답글이 작성되었습니다.');
	load_team_board_reply();
	$('#reply_refresh').click();
});

//댓글 새로고침 버튼 클릭시 이미지 회전
$(document).on('click', '#reply_refresh', function() {
	$(this).addClass('imgRotate');
	
	setTimeout( 'stop_imgRotate()' , 1000);
	load_team_board_reply();
});

$(document).on('pageinit', '#team_board_view', function() {
	$('#tb_reply_write_area').textinput("option", "autogrow", false);
	$('#tb_reply_update_area').textinput("option", "autogrow", false);
	$('.tb_comment_write_area').textinput("option", "autogrow", false);
	load_team_board_reply();
});