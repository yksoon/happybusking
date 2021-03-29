//뒤로가기 버튼 클릭시
$(document).on('click', '#area_select_back', function(){
	sessionStorage.removeItem('selectAreaTemp');
	
	$('#area_select_popup').hide();
	
	$('#header').show();
	$('#footer').show();
	$('#select_area').blur();
});

//시/도 전체 선택시
$(document).on('click', '.asb_item_all.asb_main_item', function(){
	$('.asb_item.asb_main_item').removeClass('asb_item_on');
	$(this).addClass('asb_item_on');
	$('.asb_second_container').hide();
	$('.asb_second_container').find('.asb_item_all').addClass('asb_item_on');
	$('.asb_second_container').find('.asb_item').removeClass('asb_item_on');
});

//시/도 아이템 선택시
$(document).on('click', '.asb_item.asb_main_item', function(){
	var str = $(this).attr('id');
	
	$('.asb_main_item.asb_item_all').removeClass('asb_item_on');
	
	var showChk = $(this).attr('class').split(' ');
	showChk = showChk[showChk.length-1];
	
	if(showChk == 'asb_item_on'){
		//이미 선택되어있는 경우
		//해제 해줘야함
		$(this).removeClass('asb_item_on');
		$('.'+str).hide();
		$('.'+str).find('.asb_item_all').click();
		
		var sidoChk = $('.asb_item.asb_main_item.asb_item_on').length;
		if(sidoChk == 0) $('.asb_item_all.asb_main_item').addClass('asb_item_on');
		
	} else {
		//선택 안되어있는 경우
		//선택 해줘야함
		$(this).addClass('asb_item_on');
		$('.'+str).show();
	}
});


//구/군 전체 선택시
$(document).on('click', '.asb_item_all.asb_sub_item', function(){
	$(this).nextAll().removeClass('asb_item_on');
	$(this).addClass('asb_item_on');
});

//구/군 아이템 선택시
$(document).on('click', '.asb_item.asb_sub_item', function(){
	var showChk = $(this).attr('class').split(' ');
	showChk = showChk[showChk.length-1];
	
	if(showChk == 'asb_item_on'){
		//이미 선택되어있는 경우
		//해제 해줘야함
		$(this).removeClass('asb_item_on');
		var gugunChk = $(this).parents('.asb_list').find('.asb_item.asb_sub_item.asb_item_on').length;
		if(gugunChk == 0) $(this).parents('.asb_list').find('.asb_item_all').addClass('asb_item_on');
		
	} else {
		//선택 안되어있는 경우
		//선택 해줘야함
		$(this).parents('.asb_list').find('.asb_item_all').removeClass('asb_item_on');
		$(this).addClass('asb_item_on');
		
		var gugunCount = $(this).parents('.asb_list').find('.asb_item.asb_sub_item').length;
		var gugunChk = $(this).parents('.asb_list').find('.asb_item.asb_sub_item.asb_item_on').length;
		
		if(gugunCount == gugunChk){
			$(this).parents('.asb_list').find('.asb_item.asb_sub_item').removeClass('asb_item_on');
			$(this).parents('.asb_list').find('.asb_item_all').addClass('asb_item_on');
		}
	}
});

var AREA_SELECT_MAX_COUNT = 7;
//선택완료 버튼 클릭시
$(document).on('click', '#as_footer', function(){
	var sidoCount, sigunguCount;
	var sido = '', sigungu = '';
	var sidoText = '', sigunguText = '';
	var area = '', areaText = '';
	var sidoAllChk = $('.asb_item_all.asb_main_item').attr('class').split(' ');
	sidoAllChk = sidoAllChk[sidoAllChk.length-1];
	
	if(sidoAllChk == 'asb_item_on'){
		//시/도에 전체 체크 되어있으면
		$('#select_area').val('');
		$('#text_area').val('전체');
	} else {
		sidoCount = $('.asb_item.asb_main_item.asb_item_on').length;
		for(var i=0; i < sidoCount; i++){
			if(i == 0){
				sido += $('.asb_item.asb_main_item.asb_item_on').eq(i).attr('id');
				sidoText += $('.asb_item.asb_main_item.asb_item_on').eq(i).text();
			} else {
				sido += ',' + $('.asb_item.asb_main_item.asb_item_on').eq(i).attr('id');
				sidoText += ',' + $('.asb_item.asb_main_item.asb_item_on').eq(i).text();
			}
		}
		
		sigunguCount = $('.asb_item.asb_sub_item.asb_item_on').length;
		for(var i=0; i < sigunguCount; i++){
			sido += ',' + $('.asb_item.asb_sub_item.asb_item_on').eq(i).attr('id');
			sidoText += ',' + $('.asb_item.asb_sub_item.asb_item_on').eq(i).text();
		}
		
		$('#select_area').val(sido);
		$('#text_area').val(sidoText);
	}
	
	$('#area_select_popup').hide();
	
	$('#header').show();
	$('#footer').show();
	$('#select_area').blur();
});