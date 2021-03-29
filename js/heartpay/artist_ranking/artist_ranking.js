var a_ranking_menu = '';
var a_ranking_middle = '';
var a_ranking_content = '';
var a_ranking_slidebar = '';

var a_ranking_sc_temp = '';

$(document).on('pageinit', '#artist_ranking', function() {
	$('#artist_ranking').css('padding-top', '185px');
	//뒤로가기 하기 위한 설정
	team_info_pageNo = 1;
	sessionStorage.removeItem('prqstate');
	
	$('#a_ranking_menu').empty();
	a_ranking_menu = '<div class="ui-grid-b header_menu_container">'+
						'<div id="Go_AllRanking" class="ui-block-a">'+
							'<div class="haeder_menu_div_on">'+
								'<span class="header_menu_text_on">전체</span>'+
							'</div>'+
						'</div>'+
						'<div id="Go_AreaRanking" class="ui-block-b">'+
							'<div class="haeder_menu_div_base">'+
								'<span class="header_menu_text_base">지역</span>'+
							'</div>'+
						'</div>'+
						'<div id="Go_GenreRanking" class="ui-block-c">'+
							'<div class="haeder_menu_div_base">'+
								'<span class="header_menu_text_base">장르</span>'+
							'</div>'+
						'</div>'+	
					'</div>';
	
	$('#a_ranking_menu').append(a_ranking_menu);
	
	//터치슬라이드바 감춤
	$('#a_ranking_sort').show();
	$('#ar_sc_area').empty();
	$('#ar_sc_genre').empty();
	
	$('#a_ranking_middle').empty();
	a_ranking_middle =  '<div id="a_ranking_search">'+ 
							'<div class="ui-grid-b search-input-text-container">'+ 
								'<div class="ui-block-a" id="a_ranking_search_img">'+
									'<img class="search-input-icon" src="/img/artist_ranking/ar_search_.svg">'+
								'</div>'+ 
								'<div class="ui-block-b">'+
									'<input type="text" class="search-input-text" name="ar_search_date" id="ar_search_date" placeholder="팀명으로 검색하기">'+ 
								'</div>'+
								'<div class="ui-block-c search-input-text-cancel" id="a_ranking_cancle">'+
									'취소'+ 
									//'<img src="/img/artist_ranking/ar_cancle.svg">'+ 
								'</div>'+ 
							'</div>'+ 
						'</div>';
	if(a_ranking_sc_temp != ''){
		a_ranking_middle = a_ranking_middle.replace('placeholder="팀명으로 검색하기"', 'value="'+a_ranking_sc_temp+'"');
	}
	
	$('#a_ranking_middle').append(a_ranking_middle);
	
	var arankPageNum = sessionStorage.getItem('arankPageNum');
	if(arankPageNum == null || arankPageNum == '1'){
		$('#Go_AllRanking').trigger('click');
	} else if(arankPageNum == '2') {
		$('#Go_AreaRanking').trigger('click');
	} else {
		$('#Go_GenreRanking').trigger('click');
	}
});

$(document).on('pageshow', '#artist_ranking', function(){
	$('#artist_ranking').css('padding-top', '185px');
});


//전체탭 클릭시
$(document).on('click', '#Go_AllRanking', function() {
	$('#ar-container').show();
	var arankPageNum = sessionStorage.getItem('arankPageNum');
	if(arankPageNum == null || arankPageNum != '1'){
		sessionStorage.removeItem('ars_sort');
		sessionStorage.removeItem('a_ranking_count');
		sessionStorage.removeItem('arankScroll');
		sessionStorage.removeItem('aEndCount');
		sessionStorage.setItem('arankPageNum', '1');
	}
	
	sessionStorage.removeItem('arankArea');
	sessionStorage.removeItem('arankGenre');
	
	
	$('#a_ranking_menu').empty();
	a_ranking_menu = '<div class="ui-grid-b header_menu_container">'+
						'<div id="Go_AllRanking" class="ui-block-a">'+
							'<div class="haeder_menu_div_on">'+
								'<span class="header_menu_text_on">전체</span>'+
							'</div>'+
						'</div>'+
						'<div id="Go_AreaRanking" class="ui-block-b">'+
							'<div class="haeder_menu_div_base">'+
								'<span class="header_menu_text_base">지역</span>'+
							'</div>'+
						'</div>'+
						'<div id="Go_GenreRanking" class="ui-block-c">'+
							'<div class="haeder_menu_div_base">'+
								'<span class="header_menu_text_base">장르</span>'+
							'</div>'+
						'</div>'+	
					'</div>';
	$('#a_ranking_menu').append(a_ranking_menu);

	//터치슬라이드바 감춤
	$('#a_ranking_sort').show();
	$('#ar_sc_area').empty();
	$('#ar_sc_genre').empty();
	
	var sort = sessionStorage.getItem('ars_sort');
	
	if(sort === 'like'){
		$('#ars_like').click();
	} else if(sort === 'new'){
		$('#ars_new').click();
	} else if(sort === 'old'){
		$('#ars_old').click();
	} else {
		$('#ars_active').click();
	}
	
	//get_artist_ranking();
});

//지역 탭 클릭시
$(document).on('click', '#Go_AreaRanking', function() {
	$('#ar-container').show();
	var arankPageNum = sessionStorage.getItem('arankPageNum');
	
	if(arankPageNum != '2'){
		sessionStorage.removeItem('a_ranking_count');
		sessionStorage.removeItem('arankScroll');
		sessionStorage.removeItem('aEndCount');
		sessionStorage.setItem('arankPageNum', '2');
	}
	
	sessionStorage.removeItem('ars_sort');
	sessionStorage.removeItem('arankGenre');
	
	//초기 탭 클릭시 무조건 처음 li (서울) 선택
	var arankArea = sessionStorage.getItem('arankArea');
	if(arankArea == null){
		arankArea = '서울';
		sessionStorage.setItem('arankArea', arankArea);
	}
	
	$('#a_ranking_menu').empty();
	a_ranking_menu = '<div class="ui-grid-b header_menu_container">'+
						'<div id="Go_AllRanking" class="ui-block-a">'+
							'<div class="haeder_menu_div_base">'+
								'<span class="header_menu_text_base">전체</span>'+
							'</div>'+
						'</div>'+
						'<div id="Go_AreaRanking" class="ui-block-b">'+
							'<div class="haeder_menu_div_on">'+
								'<span class="header_menu_text_on">지역</span>'+
							'</div>'+
						'</div>'+
						'<div id="Go_GenreRanking" class="ui-block-c">'+
							'<div class="haeder_menu_div_base">'+
								'<span class="header_menu_text_base">장르</span>'+
							'</div>'+
						'</div>'+	
					'</div>';
	$('#a_ranking_menu').append(a_ranking_menu);

	$('#a_ranking_sort').hide();
	$('#ar_sc_area').empty();
	$('#ar_sc_genre').empty();
	
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
				if(AREA_NAME == arankArea){
					var li_content = '<li class="area_on">'+AREA_NAME+'</li>';
				}
				else{
					li_content = '<li value="' + AREA_NAME +'">'+AREA_NAME+'</li>';
				}
				$('#ar_sc_area').append(li_content);
				
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			touch_slide4();
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
		
	});	
	
	get_artist_ranking();
});

//장르 탭 클릭시
$(document).on('click', '#Go_GenreRanking', function() {
	$('#ar-container').show();
	var arankPageNum = sessionStorage.getItem('arankPageNum');
	
	if(arankPageNum != '3'){
		sessionStorage.removeItem('a_ranking_count');
		sessionStorage.removeItem('arankScroll');
		sessionStorage.removeItem('aEndCount');
		sessionStorage.setItem('arankPageNum', '3');
	}
	
	sessionStorage.removeItem('ars_sort');
	sessionStorage.removeItem('arankArea');
	
	//초기 탭 클릭시 무조건 처음 li (음악) 선택
	var arankGenre = sessionStorage.getItem('arankGenre');
	if(arankGenre == null){
		arankGenre = '음악';
		sessionStorage.setItem('arankGenre', arankGenre);
	}
	
	$('#a_ranking_menu').empty();
	a_ranking_menu = '<div class="ui-grid-b header_menu_container">'+
						'<div id="Go_AllRanking" class="ui-block-a">'+
							'<div class="haeder_menu_div_base">'+
								'<span class="header_menu_text_base">전체</span>'+
							'</div>'+
						'</div>'+
						'<div id="Go_AreaRanking" class="ui-block-b">'+
							'<div class="haeder_menu_div_base">'+
								'<span class="header_menu_text_base">지역</span>'+
							'</div>'+
						'</div>'+
						'<div id="Go_GenreRanking" class="ui-block-c">'+
							'<div class="haeder_menu_div_on">'+
								'<span class="header_menu_text_on">장르</span>'+
							'</div>'+
						'</div>'+	
					'</div>';
	$('#a_ranking_menu').append(a_ranking_menu);
	
	$('#a_ranking_sort').hide();
	$('#ar_sc_area').empty();
	$('#ar_sc_genre').empty();
	
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
				
				if(MAIN_GENRE == arankGenre){
					var li_content = '<li class="area_on">'+MAIN_GENRE+'</li>';
				}
				else{
					li_content = '<li>'+MAIN_GENRE+'</li>';
				}
				$('#ar_sc_genre').append(li_content);
				
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
	});
	
	get_artist_ranking();
});

//슬라이드바에서 선택한 메뉴 값 가져오기
$(document).on('pagebeforeshow', '#artist_ranking', function() {
	//지역탭에서 슬라이드바 선택시 
	$('#ar_sc_area').delegate('li', "click", function() {
		var arankArea = sessionStorage.getItem('arankArea');
		if(arankArea == null){
			arankArea = '서울';
		}
		
		sessionStorage.setItem('arankArea', $(this).text());
		
		$('#ar_sc_area li').removeClass('area_on');
		$(this).addClass('area_on');
		
		sessionStorage.removeItem('ars_sort');
		sessionStorage.removeItem('a_ranking_count');
		sessionStorage.removeItem('arankScroll');
		sessionStorage.removeItem('aEndCount');
		
		get_artist_ranking();
	});
	
	//장르탭에서 슬라이드바 선택시
	$('#ar_sc_genre').delegate('li', "click", function() {
		var arankGenre = sessionStorage.getItem('arankGenre');
		if(arankGenre == null){
			arankGenre = '음악';
		}
		
		sessionStorage.setItem('arankGenre', $(this).text());
		
		$('#ar_sc_genre li').removeClass('area_on');
		$(this).addClass('area_on');

		sessionStorage.removeItem('ars_sort');
		sessionStorage.removeItem('a_ranking_count');
		sessionStorage.removeItem('arankScroll');
		sessionStorage.removeItem('aEndCount');

		get_artist_ranking();
	});
});

//정렬 탭 클릭시
$(document).on('click', '.ars_menu', function(){
	$('.ars_menu').removeClass('ars_on');
	$(this).addClass('ars_on');
});

$(document).on('click', '#ars_active', function(){
	//활동순
	sessionStorage.removeItem('ars_sort');
	get_artist_ranking();
});

$(document).on('click', '#ars_like', function(){
	//좋아요순
	sessionStorage.setItem('ars_sort', 'like');
	get_artist_ranking();
});

$(document).on('click', '#ars_old', function(){
	//가입순
	sessionStorage.setItem('ars_sort', 'old');
	get_artist_ranking();
});

$(document).on('click', '#ars_new', function(){
	//최신순
	sessionStorage.setItem('ars_sort', 'new');
	get_artist_ranking();
});

//텍스트 입력시 검색부분에 X버튼 표시
$(document).on('keyup', '#ar_search_date', function(e) {
	
	var user_no = $('#user_no').val();
	var team_search = $(this).val();
	
	if(e.keyCode == 13){
		//검색 후 ENTER 누를시
		a_ranking_sc_temp = team_search;
		$('#ar_search_date').blur();
		sessionStorage.removeItem('a_ranking_count');
		sessionStorage.removeItem('arankScroll');
		sessionStorage.removeItem('aEndCount');
		get_artist_ranking(user_no);
	}
});

//검색 부분 X표시 눌렀을 때 텍스트 초기화 및 버튼 없애기
$(document).on('click', '#a_ranking_cancle', function() {
	sessionStorage.removeItem('a_ranking_count');
	sessionStorage.removeItem('aEndCount');
	sessionStorage.removeItem('arankScroll');
	
	$('#ar_search_date').val('');
	$('#ar_search_date').focus();
	a_ranking_sc_temp = '';
	
	var arankPageNum = sessionStorage.getItem('arankPageNum');
	if(arankPageNum == null || arankPageNum == '1'){
		$('#Go_AllRanking').trigger('click');
	} else if(arankPageNum == '2') {
		$('#Go_AreaRanking').trigger('click');
	} else {
		$('#Go_GenreRanking').trigger('click');
	}
});

//관심아티스트 설정
/*$(document).on('click', '.a_ranking_like_img', function() {
	var user_no = $('#user_no').val();
	var team_no = $(this).parents('.a_ranking_con_body').attr('id');
	//var ranking_no = $('#a_ranking_content').find('.a_ranking_like_img').index($(this)) + 1;
	var like_img = $(this).find('img').attr('src');
	like_img = like_img.split('/');
	like_img = like_img[like_img.length - 1];
	
	
	if(user_no == null || user_no == 'null'){
		infoTxtBox('로그인이 필요합니다.');
		return;
	}
	
	if(like_img == 'ar_nolike.svg'){
		$.ajax({
			type: "GET",
			url: "/service/team/team_interest.jsp",
			contentType: "application/xml; charset=utf-8",
			data:{
				team_no: team_no,
				user_no: user_no
			},
			dataType: "xml",
			success: function (result) {
				get_artist_ranking(user_no);
			},
			error: function(a, b, c) {
			}
		});
	}
	else{
		$.ajax({
			type: "GET",
			url: "/service/team/team_interest_not.jsp",
			contentType: "application/xml; charset=utf-8",
			data:{
				team_no: team_no,
				user_no: user_no
			},
			dataType: "xml",
			success: function (result) {
				get_artist_ranking(user_no);
			},
			error: function(a, b, c) {
			}
		});
	}
});*/

/*$(document).on('swipeup', '#artist_ranking_content', function() {
	 $('#ar-container').slideUp();
});

$(document).on('swipedown', '#artist_ranking_content', function() {
	 $('#ar-container').slideDown();
});*/


$(document).on('click', '.artist_list_container', function(){
	var windowScrollTop = $(window).scrollTop();
	sessionStorage.setItem('arankScroll', windowScrollTop);
});

//FOOTER CSS
/*$(document).on('pageshow', '#artist_ranking', function() {
	$('.footer_ar_txt').css('color', '#8d5cb1');
	$('.footer_ar_txt').css('font-weight', 'bold');
	$('.footer_ar_img').attr('src', '/img/test/m_artist2.svg');
});

$(document).on('pagehide', '#artist_ranking', function() {
	$('.footer_ar_img').attr('src', '/img/test/m_artist.svg');
});*/