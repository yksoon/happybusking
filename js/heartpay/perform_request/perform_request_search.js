$(document).on('pageinit', '#perform_request_search', function() {
	team_info_pageNo = 1;
	sessionStorage.setItem('prqstate', 'Y');
	$('#prq_search_result_title').hide();
	
	var sessiongenre = sessionStorage.getItem('tgenre');
	if(sessiongenre != null && sessiongenre != ''){
		$('#text_genre').val(sessiongenre);
	}
	
	//지역코드 가져오기
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
				
				var area_select = '<option value="'+AREA_NAME+'">'+AREA_NAME+'</option>';
				
				$('#prq_sh_csh_area').append(area_select);
				//$('#sc_area li:firstchild').css('font-weight', 'bold');
				$('#prq_sh_csh_area').selectmenu("refresh", true);
				
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			var sessionarea = sessionStorage.getItem('tarea');
			if(sessionarea != null && sessionarea != ''){
				$('#prq_sh_csh_area').val(sessionarea).prop('selected', true);
				$('#prq_sh_csh_area').selectmenu("refresh", true);
			}
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error
	});
	
	var sessionname = sessionStorage.getItem('tname');
	var sessiongenre = sessionStorage.getItem('tgenre');
	var sessionarea = sessionStorage.getItem('tarea');
	var sessionsmoney = sessionStorage.getItem('tsmoney');
	var sessionemoney = sessionStorage.getItem('temoney');
	var sessiontype = sessionStorage.getItem('ttype');
	var sessiontextgenre = sessionStorage.getItem('textGenre');
	
	if(sessionname != null){
		if(sessionname != ''){
			$('#Go_NameSC').click();
			$('#prq_tname').val(sessionname);
			pr_search_team(sessionname, '', '', '', '');
		}
	} else if(sessiongenre != null){
		$('#text_genre').val(sessiontextgenre);
		$('#select_genre').val(sessiongenre);
		
		if(sessionsmoney != ''){
			$('#prq_tsmoney').val(sessionsmoney);
		}
		if(sessionemoney != ''){
			$('#prq_temoney').val(sessionemoney);
		}
		
		if(sessiontype == '1'){
			$('#tsolo').prop('checked', true);
			$('label[for=tsolo]').removeClass('ui-checkbox-off');
			$('label[for=tsolo]').addClass('ui-checkbox-on');
			
		} else if(sessiontype == '2'){
			$('#tteam').prop('checked', true);
			$('label[for=tteam]').removeClass('ui-checkbox-off');
			$('label[for=tteam]').addClass('ui-checkbox-on');
		} else if(sessiontype == '3'){
			$('#tsolo').prop('checked', true);
			$('label[for=tsolo]').removeClass('ui-checkbox-off');
			$('label[for=tsolo]').addClass('ui-checkbox-on');
			$('#tteam').prop('checked', true);
			$('label[for=tteam]').removeClass('ui-checkbox-off');
			$('label[for=tteam]').addClass('ui-checkbox-on');
		}
		
		pr_search_team('', sessiongenre, sessionarea, sessionsmoney, sessionemoney, sessiontype);
			
	}
});

//조건검색 버튼 클릭시
$(document).on('click', '#Go_ConditionSC', function(){
	$('.header_menu_container').empty();
	var prs_menu = '<div class="ui-block-a">'+
						'<div id="Go_ConditionSC" class="haeder_menu_div_on">'+
							'<span>조건검색</span>'+
						'</div>'+
					'</div>'+
					'<div class="ui-block-b">'+
						'<div id="Go_NameSC" class="haeder_menu_div_base">'+
							'<span>이름검색</span>'+
						'</div>'+
					'</div>';	
	
	$('.header_menu_container').append(prs_menu);
	
	$('.prq_sh_csh_content').show();
	$('.prq_sh_tname_input').hide();
	$('#prq_sh_request_btn').hide();
	$('#prq_search_result_title').hide();
	
	$('#prq_search_content').empty();
	
});

//이름검색 버튼 클릭시
$(document).on('click', '#Go_NameSC', function(){
	$('.header_menu_container').empty();
	var prs_menu = '<div class="ui-block-a">'+
						'<div id="Go_ConditionSC" class="haeder_menu_div_base">'+
							'<span>조건검색</span>'+
						'</div>'+
					'</div>'+
					'<div class="ui-block-b">'+
						'<div id="Go_NameSC" class="haeder_menu_div_on">'+
							'<span>이름검색</span>'+
						'</div>'+
					'</div>';	
	
	$('.header_menu_container').append(prs_menu);
	
	$('.prq_sh_csh_content').hide();
	$('.prq_sh_tname_input').show();
	$('#prq_sh_request_btn').hide();
	$('#prq_search_result_title').hide();
	
	$('#prq_search_content').empty();
});

//시간당 금액 입력시 자동 콤마 추가
$(document).on('keyup', '#prq_tsmoney', function(){
	var str = $(this).val();
	str = removeComma(str);
	str = addComma(str);
	$(this).val(str);
});

$(document).on('keyup', '#prq_temoney', function(){
	var str = $(this).val();
	str = removeComma(str);
	str = addComma(str);
	$(this).val(str);
});

//검색하기 클릭시
$(document).on('click', '#prq_sh_search_btn', function(){
	var search_gubun = $('.haeder_menu_div_on').find('span').text();
	
	if(search_gubun == '조건검색'){
		//조건검색인 경우
		var tname = '';
		var tgenre = $('#select_genre').val();
		var tarea = $('#prq_sh_csh_area').val();
		var tsmoney = removeComma($('#prq_tsmoney').val());
		var temoney = removeComma($('#prq_temoney').val());
		var ttype = '';
		var ttypechk = '';
		var textGenre = $('#text_genre').val();
		
		if($('#tteam').prop('checked') && !$('#tsolo').prop('checked')){
			ttype = '2';
			ttypechk = '2';
		} else if(!$('#tteam').prop('checked') && $('#tsolo').prop('checked')){
			ttype = '1';
			ttypechk = '1';
		} else if($('#tteam').prop('checked') && $('#tsolo').prop('checked')){
			ttype = '';
			ttypechk = '3';
		} else {
			ttype = '';
		}
		
		//세션 값 생성
		sessionStorage.removeItem('tname');
		sessionStorage.setItem('tgenre', tgenre);
		sessionStorage.setItem('tarea', tarea);
		sessionStorage.setItem('tsmoney', tsmoney);
		sessionStorage.setItem('temoney', temoney);
		sessionStorage.setItem('ttype', ttypechk);
		sessionStorage.setItem('textGenre', textGenre);
		
	} else {
		//명칭검색인 경우
		var tname = $('#prq_tname').val();
		var tgenre = '';
		var tarea = '';
		var tmoney = '';
		var ttype = '';
		
		if(tname == ''){
			alert('검색할 이름을 입력해주세요');
			$('#prq_tname').focus();
			return;
		}
		
		//세션 값 생성
		sessionStorage.setItem('tname', tname);
		sessionStorage.removeItem('tgenre');
		sessionStorage.removeItem('tarea');
		sessionStorage.removeItem('tsmoney');
		sessionStorage.removeItem('temoney');
		sessionStorage.removeItem('ttype');
		sessionStorage.removeItem('textGenre');
	}
	
	sessionStorage.removeItem('selectindex');
	
	pr_search_team(tname, tgenre, tarea, tsmoney, temoney, ttype);
});


//검색된 팀 선택시 버튼 색 변경
$(document).on('click', '.prq_content_btn', function() {
	var bcolor = $(this).attr('class');
	bcolor = bcolor.split(' ');
	bcolor = bcolor[bcolor.length - 1];
	//$('.prq_content').find('.prq_content_btn').removeClass('prq_content_btn_select');
	
	if(bcolor == 'prq_content_btn_select'){
		//선택되어있는 경우 선택 해제
		$(this).removeClass('prq_content_btn_select');
	} else{
		//선택 안되어있는 경우 선택
		$(this).addClass('prq_content_btn_select');
	}
	var tno_str = '';
	//선택할때마다 선택한 팀 값 세션에 추가
	$('input[name=prq_list_chk]:checked').each(function(i){
		var request_tno = $(this).val();
		
		if(i == 0){
			tno_str = tno_str + request_tno;
		} else {
			tno_str = tno_str + ',' + request_tno;
		}
	});
	sessionStorage.setItem('selectindex', tno_str);
});

//의뢰하기 버튼 눌렀을 때
$(document).on('click', '#prq_sh_request_btn', function(){
	var chkchk = $('input[name=prq_list_chk]:checked').val();
	
	if(chkchk == undefined || chkchk == 'undefined'){
		alert('한팀 이상 선택해주세요.');
		return;
	}
	var tno_str = '';
	$('input[name="prq_list_chk"]:checked').each(function(i){
		var request_tno = $(this).val();
		
		if(i == 0){
			tno_str = tno_str + request_tno;
		} else {
			tno_str = tno_str + ',' + request_tno;
		}
	});
	
	tno = tno_str;
	go_pfRequest();
});

//리스트 클릭시 스크롤 유지
$(document).on('click', '.prq_content', function(){
	var prqScroll = $(window).scrollTop();
	sessionStorage.setItem('prqScroll', prqScroll);
	
	var tgenre = sessionStorage.getItem('tgenre');
	
	if(tgenre != null && tgenre != ''){
		sessionStorage.setItem('selectGenre', tgenre);
	}
});

//리스트에서 아티스트 정보 이동 후 리스트로 돌아가기 버튼 클릭시
$(document).on('click', '.prq_goback_btn', function(){
	go_pfr_search();
});

//리스트에서 아티스트 정보 이동 후 요청 리스트 추가 버튼 클릭시
$(document).on('click', '.prq_addlist_btn', function(){
	var selectindex = sessionStorage.getItem('selectindex');
	
	if(selectindex == null || selectindex == ''){
		sessionStorage.setItem('selectindex', tno);
	} else {
		var selectindexArray = selectindex.split(',');
		for(var i = 0; i < selectindexArray.length; i++){
			if(selectindexArray[i] == tno){
				break;
			}
			
			if( (i+1) == selectindexArray.length){
				selectindex += ',' + tno;
				sessionStorage.setItem('selectindex', selectindex);
			}
		}
	}
	go_pfr_search();
});