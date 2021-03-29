$(document).on('pageinit', '#support_list_page', function(){
	var date = new Date();
	var nowYear = date.getFullYear();
	var startYear = parseInt(nowYear) - 1;
	
	var nowMonth = String(date.getMonth() + 1);
	
	var date_list = '';
	
	for(var i = startYear; i <= nowYear; i++){
		for(var j = 1; j <= 12; j++){
			j = setPad(j, 2);
			
			if( i == nowYear && j == setPad(nowMonth, 2)){
				date_list = '<option value="'+i+'-'+j+'" selected="selected">'+i+'년 '+j+'월</option>';
				$('#spt_lt_search_date-button').find('span').text(i+'년 '+j+'월');
			} else {
				date_list = '<option value="'+i+'-'+j+'">'+i+'년 '+j+'월</option>';
			}
			
			$('#spt_lt_search_date').append(date_list);
		}
	}
	
	get_support_list("1", "1");
});

$(document).on('click', '.spt_lt_search_btn', function(){
	$('.spt_lt_search_btn').removeClass('spt_lt_search_select');
	$(this).addClass('spt_lt_search_select');
	
	var sort = $('#spt_lm_sort').text();
	if(sort == '최신순'){
		sort = '1';
	} else {
		sort = '2';
	}
	
	var search_date = $(this).attr('id');
	
	if(search_date == 'spt_lt_search_onemonth'){
		search_date = '1';
	} else if(search_date == 'spt_lt_search_threemonth'){
		search_date = '3';
	} else {
		search_date = $('#spt_lt_search_date').val();
	}
	
	get_support_list(search_date, sort);
});

$(document).on('change', '#spt_lt_search_date', function(){
	var sort = $('#spt_lm_sort').text();
	if(sort == '최신순'){
		sort = '1';
	} else {
		sort = '2';
	}
	
	var search_date = $(this).val();
	
	get_support_list(search_date, sort);
});

$(document).on('click', '#spt_lm_sort', function(){
	var search_date = $('.spt_lt_search_select').attr('id');
	if(search_date == 'spt_lt_search_onemonth'){
		search_date = '1';
	} else if(search_date == 'spt_lt_search_threemonth'){
		search_date = '3';
	} else {
		search_date = $('#spt_lt_search_date').val();
	}
	
	var sort = $(this).text();
	if(sort == '최신순'){
		sort = '2';
		$(this).text('오래된순');
	} else {
		sort = '1';
		$(this).text('최신순');
	}
	
	get_support_list(search_date, sort);
});

$(document).on('click', '.spt_lb_content', function(){
	var sptno = $(this).attr('id');
	
	$.ajax({
		type: "GET",
		url: '/service/support/get_support_detail.jsp',
		data:{
			sptno: sptno
		},
		async : false,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var SUPPORT_PRICE = $(this).find('SUPPORT_PRICE').text();
				var SUPPORT_NAME = $(this).find('SUPPORT_NAME').text();
				var SUPPORT_TEL = $(this).find('SUPPORT_TEL').text();
				var SUPPORT_DATE = $(this).find('SUPPORT_DATE').text();
				var SUPPORT_PAYMETHOD = $(this).find('SUPPORT_PAYMETHOD').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				
				SUPPORT_PRICE = addComma(SUPPORT_PRICE);
				
				if(SUPPORT_PAYMETHOD == 'CARD'){
					SUPPORT_PAYMETHOD = '신용카드';
				} else if(SUPPORT_PAYMETHOD == 'MOBILE'){
					SUPPORT_PAYMETHOD = '핸드폰';
				} else if(SUPPORT_PAYMETHOD == 'BANK'){
					SUPPORT_PAYMETHOD = '계좌이체';
				} else if(SUPPORT_PAYMETHOD == 'VAACOUNT'){
					SUPPORT_PAYMETHOD = '가상계좌';
				} else if(SUPPORT_PAYMETHOD == 'CULTURE'){
					SUPPORT_PAYMETHOD = '문화상품권';
				} else if(SUPPORT_PAYMETHOD == 'HAPPY'){
					SUPPORT_PAYMETHOD = '해피머니상품권';
				} else if(SUPPORT_PAYMETHOD == 'BOOK'){
					SUPPORT_PAYMETHOD = '도서문화상품권';
				} else if(SUPPORT_PAYMETHOD == 'TMONEY'){
					SUPPORT_PAYMETHOD = '티머니';
				} else {
					SUPPORT_PAYMETHOD = '예외수단';
				}
				
				$('#spt_lp_tname').html(TEAM_NAME);
				$('#spt_lp_date').html(SUPPORT_DATE);
				$('#spt_lp_paymethod').html(SUPPORT_PAYMETHOD);
				$('#spt_lp_sname').html(SUPPORT_NAME);
				$('#spt_lp_tel').html(SUPPORT_TEL);
				$('#spt_lp_price').html(SUPPORT_PRICE);
				
			}).promise().done(function (){
				$("#support_list_popup").popup( "option" , "dismissible" , true);
				$("#support_list_popup" ).popup( "option", "overlayTheme", "b" );
				$("#support_list_popup" ).popup( "option", "positionTo", "window" );
				$("#support_list_popup" ).popup("open");
			});
		}
	});
});

$(document).on('click', '#spt_lp_btn', function(){
	$("#support_list_popup" ).popup("close");
});