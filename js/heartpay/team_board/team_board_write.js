$(document).on('pageinit', '#team_board_write', function() {
	$('#board_write_title_area').textinput("option", "autogrow", false);
	$('#board_write_subject_area').textinput("option", "autogrow", false);
});

$(document).on('pageinit', '#team_board_update', function() {
	$('#board_update_title_area').textinput("option", "autogrow", false);
	$('#board_update_subject_area').textinput("option", "autogrow", false);
}); 

//작성완료 버튼 클릭시
$(document).on('click', '#team_board_write_btn', function() {
	var user_no = $('#user_no').val();
	var board_category = $('#team-board-write-select').val();
	var board_title = changeQuotes($('#board_write_title_area').val());
	var board_content = changeQuotes($('#board_write_subject_area').val());
	
	if(board_title.length > 80){
		alert('제목은 80자 이상 입력할 수 없습니다.');
		return;
	}
	
	if(board_content.length > 1000){
		alert('내용은 1000자 이상 입력할 수 없습니다.');
		return;
	}
	
	if(user_no == 'null'){
		infoTxtBox('로그인을 해주세요');
		return;
	}
	else if(board_title == ''){
		infoTxtBox('제목을 입력해주세요');
		$('#board_write_title_area').focus();
		return;
	}
	else if(board_content == ''){
		infoTxtBox('내용을 입력해주세요');
		$('#board_write_subject_area').focus();
		return;
	}
	
	$.ajax({
		type: "POST",
		url: '/service/team_board/team_board_write.jsp',
		async: false,
		data:{
			user_no: user_no,
			board_category: board_category,
			board_title: board_title,
			board_content: board_content
		},
		success: function (data) {
		},
		error: function(a, b, c) {
		},
		complete: function(){
			alert('게시글이 작성되었습니다.');
			history.go(-1);
		}
	});
		
});



//수정완료 버튼 클릭시
$(document).on('click', '#team_board_update_btn', function() {
	var board_no = $('#board_no').val();
	var board_category = $('#team-board-update-select').val();
	var board_title = changeQuotes($('#board_update_title_area').val());
	var board_content = changeQuotes($('#board_update_subject_area').val());
	
	if(board_title.length > 80){
		alert('제목은 80자 이상 입력할 수 없습니다.');
		return;
	}
	
	if(board_content.length > 1000){
		alert('내용은 1000자 이상 입력할 수 없습니다.');
		return;
	}
	
	if(board_title == ''){
		infoTxtBox('제목을 입력해주세요');
		$('#board_update_title_area').focus();
		return;
	}
	else if(board_content == ''){
		infoTxtBox('내용을 입력해주세요');
		$('#board_update_subject_area').focus();
		return
	}
	
	$.ajax({
		type: "POST",
		url: '/service/team_board/team_board_update.jsp',
		data:{
			board_no: board_no,
			board_category: board_category,
			board_title: board_title,
			board_content: board_content
		},
		success: function (data) {
		},
		complete: function(){
			alert('해당글이 수정되었습니다.');
			history.go(-1);
		}
	});
});