//아티스트 되기 페이지
$(document).on('pageinit', '#artist_become', function () {
	/*var busker_oath = getCookie('busker_oath');
	var bocChk = sessionStorage.getItem('bocChk');
	if(busker_oath != 'Y'){
		if(bocChk != 'Y'){
			goBuskingOath();
		} else {
			alert('\'아티스트 되기\'등록 후 반드시 팀·솔로 등록을 해주세요!');
		}
	} else {
		alert('\'아티스트 되기\'등록 후 반드시 팀·솔로 등록을 해주세요!');
	}*/

	$('#artist_img').parents('.ui-corner-all').css('display', 'none');
	$('#artist-select-button').find('.ui-li-count').css('display', 'none !important');

	$('#artist_intro').textinput("option", "autogrow", false);
});

$(document).on('click', '#artist_become_img', function () {
	$('#artist_img').click();
});

//아티스트 SNS 추가버튼 클릭시
$(document).on('click', '#abc_sns_add_btn', function () {
	var artistSNSLength = $('.abc_sns_list').length;
	for (var i = 0; i < artistSNSLength; i++) {
		var artistSNS = $('.abc_sns_list').eq(i).find('.artist_become_text').val().replace(/ /g, '');

		if (artistSNS == '') {
			alert((i + 1) + '번째 칸에 회원님의 SNS를 입력해주세요.');
			$('.abc_sns_list').eq(i).find('.artist_become_text').focus();
			return;
		}
	}

	var artistSNSList = '<div class="abc_sns_list common_form_input_div">' +
		'<div class="abc_sns_del_btn"><img src="/img/team/img_del.svg"></div>' +
		'<div class="ui-input-text ui-body-inherit ui-corner-all">' +
		'<input type="text" class="artist_become_text" name="artist_sns" placeholder="ex) https://www.facebook.com/happybusking.hb.1">' +
		'</div>' +
		'</div>';

	$('.abc_sns_container').append(artistSNSList);
});

//아티스트 SNS 삭제버튼 클릭시
$(document).on('click', '.abc_sns_del_btn', function () {
	$(this).parents('.abc_sns_list').remove();
});

//아티스트 등록하기
$(document).on('click', '.artist_become_btn', function () {
	var artistSNSLength = $('.abc_sns_list').length;
	var artistSNSTotal = '';

	if ($('.abc_sns_list').eq(0).find('.artist_become_text').val().replace(/ /g, '') != '') {
		for (var i = 0; i < artistSNSLength; i++) {
			var artistSNS = $('.abc_sns_list').eq(i).find('.artist_become_text').val().replace(/ /g, '');
			if (artistSNS == '') {
				alert((i + 1) + '번째 칸에 회원님의 SNS를 입력해주세요.');
				$('.abc_sns_list').eq(i).find('.artist_become_text').focus();
				return;
			}

			if (i == 0) {
				artistSNSTotal += artistSNS;
			} else {
				artistSNSTotal += '&happybusking&' + artistSNS;
			}
		}
	}

	$('#artist_sns_total').val(artistSNSTotal);

	var artist_img = $('#img_name').val();
	var artist_name = changeQuotes($('#artist_name').val());
	var artist_intro = changeQuotes($('#artist_intro').val());
	var artist_phone = $('#artist_phone').val();
	var artist_sns = $('#artist_sns_total').val();
	var artist_use_tool = $('#artist_use_tool').val();
	var imgsrc = $('#img_preview').attr('src');

	if (artist_img == '') {
		alert('이미지를 등록해주세요.');
		$('#artist_img').focus();
		return;
	} else if (artist_name == '') {
		alert('활동명을 입력해주세요.');
		$('#artist_become_text').focus();
		return;
	} else if (artist_intro == '') {
		alert('소개를 입력해주세요.');
		$('#artist_intro').focus();
		return;
	} else if (artist_phone == '') {
		alert('핸드폰 번호를 입력해주세요.');
		$('#artist_phone').focus();
		return;
	} else if (artist_use_tool == '') {
		alert('악기/도구를 입력해주세요.');
		$('#artist_use_tool').focus();
		return;
	}


	if (!$('#useAgree_checkbox').prop('checked')) {
		infoTxtBox('약관에 동의해주세요.');
		return;
	}

	if (!$('#ab_info_checkbox').prop('checked')) {
		infoTxtBox('개인정보처리 약관에 동의해주세요.');
		return;
	}

	if (!$('#ab_pfreq_checkbox').prop('checked')) {
		infoTxtBox('공연의뢰 약관에 동의해주세요.');
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
		async: false,
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			if (DATA.length != 0) {
				alert('중복된 개인 활동명입니다. 다시 입력해주세요.');
				$('#artist_name').val('');
				$('#artist_name').focus();
				return;
			} else {
				//AJAX 로딩 표시
				$.ajax({
					type: "POST",//url: "JSON/test.json",
					cache: false,
					url: '/service/artist_become/artist_become.jsp',
					//data : data,
					data: {
						artist_img: artist_img,
						artist_name: artist_name,
						artist_intro: artist_intro,
						artist_phone: artist_phone,
						artist_sns: artist_sns,
						artist_use_tool: artist_use_tool
					},
					dataType: "xml",
					async: false,
					timeout: 30000,
					beforeSend: function () {
						$.mobile.loading('show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
					},
					success: function (data) {
						var ROOT = $(data).find("ROOT");
						var DATA = $(ROOT).find('DATA');
						if (DATA.length == 0) {
							$.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
							return;
						}
					}, // end success
					error: function (xhr, message, errorThrown) {
						alert('잠시후 다시 시도해주세요.');
						return;
						//hideLoading();
					}, // end error
					complete: function () {
						$.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
						sessionStorage.setItem('aname', $('#artist_name').val())
						sessionStorage.setItem('acontent', $('#artist_intro').val());
						setAimgCallback2(imgsrc);
						go_team_create();
					}
				});
			}
		}
	});
});

$(document).on('click', '#a_total_checkbox', function () {
	if ($(this).prop('checked')) {
		$('#useAgree_checkbox').prop('checked', true);
		$('#ab_info_checkbox').prop('checked', true);
		$('#ab_pfreq_checkbox').prop('checked', true);
	} else {
		$('#useAgree_checkbox').prop('checked', false);
		$('#ab_info_checkbox').prop('checked', false);
		$('#ab_pfreq_checkbox').prop('checked', false);
	}
});

//팝업에서 팀 신청 버튼 클릭시
$(document).on('click', '#artist_becomePopup_request_btn', function () {
	go_team_create();
});

//팝업에서 솔로 신청 버튼 클릭시
$(document).on('click', '#artist_becomePopup_solo_btn', function () {
	sessionStorage.setItem('aname', $('#artist_name').val())
	sessionStorage.setItem('acontent', $('#artist_intro').val());
	go_team_create();
});

//팝업에서 나중에하기 버튼 클릭시
$(document).on('click', '#artist_becomePopup_skip_btn', function () {
	toHome();
});