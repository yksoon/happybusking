//공공 버스킹 정보 등록 페이지 생성시
$(document).on('pageinit', '#pbi_write', function(){
	var d = new Date();
	var year = d.getFullYear();
	var lastyear = (year * 1) + 3;
	var month = d.getMonth();
	var month = (month * 1) + 1;
	var day = d.getDate();
	
	for(var i = year; i <= lastyear; i ++){
		if(i == year){
			var html = '<option value="'+i+'" selected="selected">' + i + '년</option>';
		} else {
			var html = '<option value="'+i+'">' + i + '년</option>';
		}
		$('#pbi_event_syear').append(html);
		$('#pbi_event_eyear').append(html);
		$('#pbi_receipt_syear').append(html);
		$('#pbi_receipt_eyear').append(html);
	}
	
	for(var i = 1; i <= 12; i++){
		i = setPad(i, 2);
		if(i == month){
			var html = '<option value="'+i+'" selected="selected">' + i + '월</option>';
		} else {
			var html = '<option value="'+i+'">' + i + '월</option>';
		}
		
		$('#pbi_event_smonth').append(html);
		$('#pbi_event_emonth').append(html);
		$('#pbi_receipt_smonth').append(html);
		$('#pbi_receipt_emonth').append(html);
	}
	
	for(var i = 1; i <= 31; i++){
		i = setPad(i, 2);
		if(i == day){
			var html = '<option value="'+i+'" selected="selected">' + i + '일</option>';
		} else {
			var html = '<option value="'+i+'">' + i + '일</option>';
		}
		
		$('#pbi_event_sday').append(html);
		$('#pbi_event_eday').append(html);
		$('#pbi_receipt_sday').append(html);
		$('#pbi_receipt_eday').append(html);
	}
	
	for(var i = 0; i < 24; i ++){
		i = setPad(i, 2);
		if(i == '00'){
			var html = '<option value="'+i+'" selected="selected">' + i + '시</option>';
		} else {
			var html = '<option value="'+i+'">' + i + '시</option>';
		}
		
		$('#pbi_event_shour').append(html);
		$('#pbi_event_ehour').append(html);
	}
	
	for(var i = 0; i < 60; i ++){
		i = setPad(i, 2);
		if(i == '00'){
			var html = '<option value="'+i+'" selected="selected">' + i + '분</option>';
		} else {
			var html = '<option value="'+i+'">' + i + '분</option>';
		}
		
		$('#pbi_event_smin').append(html);
		$('#pbi_event_emin').append(html);
	}
	
	$('#pbi_write').find('select').selectmenu('refresh', true);
	
});

$(document).on('pageshow', '#pbi_write', function(){
	getKakaoMap('37.6547557', '127.0605938');
});


//공공 버스킹 정보 등록 버튼 클릭시
$(document).on('click', '#pbi_ws_btn', function(){
	var pbiThumnailImg = '';
	var pbiMainImg = '';
	var pbiTitle = changeQuotes($('#pbi_title').val());
	var pbiEventSdate = $('#pbi_event_syear').val() + '-' + $('#pbi_event_smonth').val() + '-' + $('#pbi_event_sday').val();
	var pbiEventEdate = $('#pbi_event_eyear').val() + '-' + $('#pbi_event_emonth').val() + '-' + $('#pbi_event_eday').val();
	var pbiReceiptSdate = $('#pbi_receipt_syear').val() + '-' + $('#pbi_receipt_smonth').val() + '-' + $('#pbi_receipt_sday').val();
	var pbiReceiptEdate = $('#pbi_receipt_eyear').val() + '-' + $('#pbi_receipt_emonth').val() + '-' + $('#pbi_receipt_eday').val();
	var pbiGenre = changeQuotes($('#pbi_genre').val());
	var pbiPersonner = changeQuotes($('#pbi_personner').val());
	var pbiPay = changeQuotes($('#pbi_pay').val());
	var pbiAddress = changeQuotes($('#address').val());
	var pbiDetailaddress = changeQuotes($('#pbi_detailaddress').val());
	var pbiLatlng = $('#latlng').val();
	var pbiContent = changeQuotes($('#pbi_content').val());
	
	//썸네일 이미지가 비어있지 않은 경우에만
	if($('#pbi_thumnail_img').val() != ''){
		pbiThumnailImg = $('#pbi_thumnail_img')[0].files[0].name;

		var maxSize = 5 * 1024 * 1024;
		if(document.getElementById('pbi_thumnail_img').files[0].size >= maxSize){
			alert('이미지 사이즈는 5MB 이내로 등록 가능합니다').
			return;
		}
	}
	
	//메인 이미지가 비어있지 않은 경우에만
	if($('#pbi_main_img').val() != ''){
		pbiMainImg = $('#pbi_main_img')[0].files[0].name;

		var maxSize = 5 * 1024 * 1024;
		if(document.getElementById('pbi_main_img').files[0].size >= maxSize){
			alert('이미지 사이즈는 5MB 이내로 등록 가능합니다').
			return;
		}
	}
	
	if(pbiTitle == ''){
		alert('제목 입력');
		return;
	}
	
	if(pbiContent == ''){
		alert('내용 입력');
		return;
	}
	
	$.ajaxSettings.traditional = true;
	var formData = new FormData();
	
	formData.append('pbiThumnailImg', pbiThumnailImg);
	formData.append('pbiMainImg', pbiMainImg);
	formData.append('pbiTitle', pbiTitle);
	formData.append('pbiEventSdate', pbiEventSdate);
	formData.append('pbiEventEdate', pbiEventEdate);
	formData.append('pbiReceiptSdate', pbiReceiptSdate);
	formData.append('pbiReceiptEdate', pbiReceiptEdate);
	formData.append('pbiGenre', pbiGenre);
	formData.append('pbiPersonner', pbiPersonner);
	formData.append('pbiPay', pbiPay);
	formData.append('pbiAddress', pbiAddress);
	formData.append('pbiDetailaddress', pbiDetailaddress);
	formData.append('pbiLatlng', pbiLatlng);
	formData.append('pbiContent', pbiContent);
	
	//썸네일 이미지 formdata에 추가
	if($('#pbi_thumnail_img').val() != ''){
		formData.append('pbi_thumnail_img', $('#pbi_thumnail_img')[0].files[0]);
	}
	
	//메인 이미지 formdata에 추가
	if($('#pbi_main_img').val() != ''){
		formData.append('pbi_main_img', $('#pbi_main_img')[0].files[0]);
	}
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/public_busking_info/public_busking_info_write.jsp',
		data : formData,
		processData: false,
		contentType: false,
		dataType: "xml",
		timeout: 30000,
		beforeSend: function(){
			$.mobile.loading( 'show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
		},
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var RESULT = $(this).find('RESULT').text();
				var MSG = $(this).find('MESSAGE').text();
				
				if(RESULT == 'true' || RESULT == 'TRUE'){
					toHome();
				} else {
					alert(MSG);
					return;
				}
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		}, // end error
		complete: function(){
			$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
		}
	});
});