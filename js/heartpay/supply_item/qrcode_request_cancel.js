//신청 취소 페이지로 이동
function BtnQrDelete(qrPaymentTID){
	sessionStorage.setItem('qrTID', qrPaymentTID);
	loadPage('supply_item/qr_request_cancel.jsp');
}

$(document).on('pageinit', '#qrcode_request_cancel_page', function(){
	var tid = sessionStorage.getItem('qrTID');
	
	$.ajax({
		type: "GET",
		url: '/service/kiwoompay/get_kiwoompay_info.jsp',
		async : false,
		data:{
			tid: tid
		},
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var CPID = $(this).find('CPID').text();
				var DAOUTRX = $(this).find('DAOUTRX').text();
				var AMOUNT = $(this).find('AMOUNT').text();
				var PAYMETHOD = $(this).find('PAYMETHOD').text();
				
				$('#CPID').val(CPID);
				$('#DAOUTRX').val(DAOUTRX);
				$('#AMOUNT').val(AMOUNT);
				$('#PAYMETHOD').val(PAYMETHOD);
			});
		}
	});
});

$(document).on('click', '#qrc_success_btn', function(){
	$('#btnSubmit').click();
});