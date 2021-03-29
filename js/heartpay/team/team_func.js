function goTeamMediaRegPage(){
	if(userLogin_chk() == false){
		alert('로그인 하시고 해당 서비스를 이용해주세요.');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
		} else {
			loadPage('team/team_media_reg.jsp');
		}
	}
}

function getTeamPicture(team_no){
	$('#team_info_list').empty();
	
	var html = '<div class="ui-grid-a tmi_picture_list">'+
					'<div class="ui-block-a tmi_picture_content" id="tmi_pc_left">'+
					'</div>'+
					'<div class="ui-block-b tmi_picture_content" id="tmi_pc_right">'+
					'</div>'+
				'</div>';
	
	$('#team_info_list').html(html);
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/get_team_picture.jsp',
		data: {
			team_no : team_no
		},
		async : false,
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$('#main_cont').html('해당 팀의 사진이 없습니다.');
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else {
				$('#main_cont').hide();
			}
			
			$(DATA).each(function(i){
				var TM_URL = $(this).find('TM_URL').text();
				//var imgSrc = '/upload/team/team'+ team_no +'/'+TM_URL;
				
				var new_img = 'upload/images/team/team' + team_no + "/" + TM_URL;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
			    	 $('#tmi_picture_img_'+i).attr('src', value);
			     });
				
				if(i == 0 || i%2 == 0){
					$('#tmi_pc_left').append('<img class="tmi_picture_img" id="tmi_picture_img_'+i+'">');
				} else {
					$('#tmi_pc_right').append('<img class="tmi_picture_img" id="tmi_picture_img_'+i+'">');
				}
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		} // end error
	});
}

function getTeamVideo(team_no){
	$('#team_info_list').empty();
	
	var html = '<div class="ui-grid-a tmi_video_list" id="tmi_video_list">'+
				'</div>';
	
	$('#team_info_list').html(html);
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/get_team_video.jsp',
		data: {
			team_no : team_no
		},
		async : false,
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$('#main_cont').html('해당 팀의 동영상이 없습니다.');
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else {
				$('#main_cont').hide();
			}
			
			$(DATA).each(function(i){
				var TM_URL = $(this).find('TM_URL').text();
				var TM_CONTENT = $(this).find('TM_CONTENT').text();
				
				if(TM_CONTENT != '' && TM_CONTENT != null){
					TM_CONTENT = TM_CONTENT.replace(/\n/g, '<br>');
					TM_CONTENT = TM_CONTENT.replace(/\r/g, '<br>');
					//이부분 수정해야함
					TM_CONTENT = TM_CONTENT.replace(/\\\"/g, '\\\\\"');
					TM_CONTENT = TM_CONTENT.replace(/\\\'/g, '\\\\\'');
				}
				
				var v_img_list = TM_URL.split('/');
				var v_img = v_img_list[4];
				v_img = 'https://img.youtube.com/vi/' + v_img + '/1.jpg';
				
				if(i == 0 || i%2 == 0){
					var html = '<div class="ui-block-a tmi_video_content" onclick="show_teamInfoVideo(\''+TM_URL+'\', \''+TM_CONTENT+'\');">'+
									'<img class="tmi_video_play" src="/img/common/video_play.svg">'+
									'<img class="tmi_thumnail" src="'+v_img+'">'+
									'<div class="tmi_video_text">'+TM_CONTENT+'</div>'+
								'</div>';
				} else {
					var html = '<div class="ui-block-b tmi_video_content" onclick="show_teamInfoVideo(\''+TM_URL+'\', \''+TM_CONTENT+'\');">'+
									'<img class="tmi_video_play" src="/img/common/video_play.svg">'+
									'<img class="tmi_thumnail" src="'+v_img+'">'+
									'<div class="tmi_video_text">'+TM_CONTENT+'</div>'+
								'</div>';
				}
				
				$('#tmi_video_list').append(html);
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		} // end error
	});
	
}

function getTeamPictureReg(team_no){
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/get_team_picture.jsp',
		data: {
			team_no : team_no
		},
		async : false,
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i){
				var TM_URL = $(this).find('TM_URL').text();
				//var imgSrc = '/upload/team/team'+ team_no +'/'+TM_URL;
				
				$('.tmr_picture_block').eq(i).attr('id', TM_URL);
				//$('.tmr_picture_block').eq(i).find('.tmr_picture').attr('src', imgSrc);
				$('.tmr_picture_block').eq(i).find('.tmr_picture').show();
				$('.tmr_picture_block').eq(i).find('.tmr_picture_del_btn').show();
				
				
				var new_img = 'upload/images/team/team' + team_no + "/" + TM_URL;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
			    	 const target = document.getElementById(TM_URL);
			    	 target.children[1].src = value;
			     });
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		} // end error
	});
}

function getTeamVideoReg(team_no){
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/get_team_video.jsp',
		data: {
			team_no : team_no
		},
		async : false,
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i){
				var TM_URL = $(this).find('TM_URL').text();
				var TM_CONTENT = $(this).find('TM_CONTENT').text();
				
				if(i == 0){
					$('.tmr_video').eq(0).find('.tmr_video_link').val(TM_URL);
					$('.tmr_video').eq(0).find('.tmr_video_content').val(TM_CONTENT);
				} else {
					var html = '<div class="tmr_video">'+
									'<div class="tmr_video_del_btn">'+
										'<img src="/img/team/img_del.svg">'+
									'</div>'+
								'<input type="text" class="tmr_video_link" placeholder="동영상 링크를 입력해주세요(유튜브 링크만 가능)">'+
								'<textarea rows="3" cols="" class="tmr_video_content" placeholder="동영상 소개를 입력해주세요"></textarea>'+
								'</div>';
					
					$('.tmr_video_container').append(html);
					
					$('.tmr_video').eq(i).find('.tmr_video_link').val(TM_URL);
					$('.tmr_video').eq(i).find('.tmr_video_content').val(TM_CONTENT);
				}
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		} // end error
	});
}

function resetTeamMediaReg(){
	var imgLength = $('.tmr_picture_block').length;
	for(var i = 0; i < imgLength; i++){
		$('.tmr_picture_block').eq(i).removeAttr('id');
		$('.tmr_picture_block').eq(i).find('.tmr_picture').removeAttr('src');
		$('.tmr_picture_block').eq(i).find('.tmr_picture').hide();
		$('.tmr_picture_block').eq(i).find('.tmr_picture_del_btn').hide();
	}
	
	var videoLength = $('.tmr_video').length;
	
	$('.tmr_video').eq(0).find('.tmr_video_link').val('');
	$('.tmr_video').eq(0).find('.tmr_video_content').val('');
	
	if(videoLength != 1){
		for(var i = 1; i < videoLength; i++){
			$('.tmr_video').eq(1).remove();
		}
	}
}

function teamInfoBackBtn(){
	var tBackCount = sessionStorage.getItem('tBackCount');

	if(tBackCount == null){
		history.go(-1);
	} else {
		var tBackCountText = '-' + tBackCount;
		sessionStorage.removeItem('tBackCount');
		history.go(tBackCountText);
	}
}

//협업 QR 스캔 이벤트 DB연동
function qrEventChk(tno){
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/event/qr_event_chk.jsp',
		data: {
			tno : tno
		},
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i){
				var CNT = $(this).find('CNT').text();
				
				if(CNT != '0'){
					alert('이미 참여한 공연이거나, 당첨 이력이 있는 경우 재참여가 불가합니다.');
					return;
				} else {
					qrEventSet(tno);
				}
			});
		}
	});
}

function qrEventSet(tno){
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/event/qr_event.jsp',
		data: {
			tno : tno
		},
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i){
				var WINNING = $(this).find('WINNING').text();
				var EVIP = $(this).find('EVIP').text();
				
				if(WINNING == 'Y'){
					$('#event_winning_popup').show();
					$('#wepc_ip').val(EVIP);
					return;
				} else {
					$('#event_whack_popup').show();
					return;
				}
			});
		}
	});
}

function goTeamInfoMediaBtn(){
	$('#Go_MediaBtn').click();
	$('#tmi_video').click();
}

function sendReplyAddPush(no){
	const team_no = sessionStorage.getItem('TNO');
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/pushService/team_reply_push.jsp',
		data: {
			no: no,
			team_no: team_no
		},
		dataType: "xml",
		timeout: 30000,
		complete: function (data) {
			alert('댓글이 등록되었습니다.');
			$('#pf_reply_content').val('');
			getTeamReplyList();
			return;
		}
	});
}

function handlerTeamReplyAdd(){
	const no = createRandomNum();
	const team_no = sessionStorage.getItem('TNO');
	const content = $('#pf_reply_content').val();
	
	var login_chk = userLogin_chk();
	if(login_chk == false){
		alert('로그인 후 댓글입력이 가능합니다.');
		return;
	}
	
	if(blankChk(content) === ''){
		alert('댓글을 입력해주세요.');
		$('#pf_reply_content').val('');
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/set_team_reply.jsp',
		data: {
			no: no,
			team_no: team_no,
			content: content
		},
		dataType: "xml",
		timeout: 30000,
		complete: function (data) {
			sendReplyAddPush(no);
		}
	});
}

function delTeamReply(no) {
	var conf = confirm('댓글을 삭제하시겠습니까 ?');
	if(!conf){
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/del_team_reply.jsp',
		data: {
			no: no
		},
		dataType: "xml",
		timeout: 30000,
		complete: function (data) {
			getTeamReplyList();
			return;
		}
	});
}

function handlerTeamRereplyAdd(parent){
	const no = createRandomNum();
	const team_no = sessionStorage.getItem('TNO');
	const content = $('#pd_re_reply_content_'+parent).val();
	
	var login_chk = userLogin_chk();
	if(login_chk == false){
		alert('로그인 후 댓글입력이 가능합니다.');
		return;
	}
	
	if(blankChk(content) === ''){
		alert('답글을 입력해주세요.');
		$('#pd_re_reply_content_'+parent).val('');
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/set_team_rereply.jsp',
		data: {
			no: no,
			parent: parent,
			team_no: team_no,
			content: content
		},
		dataType: "xml",
		timeout: 30000,
		complete: function (data) {
			alert('답글이 등록되었습니다.');
			$('#pd_re_reply_content_'+parent).val('');
			getTeamReplyList();
			return;
		}
	});
}

function getTeamReplyList(){
	const team_no = sessionStorage.getItem('TNO');
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/get_team_reply.jsp',
		data : {
			team_no : team_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#pd_reply_body').empty();
			
			if(DATA.length == 0){
				$('#pd_reply_body').html('<p class="pd_zero_count_text">해당 팀에 등록된 댓글이 없습니다. 댓글을 달아보세요!</p>');
				$('#pd_total_count').html(0);
				return;
			}
			
			$(DATA).each(function() {
				var NO = $(this).find('NO').text();
				var CONTENT = $(this).find('CONTENT').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				var REGDATE = $(this).find('REGDATE').text().split(' ')[0];
				var ALLCNT = $(this).find('ALLCNT').text();
				var MYCHK = $(this).find('MYCHK').text();
				var RECNT = $(this).find('RECNT').text();
				
				var html = '<div class="pd_re_container" id="'+NO+'">'+
								'<div class="pd_re_body">'+
								'<p class="pd_re_title">'+CONTENT+'</p>'+
								
								'<div class="ui-grid-b pd_re_info">'+
									'<div class="ui-block-a pd_re_info_name">'+NICKNAME+' | '+REGDATE+'</div>';
							if(RECNT == 0){
								html += '<div class="ui-block-b pd_re_info_rebtn">답글달기</div>';
							} else {
								html += '<div class="ui-block-b pd_re_info_rebtn">답글'+RECNT+'개</div>';
							}
				
								html += '<div class="ui-block-c pd_re_info_delbtn_div">';
								
								if(MYCHK === '1'){
									html += '<div class="dt_re_del_btn" onclick="delTeamReply(\''+NO+'\');">삭제 <img src="/img/common/close.png"></div>';
								}
								
								html += '</div>'+
								'</div>'+
							'</div>'+
							'<div class="pd_re_re_body">'+
								'<div class="ui-grid-a pd_re_re_inputbox">'+
									'<div class="ui-block-a pd_re_re_inputdiv">'+
										'<input class="pd_re_re_input" id="pd_re_reply_content_'+NO+'" placeholder="답글을 작성해주세요">'+
									'</div>'+
									
									'<div class="ui-block-b" id="dt_re_re_input_btn" onclick="handlerTeamRereplyAdd(\''+NO+'\');">등록</div>'+
								'</div>';
								
								$.ajax({
									type: "GET",//url: "JSON/test.json",
									cache: false,
									url: '/service/team/get_team_rereply.jsp',
									data : {
										team_no : team_no,
										no : NO
									},
									contentType: "application/xml; charset=utf-8",
									dataType: "xml",
									timeout: 30000,
									async : false,
									success: function (data) {
										var ROOT = $(data).find('ROOT');
										var DATA = $(ROOT).find('DATA');
										
										if(DATA.length == 0){
											return;
										}
										
										$(DATA).each(function(){
											var NO = $(this).find('NO').text();
											var CONTENT = $(this).find('CONTENT').text();
											var REGDATE = $(this).find('REGDATE').text().split(' ')[0];
											var NICKNAME = $(this).find('NICKNAME').text();
											
											html += '<div class="pd_re_re_container">'+
														'<p class="pd_re_re">┗ '+CONTENT+' <a id="pd_rere_closebtn">닫기</a></p>'+
														'<span class="pd_re_re_detail">'+
															'<a class="pd_re_re_name">'+NICKNAME+' | '+ REGDATE +'</a>'+
														'</span>'+
													'</div>';
										});
									}
								});
								
								
							html += '</div>'+
						'</div>';
				
				$('#pd_reply_body').append(html);
				$('#pd_total_count').html(ALLCNT);
			});
		}
	});
}