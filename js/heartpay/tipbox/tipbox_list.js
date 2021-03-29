$(document).on('pageinit', '#tipbox_list_page', function(){
	var pageChk = sessionStorage.getItem('scPage');
	if(pageChk == null || pageChk == 'Go_AllTipboxList'){
		$('#Go_AllTipboxList').click();
	} else if(pageChk == 'Go_AreaTipboxList'){
		$('#Go_AreaTipboxList').click();
	} else {
		$('#Go_GenreTipboxList').click();
	}
	
	var scName = sessionStorage.getItem('scName');
	if(scName == null){
		$('#tlb_search').val('');
	} else {
		$('#tlb_search').val(scName);
	}
});

//전체버튼 클릭시
$(document).on('click', '#Go_AllTipboxList', function(){
	$('#tbl_menu').find('div').removeClass('haeder_menu_div_base');
	$('#tbl_menu').find('div').removeClass('haeder_menu_div_on');
	$(this).find('div').addClass('haeder_menu_div_on');
	$('#Go_AreaTipboxList').find('div').addClass('haeder_menu_div_base');
	$('#Go_GenreTipboxList').find('div').addClass('haeder_menu_div_base');
	
	var pageChk = sessionStorage.getItem('scPage');
	if(pageChk != 'Go_AllTipboxList'){
		sessionStorage.setItem('scPage', 'Go_AllTipboxList');
		sessionStorage.removeItem('scLimit');
		sessionStorage.removeItem('scLimitEnd');
		sessionStorage.removeItem('scName');
		sessionStorage.removeItem('scArea');
		sessionStorage.removeItem('scGenre');
		sessionStorage.removeItem('scScroll');
	}
	
	var scName = sessionStorage.getItem('scName');
	if(scName == null){
		$('#tlb_search').val('');
	} else {
		$('#tlb_search').val(scName);
	}
	
	$('#tbltouchFlow').hide();
	$('#tbl_slider_genre').hide();
	
	$('#tipbox_list_sec').css('margin-top', '0px');
	
	getTipboxList();
});

//지역버튼 클릭시
$(document).on('click', '#Go_AreaTipboxList', function(){
	$('#tbl_menu').find('div').removeClass('haeder_menu_div_base');
	$('#tbl_menu').find('div').removeClass('haeder_menu_div_on');
	$(this).find('div').addClass('haeder_menu_div_on');
	$('#Go_AllTipboxList').find('div').addClass('haeder_menu_div_base');
	$('#Go_GenreTipboxList').find('div').addClass('haeder_menu_div_base');
	
	var pageChk = sessionStorage.getItem('scPage');
	if(pageChk != 'Go_AreaTipboxList'){
		sessionStorage.setItem('scPage', 'Go_AreaTipboxList');
		sessionStorage.removeItem('scLimit');
		sessionStorage.removeItem('scLimitEnd');
		sessionStorage.removeItem('scName');
		sessionStorage.removeItem('scGenre');
		sessionStorage.removeItem('scScroll');
	}
	
	var scName = sessionStorage.getItem('scName');
	if(scName == null){
		$('#tlb_search').val('');
	} else {
		$('#tlb_search').val(scName);
	}
	
	sessionStorage.removeItem('scLimit');
	
	$('#tbl_slider_genre').hide();
	$('#tbltouchFlow').show();
	
	$('#tipbox_list_sec').css('margin-top', '40px');
	//지역 슬라이드 생성
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
			
			$('#tbl_slider_area').empty();
			
			var area = sessionStorage.getItem('scArea');
			if(area == null || area == '전국'){
				var li_content = '<li class="tbl_header_li slider_on"><div>전국</div></li>';
    		} else {
    			var li_content = '<li class="tbl_header_li"><div>전국</div></li>';
    		}
			
			$('#tbl_slider_area').append(li_content);
			
			$(DATA).each(function(i) {
				var AREA_NAME = $(this).find("AREA_NAME").text();
				var AREA_VALUE = $(this).find('AREA_VALUE').text();
				
				var area = sessionStorage.getItem('scArea');
				if(area != null && area == AREA_NAME){
					var li_content = '<li class="tbl_header_li slider_on"><div>'+AREA_NAME+'</div></li>';
				} else {
					var li_content = '<li class="tbl_header_li"><div>'+AREA_NAME+'</div></li>';
				}
				
				$('#tbl_slider_area').append(li_content);
				
		}).promise().done(function (){
			var carousel;

    	    carousel = $("#tbl_slider_area");
    	    carousel.itemslide(
    	    	{
    	    		left_sided: true,
    	    		disable_clicktoslide: true
    	    	}
    	    );
    	    carousel.reload();
    		
    		var area = sessionStorage.getItem('scArea');
    		
    		if(area == null){
    			area = '전국';
    			sessionStorage.setItem('scArea', area);
    		}

    		getTipboxList();
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
	});
	
});

//장르버튼 클릭시
$(document).on('click', '#Go_GenreTipboxList', function(){
	$('#tbl_menu').find('div').removeClass('haeder_menu_div_base');
	$('#tbl_menu').find('div').removeClass('haeder_menu_div_on');
	$(this).find('div').addClass('haeder_menu_div_on');
	$('#Go_AllTipboxList').find('div').addClass('haeder_menu_div_base');
	$('#Go_AreaTipboxList').find('div').addClass('haeder_menu_div_base');
	
	var pageChk = sessionStorage.getItem('scPage');
	if(pageChk != 'Go_GenreTipboxList'){
		sessionStorage.setItem('scPage', 'Go_GenreTipboxList');
		sessionStorage.removeItem('scLimit');
		sessionStorage.removeItem('scName');
		sessionStorage.removeItem('scLimitEnd');
		sessionStorage.removeItem('scArea');
		sessionStorage.removeItem('scScroll');
	}
	
	var scName = sessionStorage.getItem('scName');
	if(scName == null){
		$('#tlb_search').val('');
	} else {
		$('#tlb_search').val(scName);
	}
	
	$('#tbltouchFlow').hide();
	$('#tbl_slider_genre').show();
	
	$('#tipbox_list_sec').css('margin-top', '40px');
	//장르 슬라이드 생성
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
			
			$('#tbl_slider_genre').empty();
			
			$(DATA).each(function(i) {
				var MAIN_GENRE = $(this).find("MAIN_GENRE").text();
				
				var genre = sessionStorage.getItem('scGenre');
				if(genre == null){
					genre = '음악';
					sessionStorage.setItem('scGenre', genre);
				}
				
				if(genre == MAIN_GENRE){
					var li_content = '<li class="tbi_genre_li area_on"><div>'+MAIN_GENRE+'</div></li>';
				} else {
					var li_content = '<li class="tbi_genre_li"><div>'+MAIN_GENRE+'</div></li>';
				}
				
				
				$('#tbl_slider_genre').append(li_content);
				
		}).promise().done(function (){
    		getTipboxList();
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
	});	
});

//지역 클릭시
$(document).on('click', '.tbl_header_li', function(){
	$('.tbl_header_li').removeClass('slider_on');
	$(this).addClass('slider_on');

	var str = $(this).find('div').text();
	sessionStorage.setItem('scArea', str);
	
	sessionStorage.removeItem('scLimit');
	sessionStorage.removeItem('scLimitEnd');
	sessionStorage.removeItem('scScroll');
	
	var scName = sessionStorage.getItem('scName');
	if(scName == null){
		$('#tlb_search').val('');
	} else {
		$('#tlb_search').val(scName);
	}
	
	getTipboxList();
});

//장르 클릭시
$(document).on('click', '.tbi_genre_li', function(){
	$('.tbi_genre_li').removeClass('area_on');
	$(this).addClass('area_on');
	
	var str = $(this).find('div').text();
	sessionStorage.setItem('scGenre', str);
	
	sessionStorage.removeItem('scLimit');
	sessionStorage.removeItem('scLimitEnd');
	sessionStorage.removeItem('scScroll');
	
	var scName = sessionStorage.getItem('scName');
	if(scName == null){
		$('#tlb_search').val('');
	} else {
		$('#tlb_search').val(scName);
	}
	
	getTipboxList();
});

//모바일 팁박스 페이지 검색부분 입력시 옆에 cancel버튼 표시
$(document).on('keyup', '#tlb_search', function(e){
	var str = $(this).val();
	
	var keycode = e.keyCode;
	
	if(keycode == 13 || keycode == '13'){
		sessionStorage.removeItem('scLimit');
		sessionStorage.removeItem('scLimitEnd');
		sessionStorage.removeItem('scScroll');
		
		sessionStorage.setItem('scName', str);
		
		getTipboxList();
	}
});

//모바일 팁박스 페이지 검색 cancel 버튼 클릭시
$(document).on('click', '#tlb_search_cancel_btn', function(){
	$('#tlb_search').val('');
	
	sessionStorage.removeItem('scLimit');
	sessionStorage.removeItem('scLimitEnd');
	sessionStorage.removeItem('scScroll');
	
	sessionStorage.removeItem('scName');
	
	getTipboxList();
});

//모바일 팁박스 상세로 이동시 스크롤 유지
$(document).on('click', '.tbl_content', function(){
	var scroll = $(window).scrollTop();
	sessionStorage.setItem('scScroll', scroll);
});

//QR스캔하여 팁주기 버튼 클릭시
$(document).on('click', '.tbl_qr_scan_btn', function(){
	//스캐너 띄워서 team_no값 가져오고 , 후원하기 페이지로 바로 이동
	qr_scan_tipbox();
});