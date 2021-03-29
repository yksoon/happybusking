var board_no_temp;
function go_team_board(bc) {
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
			return;
		} else {
			board_category = bc;
			var currentPage_url = window.location.href;	//현재 페이지
			if(currentPage_url == 'https://www.happybusking.com/app_root/jsp/team_board/team_board.jsp'){
				var tbBackCount = sessionStorage.getItem('tbBackCount');
				if(tbBackCount == null){
					sessionStorage.setItem('tbBackCount', '2');
				} else {
					tbBackCount = (tbBackCount * 1) + 1;
					sessionStorage.setItem('tbBackCount', tbBackCount);
				}
				
				$.mobile.changePage(
					currentPage_url, {
						allowSamePageTransition : true,
					    transition              : 'none',
					    showLoadMsg             : false,
					    reloadPage              : true
					}
				);
			} else {
				loadPage('team_board/team_board.jsp');
			}
		}
	}
}

function teamBoardBackBtn(){
	var tbchk = sessionStorage.getItem('tbchk');
	var tbBackCount = sessionStorage.getItem('tbBackCount');
	if(tbchk == 'yes'){
		if(tbBackCount == null){
			history.go(-3);
			sessionStorage.removeItem('tbchk');
		} else {
			tbBackCount = parseInt(tbBackCount) + 3;
			var tbBackText = '-' + tbBackCount;
			sessionStorage.removeItem('tbchk');
			sessionStorage.removeItem('tbBackCount');
			history.go(tbBackText);
		}
	} else {
		if(tbBackCount == null){
			history.go(-1);
		} else {
			var tbBackText = '-' + tbBackCount;
			sessionStorage.removeItem('tbBackCount');
			history.go(tbBackText);
		}
	}
}

function teamBoardDetailBackBtn(){
	var tbdchk = sessionStorage.getItem('tbdchk');
	if(tbdchk == 'yes'){
		history.go(-3);
		sessionStorage.removeItem('tbdchk');
	} else {
		history.go(-1);
	}
}

function go_team_board_write() {
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
		} else {
			loadPage('team_board/team_board_write.jsp');
		}
	}
}

function stop_imgRotate(){
	$('#reply_refresh').removeClass('imgRotate');
	$('#board_refresh_btn').removeClass('imgRotate');
	
}

//게시글 상세보기로 이동
function team_board_view_load(board_no) {
	add_board_hits(board_no);
	board_no_temp = board_no;
	loadPage('team_board/team_board_view.jsp');
}

function team_board_load(){
	var url = '/service/team_board/team_board.jsp';
	
	var tbLimit = sessionStorage.getItem('tbLimit');
	var tbLast = 10;
	
	if(tbLimit === null || tbLimit === 'null'){
		tbLimit = 0;
		sessionStorage.setItem('tbLimit', tbLimit);
	} else {
		tbLast = parseInt(tbLimit) + 10;	
		tbLimit = 0;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data : {
			board_category : board_category,
			team_board_sort : team_board_sort,
			tb_search : tb_search_temp,
			start : tbLimit,
			end: tbLast
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			
			$('#team_board_body').empty();
			
			if(DATA.length == 0){
				$("#main_cont").text("게시글이 없습니다.");
				return;
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function(i) {
				var BOARD_NO = $(this).find("BOARD_NO").text();
				var USER_NO = $(this).find("USER_NO").text();
				var BOARD_DATE = $(this).find("BOARD_DATE").text();
				var BOARD_HITS = $(this).find("BOARD_HITS").text();
				var BOARD_TITLE = $(this).find("BOARD_TITLE").text();
				var BOARD_CONTENT = $(this).find("BOARD_CONTENT").text();
				var BOARD_DEL = $(this).find("BOARD_DEL").text();
				var CODE_DECLARE = $(this).find("CODE_DECLARE").text();
				var CNT = $(this).find("CNT").text();
				var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
				var ARTIST_IMG = $(this).find("ARTIST_IMG").text();
				
				//var a_img = '/upload/artist/artist'+ USER_NO +'/'+ARTIST_IMG;
				
				var new_img = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('.board_profile_'+USER_NO).attr('src', value);
			     });
				
				BOARD_DATE = BOARD_DATE.substring(0, 16);
				
				if(BOARD_DEL != 'Y'){
					var team_board_body = '<div class="team_board_content" onclick="team_board_view_load('+BOARD_NO+');">'+
								  			'<div class="ui-grid-b" style="height: 100%;">'+
							  				'<div class="ui-block-a" style="width: 15%; height: 51px; margin-top: 7px;">'+
							  					'<img class="board_profile_'+USER_NO+'" style="width: 100%; height: 100%; border-radius:10px;" >'+
							  				'</div>'+
							  				'<div class="ui-block-b" style="width: 65%;">'+
							  					'<div class="ui-grid-b board_subject">'+
							  						'<div class="ui-block-a board_subject_writer" style="width: 100%;">'+ARTIST_NAME+'</div>'+
							  						'<div class="ui-block-b board_subject_title" style="width: 100%;">'+BOARD_TITLE+'</div>'+
							  						'<div class="ui-block-c board_subject_footer" style="width: 100%;">'+
							  							'<div class="ui-grid-a">'+
							  								'<div class="ui-block-a" style="width: 47%">'+BOARD_DATE+'</div>'+
							  								'<div class="ui-block-b">조회수:'+BOARD_HITS+'</div>'+
							  							'</div>'+
							  						'</div>'+
							  					'</div>'+
							  				'</div>'+
							  				'<div class="ui-block-c board_display">'+
							  					'<div class="ui-grid-c">'+
							  						'<div class="ui-block-a">'+
							  						'</div>'+
							  						'<div class="ui-block-b">'+
							  						'</div>'+
							  						'<div class="ui-block-c">'+
							  							'<img src="/img/board/reply.png">'+
							  						'</div>'+
							  						'<div class="ui-block-d">'+
							  							'<p>'+CNT+'</p>'+
							  						'</div>'+
							  					'</div>'+
							  				'</div>'+
							  			'</div>'+
							  		'</div>';
					
					$('#team_board_body').append(team_board_body);
				}
				
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });	
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error 
	});
}

//게시판에서 더보기
function more_team_baord_load(){
	var url = '/service/team_board/team_board.jsp';
	
	var tbLimit = sessionStorage.getItem('tbLimit');
	
	if(tbLimit === null || tbLimit === 'null'){
		tbLimit = 10;
	} else {
		tbLimit = parseInt(tbLimit) + 10;
	}
	sessionStorage.setItem('tbLimit', tbLimit);
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data : {
			board_category : board_category,
			team_board_sort : team_board_sort,
			tb_search : tb_search_temp,
			start : tbLimit,
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				return;
			} 

			$(DATA).each(function(i) {
				var BOARD_NO = $(this).find("BOARD_NO").text();
				var USER_NO = $(this).find("USER_NO").text();
				var BOARD_DATE = $(this).find("BOARD_DATE").text();
				var BOARD_HITS = $(this).find("BOARD_HITS").text();
				var BOARD_TITLE = $(this).find("BOARD_TITLE").text();
				var BOARD_CONTENT = $(this).find("BOARD_CONTENT").text();
				var BOARD_DEL = $(this).find("BOARD_DEL").text();
				var CODE_DECLARE = $(this).find("CODE_DECLARE").text();
				var CNT = $(this).find("CNT").text();
				var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
				var ARTIST_IMG = $(this).find("ARTIST_IMG").text();
				
				var a_img = '/upload/artist/artist'+ USER_NO +'/'+ARTIST_IMG;
				
				BOARD_DATE = BOARD_DATE.substring(0, 16);
				
				if(BOARD_DEL != 'Y'){
					var team_board_body = '<div class="team_board_content" onclick="team_board_view_load('+BOARD_NO+');">'+
								  			'<div class="ui-grid-b" style="height: 100%;">'+
							  				'<div class="ui-block-a" style="width: 15%; height: 100%;">'+
							  					'<img class="board_profile" src="'+a_img+'">'+
							  				'</div>'+
							  				'<div class="ui-block-b" style="width: 65%;">'+
							  					'<div class="ui-grid-b board_subject">'+
							  						'<div class="ui-block-a board_subject_writer" style="width: 100%;">'+ARTIST_NAME+'</div>'+
							  						'<div class="ui-block-b board_subject_title" style="width: 100%;">'+BOARD_TITLE+'</div>'+
							  						'<div class="ui-block-c board_subject_footer" style="width: 100%;">'+
							  							'<div class="ui-grid-a">'+
							  								'<div class="ui-block-a" style="width: 47%">'+BOARD_DATE+'</div>'+
							  								'<div class="ui-block-b">조회수:'+BOARD_HITS+'</div>'+
							  							'</div>'+
							  						'</div>'+
							  					'</div>'+
							  				'</div>'+
							  				'<div class="ui-block-c board_display">'+
							  					'<div class="ui-grid-c">'+
							  						'<div class="ui-block-a">'+
							  						'</div>'+
							  						'<div class="ui-block-b">'+
							  						'</div>'+
							  						'<div class="ui-block-c">'+
							  							'<img src="/img/board/reply.png">'+
							  						'</div>'+
							  						'<div class="ui-block-d">'+
							  							'<p>'+CNT+'</p>'+
							  						'</div>'+
							  					'</div>'+
							  				'</div>'+
							  			'</div>'+
							  		'</div>';
					
					$('#team_board_body').append(team_board_body);
				}
				
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });	
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error 
	});
}

//게시글 상세 불러오기
function load_team_board_reply() {
	$('#team_board_reply_update').hide();
	$('#team_board_reply_write').hide();
	$('#team_board_reply_view').show();
	
	var BOARD_REPLY_NO;
	var uno = $('#user_no').val();
	
	var url = '/service/team_board/team_board_view.jsp'; 
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data : {
			board_no : board_no_temp
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			var DATA2 = $(ROOT).find('DATA2');
			var DATA3 = $(ROOT).find('DATA3');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				return;
			}
			
			var comment_count = 1;
			
			$(DATA).each(function(i) {
				comment_count = 1;
				
				var reply_view_count = 1;
				
				var USER_NO = $(this).find("USER_NO").text();
				var BOARD_NO = $(this).find("BOARD_NO").text();
				var BOARD_DATE = $(this).find("BOARD_DATE").text();
				var BOARD_HITS = $(this).find("BOARD_HITS").text();
				var BOARD_TITLE = $(this).find("BOARD_TITLE").text();
				var BOARD_CONTENT = $(this).find("BOARD_CONTENT").text();
				//var CODE_DECLARE = $(this).find("CODE_DECLARE").text();
				var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
				var BOARD_CATEGORY = $(this).find("BOARD_CATEGORY").text();

				BOARD_CONTENT = changeLineBreak(BOARD_CONTENT);
				
				var CNT = $(this).find("CNT").text();
				
				BOARD_DATE = BOARD_DATE.substring(0, 16);
				
				if(BOARD_CATEGORY == "1"){
					BOARD_CATEGORY = '일반';
					$('#team_board_view_title_a').css('width', '13%');
				}
				else if(BOARD_CATEGORY == "2"){
					BOARD_CATEGORY = '팀모집';
					$('#team_board_view_title_a').css('width', '17%');
				}
				else{
					BOARD_CATEGORY = '함께공연';
				}
				
				$('#team_board_view_title').empty();
				var team_board_view_title = '<div class="ui-block-a" style="width: 100%;">'+
												'<div class="ui-grid-a">'+
													'<div class="ui-block-a" id="team_board_view_title_a">['+BOARD_CATEGORY+']</div>'+
													'<div class="ui-block-b" id="team_board_view_title_b">'+BOARD_TITLE+'</div>'+
												'</div>'+
											'</div>'+
											'<div class="ui-block-b tb_vc_container">'+
												'<div class="ui-grid-d">'+
													'<div class="ui-block-a" id="team_board_view_title_c">'+BOARD_DATE+'</div>'+
													'<div class="ui-block-b" id="team_board_view_title_d">조회수:'+BOARD_HITS+'</div>'+
													'<div class="ui-block-c" id="team_board_view_title_e">'+ARTIST_NAME+'</div>'+
													'<div class="ui-block-d tb_u_btn" id="team_board_view_title_f" onclick="tb_update('+BOARD_NO+')">'+
														'<div class="ui-grid-a">'+
															'<div class="ui-block-a">'+
																'<img src="/img/board/modi.svg">'+
															'</div>'+
															'<div class="ui-block-b tb_d_btn_text">'+
																'수정'+
															'</div>'+
														'</div>'+
													'</div>'+
													'<div class="ui-block-e tb_d_btn" id="team_board_view_title_f" onclick="tb_delete('+BOARD_NO+')">'+
														'<div class="ui-grid-a">'+
															'<div class="ui-block-a">'+
																'<img src="/img/board/del.svg">'+
															'</div>'+
															'<div class="ui-block-b tb_d_btn_text">'+
																'삭제'+
															'</div>'+
														'</div>'+
													'</div>'+
												'</div>'+
											'</div>';
				$('#team_board_view_title').append(team_board_view_title);
				
				$('#team_board_view_content').html(BOARD_CONTENT);
				
				if(uno != USER_NO){
					$('.tb_u_btn').hide();
					$('.tb_d_btn').hide();
				}
				
				if(BOARD_CATEGORY == '일반'){
					$('#team_board_view_title_a').css('width', '13%');
				}
				else if(BOARD_CATEGORY == '팀모집'){
					$('#team_board_view_title_a').css('width', '17%');
				}			
				
				$('#tb_reply_view_header_a').text('댓글' + CNT + '개');
				
				$('#tb_reply_view_body').empty();
				
				$(DATA2).each(function(i) {
					//첫번째 답글에만 '닫기'버튼을 추가하기 위한 COUNT
					var close_count = 1;
					var USER_NO = $(this).find("USER_NO").text();
					var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
					var BOARD_REPLY_DATE = $(this).find("BOARD_REPLY_DATE").text();
					var BOARD_REPLY_CONTENT = $(this).find("BOARD_REPLY_CONTENT").text();
					var BOARD_REPLY_DEL = $(this).find("BOARD_REPLY_DEL").text();
					var CNT = $(this).find("CNT").text();
					var CODE_DECLARE = $(this).find("CODE_DECLARE").text();
					BOARD_REPLY_NO = $(this).find("BOARD_REPLY_NO").text();
					
					BOARD_REPLY_DATE = BOARD_REPLY_DATE.substring(0, 16);
					
					BOARD_REPLY_CONTENT = changeLineBreak(BOARD_REPLY_CONTENT);
					
					if(BOARD_REPLY_DEL == 'Y'){
						var tb_reply_view_content = '<div class="tb_reply_view_cc" id="tb_reply_view_cc'+reply_view_count+'">'+
													'<div class="tb_reply_view_content tb_rvc_no'+USER_NO+'" id="tb_reply_view_content">'+
														'<div class="ui-grid-b tb_rvc_container">'+
															'<div class="ui-block-a" id="tb_reply_content_a">'+ARTIST_NAME+'</div>'+
															'<div class="ui-block-b delete_board_text" id="tb_reply_content_b">삭제된 댓글입니다.</div>'+
															'<div class="ui-block-c" id="tb_reply_content_c">'+
																'<div class=" ui-grid-d">'+
																	'<div class="ui-block-a" id="tb_reply_content_d">'+BOARD_REPLY_DATE+'</div>'+
																	'<div class="ui-block-b" id="tb_reply_content_e">신고</div>'+
																	'<div class="ui-block-c tb_reply_content_f" id="'+BOARD_REPLY_NO+'">답글 '+CNT+'개</div>'+
																	'<div class="ui-block-d tb_reply_content_update" id="u_'+BOARD_REPLY_NO+'"></div>'+
																	'<div class="ui-block-e tb_reply_content_delete" id="d_'+BOARD_REPLY_NO+'" onclick="tb_comment_delete('+BOARD_REPLY_NO+')"></div>'+
																'</div>'+
															'</div>'+
														'</div>'+
													'</div>';
					}
					else{
						var tb_reply_view_content = '<div class="tb_reply_view_cc" id = "tb_reply_view_cc'+reply_view_count+'">'+
													'<div class="tb_reply_view_content tb_rvc_no'+USER_NO+'" id="tb_reply_view_content">'+
														'<div class="ui-grid-b tb_rvc_container">'+
															'<div class="ui-block-a" id="tb_reply_content_a">'+ARTIST_NAME+'</div>'+
															'<div class="ui-block-b" id="tb_reply_content_b">'+BOARD_REPLY_CONTENT+'</div>'+
															'<div class="ui-block-c" id="tb_reply_content_c">'+
																'<div class=" ui-grid-d">'+
																	'<div class="ui-block-a" id="tb_reply_content_d">'+BOARD_REPLY_DATE+'</div>'+
																	'<div class="ui-block-b" id="tb_reply_content_e">신고</div>'+
																	'<div class="ui-block-c tb_reply_content_f" id="'+BOARD_REPLY_NO+'">답글 '+CNT+'개</div>'+
																	'<div class="ui-block-d tb_reply_content_update" id="u_'+BOARD_REPLY_NO+'" onclick="tb_reply_update('+BOARD_REPLY_NO+')">'+
																		'<div class="ui-grid-a">'+
																			'<div class="ui-block-a">'+
																				'<img src="/img/board/modi.svg">'+
																			'</div>'+
																			'<div class="ui-block-b tb_rc_btn_text">'+
																				'수정'+
																			'</div>'+
																		'</div>'+
																	'</div>'+
																	'<div class="ui-block-e tb_reply_content_delete" id="d_'+BOARD_REPLY_NO+'" onclick="tb_comment_delete('+BOARD_REPLY_NO+')">'+
																		'<div class="ui-grid-a">'+
																			'<div class="ui-block-a">'+
																				'<img src="/img/board/del.svg">'+
																			'</div>'+
																			'<div class="ui-block-b tb_rc_btn_text">'+
																				'삭제'+
																			'</div>'+
																		'</div>'+
																	'</div>'+
																'</div>'+
															'</div>'+
														'</div>'+
													'</div>';
					}
					
					$('#tb_reply_view_body').append(tb_reply_view_content);
					
					if(uno != USER_NO){
						$('#u_' + BOARD_REPLY_NO).hide();
						$('#d_' + BOARD_REPLY_NO).hide();
					}
					else{
						$('.tb_rvc_no'+USER_NO).addClass('replyIWorte');
						
					}
					
					$(DATA3).each(function(i) {
						var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
						var BOARD_COMMENT_DATE = $(this).find("BOARD_REPLY_DATE").text();
						var BOARD_REPLY_CONTENT = $(this).find("BOARD_REPLY_CONTENT").text();
						var BOARD_REPLY_DEL = $(this).find("BOARD_REPLY_DEL").text();
						var PARENT = $(this).find("PARENT").text();
						var USER_NO = $(this).find("USER_NO").text();
						var CODE_DECLARE = $(this).find("CODE_DECLARE").text();
						
						var COMMENT_NO = $(this).find("BOARD_REPLY_NO").text();
						BOARD_COMMENT_DATE = BOARD_COMMENT_DATE.substring(0, 16);
						
						BOARD_REPLY_CONTENT = changeLineBreak(BOARD_REPLY_CONTENT);
						
						if(BOARD_REPLY_NO == PARENT){
							if(BOARD_REPLY_DEL == 'Y'){
								var tb_comment_view_content = '<div class="tb_comment_view_content'+comment_count+' tb_cv_no'+USER_NO+'" id="tb_comment_view_content">'+
																'<div class="ui-grid-b tb_cvc_container">'+
																	'<div class="ui-block-a" id="tb_reply_content_a">'+
																		'<div class="ui-grid-b">'+
																			'<div class="ui-block-a tb_cvc_commontext">└</div>'+
																			'<div class="ui-block-b tb_cvc_aname">'+ARTIST_NAME+'</div>'+
																			'<div class="ui-block-c comment_close" id="comment_close"></div>'+
																		'</div>'+
																	'</div>'+
																	'<div class="ui-block-b delete_board_text" id="tb_reply_content_b">삭제된 답글입니다.</div>'+
																	'<div class="ui-block-c" id="tb_reply_content_c">'+
																		'<div class=" ui-grid-c">'+
																			'<div class="ui-block-a" id="tb_reply_content_d">'+BOARD_COMMENT_DATE+'</div>'+
																			'<div class="ui-block-b" id="tb_reply_content_e" >신고</div>'+
																			'<div class="ui-block-d tb_reply_content_delete" id="d_'+COMMENT_NO+'" onclick="tb_comment_delete('+COMMENT_NO+')"></div>'+
																		'</div>'+
																	'</div>'+
																'</div>'+
															'</div>';
							}
							else{
								var tb_comment_view_content = '<div class="tb_comment_view_content'+comment_count+' tb_cv_no'+USER_NO+'" id="tb_comment_view_content">'+
																	'<div class="ui-grid-b tb_cvc_container">'+
																		'<div class="ui-block-a" id="tb_reply_content_a">'+
																			'<div class="ui-grid-b">'+
																				'<div class="ui-block-a tb_cvc_commontext">└</div>'+
																				'<div class="ui-block-b tb_cvc_aname">'+ARTIST_NAME+'</div>'+
																				'<div class="ui-block-c comment_close" id="comment_close"></div>'+
																			'</div>'+
																		'</div>'+
																		'<div class="ui-block-b" id="tb_reply_content_b">'+BOARD_REPLY_CONTENT+'</div>'+
																		'<div class="ui-block-c" id="tb_reply_content_c">'+
																			'<div class=" ui-grid-c">'+
																				'<div class="ui-block-a" id="tb_reply_content_d">'+BOARD_COMMENT_DATE+'</div>'+
																				'<div class="ui-block-b" id="tb_reply_content_e" >신고</div>'+
																				'<div class="ui-block-d tb_reply_content_delete" id="d_'+COMMENT_NO+'" onclick="tb_comment_delete('+COMMENT_NO+')">'+
																					'<div class="ui-grid-a">'+
																						'<div class="ui-block-a">'+
																							'<img src="/img/board/del.svg">'+
																						'</div>'+
																						'<div class="ui-block-b">'+
																							'삭제'+
																						'</div>'+
																					'</div>'+
																				'</div>'+
																			'</div>'+
																		'</div>'+
																	'</div>'+
																'</div>';
							}
							
							$('#tb_reply_view_cc'+reply_view_count).append(tb_comment_view_content);
							
							if(uno != USER_NO){
								$('#d_' + COMMENT_NO).hide();
							}
							else{
								$('.tb_cv_no'+USER_NO).addClass('replyIWorte');
							}
						//첫번째 닫글에만 '닫기' 표시
						if(close_count == 1){
							$('.comment_close').text('닫기');
						}
						close_count++;
						}
					});
					
					//답글 달기 div 추가
					var tb_comment_write = '<div class="ui-grid-a tb_comment_write" id="tb_comment_write'+reply_view_count+'">'+
												'<div class="ui-block-a tb_comment_write_content">'+
													'<textarea rows="3" cols="" placeholder="답글을 작성해주세요." class="tb_comment_write_area"></textarea>'+
												'</div>'+
												'<div class="ui-block-b tb_commtent_write_btn">'+
													'<a>등록</a>'+
												'</div>'+
											'</div>';
					$('#tb_reply_view_cc'+reply_view_count).append(tb_comment_write);
					
					close_count = 1;
					comment_count++;
					reply_view_count++;
				});
				
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });	
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error 
	});
}

//게시글 수정 버튼 클릭시
function tb_update(no) {
	sessionStorage.setItem('bupdateNo', no);
	loadPage('team_board/team_board_update.jsp');
}

//게시글 삭제 버튼 클릭시
function tb_delete(no) {
	confirmBox('해당 글을 삭제하시겠습니까 ? ', function() {
		$.ajax({
			type: "GET",//url: "JSON/test.json",
			url: '/service/team_board/team_board_delete.jsp',
			data : {
				board_no: no
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success: function (data) {
			},
			complete: function(){
				alert('해당 글이 삭제되었습니다.');
				history.go(-1);
			}
		});
	});
}

//댓글 수정 버튼 클릭시
function tb_reply_update(no) {
	$('#team_board_reply_view').hide();
	$('#team_board_reply_update').show();
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		url: '/service/team_board/get_team_board_reply.jsp',
		data : {
			board_reply_no: no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function() {
				var BOARD_REPLY_CONTENT = $(this).find('BOARD_REPLY_CONTENT').text();
				$('#tb_reply_update_area').val(BOARD_REPLY_CONTENT);
				$('#tb_reply_update_btn').attr('class' , no);
			});
		},
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			console.log("code:"+xhr+"\n"+"message:"+message+"\n"+"error:"+errorThrown);	
		} // end error 
	});
}

//댓글, 답글 삭제
function tb_comment_delete(no) {
	confirmBox('해당 글을 삭제하시겠습니까 ? ', function() {
		$.ajax({
			type: "GET",//url: "JSON/test.json",
			url: '/service/team_board/team_board_rDelete.jsp',
			data : {
				board_reply_no: no
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success: function (data) {
			},
		});
		infoTxtBox('해당 글이 삭제되었습니다.');
		load_team_board_reply();
	});
};

//게시글 클릭시 조회수 1증가
function add_board_hits(board_no) {
	var url = '/service/team_board/add_board_hits.jsp';
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		chach : false,
		url: url,
		data : {
			board_no: board_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
		}
	});
}