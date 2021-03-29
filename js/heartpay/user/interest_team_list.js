$(document).on('pageinit', '#interest_team_list', function() {
	user_no = $('#user_no').val();
	//infoTxtBox(tno);
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/user/interest_team_list.jsp";
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data: {
			user_no : user_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			var DATA2 = $(ROOT).find('DATA2');
			
			if(DATA.length == 0){
				$('#int_team_list_body').empty();
				$('#int_team_list_body').html('<div id="main_cont" class="noViewBtn" style="display: inline-block;">관심 아티스트가 없습니다.</div>');
				return;
			}
			
			$('#int_team_list_body').empty();
			
			var l_count = 1;
			
			$(DATA).each(function(i) {
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var ALARM_CHK = $(this).find('ALARM_CHK').text();
				var CNT = $(this).find('CNT').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var TINTRO_IMG = $(this).find('TINTRO_IMG').text();
				
				//var t_img = '/upload/team/team'+ TEAM_NO +'/'+TINTRO_IMG;
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#img'+i).attr('src', value);
			     });
				
				var int_team_list_content = '<div class="int_team_list_'+l_count+'" id="int_team_list_content" >'+
												'<div class="ui-grid-b">'+
													'<div class="ui-block-a int_tlc_image" onclick="go_team_infoPage('+TEAM_NO+')">'+
														'<img id="img'+i+'">'+
													'</div>'+
													'<div class="ui-block-b int_tlc_content">'+
														'<div class="ui-grid-b int_tlc_content_box">'+
															'<div class="ui-block-a int_tlc_cb_content" onclick="go_team_infoPage('+TEAM_NO+')">'+
																'<div class="ui-grid-b">'+
																	'<div class="ui-block-a" id="int_team_name">'+
																		TEAM_NAME+
																	'</div>'+
																	'<div class="ui-block-b int_tlc_cbc_image">'+
																		'<img src="/img/detail_team/interesting_icon.svg">'+
																	'</div>'+
																	'<div class="ui-block-c int_tlc_cbc_count">'+
																		+CNT+
																	'</div>'+
																'</div>'+
															'</div>'+
															'<div class="ui-block-b" id="int_team_member" onclick="go_team_infoPage('+TEAM_NO+')"></div>'+
															'<div class="ui-block-c" id="interest_alarm_btn">'+
																	'<div class="ui-grid-a" id="interest_alarm_off_body">'+
																		'<div class="ui-block-a" id="interest_alarm_off_img">'+
																			'<img src="/img/detail_team/interest_alarm.svg">'+
																		'</div>'+
																		'<div class="ui-block-b" id="interest_alarm_off_text" onclick="int_alarm_onoff('+TEAM_NO+','+ALARM_CHK+','+l_count+')">'+
																			'<p>공연알람끔</p>'+
																		'</div>'+
																	'</div>'+
															'</div>'+
														'</div>'+
													'</div>'+
													'<div class="ui-block-c int_tlc_btn" onclick="go_team_infoPage('+TEAM_NO+')">'+
														'<img src="/img/common/show_btn.svg">'+
													'</div>'+
												'</div>'+
											'</div>';
				
				$('#int_team_list_body').append(int_team_list_content);
				
				//알람 온오프 여부 체크
				if(ALARM_CHK == 1){
					$('.int_team_list_'+l_count).find('#interest_alarm_off_body').attr('id', 'interest_alarm_on_body');
					$('.int_team_list_'+l_count).find('#interest_alarm_off_img').attr('id', 'interest_alarm_on_img');
					$('.int_team_list_'+l_count).find('#interest_alarm_off_text').attr('id', 'interest_alarm_on_text');
					$('.int_team_list_'+l_count).find('#interest_alarm_on_text').find('p').html('공연알람');
				}
				
				//팀원 부분 추가
				var artist_name_content = '';
				
				$(DATA2).each(function() {
					var ARTIST_NAME = $(this).find('ARTIST_NAME').text();
					
					if(TEAM_NO == $(this).find('TEAM_NO').text()){
						artist_name_content = artist_name_content + ARTIST_NAME + ', ';
					}
				});
				
				artist_name_content = artist_name_content.substr(0, artist_name_content.length-2);
				$('.int_team_list_'+l_count).find('#int_team_member').html(artist_name_content);

				
				l_count++;
			});
		},
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error 
	});
});

//관심 아티스트 알람 온오프!
function int_alarm_onoff(team_no, alarm_chk, l_count) {
	var user_no = $('#user_no').val();
	
	$.mobile.loading( 'hide', { text: 'loading', textVisible: false, theme: 'z', html: "" });
	var url = "/service/team/team_int_alarm.jsp";
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data: {
			user_no : user_no,
			team_no : team_no,
			alarm_chk : alarm_chk
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function() {
				//알람 온오프 여부 체크
				if(alarm_chk == 1){
					$('.int_team_list_'+l_count).find('#interest_alarm_on_body').attr('id', 'interest_alarm_off_body');
					$('.int_team_list_'+l_count).find('#interest_alarm_on_img').attr('id', 'interest_alarm_off_img');
					$('.int_team_list_'+l_count).find('#interest_alarm_on_text').attr('id', 'interest_alarm_off_text');
					$('.int_team_list_'+l_count).find('#interest_alarm_off_text').attr('onclick', 'int_alarm_onoff('+team_no+',0,'+l_count+')');
					$('.int_team_list_'+l_count).find('#interest_alarm_off_text').find('p').html('공연알람끔');
				}
				else{
					$('.int_team_list_'+l_count).find('#interest_alarm_off_body').attr('id', 'interest_alarm_on_body');
					$('.int_team_list_'+l_count).find('#interest_alarm_off_img').attr('id', 'interest_alarm_on_img');
					$('.int_team_list_'+l_count).find('#interest_alarm_off_text').attr('id', 'interest_alarm_on_text');
					$('.int_team_list_'+l_count).find('#interest_alarm_on_text').attr('onclick', 'int_alarm_onoff('+team_no+',1,'+l_count+')');
					$('.int_team_list_'+l_count).find('#interest_alarm_on_text').find('p').html('공연알람');
				}
			});
				
		},
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error 
	});
};

//페이지 이동
function go_interest_team_list() {
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		loadPage('user/interest_team_list.jsp');
	}
}
