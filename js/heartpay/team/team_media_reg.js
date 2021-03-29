$(document).on('pageinit', '#team_media_reg', function(){
	$('.tmr_video_content').textinput("option", "autogrow", false);
	$('#tmr_tselect').empty();
	//사진 동영상 등록/수정 페이지 생성시 팀 선택 option 추가
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/common/get_team_select.jsp',
		async : false,
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				var html = '<option value="" disabled selected>가입된 팀이 없습니다.</option>';
				$('#tmr_tselect').append(html);
				$('span.tmr_tselect').text('가입된 팀이 없습니다.');
				return;
			}
			
			$(DATA).each(function(i){
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var html;
				
				if(i == 0){
					html = '<option value="" disabled selected>팀을 선택해주세요.</option>';
					$('span.tmr_tselect').text('팀을 선택해주세요.');
					$('#tmr_tselect').append(html);
				}
				html = '<option value="'+TEAM_NO+'">'+TEAM_NAME+'</option>';
				$('#tmr_tselect').append(html);
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		} // end error
	});
});

//팀 선택시
$(document).on('change', '#tmr_tselect', function(){
	var team_no = $('#tmr_tselect').val();
	if(team_no == null || team_no == 'null' || team_no == ''){
		alert('팀을 선택해주세요.');
		return;
	}
	
	//team_media 테이블에서 select 된 값 불러오기
	resetTeamMediaReg();
	getTeamPictureReg(team_no);
	getTeamVideoReg(team_no);
});

//사진 추가버튼 클릭시
$(document).on('click' , '#tmr_picture_add_btn', function(){
	var team_no = $('#tmr_tselect').val();
	if(team_no == null || team_no == 'null' || team_no == ''){
		alert('팀을 선택해주세요.');
		return;
	}
	
	$('#tmr_image').click();
});

//이미지 변경시
$(document).on('change', '#tmr_image', function(){
	var team_no = $('#tmr_tselect').val();
	if(team_no == null || team_no == 'null' || team_no == ''){
		alert('팀을 선택해주세요.');
		return;
	}
	
	const path = 'images/team/team'+team_no;
	uploadManyFile('tmr_image', 'tmr_picture', path, function(url, filename){
		const $target = $('.tmr_picture_block');
		const leng = $target.length;
		let emptyChk = '';
		
		for(var i=0; i<leng; i++){
			emptyChk = $('.tmr_picture_block').eq(i).attr('id');
			
			if(emptyChk === undefined || emptyChk === 'undefined' || emptyChk === ''){
				$('.tmr_picture_block').eq(i).find('.tmr_picture').attr('src', url);
				$('.tmr_picture_block').eq(i).find('.tmr_picture').show();
				$('.tmr_picture_block').eq(i).attr('id', filename);
				$('.tmr_picture_block').eq(i).find('.tmr_picture_del_btn').show();  
				break;
			}
		}
	});
	
	/*const fileInput = document.getElementById('tmr_image');
	const files = fileInput.files;
	let file;
	
	for(var i=0; i < files.length; i++){
		file = files[i];
		console.log(file.name);
	}*/
	
	/*var imgLength = $('.tmr_picture_block').length;

	var fileInput = document.getElementById('tmr_image');
	
	var files = fileInput.files;

	var file_name;
	var img_url;

	
	for(var i = 0; i < files.length; i++){
		formData.append('tmr_image_'+i , files[i]);
	}
	
	
	for(var i = 0; i < files.length; i++){
		file_name = files[i].name;
		img_url = URL.createObjectURL(files[i]);
		
		for(var j = 0; j < imgLength; j++){
			var emptychk = $('.tmr_picture_block').eq(j).attr('id');
			if(emptychk == 'undefined' || emptychk == undefined || emptychk == ''){
				$('.tmr_picture_block').eq(j).find('.tmr_picture').attr('src', img_url);
				$('.tmr_picture_block').eq(j).find('.tmr_picture').show();
				$('.tmr_picture_block').eq(j).attr('id', file_name);
				$('.tmr_picture_block').eq(j).find('.tmr_picture_del_btn').show();
				
				break;
			}
		}
	}*/
});

//이미지 X버튼 클릭시
$(document).on('click', '.tmr_picture_del_btn', function(){
	$(this).parents('.tmr_picture_block').attr('id', '');
	$(this).parents('.tmr_picture_block').find('.tmr_picture').removeAttr('src');
	$(this).parents('.tmr_picture_block').find('.tmr_picture').hide();
	$(this).parents('.tmr_picture_block').find('.tmr_picture_del_btn').hide();
});

//동영상 추가 버튼 클릭시
$(document).on('click', '#tmr_video_add_btn', function(){
	var team_no = $('#tmr_tselect').val();
	if(team_no == null || team_no == 'null' || team_no == ''){
		alert('팀을 선택해주세요.');
		return;
	}
	
	var videoLength = $('.tmr_video').length;
	
	if(videoLength >= 10){
		alert('최대 10개까지만 추가 가능합니다.');
		return;
	}

	for(var i = 0; i < videoLength; i++){
		var linkChk = $('.tmr_video').eq(i).find('.tmr_video_link').val();
		var contentChk = $('.tmr_video').eq(i).find('.tmr_video_content').val();
		
		if(linkChk == ''){
			alert((i+1) + '번째 칸에 동영상 링크를 입력해주세요.');
			return;
		} else if(contentChk == ''){
			alert((i+1) + '번째 칸에 동영상 소개를 입력해주세요.');
			return;
		}
		var tvShareChk = linkChk.split('#').length;
		
		if(tvShareChk > 1){
			linkChk = linkChk.split('#')[0];
		}
		
		if(linkChk !== ''){
			var tcYoutubeUrlChk = linkChk.split('.');
			var videoUrlChk = linkChk.split('/');
			var youtubeChk = 0;
			
			for(var j = 0; j < tcYoutubeUrlChk.length; j++){
				if(tcYoutubeUrlChk[j] == 'youtube' || tcYoutubeUrlChk[j] == 'YOUTUBE' || 
						tcYoutubeUrlChk[j] == 'youtu' || tcYoutubeUrlChk[j] == 'YOUTU' || 
						tcYoutubeUrlChk[j] == 'http://youtube' || tcYoutubeUrlChk[j] == 'https://youtube' || 
						tcYoutubeUrlChk[j] == 'https://youtu' || tcYoutubeUrlChk[j] == 'http://youtu'){
					youtubeChk += 1;
				}
			}
			
			if(youtubeChk < 1){
				alert('유튜브 동영상만 등록 가능합니다!\n'+(i+1)+'번째 칸에 유튜브 개별 동영상 URL을 입력해주세요.');
				return;
			}
			
			for(var j = 0; j < videoUrlChk.length; j++){
				if(videoUrlChk[j] == 'channel' || videoUrlChk[j] == 'Channel'){
					alert('유튜브 채널 URL은 등록 불가능합니다.\n'+(i+1)+'번째 칸에 개별 동영상 URL을 등록해주세요!');
					return;
				}
			}
		}
	}
	
	var html = '<div class="tmr_video">'+
					'<div class="tmr_video_del_btn">'+
						'<img src="/img/team/img_del.svg">'+
					'</div>'+
				'<input type="text" class="tmr_video_link" placeholder="동영상 링크를 입력해주세요(유튜브 링크만 가능)">'+
				'<textarea rows="3" cols="" class="tmr_video_content" placeholder="동영상 소개를 입력해주세요"></textarea>'+
				'</div>';
	
	$('.tmr_video_container').append(html);
});

//동영상 삭제버튼 클릭시
$(document).on('click', '.tmr_video_del_btn', function(){
	var team_no = $('#tmr_tselect').val();
	if(team_no == null || team_no == 'null' || team_no == ''){
		alert('팀을 선택해주세요.');
		return;
	}
	
	var videoLength = $('.tmr_video').length;
	
	$(this).parents('.tmr_video').remove();
});

$(document).on('click', '#tmr_success_btn', function(){
	var team_no = $('#tmr_tselect').val();
	if(team_no == null || team_no == 'null' || team_no == ''){
		alert('팀을 선택해주세요.');
		return;
	}
	
	var imageLength = $('.tmr_picture_block').length;
	var imgText='';
	var imgChk = 0;
	
	for(var i = 0; i < imageLength; i++){
		var imgID = $('.tmr_picture_block').eq(i).attr('id');
		if(imgID != 'undefined' && imgID != undefined && imgID != ''){
			if(imgChk == 0){
				imgText = imgID;
			} else {
				imgText += '__happybusking__' + imgID;
			}
			imgChk++;
		}
	}
	
	var videoLength = $('.tmr_video').length;
	var videoUrl;
	var videoContent;
	
	for(var i = 0; i < videoLength; i++){
		var videoUrlTmp = changeQuotes($('.tmr_video').eq(i).find('.tmr_video_link').val());
		var videoContentTmp = changeQuotes($('.tmr_video').eq(i).find('.tmr_video_content').val());
		
		if(videoUrlTmp !== ''){
			var videoUrlChk = videoUrlTmp.split('/');
			var tcYoutubeUrlChk = videoUrlTmp.split('.');
			var youtubeChk = 0;
			
			var tvShareChk = videoUrlTmp.split('#').length;
			
			if(tvShareChk > 1){
				videoUrlTmp = videoUrlTmp.split('#')[0];
			}
			
			for(var j = 0; j < tcYoutubeUrlChk.length; j++){
				if(tcYoutubeUrlChk[j] == 'youtube' || tcYoutubeUrlChk[j] == 'YOUTUBE' || 
						tcYoutubeUrlChk[j] == 'youtu' || tcYoutubeUrlChk[j] == 'YOUTU' || 
						tcYoutubeUrlChk[j] == 'http://youtube' || tcYoutubeUrlChk[j] == 'https://youtube' || 
						tcYoutubeUrlChk[j] == 'https://youtu' || tcYoutubeUrlChk[j] == 'http://youtu'){
					youtubeChk += 1;
				}
			}
			
			if(youtubeChk < 1){
				alert('유튜브 동영상만 등록 가능합니다!\n'+(i+1)+'번째 칸에 유튜브 개별 동영상 URL을 입력해주세요.');
				return;
			}
			
			for(var j = 0; j < videoUrlChk.length; j++){
				if(videoUrlChk[j] == 'channel' || videoUrlChk[j] == 'Channel'){
					alert('유튜브 채널 URL은 등록 불가능합니다.\n'+(i+1)+'번째 칸에 개별 동영상 URL을 등록해주세요!');
					return;
				}
			}
		}
		
		if(videoUrlTmp != ''){
			var videoUrlTmp1 = videoUrlTmp.split('=').length;
			if(videoUrlTmp1 == 1){
				videoUrlTmp = videoUrlTmp.split('/');
				videoUrlTmp = videoUrlTmp[videoUrlTmp.length - 1];
				
				videoUrlTmp = 'https://www.youtube.com/embed/'+videoUrlTmp;
			} else {
				videoUrlTmp = videoUrlTmp.split('=');
				videoUrlTmp = videoUrlTmp[videoUrlTmp.length - 1];
				
				videoUrlTmp = 'https://www.youtube.com/embed/'+videoUrlTmp;
			}
		}
		
		if(videoLength == 1){
			if(videoUrlTmp != ''){
				if(videoContentTmp == ''){
					alert('동영상 소개를 입력해주세요.');
					return;
				}
			}
			if(videoContentTmp != ''){
				if(videoUrlTmp == ''){
					alert('동영상 링크를 입력해주세요.');
					return;
				}
			}
			videoUrl = videoUrlTmp;
			videoContent = videoContentTmp;
		} else {
			if(videoUrlTmp == ''){
				alert( (i+1) + '번째 칸에 동영상 링크를 입력해주세요.' );
				return;
			}
			
			if(videoContentTmp == ''){
				alert( (i+1) + '번째 칸에 동영상 소개를 입력해주세요.' );
				return;
			}
			
			if(i == 0){
				videoUrl = videoUrlTmp;
				videoContent = videoContentTmp;
			} else {
				videoUrl += '__happybusking__' + videoUrlTmp;
				videoContent += '__happybusking__' + videoContentTmp;
			}
		}
	}
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/team_media_insert.jsp',
		data : {
			team_no: team_no,
			imgText: imgText,
			videoUrl: videoUrl,
			videoContent: videoContent
		},
		async : false,
		dataType: "xml",
		beforeSend: function(){
			$.mobile.loading( 'show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
		},
		complete: function(){
			$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
			alert('업로드가 완료되었습니다.');
			toHome();
		}
	});
});