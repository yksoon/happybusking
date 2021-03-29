//버스킹 행사 일정 작성 페이지로 이동
function goPublicBuskingInfoWrite(){
	var adminchk = getCookie('artist_chk');
	if(adminchk != 'A'){
		alert('관리자만 접근 가능합니다.');
		return;
	}
	loadPage('public_busking_info/pbi_write.jsp');
}

//맞춤 공연 설정 페이지로 이동
function go_pbi_condition(){
	if(userLogin_chk() == false){
		alert('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		/*if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
		} else {*/
		loadPage('public_busking_info/pbi_condition.jsp');
		/*}*/
	}
}

//코이카 버스킹 공연 신청서
function goKoicaInsert(){
	loadPage('koica/insert_koica.jsp');
}

//버스킹 행사 일정 리스트 페이지로 이동
function goPublicBuskingInfoList(){
	loadPage('public_busking_info/pbi_list.jsp');
}

//버스킹 행사 일정 상세 페이지로 이동
function goPublicBuskingInfoDetail(pbiNo, chk){
	if(chk === '0' || chk === 0){
		alert('해당 공고는 모집이 종료되었습니다.');
		return;
	}
	
	sessionStorage.setItem('pbiNo', pbiNo);
	loadPage('public_busking_info/pbi_detail.jsp');
}

//맞춤 설정 여부 확인
function chkConditionApply(){
	var res = false;
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/public_busking_info/get_pbi_condition.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length > 0) res = true;
			else res = false;
		}
	});
	return res;
}

//버스킹 행사 일정 리스트 페이지 클릭시 헤더 변경
function pbiListChangeHeader(clickID){
	$('#pbi_menu').find('div').removeClass('haeder_menu_div_on');
	$('#pbi_menu').find('div').removeClass('haeder_menu_div_base');
	
	if(clickID == 'goAllEvent'){
		$('#goAllEvent').find('div').addClass('haeder_menu_div_on');
		$('#goAreaEvent').find('div').addClass('haeder_menu_div_base');
		$('#goGenreEvent').find('div').addClass('haeder_menu_div_base');
		$('#goConditionEvent').find('div').addClass('haeder_menu_div_base');
		$('#pbi_search').show();
		$('#pbi_date_search').show();
		$('#pbi_list').css('padding-top', 'calc(135px + env(safe-area-inset-top))');
	} else if(clickID == 'goAreaEvent'){
		$('#goAllEvent').find('div').addClass('haeder_menu_div_base');
		$('#goAreaEvent').find('div').addClass('haeder_menu_div_on');
		$('#goGenreEvent').find('div').addClass('haeder_menu_div_base');
		$('#goConditionEvent').find('div').addClass('haeder_menu_div_base');	
		$('#pbi_search').show();
		$('#pbi_date_search').show();
		$('#pbi_list').css('padding-top', 'calc(135px + env(safe-area-inset-top))');
	} else if(clickID == 'goGenreEvent'){
		$('#goAllEvent').find('div').addClass('haeder_menu_div_base');
		$('#goAreaEvent').find('div').addClass('haeder_menu_div_base');
		$('#goGenreEvent').find('div').addClass('haeder_menu_div_on');
		$('#goConditionEvent').find('div').addClass('haeder_menu_div_base');	
		$('#pbi_search').show();
		$('#pbi_date_search').show();
		$('#pbi_list').css('padding-top', 'calc(135px + env(safe-area-inset-top))');
	} else if(clickID == 'goConditionEvent'){
		$('#goAllEvent').find('div').addClass('haeder_menu_div_base');
		$('#goAreaEvent').find('div').addClass('haeder_menu_div_base');
		$('#goGenreEvent').find('div').addClass('haeder_menu_div_base');
		$('#goConditionEvent').find('div').addClass('haeder_menu_div_on');	
		$('#pbi_search').hide();
		$('#schedule_search').hide();
		$('#pbi_list').css('padding-top', 'calc(85px + env(safe-area-inset-top))');
	}
}

//버스킹 행사 일정 리스트 가져오는 함수
function getPbiList(){
	var pbiSearchTitle = sessionStorage.getItem('pbiSearchTitle');
	var pbiSearchDate = sessionStorage.getItem('pbiSearchDate');
	var pbiArea = sessionStorage.getItem('pbiArea');
	var pbiGenre = sessionStorage.getItem('pbiGenre');
	var pbiLimit = sessionStorage.getItem('pbiLimit');
	var pbiLast = 10;
	
	if(pbiLimit === null || pbiLimit === 'null'){
		pbiLimit = 0;
		sessionStorage.setItem('pbiLimit', pbiLimit);
	} else {
		pbiLast = parseInt(pbiLimit) + 10;	
		pbiLimit = 0;
	}
	
	$('#pbi_list_sec').empty();
	
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/public_busking_info/get_pbi_list.jsp',
		data:{
			pbiSearchTitle: pbiSearchTitle,
			pbiSearchDate: pbiSearchDate,
			pbiArea: pbiArea,
			pbiGenre: pbiGenre,
			pbiLimit: pbiLimit,
			pbiLast: pbiLast
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				var html = '<div class="noViewBtn" id="main_cont">해당하는 버스킹 행사 일정이 없습니다.</div>';
				$('#pbi_list_sec').html(html);
				return;
			}
			
			$(DATA).each(function(){
				var PBI_NO = $(this).find('PBI_NO').text();
				var PBI_USER_NO = $(this).find('PBI_USER_NO').text();
				var PBI_THUMNAIL_IMG = $(this).find('PBI_THUMNAIL_IMG').text();
				var TIMECHK = $(this).find('TIMECHK').text();
				var PBI_TITLE = $(this).find('PBI_TITLE').text();
				
				var PBI_EVENT_SDATE = $(this).find('PBI_EVENT_SDATE').text();
				var PBI_EVENT_EDATE = $(this).find('PBI_EVENT_EDATE').text();
				var PBI_RECEIPT_SDATE = $(this).find('PBI_RECEIPT_SDATE').text();
				var PBI_RECEIPT_EDATE = $(this).find('PBI_RECEIPT_EDATE').text();
				var PBI_ADDRESS = $(this).find('PBI_ADDRESS').text();
				var PBI_DETAILADDRESS = $(this).find('PBI_DETAILADDRESS').text();
				var PBI_GENRE = $(this).find('PBI_GENRE').text();
				var PBI_REGDATE = $(this).find('PBI_REGDATE').text().split(' ')[0];
				
				var pbiFullEventDate = PBI_EVENT_SDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_EVENT_SDATE)+') ~ '+PBI_EVENT_EDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_EVENT_EDATE)+')';
				var pbiFullReceiptDate = PBI_RECEIPT_SDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_RECEIPT_SDATE)+') ~ '+PBI_RECEIPT_EDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_RECEIPT_EDATE)+')';
				
				PBI_ADDRESS = PBI_ADDRESS.substr(0,2);
				
				//var thumnailPath = '/upload/user/user'+PBI_USER_NO+'/' + PBI_THUMNAIL_IMG;
				
				 var new_img = 'upload/images/user/user' + PBI_USER_NO + "/" + PBI_THUMNAIL_IMG;
	                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#'+PBI_NO).attr('src', value);
			     });
				
				var pbiFullArea = PBI_ADDRESS + ' - ' + PBI_DETAILADDRESS;
				
				
				var dday = getDday(PBI_RECEIPT_SDATE);
				
				var dday2 = getDday(PBI_REGDATE);
				
				var titleHtml = '';
				
				if(dday2 >= -7 && dday2 <=0 && TIMECHK != '0'){
					titleHtml = '<div class="pbi_lc_title"><p><img class="pbi-new" src="/img/panel_v2/NEW.svg"/>'+PBI_TITLE+'</p></div>';
				} else {
					titleHtml = '<div class="pbi_lc_title"><p>'+PBI_TITLE+'</p></div>';
				}
				
				/*if(TIMECHK == '0'){
					var pbiState = '<p class="pbi_lc_state pbi_lc_end">종료</p>';
				} else if(dday > 0){
					var pbiState = '<p class="pbi_lc_state pbi_lc_wait">예정</p>';
				} else {
					var pbiState = '<p class="pbi_lc_state pbi_lc_ing">접수</p>';
				}*/
				
				var pbiState = '';
				var onClick = '';
				
				if(TIMECHK == '0'){
					pbiState = '<div class="pbi_lc_img_back">종료</div>';
					onClick = 'onclick="goPublicBuskingInfoDetail('+PBI_NO+', 0);"';
				} else {
					pbiState = '';
					onClick = 'onclick="goPublicBuskingInfoDetail('+PBI_NO+', 1);"';
				}
				
				if(PBI_GENRE == ''){
					PBI_GENRE = '모든 장르';
				}
				
				var noDateChk = PBI_EVENT_SDATE.split('-');
				noDateChk = noDateChk[noDateChk.length-1];
				
				if(noDateChk == '00'){
					pbiFullEventDate = '주관처 문의';
				}
				
				var html = '<div class="pbi_list_container" '+onClick+'>'+
								'<div class="ui-grid-b">'+
									'<div class="ui-block-a pbi_lc_thumnail">'+
										pbiState +
										'<img id="'+PBI_NO+'">'+
									'</div>'+
									'<div class="ui-block-b pbi_lc_content">'+
										titleHtml +
										'<p class="pbi_lc_info pbi_lc_top_1">접수기간: '+pbiFullReceiptDate+'</p>'+
										'<p class="pbi_lc_info">행사기간: '+pbiFullEventDate+'</p>'+
										'<p class="pbi_lc_info pbi_lc_top_2">'+pbiFullArea+'</p>'+
										'<p class="pbi_lc_genre">'+PBI_GENRE+'</p>'+
									'</div>'+
									'<div class="ui-block-c pbi_lc_btn">'+
										'<img src="/img/common/show_btn.svg">'+
									'</div>'+
								'</div>'+
							'</div>';
				
				$('#pbi_list_sec').append(html);
			});
		},
		error: function(xhr){
			console.log(xhr);
		},
		complete: function(){
			var scroll = sessionStorage.getItem('pbiScroll');
			if(scroll == null){
				$(window).scrollTop(0);
			} else {
				$('html,body').animate({scrollTop: scroll}, 'fast');
			}
		}
	});
}


//버스킹 행사 일정 리스트 더보기 함수
function getMorePbiList(){
	var pbiSearchTitle = sessionStorage.getItem('pbiSearchTitle');
	var pbiSearchDate = sessionStorage.getItem('pbiSearchDate');
	var pbiArea = sessionStorage.getItem('pbiArea');
	var pbiGenre = sessionStorage.getItem('pbiGenre');
	var pbiLimit = sessionStorage.getItem('pbiLimit');
	
	if(pbiLimit === null || pbiLimit === 'null'){
		pbiLimit = 10;
	} else {
		pbiLimit = parseInt(pbiLimit) + 10;
	}
	sessionStorage.setItem('pbiLimit', pbiLimit);
	
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/public_busking_info/get_pbi_list.jsp',
		data:{
			pbiSearchTitle: pbiSearchTitle,
			pbiSearchDate: pbiSearchDate,
			pbiArea: pbiArea,
			pbiGenre: pbiGenre,
			pbiLimit: pbiLimit
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				return;
			}
			
			$(DATA).each(function(){
				var PBI_NO = $(this).find('PBI_NO').text();
				var PBI_USER_NO = $(this).find('PBI_USER_NO').text();
				var PBI_THUMNAIL_IMG = $(this).find('PBI_THUMNAIL_IMG').text();
				var TIMECHK = $(this).find('TIMECHK').text();
				var PBI_TITLE = $(this).find('PBI_TITLE').text();
				
				var PBI_EVENT_SDATE = $(this).find('PBI_EVENT_SDATE').text();
				var PBI_EVENT_EDATE = $(this).find('PBI_EVENT_EDATE').text();
				var PBI_RECEIPT_SDATE = $(this).find('PBI_RECEIPT_SDATE').text();
				var PBI_RECEIPT_EDATE = $(this).find('PBI_RECEIPT_EDATE').text();
				var PBI_ADDRESS = $(this).find('PBI_ADDRESS').text();
				var PBI_DETAILADDRESS = $(this).find('PBI_DETAILADDRESS').text();
				var PBI_GENRE = $(this).find('PBI_GENRE').text();
				var PBI_REGDATE = $(this).find('PBI_REGDATE').text().split(' ')[0];
				
				var pbiFullEventDate = PBI_EVENT_SDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_EVENT_SDATE)+') ~ '+PBI_EVENT_EDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_EVENT_EDATE)+')';
				var pbiFullReceiptDate = PBI_RECEIPT_SDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_RECEIPT_SDATE)+') ~ '+PBI_RECEIPT_EDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_RECEIPT_EDATE)+')';
				
				PBI_ADDRESS = PBI_ADDRESS.substr(0,2);
				
				//var thumnailPath = '/upload/user/user'+PBI_USER_NO+'/' + PBI_THUMNAIL_IMG;
				
				 var new_img = 'upload/images/user/user' + PBI_USER_NO + "/" + PBI_THUMNAIL_IMG;
	                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#'+PBI_NO).attr('src', value);
			     });
				
				var pbiFullArea = PBI_ADDRESS + ' - ' + PBI_DETAILADDRESS;
				
				var dday = getDday(PBI_RECEIPT_SDATE);
				
				var dday2 = getDday(PBI_REGDATE);
				
				var titleHtml = '';
				
				
				if(dday2 >= -7 && dday2 <=0 && TIMECHK != '0'){
					titleHtml = '<div class="pbi_lc_title"><p><img class="pbi-new" src="/img/panel_v2/NEW.svg"/>'+PBI_TITLE+'</p></div>';
				} else {
					titleHtml = '<div class="pbi_lc_title"><p>'+PBI_TITLE+'</p></div>';
				}
				
				/*if(TIMECHK == '0'){
					var pbiState = '<p class="pbi_lc_state pbi_lc_end">종료</p>';
				} else if(dday > 0){
					var pbiState = '<p class="pbi_lc_state pbi_lc_wait">예정</p>';
				} else {
					var pbiState = '<p class="pbi_lc_state pbi_lc_ing">접수</p>';
				}*/
				
				var pbiState = '';
				var onClick = '';
				
				if(TIMECHK == '0'){
					pbiState = '<div class="pbi_lc_img_back">종료</div>';
					onClick = 'onclick="goPublicBuskingInfoDetail('+PBI_NO+', 0);"';
				} else {
					pbiState = '';
					onClick = 'onclick="goPublicBuskingInfoDetail('+PBI_NO+', 1);"';
				}
				
				var noDateChk = PBI_EVENT_SDATE.split('-');
				noDateChk = noDateChk[noDateChk.length-1];
				
				if(noDateChk == '00'){
					pbiFullEventDate = '주관처 문의';
				}
				
				var html = '<div class="pbi_list_container" '+onClick+'>'+
								'<div class="ui-grid-b">'+
									'<div class="ui-block-a pbi_lc_thumnail">'+
										pbiState +
										'<img id="'+PBI_NO+'">'+
									'</div>'+
									'<div class="ui-block-b pbi_lc_content">'+
										titleHtml +
										'<p class="pbi_lc_info pbi_lc_top_1">접수기간: '+pbiFullReceiptDate+'</p>'+
										'<p class="pbi_lc_info">행사기간: '+pbiFullEventDate+'</p>'+
										'<p class="pbi_lc_info pbi_lc_top_2">'+pbiFullArea+'</p>'+
										'<p class="pbi_lc_genre">'+PBI_GENRE+'</p>'+
									'</div>'+
									'<div class="ui-block-c pbi_lc_btn">'+
										'<img src="/img/common/show_btn.svg">'+
									'</div>'+
								'</div>'+
							'</div>';
				
				$('#pbi_list_sec').append(html);
			});
		},
		error: function(xhr){
			console.log(xhr);
		}
	});
}

//버스킹 행사일정 상세정보 불러오는 함수
function getPublicBuskingInfoDetail(){
	var pbiNo = sessionStorage.getItem('pbiNo');
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/public_busking_info/get_pbi_detail.jsp',
		data:{
			pbiNo: pbiNo
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var PBI_NO = $(this).find('PBI_NO').text();
				var PBI_USER_NO = $(this).find('PBI_USER_NO').text();
				var PBI_MAIN_IMG = $(this).find('PBI_MAIN_IMG').text();
				var PBI_TITLE = $(this).find('PBI_TITLE').text();
				var PBI_EVENT_SDATE = $(this).find('PBI_EVENT_SDATE').text();
				var PBI_EVENT_EDATE = $(this).find('PBI_EVENT_EDATE').text();
				var PBI_EVENT_STIME = $(this).find('PBI_EVENT_STIME').text();
				var PBI_EVENT_ETIME = $(this).find('PBI_EVENT_ETIME').text();
				var PBI_RECEIPT_SDATE = $(this).find('PBI_RECEIPT_SDATE').text();
				var PBI_RECEIPT_EDATE = $(this).find('PBI_RECEIPT_EDATE').text();
				var PBI_ADDRESS = $(this).find('PBI_ADDRESS').text();
				var PBI_DETAILADDRESS = $(this).find('PBI_DETAILADDRESS').text();
				var PBI_GENRE = $(this).find('PBI_GENRE').text();
				var PBI_CONTENT = changeLineBreak($(this).find('PBI_CONTENT').text());
				var PBI_LATLNG = $(this).find('PBI_LATLNG').text();
				var PBI_PAY = numberWithCommas($(this).find('PBI_PAY').text());
				var PBI_PAY_MAX = numberWithCommas($(this).find('PBI_PAY_MAX').text());
				var PBI_PERSONNEL = $(this).find('PBI_PERSONNEL').text();
				var PBI_PERSONNEL_MIN = $(this).find('PBI_PERSONNEL_MIN').text();
				
				var PBI_SITE = $(this).find('PBI_SITE').text();
				var PBI_MANAGER = $(this).find('PBI_MANAGER').text();
				var PBI_TEL = $(this).find('PBI_TEL').text();
				var PBI_EMAIL = $(this).find('PBI_EMAIL').text();
				var PBI_FILE = $(this).find('PBI_FILE').text();
				
				var PBI_NO_PAY = $(this).find('PBI_NO_PAY').text();
				var PBI_TRANSPORTATION = $(this).find('PBI_TRANSPORTATION').text();
				
				var PBI_PLACE_IMG = $(this).find('PBI_PLACE_IMG').text();
				var PBI_PRODUCT_IMG = $(this).find('PBI_PRODUCT_IMG').text();
				
				var pbiFullEventDate = PBI_EVENT_SDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_EVENT_SDATE)+') ~ '+PBI_EVENT_EDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_EVENT_EDATE)+') ';
				var pbiFullReceiptDate = PBI_RECEIPT_SDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_RECEIPT_SDATE)+') ~ '+PBI_RECEIPT_EDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_RECEIPT_EDATE)+')';
				
				var pbiFullArea = PBI_ADDRESS + ', ' + PBI_DETAILADDRESS;
				
				if(PBI_GENRE == ''){
					PBI_GENRE = '모든 장르';
				} 
				
				if(PBI_PAY == '0' && PBI_PAY_MAX == '0') PBI_PAY = '내부규정';
				else if(PBI_PAY == '0' && PBI_PAY_MAX != '0') PBI_PAY = '최대 ' + PBI_PAY_MAX + '원';
				else if(PBI_PAY != '0' && PBI_PAY_MAX == '0') PBI_PAY = '최소 ' + PBI_PAY + '원';
				else PBI_PAY = '최소 ' + PBI_PAY + '원 ~ 최대 ' + PBI_PAY_MAX + '원';
				
				PBI_PAY += '<br>(자세한 사항은 상세정보를 참고해주세요.)';
				
				PBI_TRANSPORTATION = (PBI_TRANSPORTATION == '0') ? '공연비에 포함' : '별도 실비 지급';
				
				if(PBI_NO_PAY == '0'){
					PBI_PAY = '미지급';
					PBI_TRANSPORTATION = '미지급';
				}
				
				if(PBI_PERSONNEL == '제한없음' && PBI_PERSONNEL_MIN == '제한없음') PBI_PERSONNEL = '제한없음';
				else if(PBI_PERSONNEL == '제한없음' && PBI_PERSONNEL_MIN != '제한없음') PBI_PERSONNEL = '최소 ' + PBI_PERSONNEL_MIN + '명';
				else if(PBI_PERSONNEL != '제한없음' && PBI_PERSONNEL_MIN == '제한없음') PBI_PERSONNEL = '최대 ' + PBI_PERSONNEL + '명';
				else if(PBI_PERSONNEL != '제한없음' && PBI_PERSONNEL_MIN != '제한없음') PBI_PERSONNEL = '최소 ' + PBI_PERSONNEL_MIN + '명' + ' ~ 최대 ' + PBI_PERSONNEL + '명';
				
				var imgwidth = window.innerWidth;
				
				//var mainPath = '/upload/user/user'+PBI_USER_NO+'/' + PBI_MAIN_IMG;
				
				var new_img = 'upload/images/user/user' + PBI_USER_NO + "/" + PBI_MAIN_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
			    	 $('#img'+PBI_MAIN_IMG).attr('src', value);
					
					var bdc_main_img_html = '<li>'+
											'<div class="bdc_image_div">'+
												'<img src="'+value+'" style="width:'+imgwidth+'px; max-width: none; height:'+imgwidth+'px;">'+
											'</div>'+
										   '</li>';
			
					$('#bdc_pfsc_ing_ul').append(bdc_main_img_html);
					$('#bdc_img_selecter').append('<li class="bdc_img_active" id="bdc_img_selecter_1">●</li>');
					
					 if(PBI_PLACE_IMG != ''){
				    	 var pArray = PBI_PLACE_IMG.split(',');
				    	 for(var i=0; i<pArray.length; i++){
				    		 var new_img = 'upload/images/user/user' + PBI_USER_NO + "/" + pArray[i];
				    		 
				    		 var imgSrc = getImagePromise(new_img).then(value => {
						    	 bz_sub_img_html = '<li>'+
									'<div class="sid_image_div">'+
										'<img src="'+value+'" style="width:'+imgwidth+'px; max-width: none; height:'+imgwidth+'px;">'+
									'</div>'+
								   '</li>';
				
								$('#bdc_pfsc_ing_ul').append(bz_sub_img_html);
								
								const cnt = $('#bdc_img_selecter').find('li').length;
								
								bz_sub_img_selecter = '<li id="bdc_img_selecter_'+(cnt+1)+'">●</li>';
								$('#bdc_img_selecter').append(bz_sub_img_selecter);
								

								var bdc_carousel;
								bdc_carousel = $("#bdc_pfsc_ing_ul");
								bdc_carousel.itemslide(
							    	{
							    		left_sided: true,
							    		disable_clicktoslide: true
							    	}
							    );
								
								bdc_carousel.on('changePos', function(e){
									var ai = bdc_carousel.getActiveIndex() + 1;
									
									$('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
									$('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
								});
						     });
				    	 }
				    	 
				    	 
				    	 if(PBI_PRODUCT_IMG != ''){
				    		 var ppArray = PBI_PRODUCT_IMG.split(',');
					    	 for(var i=0; i<pArray.length; i++){
					    		 var new_img = 'upload/images/user/user' + PBI_USER_NO + "/" + ppArray[i];
					    		 
					    		 var imgSrc = getImagePromise(new_img).then(value => {
							    	 bz_sub_img_html = '<li>'+
										'<div class="sid_image_div">'+
											'<img src="'+value+'" style="width:'+imgwidth+'px; max-width: none; height:'+imgwidth+'px;">'+
										'</div>'+
									   '</li>';
					
									$('#bdc_pfsc_ing_ul').append(bz_sub_img_html);
									
									const cnt = $('#bdc_img_selecter').find('li').length;
									
									bz_sub_img_selecter = '<li id="bdc_img_selecter_'+(cnt+1)+'">●</li>';
									$('#bdc_img_selecter').append(bz_sub_img_selecter);
									

									var bdc_carousel;
									bdc_carousel = $("#bdc_pfsc_ing_ul");
									bdc_carousel.itemslide(
								    	{
								    		left_sided: true,
								    		disable_clicktoslide: true
								    	}
								    );
									
									bdc_carousel.on('changePos', function(e){
										var ai = bdc_carousel.getActiveIndex() + 1;
										
										$('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
										$('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
									});
							     });
					    	 }
				    	 }
				     }
			     });
				
			    
				
				
				if(PBI_SITE != '-') PBI_SITE = '<a>' + PBI_SITE + '</a>';
				
				var downloadPath = '/upload/user/user'+PBI_USER_NO+'/' + PBI_FILE;
				if(PBI_FILE != '') PBI_FILE = '<a href="'+downloadPath+'" rel="external" download>다운로드 하시려면 이곳을 클릭해주세요.</a>';
				//if(PBI_FILE != '') PBI_FILE = '<span class="pbi_download" id="'+downloadPath+'">다운로드 하시려면 이곳을 클릭해주세요.</span>';
				else PBI_FILE = '-';
				
				
				var noDateChk = PBI_EVENT_SDATE.split('-');
				noDateChk = noDateChk[noDateChk.length-1];
				
				if(noDateChk == '00'){
					pbiFullEventDate = '주관처 문의';
				}
				
				///////////////////지도 생성///////////////////////////
				var xPoint = PBI_LATLNG.split(',')[1];
				var yPoint = PBI_LATLNG.split(',')[0];
				
				getKakaoMap(xPoint, yPoint);
				/////////////////////////////////////////////////////
				//$('.pbi_ds_img').find('img').attr('src', mainPath);
				//$('#pbiip_img').attr('src', mainPath);
				
				$('#pbi_ds_title').html(PBI_TITLE);
				$('#pbi_ds_event_date').html(pbiFullEventDate);
				$('#pbi_ds_receipt_date').html(pbiFullReceiptDate);
				$('#pbi_ds_area').html(pbiFullArea);
				$('#pbi_ds_genre').html(PBI_GENRE);
				$('#pbi_ds_pay').html(PBI_PAY);
				$('#pbi_ds_personnel').html(PBI_PERSONNEL);
				$('#pbi_ds_detail_content').html(PBI_CONTENT);
				//$('#pbi_ds_site').html(PBI_SITE);
				$('#pbi_ds_manager').html(PBI_MANAGER);
				$('#pbi_ds_tel').html(PBI_TEL);
				$('#pbi_ds_email').html(PBI_EMAIL);
				$('#pbi_transportation').html(PBI_TRANSPORTATION);
				//$('#pbi_ds_file').html('-');
				//추후에 파일 다운로드 안되는거 해결 후  주석 풀어야됨.
				$('#pbi_ds_file').html(PBI_FILE);
			});
		},
		error: function(x,h,r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
	});
}

function downloadAndOpenPdf() {
	alert('click');
    let downloadUrl = 'https://e-learning.linkstudycenter.com/media/attachment/matematika_A13-Paket1.pdf';
    let path = this.file.dataDirectory;
    const transfer = this.ft.create();
    transfer.download(downloadUrl, path + 'matematika_A13-Paket1.pdf').then(entry => {
      let url = entry.toURL();
      if (this.platform.is('ios')) {
        this.document.viewDocument(url, 'application/pdf', {});
      } else {
        this.fileOpener.open(url, 'application/pdf')
          .then(() => console.log('File is opened'))
          .catch(e => console.log('Error opening file', e));
      }
    });
  }

//버스킹 행사일정 맞춤정보
function getPbiConditionList(){
	var pbiLimit = sessionStorage.getItem('pbiLimit');
	var pbiLast = 10;
	
	if(pbiLimit === null || pbiLimit === 'null'){
		pbiLimit = 0;
		sessionStorage.setItem('pbiLimit', pbiLimit);
	} else {
		pbiLast = parseInt(pbiLimit) + 10;	
		pbiLimit = 0;
	}
	
	$('#pbi_list_sec').empty();
	
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/public_busking_info/get_pbi_list_condition.jsp',
		data: {
			pbiLimit: pbiLimit,
			pbiLast: pbiLast
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				var html = '<div class="noViewBtn" id="main_cont">조건에 맞는 버스킹 행사 일정이 없습니다.</div>';
				$('#pbi_list_sec').html(html);
				return;
			}
			
			$(DATA).each(function(){
				var PBI_NO = $(this).find('PBI_NO').text();
				var PBI_USER_NO = $(this).find('PBI_USER_NO').text();
				var PBI_THUMNAIL_IMG = $(this).find('PBI_THUMNAIL_IMG').text();
				var TIMECHK = $(this).find('TIMECHK').text();
				var PBI_TITLE = $(this).find('PBI_TITLE').text();
				
				var PBI_EVENT_SDATE = $(this).find('PBI_EVENT_SDATE').text();
				var PBI_EVENT_EDATE = $(this).find('PBI_EVENT_EDATE').text();
				var PBI_RECEIPT_SDATE = $(this).find('PBI_RECEIPT_SDATE').text();
				var PBI_RECEIPT_EDATE = $(this).find('PBI_RECEIPT_EDATE').text();
				var PBI_ADDRESS = $(this).find('PBI_ADDRESS').text();
				var PBI_DETAILADDRESS = $(this).find('PBI_DETAILADDRESS').text();
				var PBI_GENRE = $(this).find('PBI_GENRE').text();
				var PBI_REGDATE = $(this).find('PBI_REGDATE').text().split(' ')[0];
				
				var pbiFullEventDate = PBI_EVENT_SDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_EVENT_SDATE)+') ~ '+PBI_EVENT_EDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_EVENT_EDATE)+')';
				var pbiFullReceiptDate = PBI_RECEIPT_SDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_RECEIPT_SDATE)+') ~ '+PBI_RECEIPT_EDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_RECEIPT_EDATE)+')';
				
				PBI_ADDRESS = PBI_ADDRESS.substr(0,2);
				
				//var thumnailPath = '/upload/user/user'+PBI_USER_NO+'/' + PBI_THUMNAIL_IMG;
				
				var new_img = 'upload/images/user/user' + PBI_USER_NO + "/" + PBI_THUMNAIL_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#'+PBI_NO).attr('src', value);
			     });
				
				var pbiFullArea = PBI_ADDRESS + ' - ' + PBI_DETAILADDRESS;
				
				var pbiState = '';
				var onClick = '';
				
				if(TIMECHK == '0'){
					pbiState = '<div class="pbi_lc_img_back">종료</div>';
					onClick = 'onclick="goPublicBuskingInfoDetail('+PBI_NO+', 0);"';
				} else {
					pbiState = '';
					onClick = 'onclick="goPublicBuskingInfoDetail('+PBI_NO+', 1);"';
				}
				
				if(PBI_GENRE == ''){
					PBI_GENRE = '모든 장르';
				}
				
				var dday2 = getDday(PBI_REGDATE);
				
				var titleHtml = '';
				
				
				if(dday2 >= -7 && dday2 <=0 && TIMECHK != '0'){
					titleHtml = '<div class="pbi_lc_title"><p><img class="pbi-new" src="/img/panel_v2/NEW.svg"/>'+PBI_TITLE+'</p></div>';
				} else {
					titleHtml = '<div class="pbi_lc_title"><p>'+PBI_TITLE+'</p></div>';
				}
				
				var html = '<div class="pbi_list_container" '+onClick+'>'+
								'<div class="ui-grid-b">'+
									'<div class="ui-block-a pbi_lc_thumnail">'+
										pbiState +
										'<img id="'+PBI_NO+'">'+
									'</div>'+
									'<div class="ui-block-b pbi_lc_content">'+
										titleHtml+
										'<p class="pbi_lc_info pbi_lc_top_1">행사기간: '+pbiFullEventDate+'</p>'+
										'<p class="pbi_lc_info">접수기간: '+pbiFullReceiptDate+'</p>'+
										'<p class="pbi_lc_info pbi_lc_top_2">'+pbiFullArea+'</p>'+
										'<p class="pbi_lc_genre">'+PBI_GENRE+'</p>'+
									'</div>'+
									'<div class="ui-block-c pbi_lc_btn">'+
										'<img src="/img/common/show_btn.svg">'+
									'</div>'+
								'</div>'+
							'</div>';
				
				$('#pbi_list_sec').append(html);
			});
		},
		error: function(x,h,r){
			console.log(x);
			console.log(h);
			console.log(r);
		},
		complete: function(){
			var scroll = sessionStorage.getItem('pbiScroll');
			if(scroll == null){
				$(window).scrollTop(0);
			} else {
				$('html,body').animate({scrollTop: scroll}, 'fast');
			}
		}
	});
}

//버스킹 행사일정 맞춤정보 더보기
function getMorePbiConditionList(){
	var pbiLimit = sessionStorage.getItem('pbiLimit');
	
	if(pbiLimit === null || pbiLimit === 'null'){
		pbiLimit = 10;
	} else {
		pbiLimit = parseInt(pbiLimit) + 10;
	}
	sessionStorage.setItem('pbiLimit', pbiLimit);
	
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/public_busking_info/get_pbi_list_condition.jsp',
		data: {
			pbiLimit: pbiLimit
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				return;
			}
			
			$(DATA).each(function(){
				var PBI_NO = $(this).find('PBI_NO').text();
				var PBI_USER_NO = $(this).find('PBI_USER_NO').text();
				var PBI_THUMNAIL_IMG = $(this).find('PBI_THUMNAIL_IMG').text();
				var TIMECHK = $(this).find('TIMECHK').text();
				var PBI_TITLE = $(this).find('PBI_TITLE').text();
				
				var PBI_EVENT_SDATE = $(this).find('PBI_EVENT_SDATE').text();
				var PBI_EVENT_EDATE = $(this).find('PBI_EVENT_EDATE').text();
				var PBI_RECEIPT_SDATE = $(this).find('PBI_RECEIPT_SDATE').text();
				var PBI_RECEIPT_EDATE = $(this).find('PBI_RECEIPT_EDATE').text();
				var PBI_ADDRESS = $(this).find('PBI_ADDRESS').text();
				var PBI_DETAILADDRESS = $(this).find('PBI_DETAILADDRESS').text();
				var PBI_GENRE = $(this).find('PBI_GENRE').text();
				var PBI_REGDATE = $(this).find('PBI_REGDATE').text().split(' ')[0];
				
				var pbiFullEventDate = PBI_EVENT_SDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_EVENT_SDATE)+') ~ '+PBI_EVENT_EDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_EVENT_EDATE)+')';
				var pbiFullReceiptDate = PBI_RECEIPT_SDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_RECEIPT_SDATE)+') ~ '+PBI_RECEIPT_EDATE.substr(5,5)+'('+getDayOfTheWeek(PBI_RECEIPT_EDATE)+')';
				
				PBI_ADDRESS = PBI_ADDRESS.substr(0,2);
				
				//var thumnailPath = '/upload/user/user'+PBI_USER_NO+'/' + PBI_THUMNAIL_IMG;
				
				var new_img = 'upload/images/user/user' + PBI_USER_NO + "/" + PBI_THUMNAIL_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#'+PBI_NO).attr('src', value);
			     });
				
				var pbiFullArea = PBI_ADDRESS + ' - ' + PBI_DETAILADDRESS;
				
				var pbiState = '';
				var onClick = '';
				
				if(TIMECHK == '0'){
					pbiState = '<div class="pbi_lc_img_back">종료</div>';
					onClick = 'onclick="goPublicBuskingInfoDetail('+PBI_NO+', 0);"';
				} else {
					pbiState = '';
					onClick = 'onclick="goPublicBuskingInfoDetail('+PBI_NO+', 1);"';
				}
				
				if(PBI_GENRE == ''){
					PBI_GENRE = '모든 장르';
				}
				
				var dday2 = getDday(PBI_REGDATE);
				
				var titleHtml = '';
				
				
				if(dday2 >= -7 && dday2 <=0 && TIMECHK != '0'){
					titleHtml = '<div class="pbi_lc_title"><p><img class="pbi-new" src="/img/panel_v2/NEW.svg"/>'+PBI_TITLE+'</p></div>';
				} else {
					titleHtml = '<div class="pbi_lc_title"><p>'+PBI_TITLE+'</p></div>';
				}
				
				
				var html = '<div class="pbi_list_container" '+onClick+'>'+
								'<div class="ui-grid-b">'+
									'<div class="ui-block-a pbi_lc_thumnail">'+
										pbiState +
										'<img id="'+PBI_NO+'">'+
									'</div>'+
									'<div class="ui-block-b pbi_lc_content">'+
										titleHtml+
										'<p class="pbi_lc_info pbi_lc_top_1">행사기간: '+pbiFullEventDate+'</p>'+
										'<p class="pbi_lc_info">접수기간: '+pbiFullReceiptDate+'</p>'+
										'<p class="pbi_lc_info pbi_lc_top_2">'+pbiFullArea+'</p>'+
										'<p class="pbi_lc_genre">'+PBI_GENRE+'</p>'+
									'</div>'+
									'<div class="ui-block-c pbi_lc_btn">'+
										'<img src="/img/common/show_btn.svg">'+
									'</div>'+
								'</div>'+
							'</div>';
				
				$('#pbi_list_sec').append(html);
			});
		},
		error: function(x,h,r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
	});
}

function get_pbi_condition(){
	$.mobile.loading( 'show', { text: '로딩중입니다.', textVisible: true, theme: 'b', html: "" });
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/public_busking_info/get_pbi_condition.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$('#apply_date_chk').prop('checked', true);
				$('.apply_date_text').find('input').val('');
				$('.apply_date_text').find('input').attr('readonly', true);
				$('.apply_date_text').find('span').addClass('pbicc_text_readonly');
				
				$('#perform_date_chk').prop('checked', true);
				$('.perform_date_text').find('input').val('');
				$('.perform_date_text').find('input').attr('readonly', true);
				$('.perform_date_text').find('span').addClass('pbicc_text_readonly');
			}
			
			$(DATA).each(function(){
				var APPLY_SDATE = $(this).find('APPLY_SDATE').text();
				var APPLY_EDATE = $(this).find('APPLY_EDATE').text();
				var PERFORM_SDATE = $(this).find('PERFORM_SDATE').text();
				var PERFORM_EDATE = $(this).find('PERFORM_EDATE').text();
				var GENRE_CODE = $(this).find('GENRE_CODE').text();
				var GENRE = ($(this).find('GENRE').text() == '') ? '전체' : $(this).find('GENRE').text();
				var AREA_CODE = $(this).find('AREA_CODE').text();
				var AREA = ($(this).find('AREA').text() == '') ? '전체' : $(this).find('AREA').text();
				var PAY = numberWithCommas($(this).find('PAY').text());
				var PERSONNEL_MIN = $(this).find('PERSONNEL_MIN').text();
				var PERSONNEL_MAX = $(this).find('PERSONNEL_MAX').text();
				
				var syear = '', smonth = '', sday = '';
				
				if(APPLY_SDATE == ''){
					$('#apply_date_chk').prop('checked', true);
					$('.apply_date_text').find('input').val('');
					$('.apply_date_text').find('input').attr('readonly', true);
					$('.apply_date_text').find('span').addClass('pbicc_text_readonly');
				} else {
					syear = APPLY_SDATE.split('-')[0];
					smonth = APPLY_SDATE.split('-')[1];
					sday = APPLY_SDATE.split('-')[2];
					
					$('#pbi_apply_syear').val(syear);
					$('#pbi_apply_smonth').val(smonth);
					$('#pbi_apply_sday').val(sday);
					
					syear = APPLY_EDATE.split('-')[0];
					smonth = APPLY_EDATE.split('-')[1];
					sday = APPLY_EDATE.split('-')[2];
					
					$('#pbi_apply_eyear').val(syear);
					$('#pbi_apply_emonth').val(smonth);
					$('#pbi_apply_eday').val(sday);
					
					$('#apply_date_chk').prop('checked', false);
					$('.apply_date_text').find('input').attr('readonly', false);
					$('.apply_date_text').find('span').removeClass('pbicc_text_readonly');
				}
				
				if(PERFORM_SDATE == ''){
					$('#perform_date_chk').prop('checked', true);
					$('.perform_date_text').find('input').val('');
					$('.perform_date_text').find('input').attr('readonly', true);
					$('.perform_date_text').find('span').addClass('pbicc_text_readonly');
				} else {
					syear = PERFORM_SDATE.split('-')[0];
					smonth = PERFORM_SDATE.split('-')[1];
					sday = PERFORM_SDATE.split('-')[2];
					
					$('#pbi_perform_syear').val(syear);
					$('#pbi_perform_smonth').val(smonth);
					$('#pbi_perform_sday').val(sday);
					
					syear = PERFORM_EDATE.split('-')[0];
					smonth = PERFORM_EDATE.split('-')[1];
					sday = PERFORM_EDATE.split('-')[2];
					
					$('#pbi_perform_eyear').val(syear);
					$('#pbi_perform_emonth').val(smonth);
					$('#pbi_perform_eday').val(sday);
					
					$('#perform_date_chk').prop('checked', false);
					$('.perform_date_text').find('input').attr('readonly', false);
					$('.perform_date_text').find('span').removeClass('pbicc_text_readonly');
				}
				
				if(PAY == 0) PAY = '';
				
				$('#select_genre').val(GENRE_CODE);
				$('#text_genre').val(GENRE);
				$('#select_area').val(AREA_CODE);
				$('#text_area').val(AREA);
				$('#pay').val(PAY);
				$('#min_personnel').val(PERSONNEL_MIN);
				$('#max_personnel').val(PERSONNEL_MAX);
				
				if(GENRE_CODE != '') sessionStorage.setItem('selectGenre', GENRE_CODE);
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		},
		complete: function(){
			sessionStorage.removeItem('selectGenre');
			$.mobile.loading( 'hide', { text: '로딩중입니다.', textVisible: true, theme: 'b', html: "" });
		}
	});
}

function pbi_condition_apply(){
	var apply_sdate = '', apply_edate = '';
	var perform_sdate = '', perform_edate = '';
	var select_genre = blankChk($('#select_genre').val());
	var genre = blankChk($('#text_genre').val());
	var select_area = blankChk($('#select_area').val());
	var area = blankChk($('#text_area').val());
	var pay = blankChk(removeComma($('#pay').val()));
	var min_personnel = blankChk($('#min_personnel').val());
	var max_personnel = blankChk($('#max_personnel').val());
	
	if(!$('#apply_date_chk').is(':checked')){
		var syear = blankChk($('#pbi_apply_syear').val());
		var smonth = blankChk($('#pbi_apply_smonth').val());
		var sday = blankChk($('#pbi_apply_sday').val());
		
		var eyear = blankChk($('#pbi_apply_eyear').val());
		var emonth = blankChk($('#pbi_apply_emonth').val());
		var eday = blankChk($('#pbi_apply_eday').val());
		
		if(syear == ''){
			alert('접수 시작 기간 년도를 입력해주세요.');
			$('#pbi_apply_syear').val('');
			$('#pbi_apply_syear').focus();
			return;
		} else if(smonth == ''){
			alert('접수 시작 기간 월을 입력해주세요.');
			$('#pbi_apply_smonth').val('');
			$('#pbi_apply_smonth').focus();
			return;
		} else if(sday == ''){
			alert('접수 시작 기간 일을 입력해주세요.');
			$('#pbi_apply_sday').val('');
			$('#pbi_apply_sday').focus();
			return;
		} else if(eyear == ''){
			alert('접수 마감 기간 년도를 입력해주세요.');
			$('#pbi_apply_eyear').val('');
			$('#pbi_apply_eyear').focus();
			return;
		} else if(emonth == ''){
			alert('접수 마감 기간 월을 입력해주세요.');
			$('#pbi_apply_emonth').val('');
			$('#pbi_apply_emonth').focus();
			return;
		} else if(eday == ''){
			alert('접수 마감 기간 일을 입력해주세요.');
			$('#pbi_apply_eday').val('');
			$('#pbi_apply_eday').focus();
			return;
		}
		
		apply_sdate = syear+'-'+smonth+'-'+sday;
		apply_edate = eyear+'-'+emonth+'-'+eday;
	}
	
	if(!$('#perform_date_chk').is(':checked')){
		var syear = blankChk($('#pbi_perform_syear').val());
		var smonth = blankChk($('#pbi_perform_smonth').val());
		var sday = blankChk($('#pbi_perform_sday').val());
		
		var eyear = blankChk($('#pbi_perform_eyear').val());
		var emonth = blankChk($('#pbi_perform_emonth').val());
		var eday = blankChk($('#pbi_perform_eday').val());
		
		if(syear == ''){
			alert('행사 시작 기간 년도를 입력해주세요.');
			$('#pbi_perform_syear').val('');
			$('#pbi_perform_syear').focus();
			return;
		} else if(smonth == ''){
			alert('행사 시작 기간 월을 입력해주세요.');
			$('#pbi_perform_smonth').val('');
			$('#pbi_perform_smonth').focus();
			return;
		} else if(sday == ''){
			alert('행사 시작 기간 일을 입력해주세요.');
			$('#pbi_perform_sday').val('');
			$('#pbi_perform_sday').focus();
			return;
		} else if(eyear == ''){
			alert('행사 종료 기간 년도를 입력해주세요.');
			$('#pbi_perform_eyear').val('');
			$('#pbi_perform_eyear').focus();
			return;
		} else if(emonth == ''){
			alert('행사 종료 기간 월을 입력해주세요.');
			$('#pbi_perform_emonth').val('');
			$('#pbi_perform_emonth').focus();
			return;
		} else if(eday == ''){
			alert('행사 종료 기간 일을 입력해주세요.');
			$('#pbi_perform_eday').val('');
			$('#pbi_perform_eday').focus();
			return;
		}
		
		perform_sdate = syear+'-'+smonth+'-'+sday;
		perform_edate = eyear+'-'+emonth+'-'+eday;
	}
	$.mobile.loading( 'show', { text: '설정중입니다.', textVisible: true, theme: 'b', html: "" });
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/public_busking_info/set_pbi_condition.jsp',
		data:{
			apply_sdate : apply_sdate,
			apply_edate: apply_edate,
			perform_sdate : perform_sdate,
			perform_edate : perform_edate,
			select_genre : select_genre,
			genre : genre,
			select_area : select_area,
			area : area,
			pay : pay,
			min_personnel : min_personnel,
			max_personnel : max_personnel
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete: function(){
			$.mobile.loading( 'hide', { text: '설정중입니다.', textVisible: true, theme: 'b', html: "" });
			alert('설정이 완료되었습니다');
			history.go(-1);
		}
	});
}