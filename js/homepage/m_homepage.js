$(document).ready(function () {
	var rbcElement = $('.hpage2_rbc_left_container');
	var rbcHeight = rbcElement.height() + 'px';

	$('.hpage2_rbc_left_container').css('height', rbcHeight);
	$('.hpage2_rbc_right_container').css('height', rbcHeight);

	var request = new Request();
	var requestStr = request.getParameter("mailchk");

	if (requestStr == '1' || requestStr == 1) {
		$('.hpage_event_banner').click();
		return;
	}

	var requestStr2 = request.getParameter("team_no");

	if (requestStr2 != null && requestStr2 != '') {
		var url = 'https://www.happybusking.com/app/appresult.jsp?team_no=' + requestStr2;
		location.href = url;
	}


	// 방문객수 카운트 하는 로직
	$(function () {
		$.getJSON("https://api.ipify.org?format=jsonp&callback=?",
			function (json) {
				// console.log("My public IP address is: ", json.ip);
				// console.log(typeof (json.ip));
				ip_address = json.ip

				// console.log(ip_address);
				if (ip_address === '1.212.49.178') {
					console.log("무야호~")
				} else {
					var ip_address_session_get = sessionStorage.getItem("home_ip_address");
					if (ip_address_session_get != ip_address) {
						var visitor_today_2 = m_home_visitor_today();
						// console.log(visitor_today_2);

						$.ajax({
							type: "GET",
							cache: false,
							url: '/service/visitor_count/get_homepage_count.jsp',
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
									m_new_home_visitor_count(visitor_today_2);
								} else {
									$(DATA).each(function (i) {
										var HOMEPAGE_VISITOR_DATE = $(this).find("HOMEPAGE_VISITOR_DATE").text();
										var HOMEPAGE_VISITOR_COUNT = $(this).find("HOMEPAGE_VISITOR_COUNT").text();

										// console.log(VISITOR_DATE);
										// console.log(VISITOR_COUNT);

										HOMEPAGE_VISITOR_COUNT = parseInt(HOMEPAGE_VISITOR_COUNT) + 1;
										m_plus_home_visitor_count(visitor_today_2, HOMEPAGE_VISITOR_COUNT);
									})
								}

							}
						});
						sessionStorage.setItem("home_ip_address", ip_address);
					} else {
						return false;
					}

				}
			}
		);
	});

});

/////////////////////////////////////////////////////////// 방문객수 함수 /////////////////////////////
function m_home_visitor_today() {
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

function m_new_home_visitor_count(visitor_today_2) {
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/visitor_count/set_homepage_count.jsp',
		data: {
			visitor_date: visitor_today_2,
			difference: "Y"
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {

		}
	});
}

function m_plus_home_visitor_count(visitor_today_2, visitor_count) {
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/visitor_count/set_homepage_count.jsp',
		data: {
			visitor_date: visitor_today_2,
			visitor_count: visitor_count,
			difference: "N"
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {

		}
	});
}
/////////////////////////////////////////////////////////////////////////////////////////

//모바일버전 헤더 패널버튼 클릭시
$(document).on('click', '#hph_menu_btn', function () {
	var showchk = $('.hpage_header_container').css('display');

	if (showchk == 'none') {
		//패널 숨겨져있을때
		$('.hpage_header_container').slideDown('fast');
		$('#hph_menu_btn').attr('src', '/img/homepage/close.png');
		$('#hph_menu_btn').css('height', '40%');
		$('#hph_menu_btn').css('top', '30%');
		$('#hph_menu_btn').css('width', '8%');
	} else {
		//패널 보여져있을때
		$('.hpage_header_container').slideUp('fast');
		$('#hph_menu_btn').attr('src', '/img/homepage/mobile/menu_mobile.png');
		$('#hph_menu_btn').css('height', '45%');
		$('#hph_menu_btn').css('top', '25%');
		$('#hph_menu_btn').css('width', '8%');
	}
});
//모바일버전 헤더 클릭시
$(document).on('click', '.hph_menu_title', function () {
	$('.hpage_header_container').slideUp('fast');
	$('#hph_menu_btn').attr('src', '/img/homepage/mobile/menu_mobile.png');
	$('#hph_menu_btn').css('height', '45%');
	$('#hph_menu_btn').css('top', '25%');
	$('#hph_menu_btn').css('width', '8%');

	var nowScroll = 0;
	var scrollTmp = 0;
	var pagemove = $(this).attr('id').split('_');
	pagemove = (pagemove[pagemove.length - 1] - 1);

	if (pagemove == '5' || pagemove == 5) {
		$('.hpage_busker_oath_popup').show();
		return;
	} else if (pagemove == 0) {
		nowScroll = 0;
	} else {
		for (var i = 1; i <= pagemove; i++) {
			scrollTmp = ($('#hpage' + i).css('height').split('px')[0]) * 1;
			nowScroll += scrollTmp;
		}
	}
	$('html').scrollTop(nowScroll);
});

//제휴 문의 버튼 클릭시
$(document).on('click', '#hpage5_send_btn', function () {
	var hqTitle = changeQuotes($('#question_title').val());
	var hqContent = changeQuotes($('#question_content').val());
	var hqRequest = changeQuotes($('#request_email').val());

	if (hqTitle == '') {
		alert('문의사항 제목을 입력해주세요.');
		$('#question_title').focus();
		return;
	} else if (hqContent == '') {
		alert('문의사항 내용을 입력해주세요.');
		$('#question_content').focus();
		return;
	} else if (hqRequest == '') {
		alert('회신받을 이메일을 입력해주세요.');
		$('#request_email').focus();
		return;
	}

	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/homepage/homepage_question_insert.jsp',
		data: {
			hqTitle: hqTitle,
			hqContent: hqContent,
			hqRequest: hqRequest
		},
		async: false,
		dataType: "xml",
		complete: function () {
			alert('문의가 접수되었습니다. 빠른 시일내에 작성해주신 이메일로 회신 드리겠습니다.');
			history.go(0);
		}
	});
});


//모바일버전 이벤트 배너 클릭시 팝업 띄워주기
$(document).on('click', '.hpage_event_banner', function () {
	$('.hep_main_img').attr('src', '/img/event/contest.jpg');
	$('.hpage_event_popup').show();
});


//모바일버전 이벤트 배너 닫기버튼 클릭시 팝업 닫기
$(document).on('click', '#hap_close_btn', function () {
	$('.hpage_event_popup').hide();
});

//모바일버전 버스커 선서 팝업 닫기버튼 클릭시
$(document).on('click', '#hbo_close_btn', function () {
	$('.hpage_busker_oath_popup').hide();
});

//구글 버튼 클릭시 해당 스토어로 이동
$(document).on('click', '#hpage_google_btn', function () {
	window.open('https://play.google.com/store/apps/details?id=com.happybusking', '_self');
});

//구글 버튼 클릭시 해당 스토어로 이동
$(document).on('click', '#hpage_apple_btn', function () {
	window.open('https://itunes.apple.com/kr/app/해피버스킹/id1436945374?mt=8', '_self');
});

//모집 공고 등록 페이지로 이동
function goRecruit() {
	window.open('https://happybusking.com/recruit/', '_blank');
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


//Request를 function으로 생성 (GET 방식만 가능)
function Request() {
	var requestParam = "";

	//getParameter 펑션
	this.getParameter = function (param) {
		//연재 주소를 decoding
		var url = unescape(location.href);

		//파라미터만 자르고, 다시 &구분자를 잘라서 배열에 넣음
		var paramArr = (url.substring(url.indexOf("?") + 1, url.length)).split("&");

		for (var i = 0; i < paramArr.length; i++) {
			var temp = paramArr[i].split("=");//파라미터 변수명을 담음

			if (temp[0].toUpperCase() == param.toUpperCase()) {
				//변수명과 일치할 경우 데이터 삽입
				requestParam = paramArr[i].split("=")[1];
				break;
			}
		}
		return requestParam;
	}
}