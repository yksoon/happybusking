
//물품공유 상세페이지 물음표 버튼 클릭시 도움말 팝업 띄웠다가 자동으로 사라지기
$(document).on('click', '#sid_question_btn', function(){
	$('.sid_help_popup').show();
	setTimeout(function(){
		$('.sid_help_popup').fadeOut('slow');
	}, 2000);
});

/////////////////////////////////////////////////////////////////////////
$(document).on('pageinit', '#share_item_detail', function(){
	getShareItemDetail(g_si_no);
	getShareItemReplyList(g_si_no);
});



//***********************************************************************
//click_bar onclick .removeclass, .addclass 구현

//장비내용 클릭시
$(document).on('click', '#cb_content', function(){
	$('.sid_click_bar_a').removeClass('active');
	$(this).addClass('active');
	$('.sib_view').hide();
	$('.sid_ib_equip_info').show();
	$('.sid_info_box').css({
		'padding': '15px'
	});
})


$(document).on('click', '#cb_reply', function(){
	$('.sid_click_bar_a').removeClass('active');
	$(this).addClass('active');
	$('.sib_view').hide();
	$('.sib_view').removeClass('hide');
	$('.sid_reply_div').show();
	$('.sid_info_box').css({
		'padding': '0px'
	});
})


$(document).on('click', '#cb_phone', function(){
	$('.sid_click_bar_a').removeClass('active');
	$(this).addClass('active');
	$('.sib_view').hide();
	$('.sib_view').removeClass('hide');
	$('.sid_phone_div').show();
	$('.sid_info_box').css({
		'padding': '15px'
	});
})

//************************************************************************
//reply form in share_item_detail
//글 삭제 버튼 클릭시
$(document).on('click', '#si_del_btn', function(){
	var si_no = $('#si_no').val();
	
	var conf = confirm('공연 장비 공유글을 삭제하시겠습니까 ?');
	if(!conf){
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/share_item/share_item_del.jsp',
		data : {
			si_no : si_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		async : false,
		timeout: 30000
	});
	
	history.go(-1);
});


//댓글 등록버튼 클릭시
$(document).on('click', '#sid_re_insertbtn', function(){
	var login_chk = userLogin_chk();
	if(login_chk == false){
		infoTxtBox('로그인 후 댓글입력이 가능합니다.');
		return;
	}
	
	var si_reply_content = changeQuotes($('#si_reply_content').val());
	
	if(si_reply_content == ''){
		$('#si_reply_content').val();
		infoTxtBox('댓글을 입력해주세요.');
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/share_item/share_item_reply_insert.jsp',
		data : {
			si_no : g_si_no,
			si_reply_content : si_reply_content
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		async : false,
		timeout: 30000
	});
	
	$('#si_reply_content').val('');
	getShareItemReplyList(g_si_no);
});

//댓글 답글달기 클릭시
$(document).on('click', '.sid_re_info_rebtn', function() {
	$(this).parents('.sid_re_container').children('.sid_re_re_body').show();
});


//댓글 답글 닫기버튼 클릭시
$(document).on('click', '#sid_rere_closebtn', function(){
	$(this).parents('.sid_re_re_body').hide();
});


//댓글 답글 등록버튼 클릭시
$(document).on('click', '#sid_re_re_input_btn', function(){
	var login_chk = userLogin_chk();
	if(login_chk == false){
		infoTxtBox('로그인 후 댓글입력이 가능합니다.');
		return;
	}
	
	var parent_no = $(this).parents('.sid_re_container').attr('id');
	var si_rereply_content = changeQuotes($(this).parents('.sid_re_container').find('#sid_re_reply_content').val());
	
	if(si_rereply_content == ''){
		infoTxtBox('답글을 입력해주세요.');
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/share_item/share_item_rereply_insert.jsp',
		data : {
			si_no : g_si_no,
			si_reply_parent_no : parent_no,
			si_rereply_content : si_rereply_content
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		async : false,
		timeout: 30000
	});
	
	$('#sid_re_reply_content').val('');
	getShareItemReplyList(g_si_no);
});


//댓글 삭제버튼 클릭시
$(document).on('click', '.sid_re_del_btn', function(){
	var conf = confirm('댓글을 삭제하시겠습니까 ?');
	if(!conf){
		return;
	}
	
	var reply_no = $(this).parents('.sid_re_container').attr('id');
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/share_item/share_item_reply_delete.jsp',
		data : {
			si_reply_no : reply_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		async : false,
		timeout: 30000
	});
	getShareItemReplyList(g_si_no);
})