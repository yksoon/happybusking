//공지사항 리스트 생성시
$(document).on('pageinit', '#notice_list', function(){
	var type;
	if(artist_chk()){
		type = 'A';
	} else {
		type = 'N';
	}
	
	getNoticeList(type);
});

//공지사항 상세 페이지 생성시
$(document).on('pageinit', '#notice_detail', function(){
	getNoticeDetail();
});


//공지사항 리스트 클릭시
$(document).on('click', '.npc_list_container', function(){
	var ntNo = $(this).attr('id');
	sessionStorage.setItem('ntNo', ntNo);
	goNoticeDetail();
});

//공지사항 댓글 새로고침 클릭시
$(document).on('click', '#ndc_rc_reflash', function(){
	$('#nt_reply').val('');
	getNoticeReply();
});


//공지사항 댓글 작성 버튼 클릭시
$(document).on('click', '.ndc_rc_btn', function(){
	if(userLogin_chk() == false){
		alert('로그인 하시고 해당 서비스를 이용해주세요');
		return;
	}
	
	var ntNo = sessionStorage.getItem('ntNo');
	var ntrContent = $('#nt_reply').val();
	
	if(blankChk(ntrContent) == ''){
		alert('댓글을 입력해주세요.');
		$('#nt_reply').focus();
		return;
	}
	
	if(ntrContent.length > 100){
		alert('100자 이상 입력이 불가능합니다.');
		return;
	}
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/notice/set_notice_reply.jsp',
		data: {
			ntNo : ntNo,
			ntrContent : ntrContent
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete : function(data){
			$('#nt_reply').val('');
			alert('댓글이 작성되었습니다.');
			getNoticeReply();
		}
	});
});

//공지사항 댓글 삭제 버튼 클릭시
$(document).on('click', '.ndc_rbc_list_delbtn', function(){
	var conf = confirm('댓글을 삭제하시겠습니까 ?');
	if(!conf){
		return;
	}
	
	var ntrNo = $(this).attr('id');
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/notice/del_notice_reply.jsp',
		data: {
			ntrNo : ntrNo
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete : function(data){
			$('#nt_reply').val('');
			alert('댓글이 삭제되었습니다.');
			getNoticeReply();
		}
	});
});

//공지사항 안쪽에 a태그 클릭시
$(document).on('click', '#notice_detail a' ,function(e){
	//e.preventDefault(); 
	var url = $(this).attr("href");
	
	var urlTmp = url.split('://')[0];
	if(urlTmp == 'http' || urlTmp == 'https'){
		window.open(url, "_blank");
		return;
	}
	
});