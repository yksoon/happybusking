/*$(document).on('panelopen', '#panel', function(){
    $.ajax({
        type: "GET",
        cache: false,
        async: false,
        url: '/service/common/new_board_chk.jsp',
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function(data) {
        	var ROOT = $(data).find('ROOT');
        	var DATA = $(ROOT).find('DATA');
        	
        	$(DATA).each(function(){
        		var BOARD_CATEGORY = $(this).find('BOARD_CATEGORY').text();
        		
        		switch(BOARD_CATEGORY){
        		case '1': 
        			//자유
        			$('.free_new_image').show();
        		case '2':
        			//팀 모집
        			$('.teamapply_new_image').show();
        		case '3':
        			//함께해요
        			$('.together_new_image').show();
        		default:
        			return;
        		}
        	});
        },
        error: function(xhr){
        	console.log(xhr);
        }
    });
});*/

//관람자 메뉴 클릭시
$(document).on('click', '#panel_spactator_menu', function(){
	var smViewState = $(this).find('.ui-block-b').find('img').attr('src');
	
	if(smViewState == '/img/common/show_btn.svg'){
		$('.panel_spactator_menu').slideDown('fast');
		$(this).find('.ui-block-b').find('img').attr('src', '/img/common/showing_btn1.svg');
	} else {
		$('.panel_spactator_menu').slideUp('fast');
		$(this).find('.ui-block-b').find('img').attr('src', '/img/common/show_btn.svg');
	}
});

//아티스트 메뉴 클릭시
$(document).on('click', '#panel_artist_menu', function(){
	var amViewState = $(this).find('.ui-block-b').find('img').attr('src');
	
	if(amViewState == '/img/common/show_btn.svg'){
		$('.panel_artist_menu').slideDown('fast');
		$('.pamCommunity').slideDown('fast');
		$(this).find('.ui-block-b').find('img').attr('src', '/img/common/showing_btn1.svg');
	} else {
		$('.panel_artist_menu').slideUp('fast');
		$('.panel_sub_menu').slideUp('fast');
		$(this).find('.ui-block-b').find('img').attr('src', '/img/common/show_btn.svg');
	}
});

//공통-마이페이지 메뉴 클릭시
$(document).on('click', '#panel_mypage_menu', function(){
var amViewState = $(this).find('.ui-block-b').find('img').attr('src');
	
	if(amViewState == '/img/common/show_btn.svg'){
		$('.panel_mypage_menu').slideDown('fast');
		$(this).find('.ui-block-b').find('img').attr('src', '/img/common/showing_btn1.svg');
	} else {
		$('.panel_mypage_menu').slideUp('fast');
		$(this).find('.ui-block-b').find('img').attr('src', '/img/common/show_btn.svg');
	}
});

//아티스트 하위메뉴 클릭시
$(document).on('click', '.panel_menu', function(){
	var pmID = $(this).attr('id');
	var pmViewState = $('.' + pmID).css('display');
	
	if(pmViewState == 'none'){
		$(this).find('.ui-block-b').find('img').attr('src', '/img/common/showing_btn1.svg');
		$('.' + pmID).slideDown('fast');
	} else {
		$(this).find('.ui-block-b').find('img').attr('src', '/img/common/show_btn.svg');
		$('.' + pmID).slideUp('fast');
	}
});



//패널 관련 function
function goArtistPush(){
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/pushService/artistPush.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete: function(){
			alert('푸시 전송 완료');
		}
	});
}



