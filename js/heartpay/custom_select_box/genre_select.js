var MAX_GENRE_COUNT =7;			//장르 최대 선택 갯수

//장르선택 팝업 메인장르 탭 클릭시
$(document).on('click', '.gs_mg_title', function(){
	$('.gs_mg_title').removeClass('gs_mg_on');
	$(this).addClass('gs_mg_on');
	
	var str = $(this).attr('id');
	$('.gsb_group').hide();
	$('.'+str).show();
});

//뒤로가기 버튼 클릭시
$(document).on('click', '#genre_select_back', function(){
	sessionStorage.removeItem('selectGenreTemp');
	
	$('#genre_select_popup').hide();
	
	$('#header').show();
	$('#footer').show();
	$('#text_area').blur();
});

//선택완료 버튼 클릭시
$(document).on('click', '#gs_footer', function(){
	var selectGenreTemp = sessionStorage.getItem('selectGenreTemp');
	
	if(selectGenreTemp == null || selectGenreTemp == ''){
		alert('장르를 선택해주세요.');
		return;
	}
	
	$('#select_genre').val(selectGenreTemp);
	
	var mainGenre;
	var textGenre;
	
	$.ajax({
        type: "GET",
        cache: false,
        url: "/service/common/get_search_main_genre.jsp",
        data: {
        	selectGenre: selectGenreTemp
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        async: false,
        success: function(data) {
        	var ROOT = $(data).find('ROOT');
        	var DATA = $(ROOT).find('DATA');
        	var DATA2 = $(ROOT).find('DATA2');
        	
        	$(DATA).each(function(i){
        		var MAIN_GENRE = $(this).find('MAIN_GENRE').text();
        		if(i == 0){
        			mainGenre = MAIN_GENRE;
        		} else {
        			mainGenre += ',' + MAIN_GENRE;
        		}
        	});
        	
        	$(DATA2).each(function(i){
        		var SUB_GENRE = $(this).find('SUB_GENRE').text();
        		if(i == 0){
        			textGenre = SUB_GENRE;
        		} else {
        			textGenre += ', ' + SUB_GENRE;
        		}
        	});
        },
        complete: function(){
        	$('#text_genre').val(textGenre);
        	$('#main_genre').val(mainGenre);
        }
	});
	
	sessionStorage.setItem('selectGenre', selectGenreTemp);
	sessionStorage.removeItem('selectGenreTemp');
	
	$('#genre_select_popup').hide();
	
	$('#header').show();
	$('#footer').show();
});

//장르 아이템 클릭시
$(document).on('click', '.gsb_item', function(){
	var selectChk = $(this).attr('class').split(' ');
	selectChk = selectChk[selectChk.length - 1];
	
	var selectValue = $(this).attr('id');
	
	var selectGenreTemp = sessionStorage.getItem('selectGenreTemp');
	if(selectGenreTemp == null || selectGenreTemp == ''){
		selectGenreTemp = new Array();
	} else {
		selectGenreTemp = selectGenreTemp.split(',');
	}
	
	var nowPage = $('.ui-page').attr('id');
	
	if(selectChk == 'gsb_item_on'){
		//선택 되어있는 경우
		//선택 해제해야함
		$(this).removeClass('gsb_item_on');
		
		if(nowPage == 'perform_request_search'){
			var allChk = $(this).parents('.gsb_list').find('.gsb_item_all').attr('class').split(' ');
			allChk = allChk[allChk.length - 1];
			
			if(allChk == 'gsb_item_on'){
				$(this).parents('.gsb_list').find('.gsb_item_all').removeClass('gsb_item_on');
			}
		}
		
		selectGenreTemp.splice(selectGenreTemp.indexOf(selectValue), 1);
		
	} else {
		//선택 해제되어있는 경우
		//선택 해야함
		
		if(nowPage != 'perform_request_search'){
			//최대 개수 넘는 경우 return
			if($('.gsb_item_on').length >= MAX_GENRE_COUNT){
				alert('장르는 '+MAX_GENRE_COUNT+'개까지만 선택 가능합니다.');
				return;
			}
		}
		
		$(this).addClass('gsb_item_on');
		
		if(nowPage == 'perform_request_search'){
			var itemTotalLength = $(this).parents('.gsb_list').find('.gsb_item').length;
			var selectTotalLength = $(this).parents('.gsb_list').find('.gsb_item_on').length;
			
			if(itemTotalLength == selectTotalLength){
				$(this).parents('.gsb_list').find('.gsb_item_all').addClass('gsb_item_on');
			}
		}
		
		
		selectGenreTemp.push(selectValue);
		selectGenreTemp.join(',');
	}
	
	sessionStorage.setItem('selectGenreTemp', selectGenreTemp);
	
	var mainChk = $(this).attr('class').split(' ')[1];
	if(mainChk == 'gsb_main_vocal' || mainChk == 'gsb_main_instrument'){
		musicClickEvnet(mainChk);
	}
});

//장르별 '전체' 아이템 클릭시
$(document).on('click', '.gsb_item_all', function(){
	var selectGenreTemp = sessionStorage.getItem('selectGenreTemp');
	if(selectGenreTemp == null || selectGenreTemp == ''){
		selectGenreTemp = new Array();
	} else {
		selectGenreTemp = selectGenreTemp.split(',');
	}
	
	var selectChk = $(this).attr('class').split(' ');
	selectChk = selectChk[selectChk.length - 1];
	
	var str;
	
	if(selectChk == 'gsb_item_on'){
		//선택되어있는 경우
		//선택 해제 해줘야함
		$(this).removeClass('gsb_item_on');
		var selectLength = $(this).parents('.gsb_list').find('.gsb_item_on').length;
		for(i = 0; i < selectLength; i++){
			str = $(this).parents('.gsb_list').find('.gsb_item_on').eq(i).attr('id');
			selectGenreTemp.splice(selectGenreTemp.indexOf(str), 1);
			
			console.log(str);
			
			sessionStorage.setItem('selectGenreTemp', selectGenreTemp);
			
			if(str == '1' || str == '2'){
				vocalinstRemoveClass('gsb_main_vocal');
				vocalinstRemoveClass('gsb_main_instrument');
			}
		}
		
		$(this).parents('.gsb_list').find('.gsb_item_on').removeClass('gsb_item_on');
		
	} else {
		//선택되어있지 않은 경우
		//선택 해줘야함
		$(this).addClass('gsb_item_on');
		var selectLength = $(this).parents('.gsb_list').find('.gsb_item').length;
		
		for(i = 0; i < selectLength; i++){
			str = $(this).parents('.gsb_list').find('.gsb_item').eq(i).attr('id');
			
			var selectChkForID = $('#'+str).attr('class').split(' ');
			selectChkForID = selectChkForID[selectChkForID.length - 1];
			
			if(selectChkForID != 'gsb_item_on'){
				selectGenreTemp.push(str);
			}
			
			if(str == '1' || str == '2'){
				$('#gsb_main_vocal').show();
				$('#gsb_main_instrument').show();
			}
		}
		$(this).parents('.gsb_list').find('.gsb_item').addClass('gsb_item_on');
		selectGenreTemp.join(',');
		
		sessionStorage.setItem('selectGenreTemp', selectGenreTemp);
	}
});
