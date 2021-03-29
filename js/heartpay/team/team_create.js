var div_count = 1;
var add_count;
var tc_member_index = 1;

$(document).on('pageinit', '#team_create', function () {
	var device_width = document.body.offsetWidth;
	device_width -= 50;
	var popup_width = device_width + 'px';
	$('#team_member_add_popup').css('width', popup_width);

	$('#team_no').val(createRandomNum());

	var user_no = $('#user_no').val();
	div_count = $('.team_member_content_body').length + 1;
	add_count = $('.team_member_content_body').length;
	tm_member_add_count = add_count + 1;

	$('#tcreate_img').parents('.ui-corner-all').css('display', 'none');
	$('#tc_video_file').parents('.ui-corner-all').css('display', 'none');

	$('#t_content').textinput("option", "autogrow", false);
	$('#tc_video_textarea').textinput("option", "autogrow", false);

	var s_aname = sessionStorage.getItem('aname');
	var s_acontent = sessionStorage.getItem('acontent');

	if (s_aname != null) {
		$('#t_name').val(s_aname);
		$('#t_content').val(s_acontent);

		sessionStorage.removeItem('aname');
		sessionStorage.removeItem('acontent');
	}

	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/get_area_code.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			$(DATA).each(function (i) {
				var AREA_NAME = $(this).find("AREA_NAME").text();

				if (i == 0) {
					area_select = '<option value="' + AREA_NAME + '" selected="selected">' + AREA_NAME + '</option>';
				} else {
					area_select = '<option value="' + AREA_NAME + '">' + AREA_NAME + '</option>';
				}

				$('#area-select').append(area_select);
				$('#area-select').selectmenu("refresh", true);

			}).promise().done(function () {
				$.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error
	});

	//첫 등록 시 본인 프로필 1번으로
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/user/get_user_profile.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			$(DATA).each(function (i) {
				var USER_NO = $(this).find('USER_NO').text();
				var ARTIST_NAME = $(this).find('ARTIST_NAME').text();
				var ARTIST_IMG = $(this).find('ARTIST_IMG').text();
				var USE_TOOL = $(this).find('USE_TOOL').text();
				var CODE_GENRE = $(this).find('CODE_GENRE').text();

				//var a_img = '/upload/artist/artist'+ USER_NO +'/'+ARTIST_IMG;

				var new_img = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;

				var imgSrc = getImagePromise(new_img).then(value => {
					$('#aimg' + USER_NO).attr('src', value);
				});

				var artist_tg = USE_TOOL + '&nbsp;|&nbsp;' + CODE_GENRE;

				var team_member_content = '';

				team_member_content = '<div class="team_member_content_body" id="' + USER_NO + '">' +
					'<div class="ui-grid-a" style="height: 100%;">' +
					'<div class="ui-block-a" style="width: 30%; height: 100%;">' +
					'<img id="aimg' + USER_NO + '">' +
					'</div>' +
					'<div class="ui-block-b team_member_content_con">' +
					'<div class="ui-grid-a">' +
					'<div class="ui-block-a tm_content_name">' + ARTIST_NAME + '</div>' +
					'<div class="ui-block-b tm_content_genre">' + artist_tg + '</div>' +
					'</div>' +
					'</div>' +
					'</div>' +
					'</div>';

				$('#team_member_content').append(team_member_content);

				add_count = $('.team_member_content_body').length;
				$('#team_member_count').find('.ui-block-b').html('총 ' + add_count + '명');

			}).promise().done(function () {
				$.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
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

$(document).on('pageshow', '#team_create', function () {
	var position_left = ($(document).outerWidth() - 250) / 2;
	$('#success_msg_popup').css({ 'left': position_left + 'px' });

});

$(document).on('click', '#team_create_img', function () {
	$('#tcreate_img').click();
});

$(document).on('click', '#tc_video_img', function () {
	$('#tc_video_file').click();
});

$(document).on('change', '#tcreate_img', function () {
	if ($(this).val() === '') return;
	readURL(this, 2, 1);
});

$(document).on('change', '#tc_video_file', function () {
	const path = 'video/';
	uploadFile('tc_video_file', 'video', path, function () {
	});
});


$(document).on('click', '#team_member_addBtn', function () {
	$('#tm_add_list').empty();
	$("#team_member_add_popup").popup("option", "dismissible", false);
	$("#team_member_add_popup").popup("option", "overlayTheme", "b");
	$("#team_member_add_popup").popup("option", "positionTo", "window");
	$('#team_member_add_popup').popup('open');
	tc_member_index = 1;
});

$(document).on('click', '#tm_add_popup_close', function () {
	$('#tm_add_popup_content').empty();
	$('#tm_add_list').empty();
	$('#team_member_add_popup').popup('close');
});

//팝업에서 전화번호 입력하고 엔터 쳤을때
$(document).on('keyup', '#tm_member_phone', function (e) {
	var tm_member_phone = $(this).val();

	if (e.keyCode == 13) {
		if (tm_member_phone.replace(/ /gi, '') == '') {
			alert('휴대폰번호를 입력해주세요.\n숫자만 입력 가능합니다.');
			$(this).focus();
			return;
		}

		$(this).blur();
		$.ajax({
			type: "GET",
			cache: false,
			url: '/service/user/get_user_profile.jsp',
			data: {
				phone: tm_member_phone
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success: function (data) {
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');

				$('#tm_add_popup_content').empty();

				if (DATA.length == 0) {
					$('#tm_add_popup_content').html('<div id="tm_add_popup_none">검색결과가 없습니다.</div>');
					return;
				} else {
					$('#tm_add_popup_content').html('<ul id="tm_apc_list"></ul>');
				}

				$(DATA).each(function (i) {
					var USER_NO = $(this).find('USER_NO').text();

					var uno = $('#user_no').val();
					if (uno == USER_NO) {
						alert('자기 자신은 멤버로 초대할 수 없습니다.');
						return;
					}

					var ARTIST_NAME = $(this).find('ARTIST_NAME').text();
					var ARTIST_IMG = $(this).find('ARTIST_IMG').text();
					var USE_TOOL = $(this).find('USE_TOOL').text();
					var CODE_GENRE = $(this).find('CODE_GENRE').text();

					//var a_img = '/upload/artist/artist'+ USER_NO +'/'+ARTIST_IMG;

					var new_img = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;

					var imgSrc = getImagePromise(new_img).then(value => {
						$('#aimg' + USER_NO).attr('src', value);
					});

					var artist_tg = USE_TOOL + '&nbsp;&nbsp;|&nbsp;&nbsp;' + CODE_GENRE;

					var html = '<li>' +
						'<div class="ui-grid-b tm_member_container" id="' + USER_NO + '">' +
						'<div class="ui-block-a" id="tm_add_popup_a">' +
						'<img id="aimg' + USER_NO + '">' +
						'</div>' +
						'<div class="ui-block-b" id="tm_add_popup_b">' +
						ARTIST_NAME +
						'</div>' +
						'<div class="ui-block-c" id="tm_add_popup_c">' +
						artist_tg +
						'</div>' +
						'</div>' +
						'</li>';

					$('#tm_apc_list').append(html);
				}).promise().done(function () {
					var carousel;

					carousel = $("#tm_apc_list");
					carousel.itemslide(
						{
							left_sided: true,
							disable_clicktoslide: true
						}
					);
					carousel.reload();
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
});

//멤버 검색 후 해당 멤버 눌렀을 때
$(document).on('click', '.tm_member_container', function () {
	var addChk = $(this).attr('id');

	var selectLength = $('.tm_add_content').length;
	for (var i = 0; i < selectLength; i++) {
		var selectChkID = $('.tm_add_content').eq(i).attr('id');
		if (addChk == selectChkID) {
			alert('이미 선택한 멤버입니다.');
			return;
		}
	}

	var addLength = $('.team_member_content_body').length;
	for (var i = 0; i < addLength; i++) {
		var addChkID = $('.team_member_content_body').eq(i).attr('id');
		if (addChk == addChkID) {
			alert('이미 추가한 멤버입니다.');
			return;
		}
	}


	var a_img_src = $(this).find('#tm_add_popup_a').find('img').attr('src');
	var a_name = $(this).find('#tm_add_popup_b').text();

	var tm_add_content = '<div class="ui-grid-a tm_add_content" id="' + addChk + '">' +
		'<div class="ui-block-a" id="team_add_list_img">' +
		'<img src="' + a_img_src + '">' +
		'</div>' +
		'<div class="ui-block-b" id="team_add_list_name">' +
		a_name +
		'</div>' +
		'<div id="team_add_list_del">' +
		'<img src="/img/team/cancle1.png">' +
		'</div>' +
		'</div>';
	$('#tm_add_list').append(tm_add_content);
})

//선택한 멤버 삭제버튼 눌렀을 때
$(document).on('click', '#team_add_list_del', function () {
	$(this).parent('.tm_add_content').remove();
});


//추가하기 버튼 눌렀을 때
$(document).on('click', '#tm_member_add_btn', function () {
	var memberChk = $('.tm_add_content').length;
	if (memberChk == 0) {
		alert('추가된 멤버가 없습니다.\n핸드폰번호로 검색 후 멤버를 추가해주세요!');
		return;
	}

	for (var i = 0; i < memberChk; i++) {
		a_no = $('.tm_add_content').eq(i).attr('id');
		console.log(a_no);
		$.ajax({
			type: "GET",
			cache: false,
			async: false,
			url: '/service/team/get_user_profile.jsp',
			data: {
				user_no: a_no
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success: function (data) {
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');

				$(DATA).each(function (i) {
					var USER_NO = $(this).find('USER_NO').text();
					var ARTIST_NAME = $(this).find('ARTIST_NAME').text();
					var ARTIST_IMG = $(this).find('ARTIST_IMG').text();
					var USE_TOOL = $(this).find('USE_TOOL').text();
					var CODE_GENRE = $(this).find('CODE_GENRE').text();

					//var a_img = '/upload/artist/artist'+ USER_NO +'/'+ARTIST_IMG;

					var new_img = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;

					var imgSrc = getImagePromise(new_img).then(value => {
						$('#arimg' + USER_NO).attr('src', value);
					});

					var artist_tg = USE_TOOL + '&nbsp;|&nbsp;' + CODE_GENRE;

					var team_member_content = '<div class="team_member_content_body new_team_member" id="' + USER_NO + '">' +
						'<div class="ui-grid-a" style="height: 100%;">' +
						'<div class="ui-block-a" style="width: 30%; height: 100%;">' +
						'<img id="arimg' + USER_NO + '">' +
						'</div>' +
						'<div class="ui-block-b team_member_content_con">' +
						'<div class="ui-grid-a">' +
						'<div class="ui-block-a tm_content_name">' + ARTIST_NAME + '</div>' +
						'<div class="ui-block-b tm_content_genre">' + artist_tg + '</div>' +
						'</div>' +
						'</div>' +
						'</div>' +
						'<img id="tmcb_del_btn" src="/img/team/cancle1.png">' +
						'</div>';

					$('#team_member_content').append(team_member_content);

				}).promise().done(function () {
					var memberCount = $('.team_member_content_body').length;
					$('#team_member_count').find('.ui-block-b').html('총 ' + memberCount + '명');
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

	$('#tm_add_popup_content').empty();
	$('#tm_add_list').empty();

	$('#team_member_add_popup').popup('close');
});

//추가된 멤버 삭제버튼 클릭시
$(document).on('click', '#tmcb_del_btn', function () {
	var conf = confirm('해당 멤버를 제외하시겠습니까?');
	if (!conf) {
		return;
	}

	$(this).parent('.team_member_content_body').remove();

	var memberCount = $('.team_member_content_body').length;
	$('#team_member_count').find('.ui-block-b').html('총 ' + memberCount + '명');
});

$(document).on('keyup', '#t_pay', function () {
	var str = $(this).val();
	str = removeComma(str);
	str = addComma(str);

	$(this).val(str);
});


$(document).on('change', '#video_select', function () {
	const value = $(this).val();

	if (value === 'url') {
		$('#tc_video_url').show();
		$('#tc_video_file').hide();
		$('#url_warning').show();
		$('#file_warning').hide();
	} else {
		$('#tc_video_url').hide();
		$('#tc_video_file').show();
		$('#url_warning').hide();
		$('#file_warning').show();
	}
});


$(document).on('keyup', '#t_name', function (e) {
	if (e.keyCode == 13) {
		console.log($('#t_name').val());
		var t_name = $('#t_name').val()
		if (t_name.indexOf("'")) {
			tname = t_name.replace(/\'/ig, "\\" + "'")
			console.log(tname);
		}
	}
})