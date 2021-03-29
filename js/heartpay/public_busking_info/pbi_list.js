//버스킹 행사 일정 페이지 생성시
$(document).on('pageinit', '#pbi_list', function(){
	//공연일정 검색 기간 선택
	$('#pbi_search_date_2').daterangepicker({
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
	$('#pbi_search_date_2').on('hide.daterangepicker', function(ev, picker) {
		$(this).val(picker.startDate.format('MM월 DD일') + ' - ' + picker.endDate.format('MM월 DD일'));
		$('#pbi_search_date').val(picker.startDate.format('YYYY-MM-DD') + '~' + picker.endDate.format('YYYY-MM-DD'));
		$('#pbi_search_date_2').css('width', '170px');
		$('#pbi_date_search_cancle').show();
		
		sessionStorage.setItem('pbiSearchDate', $('#pbi_search_date').val());
		sessionStorage.setItem('pbiSearchDateText', $(this).val());
		
		getPbiList();
	});
	
	var pbiMenuChk = sessionStorage.getItem('pbiMenu');
	if(pbiMenuChk == null && chkConditionApply()){
		$('#schedule_search').hide();
		$('#goConditionEvent').click();
	} else if(pbiMenuChk == null || pbiMenuChk == 'all' ){
		$('#schedule_search').show();
		$('#goAllEvent').click();
	} else if(pbiMenuChk == 'A'){
		$('#schedule_search').show();
		$('#goAreaEvent').click();
	} else if(pbiMenuChk == 'G'){
		$('#schedule_search').show();
		$('#goGenreEvent').click();
	} else if(pbiMenuChk == 'condition'){
		$('#schedule_search').hide();
		$('#goConditionEvent').click();
	}
	
	var pbiSearchTitle = sessionStorage.getItem('pbiSearchTitle');
	if(pbiSearchTitle != null){
		$('#pbi_search_title').val(pbiSearchTitle);
	}
	var pbiSearchDate = sessionStorage.getItem('pbiSearchDate');
	if(pbiSearchDate != null){
		$('#pbi_search_date').val(pbiSearchDate);
		$('#pbi_date_search_cancle').show();
	} else {
		$('#pbi_date_search_cancle').hide();
	}
	
	var pbiSearchDateText = sessionStorage.getItem('pbiSearchDateText');
	
	if(pbiSearchDateText != null){
		$('#pbi_search_date_2').css('width', '170px');
		$('#pbi_search_date_2').val(pbiSearchDateText);
		$('#pbi_date_search_cancle').show();
	} else {
		$('#pbi_search_date_2').css('width', '98px');
	}
});

//맞춤 버튼 클릭시
$(document).on('click', '#goConditionEvent', function(){
	if(!chkConditionApply()){
		var conf = confirm('맞춤 공연 설정을 하시면 설정하신 조건에 맞는 행사들만 보여드립니다.\n맞춤 공연 설정으로 이동하시겠습니까?');
		if(!conf) return;
		else go_pbi_condition();
	}
	
	var sessionChk = sessionStorage.getItem('pbiMenu');
	if(sessionChk != 'condition'){
		sessionStorage.setItem('pbiMenu', 'condition');
		sessionStorage.removeItem('pbiArea');
		sessionStorage.removeItem('pbiGenre');
		sessionStorage.removeItem('pbiScroll');
		sessionStorage.removeItem('pbiLimit');
		
		sessionStorage.removeItem('pbiSearchTitle');
		sessionStorage.removeItem('pbiSearchDate');
		sessionStorage.removeItem('pbiSearchDateText');
		
		$('#pbi_search_title').val('');
		$('#pbi_search_date').val('');
		$('#pbi_search_date_2').val('');
		$('#pbi_search_date_2').css('width', '98px');
		$('#pbi_date_search_cancle').hide();
	}
	$('#schedule_search').hide();
	
	pbiListChangeHeader('goConditionEvent');

	$('#pbi_area').hide();
	$('#pbi_genre').hide();
	
	//$('#pbi_list').css('padding-top', '85px');
	$('#pbi_list_sec').css('margin-top', '0px');
	
	getPbiConditionList();
});

//전체 버튼 클릭시
$(document).on('click', '#goAllEvent', function(){
	var sessionChk = sessionStorage.getItem('pbiMenu');
	if(sessionChk != 'all'){
		sessionStorage.setItem('pbiMenu', 'all');
		sessionStorage.removeItem('pbiArea');
		sessionStorage.removeItem('pbiGenre');
		sessionStorage.removeItem('pbiScroll');
		

		sessionStorage.removeItem('pbiSearchTitle');
		sessionStorage.removeItem('pbiSearchDate');
		sessionStorage.removeItem('pbiSearchDateText');
		
		$('#schedule_search').show();
		$('#pbi_search_title').val('');
		$('#pbi_search_date').val('');
		$('#pbi_search_date_2').val('');
		$('#pbi_search_date_2').css('width', '98px');
		$('#pbi_date_search_cancle').hide();
	}
	
	pbiListChangeHeader('goAllEvent');

	$('#pbi_area').hide();
	$('#pbi_genre').hide();
	
	$('#pbi_list_sec').css('margin-top', '0px');
	
	getPbiList();
});

//지역 버튼 클릭시
$(document).on('click', '#goAreaEvent', function(){
	var sessionChk = sessionStorage.getItem('pbiMenu');
	if(sessionChk != 'A'){
		sessionStorage.setItem('pbiMenu', 'A');
		sessionStorage.removeItem('pbiGenre');
		sessionStorage.removeItem('pbiScroll');
		sessionStorage.removeItem('pbiLimit');

		sessionStorage.removeItem('pbiSearchTitle');
		sessionStorage.removeItem('pbiSearchDate');
		sessionStorage.removeItem('pbiSearchDateText');
		
		$('#schedule_search').show();
		$('#pbi_search_title').val('');
		$('#pbi_search_date').val('');
		$('#pbi_search_date_2').val('');
		$('#pbi_search_date_2').css('width', '98px');
		$('#pbi_date_search_cancle').hide();
	}
	
	pbiListChangeHeader('goAreaEvent');
	
	$('#pbi_area').show();
	$('#pbi_genre').hide();
	
	$('#pbi_list_sec').css('margin-top', '40px');

	$('#pbi_area').empty();
	
	//지역 리스트 가져오기
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/common/get_area_code.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			var pbiArea = sessionStorage.getItem('pbiArea');
			
			$(DATA).each(function(i) {
				var AREA_NAME = $(this).find("AREA_NAME").text();
				
				if(pbiArea == null){
					if(i == 0){
						var li_content = '<li class="area_on pbi_area_li">'+AREA_NAME+'</li>';
					} else {
						var li_content = '<li class="pbi_area_li">'+AREA_NAME+'</li>';
					}
				} else {
					if(pbiArea == AREA_NAME){
						var li_content = '<li class="area_on pbi_area_li">'+AREA_NAME+'</li>';
					} else {
						var li_content = '<li class="pbi_area_li">'+AREA_NAME+'</li>';
					}
				}
				
				$('#pbi_area').append(li_content);
				//$('#sc_area li:firstchild').css('font-weight', 'bold');
				
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			touch_slide2();
			
			var pbiArea = sessionStorage.getItem('pbiArea');
			if(pbiArea == null){
				var pbiArea = sessionStorage.setItem('pbiArea', '서울');
			}
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
	});	
	getPbiList();
});

//장르 버튼 클릭시
$(document).on('click', '#goGenreEvent', function(){
	var sessionChk = sessionStorage.getItem('pbiMenu');
	if(sessionChk != 'G'){
		sessionStorage.setItem('pbiMenu', 'G');
		sessionStorage.removeItem('pbiArea');
		sessionStorage.removeItem('pbiScroll');
		sessionStorage.removeItem('pbiLimit');

		sessionStorage.removeItem('pbiSearchTitle');
		sessionStorage.removeItem('pbiSearchDate');
		sessionStorage.removeItem('pbiSearchDateText');
		
		$('#schedule_search').show();
		$('#pbi_search_title').val('');
		$('#pbi_search_date').val('');
		$('#pbi_search_date_2').val('');
		$('#pbi_search_date_2').css('width', '98px');
		$('#pbi_date_search_cancle').hide();
	}

	pbiListChangeHeader('goGenreEvent');
	
	$('#pbi_area').hide();
	$('#pbi_genre').show();
	
	$('#pbi_list_sec').css('margin-top', '40px');
	
	$('#pbi_genre').empty();
	
	//장르 리스트 가져오기
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/common/get_main_genre.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			var pbiGenre = sessionStorage.getItem('pbiGenre');
			
			$(DATA).each(function(i) {
				var MAIN_GENRE = $(this).find("MAIN_GENRE").text();
				
				if(pbiGenre == null){
					if(i == 0){
						var li_content = '<li class="area_on pbi_genre_li">'+MAIN_GENRE+'</li>';
					} else {
						var li_content = '<li class="pbi_genre_li">'+MAIN_GENRE+'</li>';
					}
				} else {
					if(pbiGenre == MAIN_GENRE){
						var li_content = '<li class="area_on pbi_genre_li">'+MAIN_GENRE+'</li>';
					} else {
						var li_content = '<li class="pbi_genre_li">'+MAIN_GENRE+'</li>';
					}
				}
				
				$('#pbi_genre').append(li_content);
				//$('#sc_area li:firstchild').css('font-weight', 'bold');
				
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			
			var pbiGenre = sessionStorage.getItem('pbiGenre');
			if(pbiGenre == null){
				var pbiGenre = sessionStorage.setItem('pbiGenre', '음악');
			}
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
	});	
	getPbiList();
});

//지역 li 클릭시
$(document).on('click', '.pbi_area_li', function(){
	$('.pbi_area_li').removeClass('area_on');
	$(this).addClass('area_on');
	
	var pbiArea = $(this).text();
	sessionStorage.setItem('pbiArea', pbiArea);
	sessionStorage.removeItem('pbiScroll');
	
	getPbiList();
});

//장르 li 클릭시
$(document).on('click', '.pbi_genre_li', function(){
	$('.pbi_genre_li').removeClass('area_on');
	$(this).addClass('area_on');
	
	var pbiGenre = $(this).text();
	sessionStorage.setItem('pbiGenre', pbiGenre);
	sessionStorage.removeItem('pbiScroll');
	
	getPbiList();
});

//검색쪽에 텍스트 입력시 옆에 캔슬버튼 보여주기
$(document).on('keyup', '#pbi_search_title', function(e){
	var str = $(this).val();
	
	if(e.keyCode == 13){
		sessionStorage.setItem('pbiSearchTitle', str);
		sessionStorage.removeItem('pbiScroll');
		getPbiList();
	}
});

//타이틀 검색쪽 캔슬버튼 클릭시
$(document).on('click', '#pbi_search_cancle', function(){
	$('#pbi_search_title').val('');
	sessionStorage.removeItem('pbiSearchTitle');
	sessionStorage.removeItem('pbiScroll');
	
	getPbiList();
});

//기간 검색쪽 캔슬버튼 클릭시
$(document).on('click', '#pbi_date_search_cancle', function(){
	$('#pbi_search_date').val('');
	$(this).hide();
	sessionStorage.removeItem('pbiScroll');
	sessionStorage.removeItem('pbiSearchDate');
	sessionStorage.removeItem('pbiSearchDateText');
	$('#pbi_search_date').val('');
	$('#pbi_search_date_2').val('');
	$('#pbi_search_date_2').css('width', '98px');
	$('#pbi_date_search_cancle').hide();
	
	getPbiList();
});

//리스트 클릭시 스크롤 유지
$(document).on('click', '.pbi_list_container', function(){
	var scroll = $(window).scrollTop();
	sessionStorage.setItem('pbiScroll', scroll);
});

/*$(document).on('swipeup', '#pbi_list', function(){
	var menuChk = sessionStorage.getItem('pbiMenu');
	if(menuChk != 'condition'){
		$('#pbi_search').slideUp('fast');
		$('#pbi_date_search').slideUp('fast');
	}
});

$(document).on('swipedown', '#pbi_list', function(){
	var menuChk = sessionStorage.getItem('pbiMenu');
	if(menuChk != 'condition'){
		$('#pbi_search').slideDown('fast');
		$('#pbi_date_search').slideDown('fast');
	}
});*/