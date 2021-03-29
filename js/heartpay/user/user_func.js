function goUserRequestList(){
	loadPage('user/user_request_list.jsp');
}

function goUserRequestWrite(){
	if(userLogin_chk() == false){
		var conf = confirm('비회원으로 문의하시겠습니까 ?');
		if(!conf){
			loadPage('login/login.jsp');
		} else {
			loadPage('user/user_request_write.jsp');
		}
	} else {
		loadPage('user/user_request_write.jsp');
	}
}

function goUserRequestDetail(uq_no){
	sessionStorage.setItem('uq_no', uq_no);
	loadPage('user/user_request_detail.jsp');
}

function getUserRequestList(){
	$('#url_list_container').empty();
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/user/get_user_request_list.jsp',
		async : false,
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$("#main_cont").text("문의하신 내역이 없습니다.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function(i){
				var UQ_NO = $(this).find('UQ_NO').text();
				var UQ_STATE = $(this).find('UQ_STATE').text();
				var UQ_TYPE = $(this).find('UQ_TYPE').text();
				var UQ_TITLE = $(this).find('UQ_TITLE').text();
				var UQ_CONTENT = $(this).find('UQ_CONTENT').text();
				var UQ_REGIDATE = $(this).find('UQ_REGIDATE').text();
				
				var title = '[' + UQ_TYPE + ']' + UQ_TITLE;
				
				var html;
				
				if(UQ_STATE == 'N'){
					//답변 대기
					html = '<div class="ui-grid-a url_list" onclick="goUserRequestDetail('+UQ_NO+');">'+
							'<div class="ui-block-a url_content">'+
								'<div class="url_title">'+title+'</div>'+
								'<p class="url_state_btn url_state_wait">답변대기</p>'+
							'</div>'+
							'<div class="ui-block-b url_date">'+UQ_REGIDATE+'</div>'+ 
							'</div>';
				} else {
					//답변 완료
					html = '<div class="ui-grid-a url_list" onclick="goUserRequestDetail('+UQ_NO+');">'+
							'<div class="ui-block-a url_content">'+
								'<div class="url_title">'+title+'</div>'+
								'<p class="url_state_btn url_state_success">답변완료</p>'+
							'</div>'+
							'<div class="ui-block-b url_date">'+UQ_REGIDATE+'</div>'+ 
							'</div>';
				}
				$('#url_list_container').append(html);
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		} // end error
	});
}

function getNonmemberRequestList(nmID, nmPW){
	$('#url_list_container').empty();
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/user/get_nonmember_request_list.jsp',
		data: {
			nmID: nmID,
			nmPW: nmPW
		},
		async : false,
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$("#main_cont").html("문의하신 내역이 없습니다.<br>비회원 아이디와 비밀번호를 확인해주세요.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function(i){
				var UQ_NO = $(this).find('UQ_NO').text();
				var UQ_STATE = $(this).find('UQ_STATE').text();
				var UQ_TYPE = $(this).find('UQ_TYPE').text();
				var UQ_TITLE = $(this).find('UQ_TITLE').text();
				var UQ_CONTENT = $(this).find('UQ_CONTENT').text();
				var UQ_REGIDATE = $(this).find('UQ_REGIDATE').text();
				
				var title = '[' + UQ_TYPE + ']' + UQ_TITLE;
				
				var html;
				
				if(UQ_STATE == 'N'){
					//답변 대기
					html = '<div class="ui-grid-a url_list" onclick="goUserRequestDetail('+UQ_NO+');">'+
							'<div class="ui-block-a url_content">'+
								'<div class="url_title">'+title+'</div>'+
								'<p class="url_state_btn url_state_wait">답변대기</p>'+
							'</div>'+
							'<div class="ui-block-b url_date">'+UQ_REGIDATE+'</div>'+ 
							'</div>';
				} else {
					//답변 완료
					html = '<div class="ui-grid-a url_list" onclick="goUserRequestDetail('+UQ_NO+');">'+
							'<div class="ui-block-a url_content">'+
								'<div class="url_title">'+title+'</div>'+
								'<p class="url_state_btn url_state_success">답변완료</p>'+
							'</div>'+
							'<div class="ui-block-b url_date">'+UQ_REGIDATE+'</div>'+ 
							'</div>';
				}
				$('#url_list_container').append(html);
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		} // end error
	});
}

function getUserRequestDetail(uq_no){
	$('#urd_request_container').empty();
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/user/get_user_request_detail.jsp',
		data: {
			uq_no: uq_no
		},
		async : false,
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i){
				var UQ_NO = $(this).find('UQ_NO').text();
				var UQ_STATE = $(this).find('UQ_STATE').text();
				var UQ_TYPE = $(this).find('UQ_TYPE').text();
				var UQ_TITLE = $(this).find('UQ_TITLE').text();
				var UQ_CONTENT = $(this).find('UQ_CONTENT').text();
				var UQ_REGIDATE = $(this).find('UQ_REGIDATE').text();
				
				var title = '[' + UQ_TYPE + ']' + UQ_TITLE;
				
				UQ_CONTENT = changeLineBreak(UQ_CONTENT);
				
				var html = '<div class="ui-grid-a urd_title_container">'+
									'<div class="ui-block-a urd_title_content">'+
									'<p class="urd_title">'+title+'</p>'+
								'</div>'+
								'<div class="ui-block-b urd_title_content">'+
									'<p class="urd_date">'+UQ_REGIDATE+'</p>'+
									'<div id="urd_del_btn"><img src="/img/board/del.svg">삭제</div>'+
								'</div>'+
							'</div>'+
							'<div class="urd_content">'+UQ_CONTENT+'</div>';
				
				$('#urd_request_container').html(html);
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		} // end error
	});
}

function getUserAnswerDetail(uq_no){
	$('#urd_answer_container').hide();
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/user/get_user_answer_detail.jsp',
		data: {
			uq_no: uq_no
		},
		async : false,
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				return;
			}
			
			$(DATA).each(function(i){
				$('#urd_answer_container').show();
				
				var UQ_NO = $(this).find('UQ_NO').text();
				var UQ_TYPE = $(this).find('UQ_TYPE').text();
				var UQ_TITLE = $(this).find('UQ_TITLE').text();
				var UQ_CONTENT = $(this).find('UQ_CONTENT').text();
				var UQ_REGIDATE = $(this).find('UQ_REGIDATE').text();
				
				UQ_CONTENT = changeLineBreak(UQ_CONTENT);
				
				var html = '<div class="ui-grid-a urd_title_container">'+
								'<div class="ui-block-a urd_title_content">'+
									'<p class="urd_title">RE : '+UQ_TITLE+'</p>'+
								'</div>'+
								'<div class="ui-block-b urd_title_content">'+
									'<p class="urd_date">'+UQ_REGIDATE+'</p>'+
								'</div>'+
							'</div>'+
							'<div class="urd_content">'+UQ_CONTENT+'</div>';
				
				$('#urd_answer_container').html(html);
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		} // end error
	});
}