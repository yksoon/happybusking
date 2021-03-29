$(document).on('pageinit', '#board_write_list', function() {
	$('#Go_boardList').click();
});


//내가 쓴 게시물
$(document).on('click', '#Go_boardList', function() {
	$('#bw_header_title').text('글 제목');
	$('#bw_main_menu').empty();
	var bw_main_menu = '<div class="ui-grid-a header_menu_container">'+
							'<div id="Go_boardList" class="ui-block-a">'+
							'<div class="haeder_menu_div_on">'+
								'<span class="header_menu_text_on">내가 쓴 글</span>'+
							'</div>'+
						'</div>'+
						'<div id="Go_replyList" class="ui-block-b">'+
							'<div class="haeder_menu_div_base">'+
								'<span class="header_menu_text_base">내가 쓴 댓글</span>'+
							'</div>'+
						'</div>'+
						'</div>';	
	$('#bw_main_menu').append(bw_main_menu);
	get_board_list();
});


//내가 쓴 댓글
$(document).on('click', '#Go_replyList', function() {
	$('#bw_header_title').text('댓글 내용');
	$('#bw_main_menu').empty();
	var bw_main_menu = '<div class="ui-grid-a header_menu_container">'+
							'<div id="Go_boardList" class="ui-block-a">'+
							'<div class="haeder_menu_div_base">'+
								'<span class="header_menu_text_base">내가 쓴 글</span>'+
							'</div>'+
						'</div>'+
						'<div id="Go_replyList" class="ui-block-b">'+
							'<div class="haeder_menu_div_on">'+
								'<span class="header_menu_text_on">내가 쓴 댓글</span>'+
							'</div>'+
						'</div>'+
						'</div>';
	$('#bw_main_menu').append(bw_main_menu);
	get_reply_list();
});

//정렬 클릭시
$(document).on('click', '#bw_header_sort', function() {
	var sort_title = $('#bw_header_title').text();
	var sort = $('#bw_header_sort').text();
	
	if(sort_title == '글 제목'){
		if(sort == '최신순'){
			$('#bw_header_sort').text('댓글순');
			get_board_list();
		}
		else{
			$('#bw_header_sort').text('최신순');
			get_board_list();
		}
	}
});