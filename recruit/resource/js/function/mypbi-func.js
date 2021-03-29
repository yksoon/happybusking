const getPbiList = (start) => {
	showLoading('로딩중입니다.');
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/recruit/resource/service/pbi/get_pbi_list.jsp',
		data: {
			start: start
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#mypbi-list').empty();
			
			if(DATA.length === 0){
				const noList = '<div class="ft-lgray ft-14 no-list" style="margin-top: 30px; margin-bottom: 30px;">등록한 공고가 없습니다.</div>';
				$('.go-recruit-info').show();
				$('#mypbi-list').append(noList);
				$('.middle_pagenum_wapper').hide();
			}
			
			$(DATA).each(function(){
				const PBI_NO = $(this).find('PBI_NO').text();
				const PBI_USER_NO = $(this).find('PBI_USER_NO').text();
				const PBI_TITLE = $(this).find('PBI_TITLE').text();
				const TIMECHK = $(this).find('TIMECHK').text();
				const PBI_REGDATE = $(this).find('PBI_REGDATE').text();
				const CNT = $(this).find('CNT').text();
				const CNT2 = $(this).find('CNT2').text();
				const CNT3 = $(this).find('CNT3').text();
				
				let ing = '';
				
				if(TIMECHK === '1') ing = '<span class="ft-12 ft-purple">모집중</span>';
				else ing = '<span class="ft-12 ft-gray">모집종료</span>';
				
				const date = PBI_REGDATE.split(' ')[0];
				
				const html = '<div class="ml-item" id="'+PBI_NO+'">'+
								'<div class="flex bg-white mi-body">'+
								'<div class="ml-left">'+
									'<div class="ft-black ft-15 ml-title">'+
										PBI_TITLE +
									'</div>'+
									'<p class="ft-12 ft-lgray ml-date">등록일 : ' + date + ing + '</p>'+
								'</div>'+
								'<div class="ml-right">'+
									'<img src="/recruit/resource/img/common/leftarrow-gray.svg"/>'+
								'</div>'+
							'</div>'+
							'<div class="flex mi-footer">'+
								'<div class="bg-white mi-button" onclick="goApplicantList(\''+PBI_NO+'\');">'+
									'<span class="ft-gray ft-15">신청</span><span class="ft-purple ft-15 ft-bold mi-count">'+CNT+'명</span>'+
								'</div>'+
								'<div class="bg-white mi-button" onclick="goScoreList(\''+PBI_NO+'\');">'+
									'<span class="ft-gray ft-15">채점</span><span class="ft-purple ft-15 ft-bold mi-count">'+CNT2+'명</span>'+
								'</div>'+
							'</div>'+
						'</div>';
				
				$('#mypbi-list').append(html);
				
				sessionStorage.setItem('ml-data-cnt', CNT3);
			});
		},
		error: function(x, h, r){
			console.log(x, h, r);
		},
		complete: function(){
			hideLoading();
			
			let scroll = sessionStorage.getItem('mypbi-scroll');
			if(scroll === null || scroll === 'null' || scroll === undefined || scroll === 'undefined') scroll = 0;
			$('html, body').animate({scrollTop: scroll}, 500);
		} 
	});
}



const getPbiDetail = (id) => {
	showLoading('로딩중입니다.');
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/recruit/resource/service/pbi/get_pbi_detail.jsp',
		data: {
			no: id
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				const PBI_NO = $(this).find('PBI_NO').text();
				const PBI_USER_NO = $(this).find('PBI_USER_NO').text();
				const PBI_THUMNAIL_IMG = $(this).find('PBI_THUMNAIL_IMG').text();
				const PBI_TITLE = $(this).find('PBI_TITLE').text();
				const PBI_EVENT_SDATE = $(this).find('PBI_EVENT_SDATE').text();
				const PBI_EVENT_EDATE = $(this).find('PBI_EVENT_EDATE').text();
				const PBI_RECEIPT_SDATE = $(this).find('PBI_RECEIPT_SDATE').text();
				const PBI_RECEIPT_EDATE = $(this).find('PBI_RECEIPT_EDATE').text();
				const PBI_GENRE = $(this).find('PBI_GENRE').text();
				const PBI_GENRE_CODE = $(this).find('PBI_GENRE_CODE').text();
				const PBI_PERSONNEL_MIN = $(this).find('PBI_PERSONNEL_MIN').text();
				const PBI_PERSONNEL = $(this).find('PBI_PERSONNEL').text();
				const PBI_NO_PAY = $(this).find('PBI_NO_PAY').text();
				const PBI_TRANSPORTATION = $(this).find('PBI_TRANSPORTATION').text();
				const PBI_PAY = $(this).find('PBI_PAY').text();
				const PBI_PAY_MAX = $(this).find('PBI_PAY_MAX').text();
				const PBI_MANAGER = $(this).find('PBI_MANAGER').text();
				const PBI_TEL = $(this).find('PBI_TEL').text();
				const PBI_EMAIL = $(this).find('PBI_EMAIL').text();
				const PBI_ADDRESS = $(this).find('PBI_ADDRESS').text();
				const PBI_DETAILADDRESS = $(this).find('PBI_DETAILADDRESS').text();
				const PBI_PLACE_IMG = $(this).find('PBI_PLACE_IMG').text();
				const PBI_PRODUCT_IMG = $(this).find('PBI_PRODUCT_IMG').text();
				const PBI_CONTENT = $(this).find('PBI_CONTENT').text();
				const PBI_LATLNG = $(this).find('PBI_LATLNG').text();
				
				
				$('#no').val(PBI_NO);
				$('#change-image').val(PBI_THUMNAIL_IMG);
				$('#title').val(PBI_TITLE);
				$('#asdate').val(PBI_RECEIPT_SDATE);
				$('#aedate').val(PBI_RECEIPT_EDATE);
				$('#psdate').val(PBI_EVENT_SDATE);
				$('#pedate').val(PBI_EVENT_EDATE);
				$('#text_genre').val(PBI_GENRE);
				$('#select_genre').val(PBI_GENRE_CODE);
				sessionStorage.setItem('selectGenre', PBI_GENRE_CODE);
				
				if(PBI_PERSONNEL_MIN != '제한없음') $('#personnel_min').val(PBI_PERSONNEL_MIN);
				if(PBI_PERSONNEL != '제한없음') $('#personnel').val(PBI_PERSONNEL);
				
				if(PBI_NO_PAY === '0'){
					//페이 지급 안함
					$('#no_pay').prop('checked', true);
					$('#transportation').prop('checked', false);
					$('#transportation').attr('disabled', true);
					$('#pay').val('');
					$('#pay').attr('readonly', true);
					$('#pay').addClass('bg-gray');
					$('#pay_max').val('');
					$('#pay_max').attr('readonly', true);
					$('#pay_max').addClass('bg-gray');
				} else {
					//페이 지급함
					$('#no_pay').prop('checked', false);
					if(PBI_TRANSPORTATION === '1') $('#transportation').prop('checked', true);
					if(PBI_PAY != '0') $('#pay').val(PBI_PAY);
					if(PBI_PAY_MAX != '0') $('#pay_max').val(PBI_PAY_MAX);
				}
				
				$('#manager').val(PBI_MANAGER);
				if(PBI_TEL != '-') $('#tel').val(PBI_TEL);
				if(PBI_EMAIL != '-') $('#email').val(PBI_EMAIL);
				
				$('#address').val(PBI_ADDRESS);
				$('#detailaddress').val(PBI_DETAILADDRESS);
				
				const path = 'images/user/user'+PBI_USER_NO;
				let imgId = '';
				let leng = 0;
				let imgarry;
				let cnt, cnt2;
				
				if(PBI_PLACE_IMG != ''){
					imgarry = PBI_PLACE_IMG.split(',');
					leng = imgarry.length;
					cnt = leng-1;
					
					for(let i=0; i<leng; i++){
						imgId = imgarry[i];
						$('.hall-box').eq(i).attr('id', imgId);
						
						 var new_img = 'upload/images/user/user' + PBI_USER_NO + "/" + imgId;
						 var imgSrc = getImagePromise(new_img).then(value => {
							$('.hall-box').eq(cnt).find('.rimg').attr('src', value);
							$('.hall-box').eq(cnt).find('.rimg').show();
							$('.hall-box').eq(cnt).find('.cancel').show();
							cnt--;
					     });
					}
					
				}
				
				if(PBI_PRODUCT_IMG != ''){
					imgarry = PBI_PRODUCT_IMG.split(',');
					leng = imgarry.length;
					cnt2 = leng-1;
					
					for(let i=0; i<leng; i++){
						imgId = imgarry[i];
						$('.product-box').eq(i).attr('id', imgId);
						
						 var new_img = 'upload/images/user/user' + PBI_USER_NO + "/" + imgId;
						 var imgSrc = getImagePromise(new_img).then(value => {
								$('.product-box').eq(cnt2).find('.rimg').attr('src', value);
								$('.product-box').eq(cnt2).find('.rimg').show();
								$('.product-box').eq(cnt2).find('.cancel').show();
								cnt2--;
					     });
					}
				}
	                
			    
				
				$('#content').val(PBI_CONTENT);

				const lat = PBI_LATLNG.split(',')[1];
				const lng = PBI_LATLNG.split(',')[0];
				
				getKakaoMap(lat, lng);
				
				$('#lat').val(lat);
				$('#lng').val(lng);
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		},
		complete: function(){
			hideLoading();
		} 
	});
}

const handlerPbiUpdate = () => {
	const no = $('#no').val();
	const imageText = changeQuotes($('#change-image').val());
	const title = changeQuotes($('#title').val());
	let asdate = $('#asdate').val();
	let aedate = $('#aedate').val();
	let psdate = $('#psdate').val();
	let pedate = $('#pedate').val();
	let genre = $('#text_genre').val();
	let genrecode = $('#select_genre').val();
	
	let personnel = ($('#personnel').val() == '') ? '제한없음' : removeComma($('#personnel').val());
	let personnel_min = ($('#personnel_min').val() == '') ? '제한없음' : removeComma($('#personnel_min').val());
	let pay = ($('#pay').val() == '') ? '0' : removeComma($('#pay').val());
	let payMax = ($('#pay_max').val() == '') ? '0' : removeComma($('#pay_max').val());
	let address = $('#address').val();
	let detailaddress = changeQuotes($('#detailaddress').val());
	let content = changeQuotes($('#content').val().replace(/<a>/gi, '<url>').replace(/<\/a>/gi, '</url>'));
	
	let noPay = ($('#no_pay').is(':checked')) ? '0' : '1';
	let transportation = ($('#transportation').is(':checked')) ? '1' : '0';
	
	let lat = $('#lat').val();
	let lng = $('#lng').val();
	
	let latlng = lng+','+lat;
	
	//let fileText = $('#change-appfile').val();
	//let site = changeQuotes($('#site').val());
	let manager = $('#manager').val();
	let tel = $('#tel').val();
	let email = $('#email').val();
	
	if(spaceChk(manager) == '') manager = '-';
	if(spaceChk(tel) == '') tel = '-';
	if(spaceChk(email) == '') email = '-';
	
	let hallImg = '';
	let productImg = '';
	
	const hallLeng = $('.hall-box').length;
	const productLeng = $('.product-box').length;
	
	let imgstr = '';
	
	for(var i=0; i<hallLeng; i++){
		imgstr = $('.hall-box').eq(i).attr('id');
		
		if(imgstr != '' && imgstr != null && imgstr != 'null' && imgstr != undefined && imgstr != 'undefined'){
			if(hallImg === '') hallImg += imgstr;
			else hallImg += ',' + imgstr;
		}
	}
	
	for(var i=0; i<productLeng; i++){
		imgstr = $('.product-box').eq(i).attr('id');
		
		if(imgstr != '' && imgstr != null && imgstr != 'null' && imgstr != undefined && imgstr != 'undefined'){
			if(productImg === '') productImg += imgstr;
			else productImg += ',' + imgstr;
		}
	}
	
	
	if(spaceChk(imageText) == ''){
		alert('이미지를 선택해주세요.');
		$(window).scrollTop(0);
		return;
	} else if(spaceChk(title) == ''){
		alert('제목을 입력해주세요.');
		$('#title').val('');
		$('#title').focus();
		return;
	} else if(spaceChk(asdate) == ''){
		alert('접수 시작일을 입력해주세요.');
		$('#asdate').val('');
		$('#asdate').focus();
		return;
	} else if(spaceChk(aedate) == ''){
		alert('접수 마감일을 입력해주세요.');
		$('#aedate').val('');
		$('#aedate').focus();
		return;
	} else if(spaceChk(psdate) == ''){
		alert('행사 시작일을 입력해주세요.');
		$('#psdate').val('');
		$('#psdate').focus();
		return;
	} else if(spaceChk(pedate) == ''){
		alert('행사 종료일을 입력해주세요.');
		$('#pedate').val('');
		$('#pedate').focus();
		return;
	} else if(spaceChk(address) == ''){
		alert('주소를 검색해주세요.');
		$('#address').val('');
		$('#address').focus();
		return;
	} else if(spaceChk(detailaddress) == ''){
		alert('상세주소를 입력해주세요.');
		$('#detailaddress').val('');
		$('#detailaddress').focus();
		return;
	} else if(spaceChk(lat) == ''){
		alert('좌표값을 찾지 못했습니다. 장소를 지도에서 선택해주세요.');
		return;
	} else if(spaceChk(content) == ''){
		alert('상세 모집요강을 입력해주세요.');
		$('#content').val('');
		$('#content').focus();
		return;
	} 
	
	if(asdate.length != 10 || aedate.length != 10 || psdate.length != 10 || pedate.length != 10){
		$('#asdate').focus();
		alert('접수기간 또는 행사기간을 다시 확인해주세요.');
		return;
	} else if(tel != '' && tel.length < 11){
		$('#tel').focus();
		alert('전화번호를 다시 확인해주세요');
		return;
	}
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/public_busking_info/public_busking_info_update.jsp',
		data : {
			no: no,
			pbiThumnailImg: imageText,
			pbiMainImg: imageText,
			pbiTitle: title,
			pbiReceiptSdate: asdate,
			pbiReceiptEdate: aedate,
			pbiEventSdate: psdate,
			pbiEventEdate: pedate,
			pbiGenre: genre,
			pbiGenreCode: genrecode,
			pbiPersonner: personnel,
			pbiPersonner_min: personnel_min,
			pbiPay: pay,
			pbiPayMax: payMax,
			pbiAddress: address,
			pbiDetailaddress: detailaddress,
			pbiLatlng: latlng,
			pbiContent: content,
			pbiManager: manager,
			pbiTel: tel,
			pbiEmail: email,
			pbiNoPay: noPay,
			pbiTransportation: transportation,
			hallImg: hallImg,
			productImg: productImg
		},
		dataType: "xml",
		timeout: 30000,
		beforeSend: function(){
			showLoading('수정중입니다.');
		},
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var RESULT = $(this).find('RESULT').text();
				var MSG = $(this).find('MESSAGE').text();
				
				if(RESULT == 'true' || RESULT == 'TRUE'){
					sessionStorage.clear();
					showApplyPopup();
				} else {
					alert('수정 실패했습니다.\n잠시후 다시 시도해주세요');
					return;
				}
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('수정 실패했습니다.\n잠시후 다시 시도해주세요');
			return;
			//hideLoading();
		}, // end error
		complete: function(){
			hideLoading();
		}
	});
}

const noLogin = () => {
	alert('공모등록을 위하여 재로그인이 필요합니다.');
	return;
}