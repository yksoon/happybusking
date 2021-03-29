$(document).ready(function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	$('.apm_loginout_btn').removeAttr('id');
	getAppVisitorCount();

	if (loginchk == 'Y') {
		$('.apm_loginout_btn').attr('id', 'apm_logout');
		$('.apm_loginout_btn').text('로그아웃');
		$('#user_count').show();
		getUTCount();
		getAppVisitorCount();
	} else {
		$('.apm_loginout_btn').attr('id', 'apm_login');
		$('.apm_loginout_btn').text('로그인');
		$('#apm_login').click();
		$('#user_count').hide();
	}
	getNewWrite();
	endPerformChk(); // 공연 종료 안눌렀을시 공연일 +3일 지나면 자동 공연종료 처리
});

$(document).on('click', '#apm_login', function () {
	$('#admin_page_container').empty();
	$('#admin_page_container').load('/app_admin/login.jsp #login_page_container');
});

$(document).on('click', '#apm_notice', function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	if (loginchk != 'Y') {
		alert('로그인 후 이용가능');
		return;
	} else {
		getNoticeList();
	}
});


$(document).on('click', '#apm_userinfo', function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	if (loginchk != 'Y') {
		alert('로그인 후 이용가능');
		return;
	} else {
		getUserinfoList();
	}
});

$(document).on('click', '#apm_artistinfo', function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	if (loginchk != 'Y') {
		alert('로그인 후 이용가능');
		return;
	} else {
		getArtistInfo();
	}
});

$(document).on('click', '#apm_teaminfo', function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	if (loginchk != 'Y') {
		alert('로그인 후 이용가능');
		return;
	} else {
		getTeaminfoList();
	}
});

$(document).on('click', '#apm_qrmanagement', function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	if (loginchk != 'Y') {
		alert('로그인 후 이용가능');
		return;
	} else {
		getQRRequestList();
	}
});

$(document).on('click', '#apm_withdrawmanagement', function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	if (loginchk != 'Y') {
		alert('로그인 후 이용가능');
		return;
	} else {
		getWithdrawList();
	}
});

$(document).on('click', '#apm_koica_apply', function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	if (loginchk != 'Y') {
		alert('로그인 후 이용가능');
		return;
	} else {
		getKoicaApplyList();
	}
});

$(document).on('click', '#apm_uqmanagement', function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	if (loginchk != 'Y') {
		alert('로그인 후 이용가능');
		return;
	} else {
		getUQList();
	}
});

$(document).on('click', '#apm_hqmanagement', function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	if (loginchk != 'Y') {
		alert('로그인 후 이용가능');
		return;
	} else {
		getHQList();
	}
});

$(document).on('click', '#apm_video', function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	if (loginchk != 'Y') {
		alert('로그인 후 이용가능');
		return;
	} else {
		goVideoList();
	}
});

$(document).on('click', '#apm_uuv', function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	if (loginchk != 'Y') {
		alert('로그인 후 이용가능');
		return;
	} else {
		goUUV();
	}
});

$(document).on('click', '#apm_contract', function () {
	var loginchk = sessionStorage.getItem('happybuskingloginchk');
	if (loginchk != 'Y') {
		alert('로그인 후 이용가능');
		return;
	} else {
		goContract();
	}
});


//헤더에 New 표시
function getNewWrite() {
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/admin/get_new_write.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			$(DATA).each(function () {
				var QRCNT = $(this).find('QRCNT').text();
				var HQCNT = $(this).find('HQCNT').text();
				var UQCNT = $(this).find('UQCNT').text();
				var WCNT = $(this).find('WCNT').text();
				var TVCNT = $(this).find('TVCNT').text();
				var UUV = $(this).find('UUV').text();

				if (QRCNT != '0') $('#new-qr').show();
				else $('#new-qr').hide();

				if (HQCNT != '0') $('#new-hq').show();
				else $('#new-hq').hide();

				if (UQCNT != '0') $('#new-uq').show();
				else $('#new-uq').hide();

				if (WCNT != '0') $('#new-w').show();
				else $('#new-w').hide();

				if (TVCNT != '0') $('#new-video').show();
				else $('#new-video').hide();

				if (UUV != '0') $('#new-uuv').show();
				else $('#new-uuv').hide();

			});
		},
		error: function (xhr) {
			console.log(xhr);
		}
	});
}

//유저, 팀 전체 카운트
function getUTCount() {
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/get_user_team_count.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			$(DATA).each(function () {
				var UCOUNT = $(this).find('UCOUNT').text();
				var TCOUNT = $(this).find('TCOUNT').text();
				var ACOUNT = $(this).find('ACOUNT').text();

				$('#ucount').html(UCOUNT);
				$('#tcount').html(TCOUNT);
				$('#acount').html(ACOUNT);
			});
		},
		error: function (xhr) {
			console.log(xhr);
		}
	});
}

// 앱 방문자 카운트
function getAppVisitorCount() {
	var visitor_today_2 = visitor_today();
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/visitor_count/get_visitor_count.jsp',
		data: {
			visitor_date: visitor_today_2
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			if (DATA.length == 0) {
				$.ajax({
					type: "GET",
					cache: false,
					url: '/service/visitor_count/get_total_count.jsp',
					contentType: "application/xml; charset=utf-8",
					dataType: "xml",
					timeout: 30000,
					success: function (data2) {
						var ROOT2 = $(data2).find('ROOT2');
						var DATA2 = $(ROOT2).find('DATA2');
						$(DATA2).each(function (i) {
							var TOTAL_COUNT = $(this).find("TOTAL_COUNT").text();
							$('#admin_day_count_p').html("앱 일일방문자 (" + visitor_today_2 + ") : <span id='admin_day_count'></span>명");
							$('#admin_day_count').html("0");
							$('#admin_total_count').html(TOTAL_COUNT);
						});
					}
				});
			} else {
				$(DATA).each(function (i) {
					var VISITOR_COUNT = $(this).find("VISITOR_COUNT").text();
					var TOTAL_COUNT = $(this).find("TOTAL_COUNT").text();

					// console.log(VISITOR_DATE);
					// console.log(VISITOR_COUNT);

					$('#admin_day_count_p').html("앱 일일방문자 (" + visitor_today_2 + ") : <span id='admin_day_count'></span>명");
					$('#admin_day_count').html(VISITOR_COUNT);
					$('#admin_total_count').html(TOTAL_COUNT);
				});
			}
		}
	});
}

function visitor_today() {
	var date = new Date();
	var year = String(date.getFullYear());
	var month = String(date.getMonth() + 1);
	var day = String(date.getDate());

	if (month.length === 1) {
		month = "0" + month;
	}
	if (day.length === 1) {
		day = "0" + day;
	}
	var today = (year + "-" + month + "-" + day);
	// console.log(today);
	return today;
}

//DB INSERT를 위해 특수문자 치환
function changeQuotes(str) {
	str = str.replace(/;/gi, "");
	str = str.replace(/&/gi, "&amp;");
	str = str.replace(/\'/gi, "&apos;");
	str = str.replace(/\"/gi, "&quot;");
	str = str.replace(/</gi, "&lt;");
	str = str.replace(/>/gi, "&gt;");
	return str;
}

//DB SELECT시 줄바꿈
function changeLineBreak(str) {
	str = str.replace(/(?:\r\n|\r|\n)/g, '<br/>');
	return str;
}


//자릿수 채우기
function setPad(n, width) {
	//n : 숫자, width : 글자수
	n = n + '';
	return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

//숫자에 세자리마다 콤마(,) 표시
function addComma(str) {
	str = str.toString().replace(/[^0-9]/g, '');
	return str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//콤마제거 함수
function removeComma(str) {  // 콤마제거
	return str.toString().replace(/(,)/g, "");
}


//공백 체크
function breakCheck(str) {
	return str.toString().replace(/ /gi, "");
}

const initFirebase = () => {
	var firebaseConfig = {
		apiKey: "AIzaSyDL2WVpKQkBmSHJ1Sld0LZhONyrFLoCShM",
		authDomain: "happybusking.firebaseapp.com",
		databaseURL: "https://happybusking.firebaseio.com",
		projectId: "happybusking",
		storageBucket: "happybusking.appspot.com",
		appID: "1:832071675001:android:822e4e2908e642b1",
	};

	if (!firebase.apps.length) {
		firebase.initializeApp(firebaseConfig);
	}
}

function getImagePromise(str) {
	/*
	사용 예시
	 var new_img = 'upload/images/team/team' + TEAM_NO + "/" + PF_IMG;
			    
	 var imgSrc = getImagePromise(new_img).then(value => {
		$('#mpimg'+i).attr('src', value);
	 });
	*/

	initFirebase();

	return new Promise(function (resolve, reject) {
		const storage = firebase.storage();
		const storageRef = storage.ref();

		storageRef.child(str).getDownloadURL().then(function (url) {
			resolve(url);
		}).catch(function () {
			reject();
		});
	});
}

// 공연 종료 안눌렀을시 공연일 +3일 지나면 자동 공연종료 처리
function endPerformChk() {
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		url: '/service/busking_time/daily_buskingstatus_update.jsp',
		async: false,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete: function () {
		}
	});
}