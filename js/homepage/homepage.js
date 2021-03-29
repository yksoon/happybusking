//마우스 휠 인식
var nowpage = 0;
var nowpageTmp = 0;
var totalpage = 6;	//전체 페이지수 - 1
var hcicviewcount = 0;	//사업자정보 보이는경우 1, 안보이는경우 0

/*function htmlScroll(){
	$('html, body').on('mousewheel DOMMouseScroll', function(e){
		var trans = '';
		var E = e.originalEvent;
		delta = 0;
		if(E.detail){
			delta = E.detail * -40;
		} else {
			delta = E.wheelDelta;
		}
		
		var height = $('body').css('height').split('px')[0];
		var hcicheight = $('#hpage_hcic').css('height').split('px')[0];
		
		if(delta < 0){
			//마우스 휠 다운
			if(nowpage == totalpage){
				$('#hpage_hcic').fadeIn('fast');
				hcicviewcount = 1;
				return;
			}
			nowpage += 1;
		} else{
			//마우스 휠 업
			if(nowpage == totalpage){
				if(hcicviewcount == 1){
					$('#hpage_hcic').fadeOut('fast');
					hcicviewcount = 0;
					nowpage = totalpage + 1;
					return;
				}
			}
			
			if(nowpage == 0){
				return;
			}
			nowpage -= 1;
		}
		nowpageTmp = nowpage;
		
		height = height * nowpage;
		height = '-' + height + 'px';
		
		trans = 'translate3d(0px, '+height+', 0px)';
		
		$('.hpage_body_container').css('transform', trans);
		
		$('.hpage_footer').find('img').attr('src', '/img/homepage/img/'+(nowpage+1)+'_scroll.png');
		
		$('.hps_menu_title').removeClass('hps_menu_select_title');
		$('#hps_menu_'+nowpage).addClass('hps_menu_select_title');
		
		$('html, body').off('mousewheel DOMMouseScroll');
		setTimeout(function(){
			htmlScroll();
		}, 700);
	});
}


$('html, body').on('mousewheel DOMMouseScroll', function(e){
	htmlScroll();
});


//네이게이션 버튼 클릭시 페이지 이동
$(document).on('click', '.hps_menu_title', function(){
	$('.hps_menu_title').removeClass('hps_menu_select_title');
	$(this).addClass('hps_menu_select_title');

	var height = $('body').css('height').split('px')[0];
	nowpage = $(this).attr('id').split('_');
	nowpage = (nowpage[nowpage.length - 1]*1);
	
	if(nowpage == 5){
		nowpage = nowpageTmp;
		$('.hpage_event_popup').show();
		return;
	}
	
	nowpageTmp = nowpage;
	
	height = height * nowpage;
	height = '-' + height + 'px';
	
	trans = 'translate3d(0px, '+height+', 0px)';
	$('.hpage_body_container').css('transform', trans);
	$('.hpage_footer').find('img').attr('src', '/img/homepage/img/'+(nowpage+1)+'_scroll.png');
});*/

$(document).ready(function () {
	var height = $('body').css('height').split('px')[0];

	$('.hpage_body').css('height', height);

	height = height * nowpage;
	height = '-' + height + 'px';

	var request = new Request();
	var requestStr = request.getParameter("mailchk");

	//var requestStr2 = request.getParameter("team_no");

	//console.log(requestStr2);

	if (requestStr == '1' || requestStr == 1) {
		$('#hps_menu_6').click();
	}

	/*if(requestStr2 != null && requestStr2 != ''){
		var url = 'https://www.happybusking.com/app/appresult.jsp?team_no='+requestStr2;
		location.href = url;
	}*/


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
						var visitor_today_2 = home_visitor_today();
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
									new_home_visitor_count(visitor_today_2);
								} else {
									$(DATA).each(function (i) {
										var HOMEPAGE_VISITOR_DATE = $(this).find("HOMEPAGE_VISITOR_DATE").text();
										var HOMEPAGE_VISITOR_COUNT = $(this).find("HOMEPAGE_VISITOR_COUNT").text();

										// console.log(VISITOR_DATE);
										// console.log(VISITOR_COUNT);

										HOMEPAGE_VISITOR_COUNT = parseInt(HOMEPAGE_VISITOR_COUNT) + 1;
										plus_home_visitor_count(visitor_today_2, HOMEPAGE_VISITOR_COUNT);
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
function home_visitor_today() {
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

function new_home_visitor_count(visitor_today_2) {
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

function plus_home_visitor_count(visitor_today_2, visitor_count) {
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

$(window).resize(function () {
	var height = $('body').css('height').split('px')[0];

	$('.hpage_body').css('height', height);

	height = height * nowpage;
	height = '-' + height + 'px';

	/*var trans = 'translate3d(0px, '+height+', 0px)';
	$('.hpage_body_container').css('transform', trans);*/
});

$(document).on('click', '.hps_menu_title', function () {
	$('.hps_menu_title').removeClass('hps_menu_select_title');
	$(this).addClass('hps_menu_select_title');

	var clickpage = $(this).attr('id').split('_')[2];
	var height = 0;
	var scroll;

	if (clickpage == '5') {
		$('.hpage_busker_oath_popup').show();
	} else if (clickpage == '6') {
		$('.hpage_event_popup').show();
	} else {
		if (clickpage == 0) {
			height = 0;
		}
		for (var i = 1; i <= clickpage; i++) {
			var thisHeight = $('#hpage' + i).css('height');
			thisHeight = thisHeight.split('px')[0];

			height = height + (thisHeight * 1);
		}
		$('html').scrollTop(height);
	}
});

document.addEventListener('scroll', function (e) {
	sidemenuChange();
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

//이벤트 배너 버튼 클릭시 팝업 보여주기
$(document).on('click', '.hpe_move_btn', function () {
	$('.hpage_event_popup').show();
});

//이벤트 배너 닫기버튼 클릭시 배너 사라지게
$(document).on('click', '.hpe_close_btn', function () {
	$('.hpage_event_banner').hide();
});

//이벤트 팝업 닫기버튼 클릭시 팝업 사라지게
$(document).on('click', '#hap_close_btn', function () {
	$('.hpage_event_popup').hide();
	sidemenuChange();
});

//패밀리 사이트 변경시
$(document).on('change', '.hps_family_select', function () {
	var str = $(this).val();

	if (str == 'bizworks') {
		window.open('http://www.bizworks.co.kr');
	}
});

//hps_footer_btn_eng 영문 페이지로 이동
$(document).on('click', '#hps_footer_btn_eng', function () {
	window.open('http://www.happybusking.com/en/index.jsp', '_self');
});
//hps_footer_btn_eng 영문 페이지로 이동
$(document).on('click', '.hps_menu_7_en', function () {
	window.open('http://www.happybusking.com/en/index.jsp', '_self');
});

//hps_footer_btn_kor 한글 페이지로 이동
$(document).on('click', '#hps_footer_btn_kor', function () {
	window.open('http://www.happybusking.com/', '_self');
});
//hps_footer_btn_kor 한글 페이지로 이동
$(document).on('click', '.hps_menu_7_ko', function () {
	window.open('http://www.happybusking.com/', '_self');
});
//구글 버튼 클릭시 해당 스토어 이동  QR 팝업 띄우기
$(document).on('click', '#hpage_google_btn', function () {
	$('.hpage_google_qr_popup').show();
});

//구글 스토어 팝업 닫기버튼 클릭시
$(document).on('click', '#gsq_close_btn', function () {
	$('.hpage_google_qr_popup').hide();
	sidemenuChange();
});

//애플 버튼 클릭시 해당 스토어 이동  QR 팝업 띄우기
$(document).on('click', '#hpage_apple_btn', function () {
	$('.hpage_apple_qr_popup').show();
});

//구글 스토어 팝업 닫기버튼 클릭시
$(document).on('click', '#asq_close_btn', function () {
	$('.hpage_apple_qr_popup').hide();
	sidemenuChange();
});

//버스커 선서 팝업 닫기버튼 클릭시
$(document).on('click', '#hbo_close_btn', function () {
	$('.hpage_busker_oath_popup').hide();
	sidemenuChange();
});

//모집 공고 등록 페이지로 이동
function goRecruit() {
	window.open('https://happybusking.com/recruit/', '_blank');
}

function sidemenuChange() {
	var height = window.scrollY;

	var hpage1 = ($('#hpage1').css('height').split('px')[0]) * 1;
	var hpage2 = hpage1 + ($('#hpage2').css('height').split('px')[0]) * 1;
	var hpage3 = hpage2 + ($('#hpage3').css('height').split('px')[0]) * 1;
	var hpage4 = hpage3 + ($('#hpage4').css('height').split('px')[0]) * 1;
	var hpage5 = hpage4 + ($('#hpage5').css('height').split('px')[0]) * 1;

	$('.hps_menu_title').removeClass('hps_menu_select_title');
	if (height < hpage1) {
		$('#hps_menu_0').addClass('hps_menu_select_title');
	} else if (hpage1 <= height && height < hpage2) {
		$('#hps_menu_1').addClass('hps_menu_select_title');
	} else if (hpage2 <= height && height < hpage3) {
		$('#hps_menu_2').addClass('hps_menu_select_title');
	} else if (hpage3 <= height && height < hpage4) {
		$('#hps_menu_3').addClass('hps_menu_select_title');
	} else {
		$('#hps_menu_4').addClass('hps_menu_select_title');
	}
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