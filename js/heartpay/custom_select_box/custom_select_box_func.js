function viewGenreSelectBox(){
	$('#genre_select_popup').load('/app_root/jsp/custom_select_box/genre_select.jsp', function(){
		$('#genre_select_popup').show();
		
		$('#header').hide();
		$('#footer').hide();
		
		$.ajax({
	        type: "GET",
	        cache: false,
	        url: "/service/common/get_sub_genre.jsp",
	        contentType: "application/xml; charset=utf-8",
	        dataType: "xml",
	        timeout: 30000,
	        async: false,
	        success: function(data) {
	        	var selectGenre = $('#select_genre').val();
	        	if(selectGenre != '' && typeof selectGenre != 'undefined'){
	        		sessionStorage.setItem('selectGenreTemp', selectGenre);
	        	}
	        	
	        	$('.gsb_list').empty();
	        	
	        	var nowPage = $('.ui-page').attr('id');
	        	
	        	if(nowPage == 'perform_request_search'){
	        		var htmlAll = '<div class="gsb_item_all">전체</div>';
	        		
	        		$('.gsb_list').append(htmlAll);
	        		$('#music_type').find('.gsb_item_all').text('보컬 + 연주');
	        	}
	        	
	            var ROOT = $(data).find("ROOT");
	            var DATA = $(ROOT).find('DATA');
	            $(DATA).each(function(i) {
	            	var GENRE_NO = $(this).find('GENRE_NO').text();
	            	var SUB_GENRE = $(this).find('SUB_GENRE').text();
	            	var GENRE_TAP = $(this).find('GENRE_TAP').text();
	            	
	            	var html;
	            	
	            	if(GENRE_TAP == 'music_type'){
	            		if(SUB_GENRE == '보컬'){
	            			html = '<div class="gsb_item gsb_main_vocal" id="'+GENRE_NO+'">' + SUB_GENRE + '</div>';
	            		} else if(SUB_GENRE == '연주'){
	            			html = '<div class="gsb_item gsb_main_instrument" id="'+GENRE_NO+'">' + SUB_GENRE + '</div>';
	            		}
	            	} else {
	            		html = '<div class="gsb_item gsb_'+GENRE_NO+'" id="'+GENRE_NO+'">' + SUB_GENRE + '</div>';
	            	}
	            	
	            	
	            	$('#' + GENRE_TAP).append(html);
	            	
	            	
	            });
	        },
	        error: function(xhr, message, errorThrown) {},
	        complete: function(){
	        	var selectGenre = sessionStorage.getItem('selectGenre');
	        	if(selectGenre != null && selectGenre != ''){
	        		selectGenre = selectGenre.split(',');
	        		
        			for(var i = 0; i < selectGenre.length; i++){
	        			$('#genre_select').find('#'+selectGenre[i]).addClass('gsb_item_on');
	        			
	        			if(selectGenre[i] == '1'){
	        				$('#gsb_main_vocal').show();
	        			} else if(selectGenre[i] == '2') {
	        				$('#gsb_main_vocal').show();
	        				$('#gsb_main_instrument').show();
	        			}
	        		}
	        	}
	        	
	        	$('.gs_mg_music').show();
	        	
	        	$.ajax({
	    	        type: "GET",
	    	        cache: false,
	    	        url: "/service/common/get_genre_tap.jsp",
	    	        contentType: "application/xml; charset=utf-8",
	    	        dataType: "xml",
	    	        timeout: 30000,
	    	        async: false,
	    	        success: function(data) {
	    	        	var ROOT = $(data).find('ROOT');
	    	        	var DATA = $(ROOT).find('DATA');
	    	        	
	    	        	$(DATA).each(function(i){
	    	        		var GENRE_TAP = $(this).find('GENRE_TAP').text();
	    	        		
	    	        		var itemLength = $('#'+GENRE_TAP).find('.gsb_item').length;
	    	        		var selectLength = $('#'+GENRE_TAP).find('.gsb_item_on').length;
	    	        		
	    	        		if(itemLength == selectLength){
	    	        			$('#'+GENRE_TAP).find('.gsb_item_all').addClass('gsb_item_on');
	    	        		}
	    	        	});
	    	        }
	        	});
	        }
	    });
	});
}


//보컬, 연주 클릭시 서브장르 띄워주기 
function musicClickEvnet(str){
	var selectChk = $('.'+str).attr('class').split(' ');
	selectChk = selectChk[selectChk.length - 1];			//아이템 선택 체크
	
	if(selectChk != 'gsb_item_on'){
		//선택 되어있는 경우
		//선택 해제해야함
		if(str == 'gsb_main_vocal'){
			//보컬 해제하는 경우
			var instrumentChk = $('.gsb_main_instrument').attr('class').split(' ');
			instrumentChk = instrumentChk[instrumentChk.length-1];	// 연주 선택 체크
			
			if(instrumentChk == 'gsb_item_on'){
				//연주는 선택되어있는 경우
			} else {
				//연주도 해제되어있는 경우
				vocalinstRemoveClass('gsb_main_vocal');
				vocalinstRemoveClass('gsb_main_instrument');
			}
		} else if(str == 'gsb_main_instrument'){
			//악기 해제하는 경우
			var vocalChk = $('.gsb_main_vocal').attr('class').split(' ');
			vocalChk = vocalChk[vocalChk.length-1];	//보컬 선택 체크
			
			if(vocalChk == 'gsb_item_on'){
				//보컬은 선택되어있는 경우
				vocalinstRemoveClass('gsb_main_instrument');
			} else {
				//보컬도 해제되어있는 경우
				vocalinstRemoveClass('gsb_main_vocal');
				vocalinstRemoveClass('gsb_main_instrument');
			}
		}
	} else {
		//선택 해제되어있는 경우
		//선택 해야함
		$('#gsb_main_vocal').show();
		
		if(str == 'gsb_main_instrument'){
			//연주 선택한 경우에 둘다 보여주기.
			$('#gsb_main_instrument').show();
		}
	}
}

//보컬, 연주 해제시 하위 카테고리 전부 선택 해제
function vocalinstRemoveClass(str){
	var itemLength = $('#'+str).find('.gsb_item_on').length;
	var id;
	
	if(itemLength > 0){
		var selectGenreTemp = sessionStorage.getItem('selectGenreTemp');
		if(selectGenreTemp == null || selectGenreTemp == ''){
			selectGenreTemp = new Array();
		} else {
			selectGenreTemp = selectGenreTemp.split(',');
		}
		
		for(i = 0; i < itemLength; i++){
			id = $('#'+str).find('.gsb_item_on').eq(i).attr('id');
			selectGenreTemp.splice(selectGenreTemp.indexOf(id), 1);
		}
		
		$('#'+str).find('.gsb_item_on').removeClass('gsb_item_on');
		sessionStorage.setItem('selectGenreTemp', selectGenreTemp);
	}
	
	$('#'+str).hide();
}


function viewAreaSelectBox(){
	$.mobile.loading( 'show', { text: '로딩중입니다.', textVisible: true, theme: 'b', html: "" });
	$('#area_select_popup').load('/app_root/jsp/custom_select_box/area_select.jsp', function(){
		$('#area_select_popup').show();
		
		$('#header').hide();
		$('#footer').hide();
		
		$('#si_do').empty();
		
		$.ajax({
	        type: "GET",
	        cache: false,
	        url: "/service/common/get_area_code.jsp",
	        contentType: "application/xml; charset=utf-8",
	        dataType: "xml",
	        timeout: 30000,
	        async: false,
	        success: function(data) {
	        	var ROOT = $(data).find('ROOT');
	        	var DATA = $(ROOT).find('DATA');
        		
        		var htmlAll = '<div class="asb_item_all asb_main_item asb_item_on">전체</div>';
        		$('#si_do').append(htmlAll);
	        	
	        	$(DATA).each(function(i){
	        		var CODE_AREA = $(this).find('CODE_AREA').text();
	        		var AREA_VALUE = $(this).find('AREA_VALUE').text();
	        		
	        		var html = '<div class="asb_item asb_main_item" id="'+CODE_AREA+'">' + AREA_VALUE + '</div>';
	        		$('#si_do').append(html);
	        	});
	        },
	        error: function(x, h, r){
	        	console.log(x);
	        	console.log(h);
	        	console.log(r);
	        },
	        complete: function(){
	        	$.ajax({
	    	        type: "GET",
	    	        cache: false,
	    	        url: "/service/common/get_area_sub_code_all.jsp",
	    	        contentType: "application/xml; charset=utf-8",
	    	        dataType: "xml",
	    	        timeout: 30000,
	    	        async: false,
	    	        success: function(data) {
	    	        	var ROOT = $(data).find('ROOT');
	    	        	var DATA = $(ROOT).find('DATA');
	            		
	            		var htmlAll = '<div class="asb_item_all asb_sub_item asb_item_on">전체</div>';
	            		$('.asb_second_container').find('.asb_list').append(htmlAll);
	    	        	
	    	        	$(DATA).each(function(i){
	    	        		var AREA_ID = $(this).find('AREA_ID').text();
	    	        		var AREA_SUB_ID = $(this).find('AREA_SUB_ID').text();
	    	        		var AREA_KEY = $(this).find('AREA_KEY').text();
	    	        		var AREA_VALUE = $(this).find('AREA_VALUE').text();
	    	        		
	    	        		var html = '<div class="asb_item asb_sub_item" id="'+AREA_ID+'">' + AREA_VALUE + '</div>';
	    	        		$('.'+AREA_SUB_ID).find('.asb_list').append(html);
	    	        	});
	    	        },
	    	        error: function(x, h, r){
	    	        	console.log(x);
	    	        	console.log(h);
	    	        	console.log(r);
	    	        },
	    	        complete: function(){
	    	        	var select = $('#select_area').val();
	    	        	if(select == '') {
	    	        		$.mobile.loading( 'hide', { text: '로딩중입니다.', textVisible: true, theme: 'b', html: "" });
	    	        		return;
	    	        	}
	    	        	else {
	    	        		select = select.split(',');
	    	        		for(var i=0; i<select.length; i++){
	    	        			$('#'+select[i]).click();
	    	        		}
		    	        	$.mobile.loading( 'hide', { text: '로딩중입니다.', textVisible: true, theme: 'b', html: "" });
	    	        	}
	    	        }
	        	});
	        }
    	});
	});
}