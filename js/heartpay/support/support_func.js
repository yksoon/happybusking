function go_support_list() {
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	} else {
		loadPage('support/support_list.jsp');
	}
}

function go_support(){
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	} else {
		loadPage('support/support.jsp');
	}
	
}

function go_support_fromtipbox(team_no, team_name){
	var conf = confirm(team_name + '팀에게 팁을 주시겠습니까?');
	if(!conf){
		return;
	}
	
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	} else {
		tno = team_no;
		loadPage('support/support.jsp');
	}
	
}

function go_support_complete() {
	loadPage('support/support_complete.jsp');
}

function support_list_back(){	
	//결제 완료 후 시점때문에 뒤로가기 따로 만들어줘야함
	var spcys = sessionStorage.getItem('spcys');
	if(spcys == null || spcys == 'null'){
		history.go(-1);
	} else {
		location.href = '/app_root/index.jsp';
	}
}

function get_support_list(date, sort){
	$('#spt_list_body').empty();
	
	$.ajax({
		type: "GET",
		url: '/service/support/get_support_list.jsp',
		data:{
			date: date,
			sort: sort
		},
		async : false,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA0 = $(data).find('DATA0');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA0).each(function(){
				var TOTAL_PRICE = $(this).find('TOTAL_PRICE').text();
				TOTAL_PRICE = addComma(TOTAL_PRICE);
				$('#spt_lt_price').html(TOTAL_PRICE);
			});
			
			var sdata = $('.spt_lt_search_select').attr('id');
			if(sdata == 'spt_lt_search_onemonth'){
				$('#spt_lm_title').html('최근 1개월');
			} else if(sdata == 'spt_lt_search_threemonth'){
				$('#spt_lm_title').html('최근 3개월');
			} else {
				sdate = $('#spt_lt_search_date').val();
				$('#spt_lm_title').html(sdate.split('-')[0] + '년 ' + sdate.split('-')[1] + '월');
			}
			
			if(DATA.length == 0){
				$('#spt_list_body').html('<div class="noViewBtn" id="main_cont">해당 기간에 후원한 내역이 없습니다.</div>');
				return;
			}
			
			$(DATA).each(function(){
				var SUPPORT_NO = $(this).find('SUPPORT_NO').text();
				var SUPPORT_PRICE = $(this).find('SUPPORT_PRICE').text();
				var SUPPORT_DATE = $(this).find('SUPPORT_DATE').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				
				SUPPORT_PRICE = addComma(SUPPORT_PRICE);
				
				var html = '<div class="ui-grid-a spt_lb_content" id="'+SUPPORT_NO+'">' +
								'<div class="ui-block-a spt_lb_teamname">'+TEAM_NAME+'</div>' +
								'<div class="ui-block-b spt_lb_price_block">'+
									'<img src="/img/support/support2.png">'+
									'<span class="spt_lb_price">'+SUPPORT_PRICE+'</span>'+
									'원'+
								'</div>'+
								'<div class="ui-block-a spt_lb_date">'+SUPPORT_DATE+'</div>'+
								'<div class="ui-block-b spt_lb_state">결제완료</div>'+
							'</div>';
				
				$('#spt_list_body').append(html);
			});
		}
	});
}


function kakaoPaymentTest(){
	var settings = {
		"async": true,
		"crossDomain": true,
		"crossOrigin": true,
		"url": "https://kapi.kakao.com/v1/payment/ready",
		"method": "POST",
		"headers": {
		"authorization": "KakaoAK ***************************",
		"content-type": "application/x-www-form-urlencoded",
		"cache-control": "no-cache",
		},
		"data": {
		"cid": "TC0ONETIME",
		"partner_order_id": "partner_order_id",
		"partner_user_id": "partner_user_id",
		"item_name": "라이언빵",
		"quantity": "1",
		"total_amount": "1000",
		"vat_amount": "200",
		"tax_free_amount": "0",
		"approval_url": "http://www.happybusking.com/app_root",
		"fail_url": "http://www.happybusking.com/app_root",
		"cancel_url": "http://www.happybusking.com/app_root"
		}
	}
	
	$.ajax(settings).done(function (response) {
		console.log(response);
	});
}