$(document).on('keyup', '#login_pw', function (e) {
	if (e.keyCode == 13) {
		$('#lpc_success_btn').click();
	}
});

$(document).on('click', '#lpc_success_btn', function () {
	var id = $('#login_id').val();
	var pw = $('#login_pw').val();

	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/login.jsp',
		data: {
			id: id,
			pw: pw
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			$(DATA).each(function () {
				var RESULT = $(this).find('RESULT').text();

				if (RESULT == 'TRUE') {
					sessionStorage.setItem('happybuskingloginchk', 'Y');
					$('#admin_page_container').empty();
					getUTCount();
					getNewWrite();
					$('#user_count').show();
					$('.apm_loginout_btn').attr('id', 'apm_logout');
					$('.apm_loginout_btn').text('로그아웃');
				} else {
					alert('다시 시도해주세요.');
					return;
				}
			});
		}
	});
});

$(document).on('click', '#apm_logout', function () {
	var conf = confirm('로그아웃 하시겠습니까 ?');
	if (!conf) {
		return;
	}

	sessionStorage.removeItem('happybuskingloginchk');
	$('#admin_page_container').empty();
	$('.apm_loginout_btn').attr('id', 'apm_login');
	$('.apm_loginout_btn').text('로그인');
	$('#user_count').hide();
});