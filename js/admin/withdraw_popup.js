$(function(){
	setTimeout(function(){
		var str = $('#wdno_tno').val();
		
		var wdno = str.split('_')[0];
		
		$.ajax({
			type: "GET",
			cache: false,
			url: '/service/admin/withdraw_detail.jsp',
			data: {
				wdno: wdno
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				$(DATA).each(function(){
					var WITHDRAW_PRICE = $(this).find('WITHDRAW_PRICE').text();
					var PAYMENTS_OK = $(this).find('PAYMENTS_OK').text();
					var PAYMENTS_REFUSE_REASON = $(this).find('PAYMENTS_REFUSE_REASON').text();
					
					$('#wdOK').val(PAYMENTS_OK);
					$('#wdRefuseReason').val(PAYMENTS_REFUSE_REASON);
					$('#wdPrice').val(WITHDRAW_PRICE);
				});
			},
			error: function(xhr){
				console.log(xhr);
			}
		});
		
	}, 500);
});

$(document).on('click', '#wdBtn', function(){
	var str = $('#wdno_tno').val();
	
	var wdno = str.split('_')[0];
	var tno = str.split('_')[1];
	
	var wdPrice = $('#wdPrice').val();
	
	var wdOK = $('#wdOK').val();
	var wdRefuseReason = $('#wdRefuseReason').val();
	
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/admin/withdraw_update.jsp',
		data: {
			wdno: wdno,
			tno: tno,
			wdOK: wdOK,
			wdRefuseReason: wdRefuseReason,
			wdPrice: wdPrice
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete : function(){
			self.close();
		}
	});
});