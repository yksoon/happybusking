//팀 현황보기 페이지
$(document).on('pageinit', '#team_create_status', function() {
	var user_no = $('#user_no').val();
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/team_create_status.jsp',
		data : {
			user_no : user_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			var DATA2 = $(ROOT).find('DATA2');
			
			if(DATA.length == 0){
				var noContent = '<div id="main_cont" class="noViewBtn">팀 · 솔로 등록 내역이 없습니다.</div>';
				$('#tc_create_status_container').html(noContent);
				return;
			}
			
			$('#tc_create_status_container').empty();
			
			$(DATA).each(function() {
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var LEADER_CHK = $(this).find('LEADER_CHK').text();
				
				var team_cs_header = '<div class="ui-grid-a team_cs_header">'+
										'<div class="ui-block-a team_cs_name">'+
											TEAM_NAME +
										'</div>'+
										'<div class="ui-block-b team_cs_go_history" id="'+TEAM_NO+'" onclick="go_team_create_update('+TEAM_NO+')">'+
										'</div>'+
									'</div>';
				
				$('#tc_create_status_container').append(team_cs_header);
				
				if(LEADER_CHK == 1){
					$('#' + TEAM_NO).text('팀·솔로 수정');
				}
				else{
					$('#' + TEAM_NO).css('display', 'none');
				}
				
				$('#tc_create_status_container').append('<div class="team_cs_liner"></div>');
				
				var team_no_temp = TEAM_NO;
				$(DATA2).each(function() {
					var TEAM_NO = $(this).find('TEAM_NO').text();
					var USER_NO = $(this).find('USER_NO').text();
					var ARTIST_NAME = $(this).find('ARTIST_NAME').text();
					var MEMBER_REQ_STATUS = $(this).find('MEMBER_REQ_STATUS').text();
					var ARTIST_IMG = $(this).find('ARTIST_IMG').text();
					var CODE_GENRE = $(this).find('CODE_GENRE').text();
					var USE_TOOL = $(this).find('USE_TOOL').text();
					
					//var a_img = '/upload/artist/artist'+ USER_NO +'/'+ARTIST_IMG;
					
					 var new_img = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;
		                
				     var imgSrc = getImagePromise(new_img).then(value => {
						$('#'+TEAM_NO+USER_NO).attr('src', value);
				     });
					
					var artist_tg = USE_TOOL + '&nbsp;|&nbsp;'+ CODE_GENRE;
					
					if(team_no_temp == TEAM_NO){
					
					var team_cs_content = '<div class="team_cs_body">'+
											'<div class="ui-grid-a team_cs_content">'+
												'<div class="ui-block-a t_cs_content_img">'+
												'<img id="'+TEAM_NO+USER_NO+'">'+
											'</div>'+
											'<div class="ui-block-b t_cs_content_subject">'+
												'<div class="ui-grid-a">'+
													'<div class="ui-block-a t_cs_content_name">'+ARTIST_NAME+'</div>'+
													'<div class="ui-block-b t_cs_content_genre">'+artist_tg+'</div>'+
												'</div>'+
											'</div>'+
											'<div class="ui-block-c t_cs_content_btn" id="'+TEAM_NO+'_'+USER_NO+'">'+
											'</div>'+
										'</div>';
						$('#tc_create_status_container').append(team_cs_content);
					
					var btn_content;
					
					if(MEMBER_REQ_STATUS == '2'){
						btn_content = '<div class="t_cs_success_btn">수락완료</div>';
					}
					else if(MEMBER_REQ_STATUS == '3'){
						btn_content = '<div class="t_cs_refusal_btn">거절</div>';
					}
					else if(MEMBER_REQ_STATUS == '1'){
						if(user_no == USER_NO){
							btn_content = '<div class="ui-grid-a" style="display: inline-block;">'+
												'<div class="ui-block-a t_cs_accept_btn">수락</div>'+
												'<div class="ui-block-b t_cs_refuse_btn">거절</div>'+
											'</div>';
						}
						else{
							btn_content = '<div class="t_cs_proceeding_btn">요청중</div>';
						}
					}
					
					$('#'+TEAM_NO+'_'+USER_NO).append(btn_content);
					}
				});
				$('#tc_create_status_container').append('<div class="team_cs_body_footer"></div>');
			});
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			console.log("code:"+xhr+"\n"+"message:"+message+"\n"+"error:"+errorThrown);
			return;
		} // end error 
	});
});

//수락버튼 눌렀을 때
$(document).on('click', '.t_cs_accept_btn', function() {
	var result = confirm('수락 하시겠습니까 ?');
	if(result){
		
	}
	else{
		return;
	}
	var team_no_user_no = $(this).parents('.t_cs_content_btn').attr('id');
	var team_no = team_no_user_no.split('_')[0];
	var user_no = team_no_user_no.split('_')[1];
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/team_create_status_update.jsp',
		data : {
			team_no : team_no,
			user_no : user_no,
			member_seq_status : '2'
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			$.mobile.changePage(window.location.href, {
				allowSamePageTransition : true,
				transition : 'none',
				showLoadMsg : false,
				reloadPage : true
			});
		},
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			console.log("code:"+xhr+"\n"+"message:"+message+"\n"+"error:"+errorThrown);
			return;
		} // end error 
	});
});

//거절버튼 눌렀을 때
$(document).on('click', '.t_cs_refuse_btn', function() {
	var result = confirm('거절 하시겠습니까 ?');
	if(result){
		
	}
	else{
		return;
	}
	
	var team_no_user_no = $(this).parents('.t_cs_content_btn').attr('id');
	var team_no = team_no_user_no.split('_')[0];
	var user_no = team_no_user_no.split('_')[1];
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/team_create_status_update.jsp',
		data : {
			team_no : team_no,
			user_no : user_no,
			member_seq_status : '3'
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			$.mobile.changePage(window.location.href, {
				allowSamePageTransition : true,
				transition : 'none',
				showLoadMsg : false,
				reloadPage : true
			});
		},
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			console.log("code:"+xhr+"\n"+"message:"+message+"\n"+"error:"+errorThrown);
			return;
		} // end error 
	});
});