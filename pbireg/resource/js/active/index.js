let map;
let markers = [];
let geocoder = new kakao.maps.services.Geocoder();

$(document).ready(function(){
	let lat, lng;
	
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
});

const addMarkers = (lat, lng) => {
	let marker = new kakao.maps.Marker({
		position: new kakao.maps.LatLng(lat, lng)
	});
	
	markers.push(marker);
	removeMarkers();
	
	marker.setMap(map);
	
	$('#lat').val(lat);
	$('#lng').val(lng);
}

const removeMarkers = () =>{
	for(let i=0; i<markers.length; i++){
		markers[i].setMap(null);
	}
}

const searchDetailAddrFromCoords = (latlng, callback) => {
	geocoder.coord2Address(latlng.getLng(), latlng.getLat(), callback);
}

const serchGeocoderFromAddr = (addr) => {
	geocoder.addressSearch(addr, function(res, status){
		if(status === kakao.maps.services.Status.OK){	//정상 호출
			let lat = res[0].y;
			let lng = res[0].x;
			
			let coords = new kakao.maps.LatLng(lat, lng);
			addMarkers(lat, lng);
			
			map.setCenter(coords);
		} else { //에러
			alert('좌표 검색에 실패했습니다. 지도에서 클릭해주세요.');
			return;
		}
	});
}

const searchAddrFromText = () =>{
	let q = $('#address').val();
	new daum.Postcode({
        oncomplete: function(data) {
            let addr = '';
            let extraAddr = '';
            
            if(data.userSelectedType === 'R'){
            	addr = data.roadAddress;
            } else {
            	addr = data.jibunAddress;
            }
            
            if(data.userSelectedType === 'R'){
            	if(data.bname != '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
            	
            	if(data.buildingName !== '' && data.spartment === 'Y'){
            		extraAddr += (extraAddr !== '' ? ',' + data.buildingName : data.buildingName);
            	}
            	
            	if(extraAddr !== ''){
            		extraAddr = ' (' + extraAddr + ')';
            	}
            	
            	document.getElementById('detailaddress').value = extraAddr;
            } else {
            	document.getElementById('detailaddress').value = '';
            }
            
            document.getElementById('address').value = addr;
            
            document.getElementById('detailaddress').focus();
            
            serchGeocoderFromAddr(addr);
        }
    }).open({
    	q: q
    });
}

$(document).on('click', '#change-image', function(){
	$('#image').click();
});

$(document).on('change', '#image', function(e){
	const path = 'images/user/user0';
	uploadFile('image', 'video', path, function(){
		let res = $('#image').val().split('\\');
		res = res[res.length - 1];
		
		$('#change-image').val(res);
		
	});
});

$(document).on('keyup', '.dateinput', function(){
	let res = CommonFunction.dateFormatChange($(this).val());
	
	$(this).val(res);
});

$(document).on('keyup', '#personnel', function(){
	let res = CommonFunction.addComma($(this).val());
	
	if(parseInt(CommonFunction.removeComma(res)) === 0){
		res = '';
	} else if(parseInt(CommonFunction.removeComma(res)) > 1000){
		alert('최대 1000까지만 입력 가능합니다.');
		res = '1,000';
	}
	
	$(this).val(res);
});

$(document).on('change', '#no_pay', function(){
	const chk = $(this).is(':checked');
	
	const $t1 = $('#pay');
	const $t2 = $('#pay_max');
	const $t3 = $('#transportation');
	
	if(chk) {
		$t1.val('');
		$t1.attr('readonly', true);
		$t2.val('');
		$t2.attr('readonly', true);
		$t3.prop('checked', false);
		$t3.attr('disabled', true);
	} else {
		$t1.attr('readonly', false);
		$t2.attr('readonly', false);
		$t3.attr('disabled', false);
	}
});

$(document).on('keyup', '#pay, #pay_max', function(){
	let res = CommonFunction.addComma($(this).val());
	
	$(this).val(res);
});

$(document).on('keyup', '#tel', function(){
	let res = CommonFunction.telFormatChange($(this).val());
	
	$(this).val(res);
});

const pbiApply = () => {
	//let image = $('#image');
	let imageText = $('#change-image').val();
	let title = CommonFunction.changeQuotes($('#title').val());
	let asdate = $('#asdate').val();
	let aedate = $('#aedate').val();
	let psdate = $('#psdate').val();
	let pedate = $('#pedate').val();
	let genre = $('#text_genre').val();
	let personnel = (CommonFunction.removeComma($('#personnel').val()) == '') ? '제한없음' : CommonFunction.removeComma($('#personnel').val());
	let personnel_min = (CommonFunction.removeComma($('#personnel_min').val()) == '') ? '제한없음' : CommonFunction.removeComma($('#personnel_min').val());
	let pay = (CommonFunction.removeComma($('#pay').val()) == '') ? '0' : CommonFunction.removeComma($('#pay').val());
	let payMax = (CommonFunction.removeComma($('#pay_max').val()) == '') ? '0' : CommonFunction.removeComma($('#pay_max').val());
	let address = $('#address').val();
	let detailaddress = CommonFunction.changeQuotes($('#detailaddress').val());
	let content = CommonFunction.changeQuotes($('#content').val().replace(/<a>/gi, '<url>').replace(/<\/a>/gi, '</url>'));
	
	let noPay = ($('#no_pay').is(':checked')) ? '0' : '1';
	let transportation = ($('#transportation').is(':checked')) ? '1' : '0';
	
	//let fileText = $('#change-appfile').val();
	//let site = CommonFunction.changeQuotes($('#site').val());
	let manager = $('#manager').val();
	let tel = $('#tel').val();
	let email = $('#email').val();
	
	if(tel != '' && tel.length < 11){
		$('#tel').focus();
		alert('전화번호를 다시 확인해주세요');
		return;
	}
	
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
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/public_busking_info/public_busking_info_write.jsp',
		data : {
			pbiThumnailImg: imageText,
			pbiMainImg: imageText,
			pbiTitle: title,
			pbiReceiptSdate: asdate,
			pbiReceiptEdate: aedate,
			pbiEventSdate: psdate,
			pbiEventEdate: pedate,
			pbiGenre: genre,
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
			pbiTransportation: transportation
		},
		dataType: "xml",
		timeout: 30000,
		beforeSend: function(){
			$('#popup_text').html('등록중입니다.');
			$('#loading').show();
		},
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var RESULT = $(this).find('RESULT').text();
				var MSG = $(this).find('MESSAGE').text();
				
				if(RESULT == 'true' || RESULT == 'TRUE'){
					alert('등록되었습니다.');
					sessionStorage.clear();
					history.go(0);
				} else {
					alert('등록 실패했습니다.\n잠시후 다시 시도해주세요');
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

$(document).on('click', '#text_genre', function(){
	viewGenreSelectBox();
});

$(document).on('click', '#listbtn', function(){
	location.href='/pbireg/page/list.jsp';
});