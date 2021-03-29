function go_bw_list() {
	if(userLogin_chk() == false){
		alert('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
		} else {
			loadPage('user/board_write_list.jsp');
		}
	}
}

var board_list_count;

//작성한 게시판 목록 불러오기
function get_board_list() {
	var user_no = $('#user_no').val();
	var sort = $('#bw_header_sort').text();
	
	board_list_count = 0;
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		chach : false,
		url: '/service/user/get_board_list.jsp',
		data : {
			user_no : user_no,
			board_list_count : board_list_count,
			sort : sort
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#bw_body').empty();
			
			if(DATA.length == 0){
				$("#main_cont").text("내용이 없습니다.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else if(DATA.length == 10){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "get_board_reList()");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").css('display', 'inline-block');
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function() {
				var BOARD_NO = $(this).find('BOARD_NO').text();
				var BOARD_HITS = $(this).find('BOARD_HITS').text();
				var CNT = $(this).find('CNT').text();
				var BOARD_TITLE = $(this).find('BOARD_TITLE').text();
				var BOARD_CATEGORY = $(this).find('BOARD_CATEGORY').text();
				var BOARD_DATE = $(this).find('BOARD_DATE').text();
				var BOARD_DEL = $(this).find('BOARD_DEL').text();
				
				if(BOARD_DEL == 'Y'){
					var bw_body = '<div class="ui-grid-a bw_content">'+
							  		'<div class="ui-block-a bw_content_title delete_board_text">삭제된 글입니다.</div>'+
							  			'<div class="ui-block-b bw_content_div">'+
							  				'<div class="ui-grid-c bw_content_subject">'+
							  					'<div class="ui-block-a bw_content_date">'+BOARD_DATE+'</div>'+
							  					'<div class="ui-block-b bw_content_viewcount">조회수:'+BOARD_HITS+'</div>'+
							  					'<div class="ui-block-c bw_content_img"><img src="/img/board/reply.png"></div>'+
							  					'<div class="ui-block-d bw_content_replycount">'+CNT+'</div>'+
							  				'</div>'+
							  			'</div>'+
							  		'</div>';
					
					$('#bw_body').append(bw_body);
				}
				else{
					if(BOARD_CATEGORY == "1"){
						BOARD_CATEGORY = '일반'
					}
					else if(BOARD_CATEGORY == "2"){
						BOARD_CATEGORY = '팀모집'
					}
					if(BOARD_CATEGORY == "3"){
						BOARD_CATEGORY = '함께공연'
					}
					
					var bw_body = '<div class="ui-grid-a bw_content" onclick="team_board_view_load('+BOARD_NO+')">'+
							  		'<div class="ui-block-a bw_content_title">['+BOARD_CATEGORY+']'+BOARD_TITLE+'</div>'+
							  			'<div class="ui-block-b bw_content_div">'+
							  				'<div class="ui-grid-c bw_content_subject">'+
							  					'<div class="ui-block-a bw_content_date">'+BOARD_DATE+'</div>'+
							  					'<div class="ui-block-b bw_content_viewcount">조회수:'+BOARD_HITS+'</div>'+
							  					'<div class="ui-block-c bw_content_img"><img src="/img/board/reply.png"></div>'+
							  					'<div class="ui-block-d bw_content_replycount">'+CNT+'</div>'+
							  				'</div>'+
							  			'</div>'+
							  		'</div>';
					
					$('#bw_body').append(bw_body);
				}
			});
		}
	});
}


//게시글 목록 더보기
function get_board_reList() {
	var user_no = $('#user_no').val();
	var sort = $('#bw_header_sort').text();
	
	board_list_count += 10;
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		chach : false,
		url: '/service/user/get_board_list.jsp',
		data : {
			user_no : user_no,
			board_list_count : board_list_count,
			sort : sort
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 10){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "get_board_reList()");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").css('display', 'inline-block');
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function() {
				var BOARD_NO = $(this).find('BOARD_NO').text();
				var BOARD_HITS = $(this).find('BOARD_HITS').text();
				var CNT = $(this).find('CNT').text();
				var BOARD_TITLE = $(this).find('BOARD_TITLE').text();
				var BOARD_CATEGORY = $(this).find('BOARD_CATEGORY').text();
				var BOARD_DATE = $(this).find('BOARD_DATE').text();
				var BOARD_DEL = $(this).find('BOARD_DEL').text();
				
				if(BOARD_DEL == 'Y'){
					var bw_body = '<div class="ui-grid-a bw_content">'+
							  		'<div class="ui-block-a bw_content_title delete_board_text">삭제된 글입니다.</div>'+
							  			'<div class="ui-block-b bw_content_div">'+
							  				'<div class="ui-grid-c bw_content_subject">'+
							  					'<div class="ui-block-a bw_content_date">'+BOARD_DATE+'</div>'+
							  					'<div class="ui-block-b bw_content_viewcount">조회수:'+BOARD_HITS+'</div>'+
							  					'<div class="ui-block-c bw_content_img"><img src="/img/board/reply.png"></div>'+
							  					'<div class="ui-block-d bw_content_replycount">'+CNT+'</div>'+
							  				'</div>'+
							  			'</div>'+
							  		'</div>';
					
					$('#bw_body').append(bw_body);
				}
				else{
					if(BOARD_CATEGORY == "1"){
						BOARD_CATEGORY = '일반'
					}
					else if(BOARD_CATEGORY == "2"){
						BOARD_CATEGORY = '팀모집'
					}
					if(BOARD_CATEGORY == "3"){
						BOARD_CATEGORY = '함께공연'
					}
					
					var bw_body = '<div class="ui-grid-a bw_content" onclick="team_board_view_load('+BOARD_NO+')">'+
							  		'<div class="ui-block-a bw_content_title">['+BOARD_CATEGORY+']'+BOARD_TITLE+'</div>'+
							  			'<div class="ui-block-b bw_content_div">'+
							  				'<div class="ui-grid-c bw_content_subject">'+
							  					'<div class="ui-block-a bw_content_date">'+BOARD_DATE+'</div>'+
							  					'<div class="ui-block-b bw_content_viewcount">조회수:'+BOARD_HITS+'</div>'+
							  					'<div class="ui-block-c bw_content_img"><img src="/img/board/reply.png"></div>'+
							  					'<div class="ui-block-d bw_content_replycount">'+CNT+'</div>'+
							  				'</div>'+
							  			'</div>'+
							  		'</div>';
					
					$('#bw_body').append(bw_body);
				}
				
			});
		}
	});
}

//작성한 댓글 목록 불러오기
function get_reply_list() {
	var user_no = $('#user_no').val();
	
	board_list_count = 0;
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		chach : false,
		url: '/service/user/get_reply_list.jsp',
		data : {
			user_no : user_no,
			board_list_count : board_list_count,
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#bw_body').empty();
			
			if(DATA.length == 0){
				$("#main_cont").text("내용이 없습니다.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else if(DATA.length == 10){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "get_reply_reList()");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").css('display', 'inline-block');
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function() {
				var BOARD_NO = $(this).find('BOARD_NO').text();
				var BOARD_TITLE = $(this).find('BOARD_TITLE').text();
				var BOARD_CATEGORY = $(this).find('BOARD_CATEGORY').text();
				var BOARD_DEL = $(this).find('BOARD_DEL').text();
				var BOARD_REPLY_CONTENT = $(this).find('BOARD_REPLY_CONTENT').text();
				var BOARD_REPLY_DEL = $(this).find('BOARD_REPLY_DEL').text();
				
				if(BOARD_DEL == 'Y'){
					var bw_body = '<div class="ui-grid-a bw_content">'+
							  		'<div class="ui-block-a bw_content_title">'+BOARD_REPLY_CONTENT+'</div>'+
							  			'<div class="ui-block-b bw_content_div">'+
							  				'<div class="bw_content_subject">'+
							  					'<div class="bw_content_reply delete_board_text">삭제된 글입니다.</div>'+
							  				'</div>'+
							  			'</div>'+
							  		'</div>';
					
					$('#bw_body').append(bw_body);
				}
				else{
					if(BOARD_REPLY_DEL == 'Y'){
						if(BOARD_CATEGORY == "1"){
							BOARD_CATEGORY = '일반'
						}
						else if(BOARD_CATEGORY == "2"){
							BOARD_CATEGORY = '팀모집'
						}
						if(BOARD_CATEGORY == "3"){
							BOARD_CATEGORY = '함께공연'
						}
						
						var bw_body = '<div class="ui-grid-a bw_content" onclick="team_board_view_load('+BOARD_NO+')">'+
								  		'<div class="ui-block-a bw_content_title delete_board_text">삭제된 글입니다.</div>'+
								  			'<div class="ui-block-b bw_content_div">'+
								  				'<div class="bw_content_subject">'+
								  					'<div class="bw_content_reply">['+BOARD_CATEGORY+']'+BOARD_TITLE+'</div>'+
								  				'</div>'+
								  			'</div>'+
								  		'</div>';
						
						$('#bw_body').append(bw_body);
					}
					else{
						if(BOARD_CATEGORY == "1"){
							BOARD_CATEGORY = '일반'
						}
						else if(BOARD_CATEGORY == "2"){
							BOARD_CATEGORY = '팀모집'
						}
						if(BOARD_CATEGORY == "3"){
							BOARD_CATEGORY = '함께공연'
						}
						
						var bw_body = '<div class="ui-grid-a bw_content" onclick="team_board_view_load('+BOARD_NO+')">'+
								  		'<div class="ui-block-a bw_content_title">'+BOARD_REPLY_CONTENT+'</div>'+
								  			'<div class="ui-block-b bw_content_div">'+
								  				'<div class="bw_content_subject">'+
								  					'<div class="bw_content_reply">['+BOARD_CATEGORY+']'+BOARD_TITLE+'</div>'+
								  				'</div>'+
								  			'</div>'+
								  		'</div>';
						
						$('#bw_body').append(bw_body);
					}
				}
			});
		}
	});
}


//댓글 목록 다시 불러오기
function get_reply_reList() {
	var user_no = $('#user_no').val();
	
	board_list_count += 10;
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		chach : false,
		url: '/service/user/get_reply_list.jsp',
		data : {
			user_no : user_no,
			board_list_count : board_list_count,
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 10){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "get_reply_reList()");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").css('display', 'inline-block');
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function() {
				var BOARD_NO = $(this).find('BOARD_NO').text();
				var BOARD_TITLE = $(this).find('BOARD_TITLE').text();
				var BOARD_CATEGORY = $(this).find('BOARD_CATEGORY').text();
				var BOARD_DEL = $(this).find('BOARD_DEL').text();
				var BOARD_REPLY_CONTENT = $(this).find('BOARD_REPLY_CONTENT').text();
				var BOARD_REPLY_DEL = $(this).find('BOARD_REPLY_DEL').text();
				
				if(BOARD_NO == 'Y'){
					var bw_body = '<div class="ui-grid-a bw_content">'+
							  		'<div class="ui-block-a bw_content_title">'+BOARD_REPLY_CONTENT+'</div>'+
							  			'<div class="ui-block-b bw_content_div">'+
							  				'<div class="bw_content_subject">'+
							  					'<div class="bw_content_reply delete_board_text">삭제된 글입니다.</div>'+
							  				'</div>'+
							  			'</div>'+
							  		'</div>';
					
					$('#bw_body').append(bw_body);
				}
				else{
					if(BOARD_REPLY_DEL == 'Y'){
						if(BOARD_CATEGORY == "1"){
							BOARD_CATEGORY = '일반'
						}
						else if(BOARD_CATEGORY == "2"){
							BOARD_CATEGORY = '팀모집'
						}
						if(BOARD_CATEGORY == "3"){
							BOARD_CATEGORY = '함께공연'
						}
						
						var bw_body = '<div class="ui-grid-a bw_content" onclick="team_board_view_load('+BOARD_NO+')">'+
								  		'<div class="ui-block-a bw_content_title delete_board_text">삭제된 글입니다.</div>'+
								  			'<div class="ui-block-b bw_content_div">'+
								  				'<div class="bw_content_subject">'+
								  					'<div class="bw_content_reply">['+BOARD_CATEGORY+']'+BOARD_TITLE+'</div>'+
								  				'</div>'+
								  			'</div>'+
								  		'</div>';
						
						$('#bw_body').append(bw_body);
					}
					else{
						if(BOARD_CATEGORY == "1"){
							BOARD_CATEGORY = '일반'
						}
						else if(BOARD_CATEGORY == "2"){
							BOARD_CATEGORY = '팀모집'
						}
						if(BOARD_CATEGORY == "3"){
							BOARD_CATEGORY = '함께공연'
						}
						
						var bw_body = '<div class="ui-grid-a bw_content" onclick="team_board_view_load('+BOARD_NO+')">'+
								  		'<div class="ui-block-a bw_content_title">'+BOARD_REPLY_CONTENT+'</div>'+
								  			'<div class="ui-block-b bw_content_div">'+
								  				'<div class="bw_content_subject">'+
								  					'<div class="bw_content_reply">['+BOARD_CATEGORY+']'+BOARD_TITLE+'</div>'+
								  				'</div>'+
								  			'</div>'+
								  		'</div>';
						
						$('#bw_body').append(bw_body);
					}
				}
			});
		}
	});
}