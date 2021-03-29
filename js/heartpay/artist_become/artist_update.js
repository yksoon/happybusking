var au_user_no;
$(document).on('pageinit', '#artist_update', function() {
	$('#artist_img').parents('.ui-corner-all').css('display', 'none');
	$('#artist_intro').textinput("option", "autogrow", false);
	
	var user_no = $('#user_no').val();
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/get_artist_info.jsp',
		data: {
			user_no : user_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i) {
				var USER_NO = $(this).find('USER_NO').text();
				var ARTIST_IMG = $(this).find('ARTIST_IMG').text();
				var PHONE = $(this).find('PHONE').text();
				var ARTIST_NAME = $(this).find('ARTIST_NAME').text();
				var ARTIST_INTRO = $(this).find('ARTIST_INTRO').text();
				var CODE_GENRE = $(this).find('CODE_GENRE').text();
				var USE_TOOL = $(this).find('USE_TOOL').text();
				var ARTIST_SNS = $(this).find('ARTIST_SNS').text();
				
				//var a_img = '/upload/artist/artist' + USER_NO + "/" + ARTIST_IMG;
				
				var new_img = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;
                
			    var imgSrc = getImagePromise(new_img).then(value => {
			    	$("#img_preview").attr('src' , value);
			    });
				
				$('#artist_name').val(ARTIST_NAME);
				$('#artist_intro').val(ARTIST_INTRO);
				$('#artist_phone').val(PHONE);
				$('#artist_use_tool').val(USE_TOOL);
				
				if(ARTIST_SNS != ''){
					var artistSNSArray = ARTIST_SNS.split('&happybusking&');
					
					for(var i = 0; i < artistSNSArray.length; i++){
						if(i == 0){
							$('.auc_sns_list').eq(i).find('.artist_update_text').val(artistSNSArray[i]);
						} else {
							var artistSNSList = '<div class="common_form_input_div auc_sns_list">'+
													'<div class="auc_sns_del_btn"><img src="/img/team/img_del.svg"></div>'+
													'<div class="ui-input-text ui-body-inherit ui-corner-all">'+
														'<input type="text" class="artist_update_text" name="artist_sns" placeholder="ex) https://www.facebook.com/happybusking.hb.1">'+
													'</div>'+
												'</div>';
							$('.auc_sns_container').append(artistSNSList);
							$('.auc_sns_list').eq(i).find('.artist_update_text').val(artistSNSArray[i]);
						}
						
					}
				}
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			console.log(xhr);
			console.log(message);
			console.log(errorThrown);
		} // end error
	});
});

$(document).on('click', '#artist_update_img', function() {
	$('#artist_img').click();
});

$(document).on('change', '#artist_img', function(){
	if($(this).val() === '') return;
	readURL(this, 2, 1);
});

//아티스트 SNS 추가버튼 클릭시
$(document).on('click', '#auc_sns_add_btn', function(){
	var artistSNSLength = $('.auc_sns_list').length;
	for(var i = 0; i < artistSNSLength; i++){
		var artistSNS = $('.auc_sns_list').eq(i).find('.artist_update_text').val().replace(/ /g, '');
		
		if(artistSNS == ''){
			alert((i+1) + '번째 칸에 회원님의 SNS를 입력해주세요.');
			$('.auc_sns_list').eq(i).find('.artist_update_text').focus();
			return;
		}
	}
	
	var artistSNSList = '<div class="common_form_input_div auc_sns_list">'+
							'<div class="auc_sns_del_btn"><img src="/img/team/img_del.svg"></div>'+
							'<div class="ui-input-text ui-body-inherit ui-corner-all">'+
								'<input type="text" class="artist_update_text" id="artist_sns" name="artist_sns" placeholder="ex) https://www.facebook.com/happybusking.hb.1">'+
							'</div>'+
						'</div>';
	
	$('.auc_sns_container').append(artistSNSList);
});

//아티스트 SNS 삭제버튼 클릭시
$(document).on('click', '.auc_sns_del_btn', function(){
	$(this).parents('.auc_sns_list').remove();
});

$(document).on('click', '.artist_update_btn', function() {
	var artistSNSLength = $('.auc_sns_list').length;
	var artistSNSTotal = '';
	
	if($('.auc_sns_list').eq(0).find('.artist_update_text').val().replace(/ /g, '') != ''){
		for(var i = 0; i < artistSNSLength; i++){
			var artistSNS = $('.auc_sns_list').eq(i).find('.artist_update_text').val().replace(/ /g, '');
			if(artistSNS == ''){
				alert((i+1) + '번째 칸에 회원님의 SNS를 입력해주세요.');
				$('.auc_sns_list').eq(i).find('.artist_update_text').focus();
				return;
			}
			
			if(i == 0){
				artistSNSTotal += artistSNS;
			} else {
				artistSNSTotal += '&happybusking&' + artistSNS;
			}
		}
	}
	
	$('#artist_sns_total').val(artistSNSTotal);
	
	au_user_no = $('#user_no').val();
	var artist_name = changeQuotes($('#artist_name').val());
	var artist_intro = changeQuotes($('#artist_intro').val());
	var artist_phone = changeQuotes($('#artist_phone').val());
	var artist_sns = changeQuotes($('#artist_sns_total').val());
	var artist_use_tool = changeQuotes($('#artist_use_tool').val());
	var imgsrc = $('#img_preview').attr('src');
	
	var a_img = $('#img_name').val();

	if(artist_name == ''){
		alert('활동명을 입력해주세요.');
		$('#artist_become_text').focus();
		return;
	} else if(artist_intro == ''){
		alert('소개를 입력해주세요.');
		$('#artist_intro').focus();
		return;
	} else if(artist_phone == ''){
		alert('핸드폰 번호를 입력해주세요.');
		$('#artist_phone').focus();
		return;
	} else if(artist_use_tool == ''){
		alert('악기/도구를 입력해주세요.');
		$('#artist_use_tool').focus();
		return;
	}
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/artist_name_chk.jsp',
		data: {
			artist_name: artist_name
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			var USER_NO = $(DATA).find('USER_NO').text();

			if(DATA.length != 0){
				if(au_user_no != USER_NO){
					infoTxtBox('중복된 아티스트 이름입니다. 다시 입력해주세요');
					$('#artist_name').val('');
					$('#artist_name').focus();
					return;
				} 
			}
			
			$.ajax({
				type: "POST",//url: "JSON/test.json",
				cache: false,
				url: '/service/artist_become/artist_update.jsp',
				//data : data,
				data : {
					artist_img: a_img,
					artist_name: artist_name,
					artist_intro: artist_intro,
					artist_phone: artist_phone,
					artist_sns: artist_sns,
					artist_use_tool: artist_use_tool
				},
				dataType: "xml",
				success: function (data) {
					var ROOT = $(data).find("ROOT");
					var DATA = $(ROOT).find('DATA');
					if(DATA.length == 0){
						$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
						return;
					}
				}, // end success
				error: function (xhr, message, errorThrown) {
					$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
					//hideLoading();
				}, // end error
				success: function(){
					alert('아티스트 정보 수정이 완료되었습니다.');
					setAimgCallback2(imgsrc);
					history.go(-1);
				}
			});			
			$(DATA).each(function(i) {
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
		});
		},//end success
		error: function (a, b, c) {
			//hideLoading();
			infoTxtBox(a + "-" + b + "-" + c);
		} // end error
	});

});