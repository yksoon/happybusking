$(document).on('pageinit', '#share_item_list', function(){
	$('#share_item_list_middle').empty();
	
	var share_item_list_middle = '<div id="sil_search">'+ 
									'<div class="ui-grid-b search-input-text-container">'+ 
										'<div class="ui-block-a" id="sil_search_img">'+
											'<img class="search-input-icon" src="/img/artist_ranking/ar_search_.svg">'+
										'</div>'+ 
										'<div class="ui-block-b" id="sil_search_text_div">'+ 
											'<input type="text" class="search-input-text" name="sil_search_text" id="sil_search_text" placeholder="키워드로 검색하기">'+
										'</div>'+
										'<div class="ui-block-c search-input-text-cancel" id="sil_cancle">'+
											'취소' +
											//'<img src="/img/artist_ranking/ar_cancle.svg">'+ 
										'</div>'+ 
									'</div>'+ 
								'</div>';
	
	$('#share_item_list_middle').append(share_item_list_middle);

	var si_category = $('.haeder_menu_div_on').find('span').text();
	var si_search = $('#sil_search_text').val();
	
	getShareItemList('', si_search);
	
});

//전체음향탭 클릭시
$(document).on('click', '#Go_AllEqu', function(){
	$('.header_menu_container').empty();
	var header = '<div class="ui-block-a">'+
					'<div class="haeder_menu_div_on" id="Go_AllEqu">'+
						'<span>전체</span>'+
					'</div>'+
				'</div>'+
				'<div class="ui-block-b">'+
					'<div class="haeder_menu_div_base" id="Go_SoundEqu">'+
						'<span>음향</span>'+
					'</div>'+
				'</div>'+
				'<div class="ui-block-c">'+
					'<div class="haeder_menu_div_base" id="Go_VideoEqu">'+
						'<span>영상</span>'+
					'</div>'+
				'</div>'+	 
				'<div class="ui-block-d">'+
					'<div class="haeder_menu_div_base" id="Go_InstrumentEqu">'+
						'<span>악기</span>'+
					'</div>'+
				'</div>'+	 
				'<div class="ui-block-e">'+
					'<div class="haeder_menu_div_base" id="Go_OtherEqu">'+
						'<span>기타</span>'+
					'</div>'+
				'</div>';
	$('.header_menu_container').append(header);
	
	var si_category = $('.haeder_menu_div_on').find('span').text();
	var si_search = $('#sil_search_text').val();
	getShareItemList('', si_search);
});

//음향탭 클릭시
$(document).on('click', '#Go_SoundEqu', function(){
	$('.header_menu_container').empty();
	var header = '<div class="ui-block-a">'+
					'<div class="haeder_menu_div_base" id="Go_AllEqu">'+
						'<span>전체</span>'+
					'</div>'+
				'</div>'+
				'<div class="ui-block-b">'+
					'<div class="haeder_menu_div_on" id="Go_SoundEqu">'+
						'<span>음향</span>'+
					'</div>'+
				'</div>'+
				'<div class="ui-block-c">'+
					'<div class="haeder_menu_div_base" id="Go_VideoEqu">'+
						'<span>영상</span>'+
					'</div>'+
				'</div>'+	 
				'<div class="ui-block-d">'+
					'<div class="haeder_menu_div_base" id="Go_InstrumentEqu">'+
						'<span>악기</span>'+
					'</div>'+
				'</div>'+	 
				'<div class="ui-block-e">'+
					'<div class="haeder_menu_div_base" id="Go_OtherEqu">'+
						'<span>기타</span>'+
					'</div>'+
				'</div>';
	$('.header_menu_container').append(header);
	
	var si_category = $('.haeder_menu_div_on').find('span').text();
	var si_search = $('#sil_search_text').val();
	getShareItemList(si_category, si_search);
});

//영상 탭 클릭시
$(document).on('click', '#Go_VideoEqu', function(){
	$('.header_menu_container').empty();
	var header = '<div class="ui-block-a">'+
					'<div class="haeder_menu_div_base" id="Go_AllEqu">'+
						'<span>전체</span>'+
					'</div>'+
				'</div>'+
				'<div class="ui-block-b">'+
					'<div class="haeder_menu_div_base" id="Go_SoundEqu">'+
						'<span>음향</span>'+
					'</div>'+
				'</div>'+
				'<div class="ui-block-c">'+
					'<div class="haeder_menu_div_on" id="Go_VideoEqu">'+
						'<span>영상</span>'+
					'</div>'+
				'</div>'+	 
				'<div class="ui-block-d">'+
					'<div class="haeder_menu_div_base" id="Go_InstrumentEqu">'+
						'<span>악기</span>'+
					'</div>'+
				'</div>'+	 
				'<div class="ui-block-e">'+
					'<div class="haeder_menu_div_base" id="Go_OtherEqu">'+
						'<span>기타</span>'+
					'</div>'+
				'</div>';
	$('.header_menu_container').append(header);
	
	var si_category = $('.haeder_menu_div_on').find('span').text();
	var si_search = $('#sil_search_text').val();
	getShareItemList(si_category, si_search);
});

//악기 탭 클릭시
$(document).on('click', '#Go_InstrumentEqu', function(){
	$('.header_menu_container').empty();
	var header = '<div class="ui-block-a">'+
					'<div class="haeder_menu_div_base" id="Go_AllEqu">'+
						'<span>전체</span>'+
					'</div>'+
				'</div>'+
				'<div class="ui-block-b">'+
					'<div class="haeder_menu_div_base" id="Go_SoundEqu">'+
						'<span>음향</span>'+
					'</div>'+
				'</div>'+
				'<div class="ui-block-c">'+
					'<div class="haeder_menu_div_base" id="Go_VideoEqu">'+
						'<span>영상</span>'+
					'</div>'+
				'</div>'+	 
				'<div class="ui-block-d">'+
					'<div class="haeder_menu_div_on" id="Go_InstrumentEqu">'+
						'<span>악기</span>'+
					'</div>'+
				'</div>'+	 
				'<div class="ui-block-e">'+
					'<div class="haeder_menu_div_base" id="Go_OtherEqu">'+
						'<span>기타</span>'+
					'</div>'+
				'</div>';
	$('.header_menu_container').append(header);
	
	var si_category = $('.haeder_menu_div_on').find('span').text();
	var si_search = $('#sil_search_text').val();
	getShareItemList(si_category, si_search);
});

//기타 탭 클릭시
$(document).on('click', '#Go_OtherEqu', function(){
	$('.header_menu_container').empty();
	var header = '<div class="ui-block-a">'+
					'<div class="haeder_menu_div_base" id="Go_AllEqu">'+
						'<span>전체</span>'+
					'</div>'+
				'</div>'+
				'<div class="ui-block-b">'+
					'<div class="haeder_menu_div_base" id="Go_SoundEqu">'+
						'<span>음향</span>'+
					'</div>'+
				'</div>'+
				'<div class="ui-block-c">'+
					'<div class="haeder_menu_div_base" id="Go_VideoEqu">'+
						'<span>영상</span>'+
					'</div>'+
				'</div>'+	 
				'<div class="ui-block-d">'+
					'<div class="haeder_menu_div_base" id="Go_InstrumentEqu">'+
						'<span>악기</span>'+
					'</div>'+
				'</div>'+	 
				'<div class="ui-block-e">'+
					'<div class="haeder_menu_div_on" id="Go_OtherEqu">'+
						'<span>기타</span>'+
					'</div>'+
				'</div>';
	$('.header_menu_container').append(header);
	
	var si_category = $('.haeder_menu_div_on').find('span').text();
	var si_search = $('#sil_search_text').val();
	getShareItemList(si_category, si_search);
});

//키워드 검색에 입력시
$(document).on('keyup', '#sil_search_text', function(e){
	var si_category = $('.haeder_menu_div_on').find('span').text();
	
	if(si_category == '전체'){
		si_category = '';
	}
	
	var si_search = $(this).val();
	
	//키워드 검색에서 엔터키 클릭시
	if(e.keyCode == 13){
		getShareItemList(si_category, si_search);
	}
});

//키워드 검색에 X버튼 클릭시
$(document).on('click', '#sil_cancle', function(){
	$('#sil_search_text').val('');
	
	var si_category = $('.haeder_menu_div_on').find('span').text();
	
	if(si_category == '전체'){
		si_category = '';
	}
	getShareItemList(si_category, '');
});