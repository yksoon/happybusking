var tp_leader_chk;	//리더 체크 사용을 위한 변수 (지급신청으로 넘어갈 때 리더인지 아닌지 체크)
var tp_team_no;		//지급 신청, 지급 내역에서 사용 될 팀 번호 변수
var tp_money_temp;	//지급 신청 할 때 출금 가능 금액과 출금할 금액 비교를 위한 변수
var tp_team_name;	//고마운 사람들에서 사용되는 팀 이름 변수

$(document).on('pageinit', '#thanks_people', function() {
	$('#Go_AllSupport').click();
});


//후원전체 버튼 클릭시
$(document).on('click', '#Go_AllSupport', function() {
	tp_leader_chk='';
	tp_team_no='';
	$('#thanks_people_menu').empty();
	$('#pay_apply_btn').hide();
	
	var thanks_people_menu = '<div class="ui-block-a">'+
								'<div class="haeder_menu_div_on" id="Go_AllSupport">'+
									'<span>후원전체</span>'+
								'</div>'+
							'</div>'+
							'<div class="ui-block-b">'+
								'<div class="haeder_menu_div_base" id="Go_PayApply">'+
									'<span>지급신청</span>'+
								'</div>'+
							'</div>'+
							'<div class="ui-block-c">'+
								'<div class="haeder_menu_div_base" id="Go_WithdrawList">'+
									'<span>지급내역</span>'+
								'</div>'+
							'</div>';
	$('#thanks_people_menu').append(thanks_people_menu);
	
	$('#thanks_people_body').empty();
	
	var all_support_team_select = '<div id="all_support_team_select">'+
									'<select name="as_team_select" id="as_team_select">'+
										'<option selected disabled hidden>팀 이름을 선택해주세요</option>'+
									'</select>'+
								  '</div>';
	
	
	$('#thanks_people_body').append(all_support_team_select);
	
	
	var user_no = $('#user_no').val();
	//속한 팀 전체 리스트 불러오기
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/get_team_select.jsp',
		data: {
			user_no : user_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			$(DATA).each(function(i) {
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var option_content = '<option>'+TEAM_NAME+'</option>';
				$('#as_team_select').append(option_content);
				//$('#sc_area li:firstchild').css('font-weight', 'bold');
				
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			alert(xhr);
			alert(message);
			alert(errorThrown);
		} // end error
		
	});	
	
	var thanks_people_body ='<div id="as_account_body">'+
								'<div class="ui-grid-a">'+
									'<div class="ui-block-a" id="as_account_content">'+
										'<div><a id="as_account_team_name"></a>의<br>후원 받은 금액</div>'+
									'</div>'+
									'<div class="ui-block-b"><a id="as_account_price_text"></a> 원</div>'+
								'</div>'+
							'</div>'+
							'<div class="ui-grid-b" id="as_account_middle">' + 
								'<div class="ui-block-a" id="as_account_middle_title">' + 
									'<p>후원목록</p>' + 
								'</div>' +
								'<div class="ui-block-b" id="as_account_middle_sort">' +
									'<span>최신순</span>' +
								'</div>' +
							'</div>'+
							'<div id="as_account_list">'+
							'</div>'+
							'<div id="as_team_refresh_btn">'+
								'<img src="/img/board/refresh.svg">'+
							'</div>';
							
	$('#thanks_people_body').append(thanks_people_body);
	
	$('#as_team_select').change(function() {
		var team_name = $("select option:selected").text();
		tp_team_name = team_name;
		//팀 이름 클릭 시 후원 금액과 받은 후원 리스트 불러오기
		$.ajax({
			type: "GET",
			cache: false,
			url: '/service/thanks_people/thanks_people_list.jsp',
			data: {
				team_name : team_name,
				user_no : user_no
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				var DATA2 = $(ROOT).find('DATA2');
				
				$(DATA).each(function(i) {
					var TEAM_NO = $(this).find('TEAM_NO').text();
					var TEAM_NAME = $(this).find('TEAM_NAME').text();
					var TEAM_MONEY = $(this).find('TEAM_MONEY').text();
					var LEADER_CHK = $(this).find('LEADER_CHK').text();
					
					var total_sp_price = addComma(TEAM_MONEY);
					
					tp_leader_chk = LEADER_CHK;
					tp_team_no = TEAM_NO;
					
					$('#as_account_team_name').html(TEAM_NAME);
					$('#as_account_price_text').html(total_sp_price);
					
					$('#as_account_list').empty();
					
					if(DATA2.length == 0){
						$('#as_account_list').append('<div class="noViewBtn">해당 팀이 받은 후원 내역이 없습니다.</div>');
						return;
					}
					
					$(DATA2).each(function() {
						var SUPPORT_PRICE = $(this).find('SUPPORT_PRICE').text();
						var SUPPORT_DATE = $(this).find('SUPPORT_DATE').text();
						var SUPPORT_MSG = $(this).find('SUPPORT_MSG').text();
						var NICKNAME = $(this).find('NICKNAME').text();
						
						var sp_price = addComma(SUPPORT_PRICE);
						
						var as_account_list = '<div class="thanks_people_line2"></div>'+
												'<div class="ui-grid-a as_support_people">'+
												'<div class="ui-block-a" style="width:100%;">'+
													'<div class="ui-grid-a">'+
														'<div class="ui-block-a" style="text-align: left;">'+
															'<div id="as_support_price">&#43; '+sp_price+'</div>'+
															'<div id="as_support_won">원</div>'+
														'</div>'+
														'<div class="ui-block-b" id="as_support_date">'+
															SUPPORT_DATE+
														'</div>'+
													'</div>'+
												'</div>'+
												'<div class="ui-block-b" style="text-align: left; width:100%;">'+
													'<div id="as_support_name">'+NICKNAME+'</div>'+
													'<div id="as_support_msg">'+SUPPORT_MSG+'</div>'+
												'</div>'+
											'</div>';
						
						$('#as_account_list').append(as_account_list);
					});
					
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			});
			},//end success
			error: function (xhr, message, errorThrown) {
				//hideLoading();
				alert(xhr);
				alert(message);
				alert(errorThrown);
			} // end error
			
		});	
	});
	
});

//지급신청 클릭시
$(document).on('click', '#Go_PayApply', function() {
	if(tp_team_no == ''){
		alert('팀 이름을 선택해주세요.');
		return;
	}
	else if(tp_leader_chk != 1){
		alert('리더만 신청가능합니다.');
		return;
	}
	$('#pay_apply_btn').show();
	$('#thanks_people_menu').empty();
	var thanks_people_menu = '<div class="ui-block-a">'+
								'<div class="haeder_menu_div_base" id="Go_AllSupport">'+
									'<span>후원전체</span>'+
								'</div>'+
							'</div>'+
							'<div class="ui-block-b">'+
								'<div class="haeder_menu_div_on" id="Go_PayApply">'+
									'<span>지급신청</span>'+
								'</div>'+
							'</div>'+
							'<div class="ui-block-c">'+
								'<div class="haeder_menu_div_base" id="Go_WithdrawList">'+
									'<span>지급내역</span>'+
								'</div>'+
							'</div>';	
	$('#thanks_people_menu').append(thanks_people_menu);
	
	$('#thanks_people_body').empty();
	var thanks_people_body ='<div class="thanks_people_line"></div>'+ 
							'<div id="pay_account_body">'+
								'<div class="ui-grid-a">'+
									'<div class="ui-block-a" id="pay_account_content">'+
										'<div class="ui-grid-a">'+
											'<div class="ui-block-a" id="pay_account_title">지급 전용 계좌</div>'+
											'<div class="ui-block-b" id="pay_account_subject"></div>'+
										'</div>'+
									'</div>'+
									'<div class="ui-block-b" id="pay_account_btn" onclick="go_account_change();"><a id="pay_account_btn_text"></a></div>'+
								'</div>'+
							'</div>'+
							'<div id="pay_apply_body">'+
								'<div id="pay_apply_body_title">출금하실 금액</div>'+
								'<div class="ui-grid-a" id="pay_apply_body_content">'+
									'<div class="ui-block-a">'+
										'<input type="text" id="pay_apply_body_text" name="pay_apply_body_text" placeholder="10,000원 이상 입력시 총 출금 금액이 계산됩니다.">'+
									'</div>'+
									'<div class="ui-block-b">원</div>'+
								'</div>'+
								'<div id="pay_apply_body_footer">출금 가능한 금액: 0원</div>'+
								'<div class="ui-grid-a" id="pay_apply_footer">'+
									'<div class="ui-block-a" id="pay_apply_footer_title">총 출금 금액</div>'+
									'<div class="ui-block-b" id="pay_apply_footer_content">'+
											'<div id="pay_apply_footer_content_a">(수수료제외)</div>'+
											'<div id="pay_apply_footer_content_b">0</div>'+
											'<div id="pay_apply_footer_content_c">원</div>'+
									'</div>'+
								'</div>'+
							'</div>'+
							'<div id="pay_precautions_body">'+
								'<div class="ui-grid-a ppb_main_title">'+
									'<div class="ui-block-a">&#33;</div>'+
									'<div class="ui-block-b">후원금액 출금시 주의사항</div>'+
								'</div>'+
								'<div class="ppb_big_content">1. 출금 신청은 팀의 리더만 신청 가능합니다.</div>'+
								'<div class="ppb_big_content">2. 후원금액 출금요청 시 카드사 정산일(최대10일) 포함 최대 2주이내 요청하신 계좌로 지급처리 됩니다.</div>'+
								'<div class="ppb_big_content">3. 신청자 과실에 의한 타 계좌 입금은 당사에서 책임지지 않사오니 계좌번호 기재 시 꼭 확인 부탁드립니다.</div>'+
								'<div class="ppb_big_content">&#8251; 출금 수수료 안내</div>'+
								'<div class="ppb_small_content">1. PG(결제대행) 수수료(2.9%, 부가세별도) 및 해피버스킹 중개수수료(7%, 부가세별도)를 제외한 금액이 입금됩니다.</div>'+
								'<div class="ppb_small_content">2. 지급 전용 계좌가 우리은행 이외의 은행인 경우 이체수수료 500원이 추가 발생됩니다.</div>'+
							'</div>';
	
	$('#thanks_people_body').append(thanks_people_body);
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/team/team_info.jsp',
		data: {
			team_no : tp_team_no,
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#pay_account_subject').empty();
			$('#pay_apply_body_footer').empty();
			
			$(DATA).each(function(i) {
				var TEAM_MONEY = $(this).find('TEAM_MONEY').text();
				var TEAM_ACC_HOLDER = $(this).find('TEAM_ACC_HOLDER').text();
				var TEAM_BANK= $(this).find('TEAM_BANK').text();
				var TEAM_ACCOUNT = $(this).find('TEAM_ACCOUNT').text();
				
				tp_money_temp = TEAM_MONEY;
				
				var wd_price = TEAM_MONEY.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
				
				var wd_price = '출금 가능한 금액: '+wd_price+'원';
				
				$('#pay_apply_body_footer').append(wd_price);
				
				if(TEAM_ACCOUNT == 0){
					var account_info = '계좌 정보를 등록해주세요.';
					$('#pay_account_btn_text').html('등록');
				}
				else{
					var account_info = TEAM_BANK + ' ' + TEAM_ACCOUNT + ' ' + TEAM_ACC_HOLDER;
					$('#pay_account_btn_text').html('변경');
				}
				
				$('#pay_account_subject').append(account_info);
			});
		}
	});
	
});

//지급내역 클릭시
$(document).on('click', '#Go_WithdrawList', function() {
	if(tp_team_no == ''){
		alert('팀 이름을 선택해주세요.');
		return;
	}
	
	$('#pay_apply_btn').hide();
	$('#thanks_people_menu').empty();
	var thanks_people_menu = '<div class="ui-block-a">'+
								'<div class="haeder_menu_div_base" id="Go_AllSupport">'+
									'<span>후원전체</span>'+
								'</div>'+
							'</div>'+
							'<div class="ui-block-b">'+
								'<div class="haeder_menu_div_base" id="Go_PayApply">'+
									'<span>지급신청</span>'+
								'</div>'+
							'</div>'+
							'<div class="ui-block-c">'+
								'<div class="haeder_menu_div_on" id="Go_WithdrawList">'+
									'<span>지급내역</span>'+
								'</div>'+
							'</div>';	
	$('#thanks_people_menu').append(thanks_people_menu);
	
	$('#thanks_people_body').empty();
	
	var thanks_people_body ='<div class="ui-grid-b" id="wd_account_middle">' + 
									'<div class="ui-block-a" id="wd_account_middle_title">' + 
										'<p>지급목록</p>' + 
									'</div>' +
									'<div class="ui-block-b" id="wd_account_middle_sort">' +
										'<span>최신순</span>' +
									'</div>' +
								'</div>'+
								'<div id="wd_account_list">'+
								'</div>'+
								'<div id="wd_team_refresh_btn">'+
									'<img src="/img/board/refresh.svg">'+
								'</div>';

	$('#thanks_people_body').append(thanks_people_body);
	
	$('#wd_account_list').empty();
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/thanks_people/withdraw_list.jsp',
		data: {
			team_no : tp_team_no,
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$('#wd_account_list').empty();
				$('#wd_account_list').append('<div class="noViewBtn">해당 팀이 신청한 지급내역이 없습니다.</div>');
				return;
			}
			
			$(DATA).each(function(i) {
				var WITHDRAW_NO = $(this).find('WITHDRAW_NO').text();
				var WITHDRAW_PRICE = addComma($(this).find('WITHDRAW_PRICE').text());
				var WITHDRAW_DATE= $(this).find('WITHDRAW_DATE').text();
				var WITHDRAW_BANK = $(this).find('WITHDRAW_BANK').text();
				var WITHDRAW_ACCOUNT = $(this).find('WITHDRAW_ACCOUNT').text();
				var PAYMENTS_DATE = $(this).find('PAYMENTS_DATE').text();
				var PAYMENTS_OK = $(this).find('PAYMENTS_OK').text();
				var PAYMENTS_REFUSE_REASON = changeLineBreak($(this).find('PAYMENTS_REFUSE_REASON').text());
				var WITHDRAW_REAL_PRICE = addComma($(this).find('WITHDRAW_REAL_PRICE').text());
				
				
				var wp_account = WITHDRAW_BANK + ' ' + WITHDRAW_ACCOUNT;

				if(PAYMENTS_OK == '2'){
					var wd_account_list = '<div class="ui-grid-a wd_account_list_content" id="'+WITHDRAW_NO+'">'+
											'<div class="ui-block-a" style="text-align: left;">'+
												'<div id="wd_account_price">&#45;'+WITHDRAW_PRICE+'</div>'+
												'<div id="wd_account_won">원</div>'+
											'</div>'+
											'<div class="ui-block-b" style="text-align: right;">'+
												'<div id="wd_account_date">'+WITHDRAW_DATE+'</div>'+
												'<div class="wd_account_ok" id="wd_account_status">지급완료</div>'+
											'</div>'+
										'</div>'+
										'<div class="wd_account_list_detail" id="wd_account_list_detail_'+WITHDRAW_NO+'">'+
											'<div id="wd_al_detail_header">상세내역</div>'+
											'<div class="ui-grid-b" id="wd_al_detail_body">'+
												'<div class="ui-block-a" style="width: 100%;">'+
													'<div class="ui-grid-a">'+
														'<div class="ui-block-a" id="wd_al_detail_title">지급일시</div>'+
														'<div class="ui-block-b" id="wd_al_detail_content">'+PAYMENTS_DATE+'</div>'+
													'</div>'+
												'</div>'+
												'<div class="ui-block-c" style="width: 100%;">'+
													'<div class="ui-grid-a">'+
														'<div class="ui-block-a" id="wd_al_detail_title">지급계좌</div>'+
														'<div class="ui-block-b" id="wd_al_detail_content">'+wp_account+'</div>'+
													'</div>'+
												'</div>'+
											'</div>'+
											'<div class="ui-grid-a" style="border-top: 1px solid #000; padding-top: 20px;">'+
												'<div class="ui-block-a" id="wd_al_detail_footer">총 지급 금액</div>'+
												'<div class="ui-block-b" style="text-align : right;">'+
													'<div style="display: inline-block; font-size: 13px;">(수수료제외) </div>'+
													'<div id="wd_al_detail_total">'+WITHDRAW_REAL_PRICE+'</div>'+
													'<div style="display: inline-block; font-size: 18px;">원</div>'+
											'</div>'+
											'</div>'+
										'</div>';
				} else if(PAYMENTS_OK == '3'){
					var wd_account_list = '<div class="ui-grid-a wd_account_list_content" id="'+WITHDRAW_NO+'">'+
											'<div class="ui-block-a" style="text-align: left;">'+
												'<div id="wd_account_price" style="color:#ff2626;" >&#43;'+WITHDRAW_PRICE+'</div>'+
												'<div id="wd_account_won">원</div>'+
											'</div>'+
											'<div class="ui-block-b" style="text-align: right;">'+
												'<div id="wd_account_date">'+WITHDRAW_DATE+'</div>'+
												'<div class="wd_account_refuse" id="wd_account_status">지급거절</div>'+
											'</div>'+
										'</div>'+
										'<div class="wd_account_list_detail" id="wd_account_list_detail_'+WITHDRAW_NO+'">'+
											'<div id="wd_al_detail_header">상세내역</div>'+
											'<div class="ui-grid-b" id="wd_al_detail_body">'+
												'<div class="ui-block-a" style="width: 100%;">'+
													'<div class="ui-grid-a">'+
														'<div class="ui-block-a" id="wd_al_detail_title">거절일시</div>'+
														'<div class="ui-block-b" id="wd_al_detail_content">'+PAYMENTS_DATE+'</div>'+
													'</div>'+
												'</div>'+
												'<div class="ui-block-c" style="width: 100%;">'+
													'<div class="ui-grid-a">'+
														'<div class="ui-block-a" id="wd_al_detail_title">거절사유</div>'+
														'<div class="ui-block-b" id="wd_al_detail_content">'+PAYMENTS_REFUSE_REASON+'</div>'+
													'</div>'+
												'</div>'+
											'</div>'+
											'<div class="ui-grid-a" style="border-top: 1px solid #000; padding-top: 20px;">'+
												'<div class="ui-block-a" id="wd_al_detail_footer">취소된 금액</div>'+
												'<div class="ui-block-b" style="text-align : right;">'+
													'<div style="display: inline-block; font-size: 13px;">(수수료포함) </div>'+
													'<div id="wd_al_detail_total" style="color:#ff2626;">'+WITHDRAW_PRICE+'</div>'+
													'<div style="display: inline-block; font-size: 18px;">원</div>'+
											'</div>'+
											'</div>'+
										'</div>';
				} else {
					var wd_account_list = '<div class="ui-grid-a wd_account_list_content" id="'+WITHDRAW_NO+'">'+
											'<div class="ui-block-a" style="text-align: left;">'+
												'<div id="wd_account_price">&#45;'+WITHDRAW_PRICE+'</div>'+
												'<div id="wd_account_won">원</div>'+
											'</div>'+
											'<div class="ui-block-b" style="text-align: right;">'+
												'<div id="wd_account_date">'+WITHDRAW_DATE+'</div>'+
												'<div class="wd_account_no" id="wd_account_status">진행중</div>'+
											'</div>'+
										'</div>';
				}

				$('#wd_account_list').append(wd_account_list);
			});
		}
	});
	
});

//지급신청 버튼 눌렀을 때
$(document).on('click', '#pay_apply_btn', function() {
	var pay_apply = $('#pay_apply_body_text').val();
	pay_apply = removeComma(pay_apply);
	pay_apply = parseInt(pay_apply);
	tp_money_temp = parseInt(tp_money_temp);
	
	var accountchk = $('#pay_account_subject').text();
	
	if(accountchk =='계좌 정보를 등록해주세요.'){
		alert('계좌 정보를 등록해주세요.');
		return;
	}

	if($('#pay_apply_body_text').val() == ''){
		alert('출금하실 금액을 입력해주세요.');
		return;
	}
	else if(pay_apply < 10000){
		alert('10,000원 이상 출금 가능합니다.');
		return;
	}
	else if(pay_apply > tp_money_temp){
		alert('출금하실 금액이 출금 가능한 금액보다 많습니다.');
		return;
	}
	else{
		var confText = '*후원금액 출금시 주의사항\n'+
						'1. 출금 신청은 팀의 리더만 신청 가능합니다.\n'+
						'2. 후원금액 출금요청 시 카드사 정산일(최대10일) 포함 최대 2주이내 요청하신 계좌로 지급처리 됩니다.\n'+
						'3. 신청자 과실에 의한 타 계좌 입금은 당사에서 책임지지 않사오니 계좌번호 기재 시 꼭 확인 부탁드립니다.\n\n'+
						'* 출금 수수료 안내\n'+
						  '1. PG(결제대행) 수수료(2.9%, 부가세별도) 및 해피버스킹 중개수수료(7%, 부가세별도)를 제외한 금액이 입금됩니다.\n'+
						  '2. 우리은행 이외의 은행에는 위 수수료와 별개로 이체수수료 500원이 추가 발생될 수 있습니다.\n'+
						 '위 내용에 동의하시겠습니까?';
		
		var conf = confirm(confText);
		
		if(!conf){
			return;
		}
		
		var total_account = $('#pay_account_subject').text();
		
		var withdraw_price = String(pay_apply);
		var team_no = tp_team_no;
		var withdraw_bank = total_account.split(' ')[0];
		var withdraw_account = total_account.split(' ')[1];
		
		var withdraw_real_price = removeComma($('#pay_apply_footer_content_b').text());
		
		$.ajax({
			type: "POST",
			url: '/service/thanks_people/pay_apply.jsp',
			data:{
				team_no: team_no,
				withdraw_price: withdraw_price,
				withdraw_real_price: withdraw_real_price,
				withdraw_bank: withdraw_bank,
				withdraw_account: withdraw_account
			}
		});
		
		alert('지금신청 되었습니다.');
		$('#Go_WithdrawList').click();
	}
});

$(document).on('keyup', '#pay_apply_body_text', function(){
	var str = $(this).val();
	
	str = removeComma(str);
	str = addComma(str);
	$(this).val(str);
	
	var strN = parseInt(removeComma($(this).val()));
	
	if(strN < 10000){
		$('#pay_apply_footer_content_b').text('0');
		return;
	}
	
	var firstCalc = strN - ((strN * 0.029) + (strN * 0.029 * 0.1));
	var total = firstCalc - ((firstCalc * 0.07) + (firstCalc * 0.07 * 0.1));
	
	var withdraw_bank = $('#pay_account_subject').text().split(' ')[0];
	
	total = String(parseInt(total)).slice(0, -1);
	total = total + '0';
	
	if(withdraw_bank != '우리' && withdraw_bank != '우리은행'){
		if(parseInt(total) > 500){
			total = parseInt(removeComma(total)) - 500;
		}
	}
	
	if(total == 0){
		total = '0';
	} else {
		total = removeComma(total);
		total = addComma(total);
	}
	
	$('#pay_apply_footer_content_b').text(total);
});

//지급 상세내역 보이기/숨기기
$(document).on('click', '.wd_account_list_content', function() {
	var id = $(this).attr('id');
	var display = $('#wd_account_list_detail_'+id).css('display');
	if(display == 'none'){
		$('#wd_account_list_detail_'+id).css('display', 'block');
	}
	else if(display == 'block'){
		$('#wd_account_list_detail_'+id).css('display', 'none');
	}
});

//새로고침 버튼들
$(document).on('click', '#as_team_refresh_btn', function() {
	$('#Go_AllSupport').click();
});

$(document).on('click', '#wd_team_refresh_btn', function() {
	$('#Go_WithdrawList').click();
});