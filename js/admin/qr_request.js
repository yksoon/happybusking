//여기에는 updateQRRequestState 함수 불러오는 기능 구현
$(document).on('change', '.qr_request_state', function(){
	var qr_request_no = $(this).parents('tr').attr('id');
	var qr_request_state = $(this).val();
	
	updateQRRequestState(qr_request_no, qr_request_state);
});


///////////////////////////////////////////////

function getQRRequestList(){
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/qr_request.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			$(DATA).each(function(i) {
				var QR_REQUEST_NO = $(this).find('QR_REQUEST_NO').text();
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var POSTCODE = $(this).find('POSTCODE').text();
				var ADDR = $(this).find('ADDR').text();
				var DETAIL_ADDR = $(this).find('DETAIL_ADDR').text();
				var QR_REQUEST_COUNT = $(this).find('QR_REQUEST_COUNT').text();
				var QR_REQUEST_DATE = $(this).find('QR_REQUEST_DATE').text();
				var QR_VIDEO_SHARE = $(this).find('QR_VIDEO_SHARE').text();
				var QR_REQUEST_STATE = $(this).find('QR_REQUEST_STATE').text();
				var PHONE = $(this).find('PHONE').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				var QRTYPE = $(this).find('QRTYPE').text();

				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				
				var ADDRTOTAL = '(' + POSTCODE + ')' + ADDR + ', ' + DETAIL_ADDR;
				if(QR_REQUEST_STATE == 'W'){
					var QR_REQUEST_SELECT = '<td><select class="qr_request_state">' +
												'<option class="qr_request_option" value="W" selected="selected">접수대기</option>'+
												'<option class="qr_request_option" value="I">진행중</option>'+
												'<option class="qr_request_option" value="S">발송완료</option>'+
												'<option class="qr_request_option" value="F">거절</option>'+
												'</select></td>';	
				} else if(QR_REQUEST_STATE == 'I'){
					var QR_REQUEST_SELECT = '<td><select class="qr_request_state">' +
												'<option class="qr_request_option" value="W">접수대기</option>'+
												'<option class="qr_request_option" value="I" selected="selected">진행중</option>'+
												'<option class="qr_request_option" value="S">발송완료</option>'+
												'<option class="qr_request_option" value="F">거절</option>'+
												'</select></td>';	
				} else if(QR_REQUEST_STATE == 'S'){
					var QR_REQUEST_SELECT = '<td><select class="qr_request_state">' +
												'<option class="qr_request_option" value="W">접수대기</option>'+
												'<option class="qr_request_option" value="I">진행중</option>'+
												'<option class="qr_request_option" value="S" selected="selected">발송완료</option>'+
												'<option class="qr_request_option" value="F">거절</option>'+
												'</select></td>';	
					
				} else if(QR_REQUEST_STATE == 'F'){
					var QR_REQUEST_SELECT = '<td><select class="qr_request_state">' +
												'<option class="qr_request_option" value="W">접수대기</option>'+
												'<option class="qr_request_option" value="I">진행중</option>'+
												'<option class="qr_request_option" value="S">발송완료</option>'+
												'<option class="qr_request_option" value="F" selected="selected">거절</option>'+
												'</select></td>';	
				}
				
				console.log(QRTYPE);
				
				switch(QRTYPE){
					case 'A' : QRTYPE = '400X1200(mm) - 거치대포함';
					case 'B' : QRTYPE = '500x1600(mm) - 배너만 제공(거치대별도구매)';
					case 'C' : QRTYPE = '600x1800(mm) - 배너만 제공(거치대별도구매)';
				}
				console.log(QRTYPE);
				
				if(i===0 || i%2===0){
					var qr_trtd = '<tr class="bg_whiteblue" id="'+QR_REQUEST_NO+'"><td>'+TEAM_NO+'</td><td class="qrct_name">'
					+ TEAM_NAME +'</td><td>'
					+ NICKNAME + '</td><td>'
					+ PHONE + '</td><td>'
					+ ADDRTOTAL+'</td><td>'
					+QRTYPE+'</td><td>'
					+QR_REQUEST_DATE+'</td><td>'
					+QR_VIDEO_SHARE+'</td>'+ QR_REQUEST_SELECT +'</tr>' ;
				} else {
					var qr_trtd = '<tr id="'+QR_REQUEST_NO+'"><td>'+TEAM_NO+'</td><td class="qrct_name">'
					+ TEAM_NAME +'</td><td>'
					+ NICKNAME + '</td><td>'
					+ PHONE + '</td><td>'
					+ ADDRTOTAL+'</td><td>'
					+QRTYPE+'</td><td>'
					+QR_REQUEST_DATE+'</td><td>'
					+QR_VIDEO_SHARE+'</td>'+ QR_REQUEST_SELECT +'</tr>' ;
				}
				
				
				
				
				$('.qrc_table').append(qr_trtd)	
				
			});
		},
		error: function(xhr){
			console.log(xhr);
		}
	});
	
	$('#admin_page_container').load('/app_admin/qr_request.jsp #qr_request_container');
}

//select box change 된 경우 해당 DB에 업데이트 해주는 기능 함수로 구현
function updateQRRequestState(qr_request_no, qr_request_state){
	//여기다 업데이트 기능 구현
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/qr_request_update.jsp',
		data:{
			qr_request_state: qr_request_state,
			qr_request_no: qr_request_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete: function(){
			getNewWrite();
		}
	});
}






