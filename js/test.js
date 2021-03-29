function goTestMap(){
	loadPage('test/kakao_map_test.jsp');
}

function goTelTest(){
	loadPage('test/tel_test.jsp');
}

$(document).on('pageinit', '#kakao_map_test', function(){
	 $.ajax({
	        type: "GET",
	        cache: false,
	        url: '/service/user/get_myinfo_list.jsp',
	        contentType: "application/xml; charset=utf-8",
	        dataType: "xml",
	        timeout: 30000,
	        success: function(data) {
	        	var ROOT = $(data).find('ROOT');
	        	var DATA = $(ROOT).find('DATA');
	        	
	        	$(DATA).each(function(){
	        		var USER_ID = $(this).find('USER_ID').text();
	        		var NICKNAME = $(this).find('NICKNAME').text();
	        		
	        		$('#EMAIL').val(USER_ID);
	        		$('#USERID').val(USER_ID);
	        		$('#USERNAME').val(NICKNAME);
	        	});
	        }
	 });
});

$(document).on('click', '.qr_payment_price', function(){
	$('.qr_payment_price').removeClass('qrp_on');
	$(this).addClass('qrp_on');
	
	var str = $(this).attr('id');
	var price = str.split('&')[0];
	var product = str.split('&')[1];
	
	$('#AMOUNT_TEXT').val(addComma(price) + '원');
	$('#AMOUNT').val(price);
	$('#PRODUCTNAME').val(product);
});


$(document).on('click', '#pay_test_btn', function(){

	if(!$('#qr_delivery_checkbox').prop('checked')){
		alert('QR코드 배너 배송정책에 동의해주세요.');
		return;
	} else if(!$('#qr_request_service_checkbox').prop('checked')){
		alert('QR코드 배너 신청 이용약관에 동의해주세요.');
	 	return;
	} else if(!$('#qr_consignment_checkbox').prop('checked')){
		alert('개인정보의 제3자제공 및 위탁에 동의해주세요.');
		return;
	}
	
	var d = new Date();
	var month = setPad(d.getMonth() + 1, 2);
	var day = setPad(d.getDate(), 2);
	var ranNum = Math.floor(Math.random() * (999 - 1 + 1)) + 1;
	ranNum = setPad(ranNum, 3);
	
	var qrProductcode = 'Q' +  String(month) + String(day) + ranNum;
	$('#PRODUCTCODE').val(qrProductcode);
	
	var qr_reqeust_radio = 'Y';
	var price = $('#AMOUNT').val();
	var name = '';
	var tel = '';
	var email = '';
	var paymethod = $('#kiwoompay_method').val();
	var team_no = '9999';
	var addr = '';
	var zip_code = '';
	var detail_addr = '';
	var productcode = $('#PRODUCTCODE').val();
	
	$.ajax({
		type: "GET",
		url: '/service/supply_item/qrcode_insert.jsp',
		data:{
			team_no: team_no,
			price: price,
			name: name,
			tel: tel,
			email: email,
			paymethod: paymethod,
			qr_video_share: qr_reqeust_radio,
			addr: addr,
			zip_code: zip_code,
			detail_addr: detail_addr,
			productcode: productcode
		},
		async : false,
		complete: function(){
			$('#btnSubmit').click();
		}
	});
});

