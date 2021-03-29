var tc_update_area;
$(document).on('pageinit', '#team_create_update', function() {
	var device_width = document.body.offsetWidth;
	device_width -= 50;
	var popup_width = device_width + 'px';
	$('#team_member_add_popup').css('width', popup_width);
	
	$('#tcreate_img').parents('.ui-corner-all').css('display', 'none');
	$('#tc_video_file').parents('.ui-corner-all').css('display', 'none');

	$('#t_content').textinput("option", "autogrow", false);
	$('#tc_video_textarea').textinput("option", "autogrow", false);
	
	$('#team_no').val(update_team_no);
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/team/get_team_create.jsp',
		data: {
			team_no: update_team_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			var DATA2 = $(ROOT).find('DATA2');
			
			$('#team_member_content').empty();
			
			$(DATA).each(function() {
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var TEAM_INTRO = $(this).find('TEAM_INTRO').text();
				var TEAM_PAY = $(this).find('TEAM_PAY').text();
				var CODE_GENRE = $(this).find('CODE_GENRE').text();
				var CODE_AREA = $(this).find('CODE_AREA').text();
				var TINTRO_IMG = $(this).find('TINTRO_IMG').text();
				var MAIN_GENRE = $(this).find('MAIN_GENRE').text();
				var GENRE_GUBUN = $(this).find('GENRE_GUBUN').text();
				
				//var t_img = '/upload/team/team' + TEAM_NO + "/" + TINTRO_IMG;
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
				//console.log(new_img);
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#img_preview').attr('src', value);
			     });
				
				//소개 동영상 관련
				var TVIDEO_THUMBNAIL = $(this).find('TVIDEO_THUMBNAIL').text();
				var TINTRO_VIDEO = $(this).find('TINTRO_VIDEO').text();
				var TVIDEO_CONTENT = $(this).find('TVIDEO_CONTENT').text();
				
				var tv_img = '/upload/team/team' + TEAM_NO + "/" + TVIDEO_THUMBNAIL;
				
				TEAM_PAY = addComma(TEAM_PAY);
				tc_update_area = CODE_AREA;
				
				$('#t_name').val(TEAM_NAME);
				$('#t_content').val(TEAM_INTRO);
				$('#t_pay').val(TEAM_PAY);
				
				$('#text_genre').val(CODE_GENRE);
				$('#select_genre').val(GENRE_GUBUN);
				$('#main_genre').val(MAIN_GENRE);
				
				sessionStorage.setItem('selectGenre', GENRE_GUBUN);
				
				if(TVIDEO_THUMBNAIL != ''){
					$("#tc_video_img").append('<img id="tc_video_img_src" style="width:100%;height:100%;display:inline-block;margin:0px auto;" onclick = "change_pic();">');
					$("#tc_video_img_src").attr('src', tv_img);
				}
				$('#tc_video_textarea').val(TVIDEO_CONTENT);
				$('#tc_video_url').val(TINTRO_VIDEO);
				
				$(DATA2).each(function(i) {
					var USER_NO = $(this).find('USER_NO').text();
					var ARTIST_NAME = $(this).find('ARTIST_NAME').text();
					var ARTIST_IMG = $(this).find('ARTIST_IMG').text();
					var USE_TOOL = $(this).find('USE_TOOL').text();
					var CODE_GENRE = $(this).find('CODE_GENRE').text();
					var LEADER_CHK = $(this).find('LEADER_CHK').text();
					
					//var a_img = '/upload/artist/artist'+ USER_NO +'/'+ARTIST_IMG;
					
					var new_img = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;
	                
				     var imgSrc = getImagePromise(new_img).then(value => {
						$('#aimg'+USER_NO).attr('src', value);
				     });
					
					var artist_tg = USE_TOOL + '&nbsp;|&nbsp;'+ CODE_GENRE;
					
					var team_member_content = '';
					
					if(LEADER_CHK == '1'){
						//나중에 팀 해체시 이부분 수정
						team_member_content = '<div class="team_member_content_body" id="'+USER_NO+'">'+
													'<div class="ui-grid-a" style="height: 100%;">'+
													'<div class="ui-block-a" style="width: 30%; height: 100%;">'+
														'<img id="aimg'+USER_NO+'">'+
													'</div>'+
													'<div class="ui-block-b team_member_content_con">'+
														'<div class="ui-grid-a">'+
															'<div class="ui-block-a tm_content_name">'+ARTIST_NAME+'</div>'+
															'<div class="ui-block-b tm_content_genre">'+artist_tg+'</div>'+
														'</div>'+
													'</div>'+
												'</div>'+
											'</div>';
					} else {
						team_member_content = '<div class="team_member_content_body" id="'+USER_NO+'">'+
													'<div class="ui-grid-a" style="height: 100%;">'+
													'<div class="ui-block-a" style="width: 30%; height: 100%;">'+
														'<img id="aimg'+USER_NO+'">'+
													'</div>'+
													'<div class="ui-block-b team_member_content_con">'+
														'<div class="ui-grid-a">'+
															'<div class="ui-block-a tm_content_name">'+ARTIST_NAME+'</div>'+
															'<div class="ui-block-b tm_content_genre">'+artist_tg+'</div>'+
														'</div>'+
													'</div>'+
													'<img id="tmcb_mem_del_btn" src="/img/team/cancle1.png">' +
												'</div>'+
											'</div>';
					}
					
					$('#team_member_content').append(team_member_content);
					
				}).promise().done(function (){
					var teamMemberCount = $('.team_member_content_body').length;
					$('#team_member_count').find('.ui-block-b').html('총 '+teamMemberCount+'명');
				});
				$.ajax({
					type: "GET",
					cache: false,
					url: '/service/common/get_area_code.jsp',
					contentType: "application/xml; charset=utf-8",
					dataType: "xml",
					timeout: 30000,
					success : function(data){
						var ROOT = $(data).find('ROOT');
						var DATA = $(ROOT).find('DATA');
						
						$(DATA).each(function(i) {
							var AREA_NAME = $(this).find("AREA_NAME").text();
							
							if(tc_update_area == AREA_NAME){
								area_select = '<option value="'+AREA_NAME+'" selected="selected">'+AREA_NAME+'</option>';
							}else{
								area_select = '<option value="'+AREA_NAME+'">'+AREA_NAME+'</option>';
							}
							
							$('#area-select').append(area_select);
							//$('#sc_area li:firstchild').css('font-weight', 'bold');
							$('#area-select').selectmenu("refresh", true);
							
					}).promise().done(function (){
						$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
					});
					},//end success
					error: function (xhr, message, errorThrown) {
						//hideLoading();
						infoTxtBox(xhr);
						infoTxtBox(message);
						infoTxtBox(errorThrown);
					} // end error
				});
			});
		},
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			//console.log(xhr);
			//console.log(message);
			//console.log(errorThrown);
		} // end error
	});
});

$(document).on('click', '#tmcb_mem_del_btn', function() {
	var user_no = $(this).parents('.team_member_content_body').attr('id');
	var team_no = update_team_no;
	
	var conf = confirm('해당 멤버를 탈퇴시키겠습니까 ?');
	
	if(!conf){
		return;
	}
	
	$(this).parents('.team_member_content_body').remove();
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/team/team_member_delete.jsp',
		data : {
			user_no : user_no,
			team_no : team_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
		
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		}, // end error
		complete: function(){
			var teamMemberCount = $('.team_member_content_body').length;
			$('#team_member_count').find('.ui-block-b').text('총 ' + teamMemberCount +'명');ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ
		}
	});
});