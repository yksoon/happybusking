$(document).ready(function(){
	const id = CommonFunction.GetParameterByName('id');
	
	let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	let options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(37.519505, 126.930483), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};

	map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	kakao.maps.event.addListener(map, 'click', function(e){
		let latlng = e.latLng;
		
		searchDetailAddrFromCoords(latlng, function(res, status){
			if(status === kakao.maps.services.Status.OK){ //주소 검색 성공
				let addr = !!res[0].road_address ? res[0].road_address.address_name : res[0].address.address_name;
				$('#address').val(addr);
				$('#detailaddress').val('');
				
				lat = latlng.getLat();
				lng = latlng.getLng();
				
				addMarkers(lat, lng);
				
			} else { //주소 검색 실패
				alert('주소 검색에 실패했습니다. 다시 시도해주세요');
				return;
			}
		});
	});
	
	getPbiDetail(id);
});

const getPbiDetail = (id) => {
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		async: false,
		url: '/service/public_busking_info/get_pbi_detail.jsp',
		data : {
			pbiNo: id
		},
		dataType: "xml",
		timeout: 30000,
		beforeSend: function(){
			$('#popup_text').html('로딩중입니다.');
			$('#loading').show();
		},
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				const PBI_MAIN_IMG = $(this).find('PBI_MAIN_IMG').text();
				const PBI_TITLE = $(this).find('PBI_TITLE').text();
				const PBI_RECEIPT_SDATE = $(this).find('PBI_RECEIPT_SDATE').text();
				const PBI_RECEIPT_EDATE = $(this).find('PBI_RECEIPT_EDATE').text();
				const PBI_EVENT_SDATE = $(this).find('PBI_EVENT_SDATE').text();
				const PBI_EVENT_EDATE = $(this).find('PBI_EVENT_EDATE').text();
				const PBI_GENRE = $(this).find('PBI_GENRE').text();
				const PBI_GENRE_CODE = $(this).find('PBI_GENRE_CODE').text();
				const PBI_PERSONNEL = $(this).find('PBI_PERSONNEL').text();
				const PBI_PERSONNEL_MIN = $(this).find('PBI_PERSONNEL_MIN').text();
				const PBI_NO_PAY = $(this).find('PBI_NO_PAY').text();
				const PBI_TRANSPORTATION = $(this).find('PBI_TRANSPORTATION').text();
				const PBI_PAY = $(this).find('PBI_PAY').text();
				const PBI_PAY_MAX = $(this).find('PBI_PAY_MAX').text();
				const PBI_MANAGER = $(this).find('PBI_MANAGER').text();
				const PBI_TEL = $(this).find('PBI_TEL').text();
				const PBI_EMAIL = $(this).find('PBI_EMAIL').text();
				const PBI_ADDRESS = $(this).find('PBI_ADDRESS').text();
				const PBI_DETAILADDRESS = $(this).find('PBI_DETAILADDRESS').text();
				const PBI_LATLNG = $(this).find('PBI_LATLNG').text();
				const PBI_CONTENT = $(this).find('PBI_CONTENT').text();
				const PBI_FILE = $(this).find('PBI_FILE').text();
				
				sessionStorage.setItem('selectGenre', PBI_GENRE_CODE);
				
				$('#change-appfile').val(PBI_FILE);
				$('#change-image').val(PBI_MAIN_IMG);
				$('#title').val(PBI_TITLE);
				$('#asdate').val(PBI_RECEIPT_SDATE);
				$('#aedate').val(PBI_RECEIPT_EDATE);
				$('#psdate').val(PBI_EVENT_SDATE);
				$('#pedate').val(PBI_EVENT_EDATE);
				$('#select_genre').val(PBI_GENRE_CODE);
				$('#text_genre').val(PBI_GENRE);
				$('#personnel_min').val(PBI_PERSONNEL_MIN);
				$('#personnel').val(PBI_PERSONNEL);
				$('#pay').val(PBI_PAY);
				$('#pay_max').val(PBI_PAY_MAX);
				$('#manager').val(PBI_MANAGER);
				$('#tel').val(PBI_TEL);
				$('#email').val(PBI_EMAIL);
				$('#address').val(PBI_ADDRESS);
				$('#detailaddress').val(PBI_DETAILADDRESS);
				$('#lat').val(PBI_LATLNG.split(',')[1]);
				$('#lng').val(PBI_LATLNG.split(',')[0]);
				$('#content').val(PBI_CONTENT);
				
				
				if(PBI_TRANSPORTATION == '1') $('#transportation').prop('checked', true);
				if(PBI_NO_PAY == '0') $('#no_pay').prop('checked', true);
				
				
				addMarkers(PBI_LATLNG.split(',')[1], PBI_LATLNG.split(',')[0]);
				
			});
		},
		error: function (xhr, message, errorThrown) {
			console.log(xhr);
			console.log(message);
			console.log(errorThrown);
			alert('잠시후 다시 시도해주세요.');
			history.go(-1);
			return;
			//hideLoading();
		}, // end error
		complete: function(){
			$('#loading').hide();
		}
	});
}

const pbiUpdate = () => {
	const id = CommonFunction.GetParameterByName('id');
	
	//let image = $('#image');
	let imageText = $('#change-image').val();
	let title = CommonFunction.changeQuotes($('#title').val());
	let asdate = $('#asdate').val();
	let aedate = $('#aedate').val();
	let psdate = $('#psdate').val();
	let pedate = $('#pedate').val();
	let genre = $('#text_genre').val();
	let genreCode = $('#select_genre').val();
	let personnel = (CommonFunction.removeComma($('#personnel').val()) == '') ? '제한없음' : CommonFunction.removeComma($('#personnel').val());
	let personnel_min = (CommonFunction.removeComma($('#personnel_min').val()) == '') ? '제한없음' : CommonFunction.removeComma($('#personnel_min').val());
	let pay = (CommonFunction.removeComma($('#pay').val()) == '') ? '0' : CommonFunction.removeComma($('#pay').val());
	let payMax = (CommonFunction.removeComma($('#pay_max').val()) == '') ? '0' : CommonFunction.removeComma($('#pay_max').val());
	let address = $('#address').val();
	let detailaddress = CommonFunction.changeQuotes($('#detailaddress').val());
	let content = CommonFunction.changeQuotes($('#content').val());
	
	let noPay = ($('#no_pay').is(':checked')) ? '0' : '1';
	let transportation = ($('#transportation').is(':checked')) ? '1' : '0';
	
	let fileText = $('#change-appfile').val();
	let site = CommonFunction.changeQuotes($('#site').val());
	let manager = $('#manager').val();
	let tel = $('#tel').val();
	let email = $('#email').val();
	
	if(tel != '' && tel != '-' && tel.length < 11){
		$('#tel').focus();
		alert('전화번호를 다시 확인해주세요');
		return;
	}
	
	if(CommonFunction.SpaceChk(site) == '') site = '-';
	if(CommonFunction.SpaceChk(manager) == '') manager = '-';
	if(CommonFunction.SpaceChk(tel) == '') tel = '-';
	if(CommonFunction.SpaceChk(email) == '') email = '-';
	
	let lat = $('#lat').val();
	let lng = $('#lng').val();
	
	let latlng = lng+','+lat;

	if(asdate.length != 10 || aedate.length != 10 || psdate.length != 10 || pedate.length != 10){
		$('#asdate').focus();
		alert('접수기간 또는 행사기간을 다시 확인해주세요.');
		return;
	}
	
	if(CommonFunction.SpaceChk(imageText) == ''){
		alert('이미지를 선택해주세요.');
		$(window).scrollTop(0);
		return;
	} else if(CommonFunction.SpaceChk(title) == ''){
		alert('제목을 입력해주세요.');
		$('#title').val('');
		$('#title').focus();
		return;
	} else if(CommonFunction.SpaceChk(asdate) == ''){
		alert('접수 시작일을 입력해주세요.');
		$('#asdate').val('');
		$('#asdate').focus();
		return;
	} else if(CommonFunction.SpaceChk(aedate) == ''){
		alert('접수 마감일을 입력해주세요.');
		$('#aedate').val('');
		$('#aedate').focus();
		return;
	} else if(CommonFunction.SpaceChk(psdate) == ''){
		alert('행사 시작일을 입력해주세요.');
		$('#psdate').val('');
		$('#psdate').focus();
		return;
	} else if(CommonFunction.SpaceChk(pedate) == ''){
		alert('행사 종료일을 입력해주세요.');
		$('#pedate').val('');
		$('#pedate').focus();
		return;
	} else if(CommonFunction.SpaceChk(address) == ''){
		alert('주소를 검색해주세요.');
		$('#address').val('');
		$('#address').focus();
		return;
	} else if(CommonFunction.SpaceChk(detailaddress) == ''){
		alert('상세주소를 입력해주세요.');
		$('#detailaddress').val('');
		$('#detailaddress').focus();
		return;
	} else if(CommonFunction.SpaceChk(lat) == ''){
		alert('좌표값을 찾지 못했습니다. 장소를 지도에서 선택해주세요.');
		return;
	} else if(CommonFunction.SpaceChk(content) == ''){
		alert('상세 모집요강을 입력해주세요.');
		$('#content').val('');
		$('#content').focus();
		return;
	} 
	
	if($('#image').val() != ''){
		pbiThumnailImg = $('#image')[0].files[0].name;

		var maxSize = 5 * 1024 * 1024;
		if(document.getElementById('image').files[0].size >= maxSize){
			alert('이미지 사이즈는 5MB 이내로 등록 가능합니다').
			return;
		}
	}
	
	$.ajaxSettings.traditional = true;
	var formData = new FormData();
	
	formData.append('id', id);
	formData.append('pbiThumnailImg', imageText);
	formData.append('pbiMainImg', imageText);
	formData.append('pbiTitle', title);
	formData.append('pbiReceiptSdate', asdate);
	formData.append('pbiReceiptEdate', aedate);
	formData.append('pbiEventSdate', psdate);
	formData.append('pbiEventEdate', pedate);
	formData.append('pbiGenre', genre);
	formData.append('pbiGenreCode', genreCode);
	formData.append('pbiPersonner', personnel);
	formData.append('pbiPersonner_min', personnel_min);
	formData.append('pbiPay', pay);
	formData.append('pbiPayMax', payMax);
	formData.append('pbiAddress', address);
	formData.append('pbiDetailaddress', detailaddress);
	formData.append('pbiLatlng', latlng);
	formData.append('pbiContent', content);
	formData.append('pbi_thumnail_img', $('#image')[0].files[0]);
	formData.append('pbi_main_img', $('#image')[0].files[0]);
	formData.append('pbiFile', fileText);
	formData.append('pbiSite', site);
	formData.append('pbiManager', manager);
	formData.append('pbiTel', tel);
	formData.append('pbiEmail', email);
	formData.append('pbiNoPay', noPay);
	formData.append('pbiTransportation', transportation);
	
	if(fileText != ''){
		formData.append('pbi_file', $('#appfile')[0].files[0]);
	}
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/public_busking_info/public_busking_info_update.jsp',
		data : formData,
		processData: false,
		contentType: false,
		dataType: "xml",
		timeout: 30000,
		beforeSend: function(){
			$('#popup_text').html('수정중입니다.');
			$('#loading').show();
		},
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var RESULT = $(this).find('RESULT').text();
				var MSG = $(this).find('MESSAGE').text();
				
				if(RESULT == 'true' || RESULT == 'TRUE'){
					alert('수정되었습니다.');
					sessionStorage.clear();
					history.go(-1);
				} else {
					alert('수정 실패했습니다.\n잠시후 다시 시도해주세요');
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
			$('#loading').hide();
		}
	});
}