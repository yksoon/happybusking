const handlerPbiApply = () => {
	const user_no = $('#user_no').val();
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
		url: '/service/public_busking_info/public_busking_info_write.jsp',
		data : {
			user_no: user_no,
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
			showLoading('등록중입니다.');
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
					alert('등록 실패했습니다.\n잠시후 다시 시도해주세요');
					return;
				}
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('등록 실패했습니다.\n잠시후 다시 시도해주세요');
			return;
			//hideLoading();
		}, // end error
		complete: function(){
			hideLoading();
		}
	});
}

const showApplyPopup = () => {
	$('#apply-popup').show();
}

const handlerApplyPopupClose = () => {
	$(window).scrollTop(0);
	history.go(0);
}