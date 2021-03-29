var perform_sc_menu = '';
var perform_sc_middle = '';
var perform_sc_content = '';
var perform_sc_slidebar = '';

$(document).on('pageinit', '#perform_sc', function() {
	sessionStorage.removeItem('prqstate');
	
	var search = sessionStorage.getItem('pfSearch');
	var searchDate = sessionStorage.getItem('pfSearchDate');
	var pfIndex = sessionStorage.getItem('pfIndex');
	
	$('#perform_sc_menu').empty();
	//전체탭
	perform_sc_menu = '<div class="ui-grid-b header_menu_container">'+
							'<div id="Go_AllSchedule" class="ui-block-a">'+
								'<div class="haeder_menu_div_on">'+
									'<span class="header_menu_text_on">전체</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_AreaSchedule" class="ui-block-b">'+
								'<div class="haeder_menu_div_base">'+
									'<span class="header_menu_text_base">지역</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_GenreSchedule" class="ui-block-c">'+
								'<div class="haeder_menu_div_base">'+
									'<span class="header_menu_text_base">장르</span>'+
								'</div>'+
							'</div>'+	
						'</div>';
	
	$('#perform_sc_menu').append(perform_sc_menu);
	
	$('#perform_sc_middle').empty();
	perform_sc_middle =  '<div id="touchFlow2" class="nav_h_type">'+
							'<ul id="sc_area" style="padding: 0;">'+
							'</ul>'+
						 '</div>'+
						'<ul class="main_genre_ul" id="sc_genre" style="padding: 0;">'+
						'</ul>'+
							'<div id="perform_sc_search">'+ 
								'<div class="ui-grid-b search-input-text-container">'+ 
									'<div class="ui-block-a" id="perform_sc_search_img">'+
										'<img class="search-input-icon" src="/img/artist_ranking/ar_search_.svg">'+
									'</div>'+ 
									'<div class="ui-block-b">'+ 
										'<input type="text" class="search-input-text" name="sc_search_date" id="sc_search_date" placeholder="팀명으로 검색하기">'+ 
									'</div>'+
									'<div class="ui-block-c search-input-text-cancel" id="perform_sc_cancle">'+
										'취소'+
										//'<img src="/img/artist_ranking/ar_cancle.svg">'+ 
									'</div>'+ 
								'</div>'+ 
							'</div>'+
							'<div class="date-search-container" id="schedule_search">'+ 
									'<input type="hidden" name="ts_search_date" id="ts_search_date" placeholder="조회 시작일 - 조회 종료일" readonly="readonly">'+
									'<input type="text" class="date-search-input" name="ts_search_date_2" id="ts_search_date_2" data-role="none" placeholder="오늘 - 전체" readonly="readonly">'+
									'<img class="date-search-cancel" id="schedule_search_cancel" src="/img/v2/cancel.svg" />' +
									//'<p class="date-search-btn">변경</p>'+
							'</div>';
	
	$('#perform_sc_middle').append(perform_sc_middle);
	
	if(search != null){
		$('#sc_search_date').val(search);
	}
	if(searchDate != null){
		$('#ts_search_date').val(searchDate);
	}
	
	var pfSearchDateText = sessionStorage.getItem('pfSearchDateText');
	
	if(pfSearchDateText != null){
		$('#ts_search_date_2').css('width', '170px');
		$('#ts_search_date_2').val(pfSearchDateText);
		$('#schedule_search_cancel').show();
	} else {
		$('#ts_search_date_2').css('width', '98px');
	}
	
	
	//터치슬라이드바 감춤
	$('#sc_genre').empty();
	$('#sc_area').empty();
	
	//공연일정 검색 기간 선택
	$('#ts_search_date_2').daterangepicker({
		autoApply: true,
		autoUpdateInput: false,
		"locale": {
	        "format": "YYYY-MM-DD",
	        "separator": "~",
	        "applyLabel": "Apply",
	        "cancelLabel": "Cancel",
	        "fromLabel": "From",
	        "toLabel": "To",
	        "customRangeLabel": "Custom",
	        "daysOfWeek": [
	            "일",
	            "월",
	            "화",
	            "수",
	            "목",
	            "금",
	            "토"
	        ],
	        "monthNames": [
	            "1월",
	            "2월",
	            "3월",
	            "4월",
	            "5월",
	            "6월",
	            "7월",
	            "8월",
	            "9월",
	            "10월",
	            "11월",
	            "12월"
	        ]
		}
	});
	
	$('#ts_search_date_2').on('hide.daterangepicker', function(ev, picker) {
		$(this).val(picker.startDate.format('MM월 DD일') + ' - ' + picker.endDate.format('MM월 DD일'));
		$('#ts_search_date').val(picker.startDate.format('YYYY-MM-DD') + '~' + picker.endDate.format('YYYY-MM-DD'));
		sessionStorage.setItem('pfSearch', $('#sc_search_date').val());
		sessionStorage.setItem('pfSearchDate',$('#ts_search_date').val());
		sessionStorage.setItem('pfSearchDateText', $(this).val());
		$('#ts_search_date_2').css('width', '170px');
		$('#schedule_search_cancel').show();
		schedule_load();
	});
	
	//페이지 처음 시작시 전체탭 클릭
	if(pfIndex == null || pfIndex == '1'){
		$('#Go_AllSchedule').trigger('click');
	}
	else if(pfIndex == '2'){
		$('#Go_AreaSchedule').trigger('click');
	}
	else{
		$('#Go_GenreSchedule').trigger('click');
	}
});
	

//전체탭 클릭시
$(document).on('click', '#Go_AllSchedule', function() {
	var pfIndex = sessionStorage.getItem('pfIndex');
	if(pfIndex == null || pfIndex != '1'){
		sessionStorage.setItem('pfIndex', '1');
		sessionStorage.removeItem('pfSearch');
		sessionStorage.removeItem('pfSearchDate');
		sessionStorage.removeItem('pfSearchDateText');
		sessionStorage.removeItem('scLimit');
		sessionStorage.removeItem('pfScroll');
		
		$('#sc_search_date').val('');
		$('#ts_search_date').val('');
		$('#ts_search_date_2').val('');
		$('#ts_search_date_2').css('width', '98px');
		$('#schedule_search_cancel').hide();
	}
	sessionStorage.removeItem('pfSearchGenre');
	sessionStorage.removeItem('pfSearchArea');

	
	$('#perform_sc_search').show();
	$('#schedule_search').show();
	
	$('#perform_sc_menu').empty();
	perform_sc_menu = '<div class="ui-grid-b header_menu_container">'+
							'<div id="Go_AllSchedule" class="ui-block-a">'+
								'<div class="haeder_menu_div_on">'+
									'<span class="header_menu_text_on">전체</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_AreaSchedule" class="ui-block-b">'+
								'<div class="haeder_menu_div_base">'+
									'<span class="header_menu_text_base">지역</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_GenreSchedule" class="ui-block-c">'+
								'<div class="haeder_menu_div_base">'+
									'<span class="header_menu_text_base">장르</span>'+
								'</div>'+
							'</div>'+	
						'</div>';
	$('#perform_sc_menu').append(perform_sc_menu);

	//터치슬라이드바 감춤
	$('#sc_genre').empty();
	$('#sc_area').empty();
	
	$('#perform_sc_sec').css('margin-top', '0px');
	
	schedule_load();
});

//지역 탭 클릭시
$(document).on('click', '#Go_AreaSchedule', function() {
	var pfIndex = sessionStorage.getItem('pfIndex');
	if(pfIndex == null || pfIndex != '2'){
		sessionStorage.setItem('pfIndex', '2');
		sessionStorage.removeItem('pfSearch');
		sessionStorage.removeItem('pfSearchDate');
		sessionStorage.removeItem('pfSearchDateText');
		sessionStorage.removeItem('scLimit');
		sessionStorage.removeItem('pfScroll');
		
		$('#sc_search_date').val('');
		$('#ts_search_date').val('');
		$('#ts_search_date_2').val('');
		$('#ts_search_date_2').css('width', '98px');
		$('#schedule_search_cancel').hide();
	}
	sessionStorage.removeItem('pfSearchGenre');


	$('#perform_sc_search').show();
	$('#schedule_search').show();
	
	//초기 탭 클릭시 무조건 처음 li (서울) 선택
	var pfSearchArea = sessionStorage.getItem('pfSearchArea');
	
	if(pfSearchArea == null){
		pfSearchArea = '서울';
		sessionStorage.setItem('pfSearchArea', pfSearchArea);
	}
	
	$('#perform_sc_menu').empty();
	perform_sc_menu = '<div class="ui-grid-b header_menu_container">'+
							'<div id="Go_AllSchedule" class="ui-block-a">'+
								'<div class="haeder_menu_div_base">'+
									'<span class="header_menu_text_base">전체</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_AreaSchedule" class="ui-block-b">'+
								'<div class="haeder_menu_div_on">'+
									'<span class="header_menu_text_on">지역</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_GenreSchedule" class="ui-block-c">'+
								'<div class="haeder_menu_div_base">'+
									'<span class="header_menu_text_base">장르</span>'+
								'</div>'+
							'</div>'+	
						'</div>';
	
	$('#perform_sc_menu').append(perform_sc_menu);

	//터치슬라이드바 감춤
	$('#sc_genre').empty();
	$('#sc_area').empty();

	//터치슬라이드바 li추가부분
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/get_area_code.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i) {
				var AREA_NAME = $(this).find("AREA_NAME").text();
				if(pfSearchArea == AREA_NAME){
					var li_content = '<li class="area_on">'+AREA_NAME+'</li>';
				}
				else{
					var li_content = '<li value="' + AREA_NAME +'">'+AREA_NAME+'</li>';
				}
				$('#sc_area').append(li_content);
				
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			touch_slide2();
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
		
	});	
	
	$('#perform_sc_sec').css('margin-top', '40px');
	schedule_load();
});

//장르 탭 클릭시
$(document).on('click', '#Go_GenreSchedule', function() {
	var pfIndex = sessionStorage.getItem('pfIndex');
	if(pfIndex == null || pfIndex != '3'){
		sessionStorage.setItem('pfIndex', '3');
		sessionStorage.removeItem('pfSearch');
		sessionStorage.removeItem('pfSearchDate');
		sessionStorage.removeItem('pfSearchDateText');
		sessionStorage.removeItem('scLimit');
		sessionStorage.removeItem('pfScroll');
		
		$('#sc_search_date').val('');
		$('#ts_search_date').val('');
		$('#ts_search_date_2').val('');
		$('#ts_search_date_2').css('width', '98px');
		$('#schedule_search_cancel').hide();
	}
	sessionStorage.removeItem('pfSearchArea');

	$('#perform_sc_search').show();
	$('#schedule_search').show();
	
	//초기 탭 클릭시 무조건 처음 li (음악) 선택
	var pfSearchGenre = sessionStorage.getItem('pfSearchGenre');
	
	if(pfSearchGenre == null){
		pfSearchGenre = '음악';
		sessionStorage.setItem('pfSearchGenre', pfSearchGenre);
	}
	
	 $('#perform_sc_search').show();
	 $('#schedule_search').show();
	
	$('#perform_sc_menu').empty();
	perform_sc_menu = '<div class="ui-grid-b header_menu_container">'+
							'<div id="Go_AllSchedule" class="ui-block-a">'+
								'<div class="haeder_menu_div_base">'+
									'<span class="header_menu_text_base">전체</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_AreaSchedule" class="ui-block-b">'+
								'<div class="haeder_menu_div_base">'+
									'<span class="header_menu_text_base">지역</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_GenreSchedule" class="ui-block-c">'+
								'<div class="haeder_menu_div_on">'+
									'<span class="header_menu_text_on">장르</span>'+
								'</div>'+
							'</div>'+	
						'</div>';
	$('#perform_sc_menu').append(perform_sc_menu);
	
	//터치슬라이드바 감춤
	$('#sc_genre').empty();
	$('#sc_area').empty();
	
	//장르 터치슬라이드바 li추가부분
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/get_main_genre.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i) {
				var MAIN_GENRE = $(this).find("MAIN_GENRE").text();
				
				if(MAIN_GENRE == pfSearchGenre){
					var li_content = '<li class="area_on">'+MAIN_GENRE+'</li>';
				}
				else{
					li_content = '<li>'+MAIN_GENRE+'</li>';
				}
				$('#sc_genre').append(li_content);
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
		
	});
	
	schedule_load();
	$('#perform_sc_sec').css('margin-top', '40px');
});

//슬라이드바에서 선택한 메뉴 값 가져오기
$(document).on('pagebeforeshow', '#perform_sc', function() {
	//지역탭에서 슬라이드바 선택시 
	$('#sc_area').delegate('li', "click", function() {
		sessionStorage.removeItem('pfScroll');
		sessionStorage.removeItem('pfSearchGenre');
		
		$('#sc_area li').removeClass('area_on');
		$(this).addClass('area_on');
		
		var pfSearchArea= $(this).text();
		sessionStorage.setItem('pfSearchArea', pfSearchArea);
		schedule_load();
	});
	
	//장르탭에서 슬라이드바 선택시
	$('#sc_genre').delegate('li', "click", function() {
		sessionStorage.removeItem('pfScroll');
		sessionStorage.removeItem('pfSearchArea');
		
		$('#sc_genre li').removeClass('area_on');
		$(this).addClass('area_on');

		var pfSearchGenre = $(this).text();
		sessionStorage.setItem('pfSearchGenre', pfSearchGenre);
		schedule_load();
	});
});

//팀명으로 검색하기
$(document).on('keyup', '#sc_search_date', function(e) {
	var pfSearch = $(this).val();
	
	if(e.keyCode == 13){
		sessionStorage.removeItem('pfScroll');
		if(pfSearch == ''){
			sessionStorage.removeItem('pfSearch');
		} else {
			sessionStorage.setItem('pfSearch', pfSearch);
		}
		$('#sc_search_date').blur();
		schedule_load();
	}
});

//팀명 검색 부분 X표시 눌렀을 때 텍스트 초기화 및 버튼 없애기
$(document).on('click', '#perform_sc_cancle', function() {
	sessionStorage.removeItem('pfScroll');
	sessionStorage.removeItem('pfSearch');
	$('#sc_search_date').val('');
	$('#sc_search_date').attr('placeholder', '팀명으로 검색하기');
	schedule_load();
});

//날짜 검색 부분 X표시 눌렀을 때 텍스트 초기화 및 버튼 없애기
$(document).on('click', '#schedule_search_cancel', function() {
	sessionStorage.removeItem('pfScroll');
	sessionStorage.removeItem('pfSearchDate');
	sessionStorage.removeItem('pfSearchDateText');
	$('#ts_search_date').val('');
	$('#ts_search_date_2').val('');
	$('#ts_search_date_2').css('width', '98px');
	$('#schedule_search_cancel').hide();
	schedule_load();
});

//공연 일정 리스트 클릭시 스크롤 유지
$(document).on('click', '.ps_list_contaienr', function(){
	var scroll = $(window).scrollTop();
	sessionStorage.setItem('pfScroll', scroll);
});



$(document).on('pageinit', '#perform_cancle_msg', function() {
	$('#pf_cancle_area').textinput("option", "autogrow", false);
});


//공연 일정 취소
$(document).on('click', '#pf_cancle_btn', function() {
	var msg = changeQuotes($('#pf_cancle_area').val());
	if(msg == ''){
		alert('공연 취소 사유를 입력해주세요.');
		return;
	}
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/performance_schedule/perform_cancle.jsp',
		data: {
			pf_no : cancle_pf_no,
			pf_cancle_msg : msg
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(this).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			perform_cancle_push_send(cancle_pf_no)
		},
		complete: function(){
			alert('공연 일정이 취소되었습니다.');
			history.go(-1);
		}
	});
});

//FOOTER CSS
/*$(document).on('pageshow', '#perform_sc', function() {
	$('.footer_pfsc_txt').css('color', '#8d5cb1');
	$('.footer_pfsc_txt').css('font-weight', 'bold');
	$('.footer_pfsc_img').attr('src', '/img/test/m_schedule2.svg');
});

$(document).on('pagehide', '#perform_sc', function() {
	$('.footer_pfsc_img').attr('src', '/img/test/m_schedule.svg');
});*/