function getWithdrawList(){
	$('#admin_page_container').empty();
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/withdraw_list.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var WITHDRAW_NO = $(this).find('WITHDRAW_NO').text();
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var WITHDRAW_PRICE = $(this).find('WITHDRAW_PRICE').text();
				var WITHDRAW_REAL_PRICE = $(this).find('WITHDRAW_REAL_PRICE').text();
				var WITHDRAW_DATE = $(this).find('WITHDRAW_DATE').text();
				var WITHDRAW_BANK = $(this).find('WITHDRAW_BANK').text();
				var WITHDRAW_ACCOUNT = $(this).find('WITHDRAW_ACCOUNT').text();
				var PAYMENTS_OK = $(this).find('PAYMENTS_OK').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var TEAM_ACC_HOLDER = $(this).find('TEAM_ACC_HOLDER').text();
				
				if(PAYMENTS_OK == '1'){
					PAYMENTS_OK = '진행중';
				} else if(PAYMENTS_OK == '2'){
					PAYMENTS_OK = '지급완료';
				} else {
					PAYMENTS_OK = '지급거절';
				}
				
				var html = '<tr id="'+WITHDRAW_NO+'_'+TEAM_NO+'">' + 
								'<td>' + TEAM_NAME + '</td>'+
								'<td>' + addComma(WITHDRAW_PRICE) + '</td>'+
								'<td>' + addComma(WITHDRAW_REAL_PRICE) + '</td>'+
								'<td>' + TEAM_ACC_HOLDER + '</td>'+
								'<td>' + WITHDRAW_BANK + '</td>'+
								'<td>' + WITHDRAW_ACCOUNT + '</td>'+
								'<td>' + WITHDRAW_DATE + '</td>'+
								'<td class="wpc_detail">' + PAYMENTS_OK + '</td>'+
							'</tr>';
				
				$('.wpc_table').append(html);
			});
		}, 
		error: function(xhr){
			console.log(xhr);
		}
	});
	
	$('#admin_page_container').load('/app_admin/withdraw.jsp #withdraw_page_container');
}

$(document).on('click', '.wpc_detail', function(){
	var str = $(this).parents('tr').attr('id');
	var url = 'withdraw_popup.jsp';
	
	var windowObj = window.open(url, 'withdraw_popup', 'width=500, height=500');
	
	setTimeout(function(){
		windowObj.document.getElementById('wdno_tno').value = str;
	}, 200);
});