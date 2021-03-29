//모바일팁박스 페이지 생성시
$(document).on('pageinit', '#support_page', function() {
	$('#team_no').val(tno);
	
	var now = new Date();
	var year = now.getFullYear();
	var month = now.getMonth() + 1;
	var date = now.getDate();
	var hour = now.getHours();
	var min = now.getMinutes();
	var sec = now.getSeconds();
	
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

//모바일 팁박스 금액 +버튼 클릭시
$(document).on('click', '.spt_amt_plus', function(){
	var amount = $('#AMOUNT').val();
	if(amount == '') amount = 0;
	amount = parseInt(amount);
	
	var changePrice = parseInt($(this).text().split('+')[1]);
	
	amount += changePrice;
	
	$('#AMOUNT').val(amount);
	$('#AMOUNT_TEXT').val(addComma(amount) + '원');
});

//모바일 팁박스 금액 -버튼 클릭시
$(document).on('click', '.spt_amt_minus', function(){
	var amount = $('#AMOUNT').val();
	if(amount == '') amount = 0;
	amount = parseInt(amount);
	
	var changePrice = parseInt($(this).text().split('-')[1]);
	
	amount -= changePrice;
	
	if(amount < 0){
		alert('금액은 마이너스가 될 수 없습니다.');
		return;
	}
	
	$('#AMOUNT').val(amount);
	$('#AMOUNT_TEXT').val(addComma(amount) + '원');
});

//후원하기 버튼 클릭시
$(document).on('click', '#support_success_btn', function(){
	//입력한 정보 db에 추가
	sessionStorage.setItem('spt_no', tno);
	var spt_no = tno;
	var price = $('#AMOUNT').val();
	var name = $('#USERNAME').val();
	var email = $('#EMAIL').val();
	var paymethod = $('#kiwoompay_method').val();
	var tel = $('#TEL').val();
	
	if(paymethod == '' || paymethod == null){
		alert('결제 방법을 선택해주세요.');
		return;
	} else if(name == ''){
		alert('후원자명을 입력해주세요.');
		return;
	} else if( (price * 1) < 2000 ){
		alert('최소 금액은 2000원입니다.');
		return;
	} else if(email == ''){
		alert('메일주소를 입력해주세요.');
		return;
	} else if(!$('#sp_consignment_checkbox').prop('checked')){
		alert('개인정보의 제3자제공 및 위탁에 동의해주세요.');
		return;
	}
	
	
	var d = new Date();
	var month = setPad(d.getMonth() + 1, 2);
	var day = setPad(d.getDate(), 2);
	var ranNum = Math.floor(Math.random() * (999 - 1 + 1)) + 1;
	ranNum = setPad(ranNum, 3);
	
	var tbProductcode = 'T' +  String(month) + String(day) + ranNum;
	$('#PRODUCTCODE').val(tbProductcode);
	sessionStorage.setItem('tbProductcode', tbProductcode);
	
	$.ajax({
		type: "GET",
		url: '/service/support/set_support_history.jsp',
		data:{
			team_no: spt_no,
			price: price,
			name: name,
			tel: tel,
			email: email,
			paymethod: paymethod,
			productcode: tbProductcode
		},
		complete: function(){
			$('#btnSubmit').click();
		}
	});
	
});

//모바일 팁 플래시 제어
var flash_2 = null;
function mtFlashAnimation() {
	var flash_chk= 0;
	if(flash_2 == null){
		flash_2 = setInterval(function() {
			if(flash_chk % 2 == 1){
				window.plugins.flashlight.switchOn(
		  		      function() {}, // optional success callback
		  		      function() {}, // optional error callback
		  		      {intensity: 1.0} // optional as well //flash 밝기
			  	);
			}
			else{
				window.plugins.flashlight.switchOff();
			}
			flash_chk++;
		}, 500);
	}
}

function mtFlashAnimationOff() {
	window.plugins.flashlight.switchOff();
	clearInterval(flash_2);
	flash_2 = null;
}

//후원 완료 페이지 생성시
$(document).on('pageinit', '#support_complete_page', function(){
	mtFlashAnimation();
	setTimeout(function(){
		mtFlashAnimationOff();
	}, 2500);
});

$(document).on('pageshow', '#support_complete_page', function() {
	var tbProductcode = sessionStorage.getItem('tbProductcode');
	
	$.ajax({
		type: "GET",
		url: '/service/support/get_support_history.jsp',
		data:{
			tbProductcode: tbProductcode
		},
		async : false,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var SUPPORT_SUCCESS = $(this).find('SUPPORT_SUCCESS').text();
				var SUPPORT_TID = $(this).find('SUPPORT_TID').text();
				
				if(SUPPORT_SUCCESS == 'Y'){
					$('.spt_success').show();
					$('.spt_comp_footer').show();

					$.ajax({
						type: "GET",
						url: '/service/pushService/supportPush.jsp',
						data:{
							tid: SUPPORT_TID
						},
						async : false
					});
					
				} else if(SUPPORT_SUCCESS == 'N'){
					$('.spt_failed').show();
				}
				
			}).promise().done(function (){
				sessionStorage.setItem('spcys', 'yes');
			});
		}
	});
});

$(document).on('pagehide', '#support_complete_page', function(){
	if(flash_2 != null){
		mtFlashAnimationOff();
	}
});

//건너뛰기 버튼 클릭시
$(document).on('click', '#spt_comp_skipbtn', function(){
	go_support_list();
});

//보내기 버튼 클릭시
$(document).on('click', '#spt_comp_sendbtn', function(){
	var spt_msg = $('#spt_comp_msg').val();
	var spt_no = sessionStorage.getItem('tbProductcode');
	
	if(spt_msg == ''){
		alert('메시지를 입력 후 다시 클릭해주세요.');
		$('#spt_comp_msg').focus();
		return;
	}
	
	$.ajax({
		type: "GET",
		url: '/service/support/send_support_msg.jsp',
		data:{
			support_no: spt_no,
			send_msg: spt_msg
		},
		async : false,
		complete: function(){
			alert('메시지가 전송되었습니다.');
			go_support_list();
		}
	});
});