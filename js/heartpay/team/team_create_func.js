function go_team_create() {
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
			loadPage('team/team_create.jsp');
		}
	}
}

function go_team_create_status() {
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
			loadPage('team/team_create_status.jsp');
		}
	}
}

var update_team_no;
function go_team_create_update(req) {
	loadPage('team/team_create_update.jsp');
	$(document).on('pagecreate', '#team_create_update', function() {
		update_team_no = req;
	});
}


//정보 입력 후 등록 완료 버튼 클릭 시
function team_create_btn() {
	//팀 추가 부분
	var t_img = $('#img_name').val();
	var t_name = changeQuotes($('#t_name').val());
	var t_content = changeQuotes($('#t_content').val());
	var t_genre = $('#select_genre').val();
	var text_genre = $('#text_genre').val();
	var main_genre = $('#main_genre').val();
	var add_genre = $('#add_genre').val();
	var t_area = $('#area-select').val();
	var t_type = '';
	var t_pay = $('#t_pay').val();
	t_pay = t_pay.replace(/,/g, '');
	

	if(t_img === ''){
		alert('이미지를 등록해주세요.');
		return;
	} else if(t_name === ''){
		alert('팀명/솔로명을 입력해주세요.');
		$('#artist_name').focus();
		return;
	} else if(t_content === ''){
		alert('소개를 입력해주세요.');
		$('#artist_content').focus();
		return;
	} else if(t_genre === ''){
		alert('장르를 선택해주세요.');
		return;
	} else if(t_pay === ''){
		alert('희망 페이를 입력해주세요.');
		$('#t_pay').focus();
		return;
	}
	
	
	//소개 동영상 URL 업로드
	var tv_content = changeQuotes($('#tc_video_textarea').val());
	var tv_url = changeQuotes($('#tc_video_url').val());
	
	//소개 동영상 파일 업로드
	var video = $('#tc_video_file').val();
	video = video.split('\\');
	video = video[video.length-1];
	
	var tvShareChk = tv_url.split('#').length;
	
	if(tvShareChk > 1){
		tv_url = tv_url.split('#')[0];
	}

	if(tv_content != ''){
		if(tv_url == '' && video == ''){
			alert('유튜브 개별 동영상 URL 또는 동영상 파일을 등록해주세요.');
			return;
		}
	}
	
	if(tv_url != ''){
		if(tv_content.replace(/ /g, '') == ''){
			alert('간단한 동영상 소개를 입력해주세요!');
			return;
		}
		
		
		var tcVideoUrlChk = $('#tc_video_url').val().split('/');
		var tcYoutubeUrlChk = $('#tc_video_url').val().split('.');
		var youtubeChk = 0;
		for(var i = 0; i < tcYoutubeUrlChk.length; i++){
			if(tcYoutubeUrlChk[i] == 'youtube' || tcYoutubeUrlChk[i] == 'YOUTUBE' || 
					tcYoutubeUrlChk[i] == 'youtu' || tcYoutubeUrlChk[i] == 'YOUTU' || 
					tcYoutubeUrlChk[i] == 'http://youtube' || tcYoutubeUrlChk[i] == 'https://youtube' || 
					tcYoutubeUrlChk[i] == 'https://youtu' || tcYoutubeUrlChk[i] == 'http://youtu'){
				youtubeChk += 1;
			}
		}
		
		if(youtubeChk < 1){
			alert('유튜브 동영상만 등록 가능합니다!\n유튜브 개별 동영상 URL을 입력해주세요.');
			return;
		}
		
		for(var i = 0; i < tcVideoUrlChk.length; i++){
			if(tcVideoUrlChk[i] == 'channel' || tcVideoUrlChk[i] == 'Channel'){
				alert('유튜브 채널 URL은 등록 불가능합니다.\n유튜브 개별 동영상 URL을 등록해주세요!');
				return;
			}
		}
		
		var tvUrlTmp1 = tv_url.split('=').length;
		if(tvUrlTmp1 == 1){
			tv_url = tv_url.split('/');
			tv_url = tv_url[tv_url.length - 1];
			
			tv_url = 'https://www.youtube.com/embed/'+tv_url;
		} else {
			tv_url = tv_url.split('=');
			tv_url = tv_url[tv_url.length - 1];
			
			tv_url = 'https://www.youtube.com/embed/'+tv_url;
		}
	}
	
	if(video != ''){
		if(tv_content.replace(/ /g, '') == ''){
			alert('간단한 동영상 소개를 입력해주세요!');
			return;
		}
	}
	
	if(video != ''){
		var maxSize = 80 * 1024 * 1024;
		if(document.getElementById('tc_video_file').files[0].size >= maxSize){
			alert('동영상 사이즈는 80MB 이내로 등록 가능합니다').
			return;
		}
	}
	

	var newMemberLength = $('.new_team_member').length;
	var team_member = '';
	for(var i = 0; i < newMemberLength; i++){
		if(i == 0){
			team_member += $('.new_team_member').eq(i).attr('id');
		} else {
			team_member += ',' + $('.new_team_member').eq(i).attr('id');
		}
	}
	
	if(newMemberLength == 0){
		t_type = '1';
	} else {
		t_type = '2';
	}
	
	var team_no = $('#team_no').val();
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/team/team_info.jsp',
		data: {
			team_name: t_name
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length != 0){
				infoTxtBox('중복된 팀명입니다. 다시 입력해주세요');
				$('#t_name').val('');
				$('#t_name').focus();
				return; 
			}
			
			$.ajax({
				type: "POST",//url: "JSON/test.json",
				cache: false,
				url: '/service/team/team_create.jsp',
				data: {
					team_no: team_no,
					t_type: t_type,
					t_img: t_img,
					t_name: t_name,
					t_content: t_content,
					t_genre: t_genre,
					t_area: t_area,
					t_pay: t_pay,
					main_genre: main_genre,
					text_genre: text_genre,
					add_genre: add_genre,
					team_member: team_member,
					tv_content: tv_content,
					tv_url: tv_url,
					team_video: video
				},
				dataType: "xml",
				timeout: 30000,
				beforeSend: function(){
					$.mobile.loading( 'show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
				},
				success: function (data) {
					var ROOT = $(data).find("ROOT");
					var DATA = $(ROOT).find('DATA');
					if(DATA.length == 0){
						$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
						return;
					}
					
					$(DATA).each(function(i) {
						var RESULT = $(this).find('RESULT').text();
						var MESSAGE = $(this).find('MESSAGE').text();
						
						alert(MESSAGE);

						if(RESULT == 'false'){
							return;
						} else {
							$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
							//QR코드 신청 팝업 띄우기
							/*$(window).scrollTop(100);
							$("#qrRequestPopup").popup( "option" , "dismissible" , false);
							$("#qrRequestPopup" ).popup( "option", "overlayTheme", "b" );
							$("#qrRequestPopup" ).popup( "option", "positionTo", "window" );
							$('#qrRequestPopup').popup('open');
							$('#qrRequestPopup-screen').css('height', '100%');*/
							toHome();
						}
					});
				}, // end success
				error: function (xhr, message, errorThrown) {
					alert('잠시후 다시 시도해주세요.');
					$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
					return;
					//hideLoading();
				}, // end error
				complete: function(){
					sessionStorage.removeItem('selectGenre');
					sessionStorage.removeItem('selectGenreTemp');
					$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
				}
			});			
			
			$(DATA).each(function(i) {
		}).promise().done(function (){
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			alert('잠시후 다시 시도해주세요.');
			return;
		} // end error
	});
}

$(document).on('click', '.qrp_image2', function(){
	goQrRequest();
})

$(document).on('click', '.qrp_close_btn2', function(){
	loadPage('team/team_create_status.jsp');
});

//팀 수정버튼 눌렀을 때
function team_update_btn() {
	//팀 추가 부분
	$('#t_type').val($('.team_member_content_body').length);
	
	var team_no = $('#team_no').val();
	var t_img = $('#img_name').val();
	var t_name = changeQuotes($('#t_name').val());
	var t_content = changeQuotes($('#t_content').val());
	var t_genre = $('#select_genre').val();
	var main_genre = $('#main_genre').val();
	var text_genre = $('#text_genre').val();
	var t_area = $('#area-select').val();
	var t_type = '';
	var t_pay = $('#t_pay').val();
	t_pay = t_pay.replace(/,/g, '');
	
	if(t_name === ''){
		alert('팀명/솔로명을 입력해주세요.');
		$('#t_name').focus();
		return;
	} else if(t_content === ''){
		alert('팀소개를 입력해주세요.');
		$('#t_content').focus();
		return;
	} else if(t_genre === ''){
		alert('장르를 선택해주세요.');
		return;
	} else if(t_pay === ''){
		alert('희망 페이를 입력해주세요.');
		$('#t_pay').focus();
		return;
	}
	
	//소개 동영상 URL 업로드
	var tv_content = changeQuotes($('#tc_video_textarea').val());
	var tv_url = changeQuotes($('#tc_video_url').val());
	
	var tvShareChk = tv_url.split('#').length;
	
	if(tvShareChk > 1){
		tv_url = tv_url.split('#')[0];
	}
	
	
	//소개 동영상 파일 업로드
	var video = $('#tc_video_file').val();
	video = video.split('\\');
	video = video[video.length-1];
	
	
	if(tv_content != ''){
		if(tv_url == '' && video == ''){
			alert('유튜브 개별 동영상 URL 또는 동영상 파일을 등록해주세요.');
			return;
		}
	}
	
	if(tv_url != ''){
		if(tv_content.replace(/ /g, '') == ''){
			alert('간단한 동영상 소개를 입력해주세요!');
			return;
		}
		
		var tcVideoUrlChk = $('#tc_video_url').val().split('/');
		var tcYoutubeUrlChk = $('#tc_video_url').val().split('.');
		var youtubeChk = 0;
		for(var i = 0; i < tcYoutubeUrlChk.length; i++){
			if(tcYoutubeUrlChk[i] == 'youtube' || tcYoutubeUrlChk[i] == 'YOUTUBE' || 
					tcYoutubeUrlChk[i] == 'youtu' || tcYoutubeUrlChk[i] == 'YOUTU' || 
					tcYoutubeUrlChk[i] == 'http://youtube' || tcYoutubeUrlChk[i] == 'https://youtube' || 
					tcYoutubeUrlChk[i] == 'https://youtu' || tcYoutubeUrlChk[i] == 'http://youtu'){
				youtubeChk += 1;
			}
		}
		
		if(youtubeChk < 1){
			alert('유튜브 동영상만 등록 가능합니다!\n유튜브 개별 동영상 URL을 입력해주세요.');
			return;
		}
		
		for(var i = 0; i < tcVideoUrlChk.length; i++){
			if(tcVideoUrlChk[i] == 'channel' || tcVideoUrlChk[i] == 'Channel'){
				alert('유튜브 채널 URL은 등록 불가능합니다.\n유튜브 개별 동영상 URL을 등록해주세요!');
				return;
			}
		}
		
		var tvUrlTmp1 = tv_url.split('=').length;
		if(tvUrlTmp1 == 1){
			tv_url = tv_url.split('/');
			tv_url = tv_url[tv_url.length - 1];
			
			tv_url = 'https://www.youtube.com/embed/'+tv_url;
		} else {
			tv_url = tv_url.split('=');
			tv_url = tv_url[tv_url.length - 1];
			
			tv_url = 'https://www.youtube.com/embed/'+tv_url;
		}
	}
	
	if(video != ''){
		if(tv_content.replace(/ /g, '') == ''){
			alert('간단한 동영상 소개를 입력해주세요!');
			return;
		}
	}
	
	var newMemberLength = $('.new_team_member').length;
	var team_member = '';
	for(var i = 0; i < newMemberLength; i++){
		if(i == 0){
			team_member += $('.new_team_member').eq(i).attr('id');
		} else {
			team_member += ',' + $('.new_team_member').eq(i).attr('id');
		}
	}
	
	var teamChk = $('.team_member_content_body').length;
	
	if(teamChk == 1){
		t_type = '1';
	} else {
		t_type = '2';
	}

	
	/*console.log(t_img);
	console.log(t_name);
	console.log(t_content);
	console.log(t_genre);
	console.log(main_genre);
	console.log(text_genre);
	console.log(t_area);
	console.log(t_type);
	console.log(t_pay);
	console.log(add_genre);
	console.log(team_member);
	console.log(tv_content);
	console.log(tv_url);
	console.log(video);*/
	
	
	$.ajax({
		type: "GET",
		cache: false, 
		url: '/service/team/team_info.jsp',
		data: {
			team_name: t_name
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			var TEAM_NO = $(DATA).find('TEAM_NO').text();
			
			if(DATA.length != 0){
				if(update_team_no != TEAM_NO){
					infoTxtBox('중복된 팀명입니다. 다시 입력해주세요');
					$('#t_name').val('');
					$('#t_name').focus();
					return; 
				}
			}
			$.ajax({
				type: "POST",//url: "JSON/test.json",
				cache: false,
				url: '/service/team/team_create_update.jsp',
				data : {
					team_no: team_no,
					t_type: t_type,
					t_img: t_img,
					t_name: t_name,
					t_content: t_content,
					t_genre: t_genre,
					t_area: t_area,
					t_pay: t_pay,
					main_genre: main_genre,
					text_genre: text_genre,
					add_genre: '',
					team_member: team_member,
					tv_content: tv_content,
					tv_url: tv_url,
					team_video: video
				},
				dataType: "xml",
				beforeSend: function(){
					$.mobile.loading( 'show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
				},
				success: function (data) {
					var ROOT = $(data).find("ROOT");
					var DATA = $(ROOT).find('DATA');
					if(DATA.length == 0){
						$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
						return;
					}
					
					$(DATA).each(function() {
						var RESULT = $(this).find('RESULT').text();
						var MESSAGE = $(this).find('MESSAGE').text();
						
						alert(MESSAGE);
						
						if(RESULT == 'false'){
							return;
						} else {
							loadPage('team/team_create_status.jsp');
						}
						
					}).promise().done(function (){
						$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
					});
				}, // end success
				error: function (xhr, message, errorThrown) {
					alert('잠시후 다시 시도해주세요.');
					return;
					//hideLoading();
				}, // end error
				complete: function(){
					sessionStorage.removeItem('selectGenre');
					sessionStorage.removeItem('selectGenreTemp');
					$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
				}
			});			
			
		$(DATA).each(function(i) {
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
}

