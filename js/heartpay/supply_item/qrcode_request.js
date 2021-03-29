function goQrRequest(){
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
		} else {
			loadPage('supply_item/qrcode_request.jsp');
			/*var bocChk = getCookie('busker_oath');
			if(bocChk == 'Y'){
				loadPage('supply_item/qrcode_request.jsp');
			} else {
				alert('버스커 선서에 동의한 아티스트만 QR 신청이 가능합니다.');
				goBuskingOath();
			}*/
		}
	}
}

function goQrRequestList(){
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
		} else {
			loadPage('supply_item/qrcode_request_list.jsp');
		}
	}
}

/*//QR팝업 닫기
$(document).on('click', '.qrp_close_btn', function(){
	$("#qrRequestPopup").popup("close");
});

//QR팝업 닫기
$(document).on('click', '#qrp_image', function(){
	$("#qrRequestPopup").popup("close");
});*/


/*//페이지 생성시 무상지원 팝업 띄우기
$(document).on('pageshow', '#qrcode_request', function(){
	$("#qrRequestPopup").popup( "option" , "dismissible" , false);
	$("#qrRequestPopup" ).popup( "option", "overlayTheme", "b" );
	$("#qrRequestPopup" ).popup( "option", "positionTo", "window" );
	$('#qrRequestPopup').popup('open');
	
	$('#qrRequestPopup-screen').css('height', '100%');
});*/


//약관 전체선택 클릭시
$(document).on('change', '#qr_total_checkbox', function(){
	if($(this).prop('checked')){
		$('#qr_delivery_checkbox').prop('checked', true);
		$('#qr_request_service_checkbox').prop('checked', true);
		$('#qr_consignment_checkbox').prop('checked', true);
	} else {
		$('#qr_delivery_checkbox').prop('checked', false);
		$('#qr_request_service_checkbox').prop('checked', false);
		$('#qr_consignment_checkbox').prop('checked', false);
	}
});


//QR신청 페이지
$(document).on('pageinit', '#qrcode_request', function() {
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/supply_item/qrcode_request.jsp";
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');

			$('#qr-team-select').empty();
			$("#qr-team-select").append('<option value="">팀 이름을 선택하세요</option>');			
			
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				
				if(DATA.length == 0){
					$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
					$('#qr-team-select').empty();
					$("#qr-team-select").append('<option value="">팀 이름을 선택하세요</option>');	
				}else{
				
					var html = 	'<option value="' + TEAM_NO + '">' + TEAM_NAME +'</option>';
					$("#qr-team-select").append(html);
					$("#qr-team-select").selectmenu("refresh");
					
				}
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });	
			
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		}, // end error
		complete: function(){ 
			$('#qr-team-select option:eq(1)').prop('selected', true);
			$('#qr-team-select').selectmenu().selectmenu('refresh', true);
		}
	});
	
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
        		$('#USERNAME').val(NICKNAME);
        	});
        }
	});
});

//QR코드 신청하기 클릭 시
$(document).on('click', '#BtnQrRequestGo', function(){
	var qr_reqeust_radio = $('input[name=qr_reqeust_radio]:checked').val();
	var team_no = $('#qr-team-select option:selected').val();
	var qrtype = $('#qr-select option:selected').val();
	var addr = changeQuotes($('#address').val());
	var zip_code = $('#postcode').val();
	var detail_addr = $('#qrRequest_detail_addr').val();
	
	if(team_no == ""){
		infoTxtBox("팀을 선택해주세요");
		$('#qr-team-select').focus();
		return;
	}
	if(qrtype == ''){
		infoTxtBox("QR배너 사이즈를 선택해주세요");
		$('#qr-select').focus();
		return;
	}
	if(addr == ""){
		infoTxtBox("주소를 입력해주세요");
		$('#address').focus();
		return;		
	}
	if(zip_code == ""){
		infoTxtBox("우편번호를 입력해주세요");
		$('#postcode').focus();
		return;		
	}
	if(detail_addr == ""){
		infoTxtBox("상세주소를 입력해주세요");
		$('#qrRequest_detail_addr').focus();
		return;		
	}
	
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
	
	
	var qr_reqeust_radio = $('input[name=qr_reqeust_radio]:checked').val();
	var price = $('#AMOUNT').val();
	var name = '';
	var tel = '';
	var email = '';
	var paymethod = $('#kiwoompay_method').val();
	var team_no = $('#qr-team-select option:selected').val();
	var addr = changeQuotes($('#address').val());
	var zip_code = $('#postcode').val();
	var detail_addr = changeQuotes($('#qrRequest_detail_addr').val());
	var productcode = $('#PRODUCTCODE').val();
	
	$.ajax({
		type: "GET",
		url: '/service/supply_item/qrcode_insert.jsp',
		data:{
			team_no: team_no,
			qrtype: qrtype, 
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
			alert('신청이 완료되었습니다');
			toHome();
			//QR신청 유료화시 주석 해제
			//$('#btnSubmit').click();
		}
	});
	
	//QR 신청 유료화시 주석 해제
	/*$('.qrcode_request_info').hide();
	$('#BtnQrRequestGo').hide();
	$('.qrcode_request_payment').show();
	$('.qrb_btn_container').show();*/
});

//사이즈 선택시
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

//이전 버튼 클릭시
$(document).on('click', '#qrb_prev_btn', function(){
	$('.qrcode_request_info').show();
	$('#BtnQrRequestGo').show();
	$('.qrcode_request_payment').hide();
	$('.qrb_btn_container').hide();
});

//결제하기 버튼 클릭시
$(document).on('click', '#qrb_success_btn', function(){
	/*var tf = qrRequestAppConditionChk(team_no, 2, 1);
	
	if( tf != 'true'){
		var performChk = tf.split(',')[1];
		
		if(parseInt(performChk) == 0){
			var conf2 = confirm('신청 조건을 충족하지 못했습니다.\n지금 바로 공연 일정을 등록하시겠습니까 ?');
			if(!conf2){
				return;
			} else {
				go_perform_reg();
				return;
			}
		} else {
			var conf = confirm('신청 조건을 충족하지 못했습니다.\n지금 바로 사진과 동영상을 등록하시겠습니까 ?');
			if(!conf){
				return;
			} else {
				goTeamMediaRegPage();
				return;
			}
		}
	}*/
	
	
});

/*$(document).on('pageshow', '#qrcode_request_complete_page', function() {
	var qrTno = sessionStorage.getItem('qrTno');
	
	var resultchk = $('#ResultCode').val();
	var amt = $('#Amt').val();
	var tid = $('#TID').val();
	
	if(resultchk != "3001" && resultchk != "4000" && resultchk != "4100"){
		return;
	} else {
		//결제 성공시
		$.ajax({
			type: "GET",
			url: '/service/supply_item/set_qr_request_tid.jsp',
			data:{
				team_no: qrTno,
				amt: amt,
				tid: tid
			},
			async : false,
			success: function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				$(DATA).each(function(){
					var QR_REQUEST_NO = $(this).find('QR_REQUEST_NO').text();
					
					$('#qr_request_no').val(QR_REQUEST_NO);
				}).promise().done(function (){
					sessionStorage.setItem('qpcys', 'yes');
				});
			}
		});
	}
});*/

function qr_request_complete_back(){	
	//결제 완료 후 시점때문에 뒤로가기 따로 만들어줘야함
	var qpcys = sessionStorage.getItem('qpcys');
	if(qpcys == null || qpcys == 'null'){
		history.go(-1);
	} else {
		sessionStorage.removeItem('qpcys');
		location.href = '/app_root/index.jsp';
	}
}

function qrRequestAppConditionChk(tno, pcount, vcount){
	var result;
	$.ajax({
		type: "GET",
		url: '/service/supply_item/qrcode_request_app_condition.jsp',
		data:{
			team_no: tno
		},
		async : false,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var PCOUNT = $(this).find('PCOUNT').text();
				var VCOUNT = $(this).find('VCOUNT').text();
				var PERFORMCHK = $(this).find('PERFORMCHK').text();
				
				if(parseInt(PCOUNT) >= pcount && parseInt(VCOUNT) >= vcount && parseInt(PERFORMCHK) >= 1){
					result = 'true';
				} else {
					result = 'false,'+PERFORMCHK;
				}
			});
		}
	});
	return result;
}