//qr코드 신청 내역
$(document).on('pageinit', '#qrcode_request_list', function(){
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/supply_item/qrcode_request_list.jsp";
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
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				$("#QrList_part").empty();
				$("#QrList_part").html('<div id="main_cont" class="noViewBtn">내용이 없습니다</div>');
				return;
			}
			
			$("#QrList_part").empty();
			
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var QR_REQUEST_NO = $(this).find("QR_REQUEST_NO").text();
				var QR_REQUEST_COUNT = $(this).find("QR_REQUEST_COUNT").text();
				var QR_REQUEST_DATE = $(this).find("QR_REQUEST_DATE").text();
				var QR_REQUEST_STATE = $(this).find("QR_REQUEST_STATE").text();
				var QR_PAYMENT_TID = $(this).find('QR_PAYMENT_TID').text();
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var TINTRO_IMG = $(this).find("TINTRO_IMG").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();

				
				//이미지 경로
				var img_src = "/upload/team/team" + TEAM_NO + "/" + TINTRO_IMG;				
				
				var stateContent = "";
				var cancelContent = "";
				
				if(QR_REQUEST_STATE == "W"){
					stateContent = '<p class="isWating">접수대기</p>';
					cancelContent = '<span class="srqCancel" onclick="BtnQrDelete(\''+ QR_PAYMENT_TID + '\');">신청취소</span>';
				}else if(QR_REQUEST_STATE == "I"){
					stateContent = '<p class="isIng">진행중</p>';
					cancelContent = '<span>취소불가</span>';
				}else if(QR_REQUEST_STATE == "S"){
					stateContent = '<p class="isFinish">발송완료</p>';
					cancelContent = '<span>취소불가</span>';
				}else if(QR_REQUEST_STATE == "F"){
					stateContent = '<p class="isRefuse">거절</p>';
					cancelContent = '<span>취소불가</span>';
				}else if(QR_REQUEST_STATE == "C"){
					cancelContent = '<span>취소됨</span>';
				}
				
				cancelContent = '<span>취소불가</span>';
				
				var html = 	'<p class="ShowIsTeam">' + TEAM_NAME + '<span class="ShowIsDate">' +  QR_REQUEST_DATE + '</span></p>' +
							'<div class="ui-grid-a itemStateContent">' +
								'<div class="ui-block-a">' +
									'<img src="' + img_src + '">' +
								'</div>' +
								'<div class="ui-block-b">' +
									'<p class="item-list-middle1">공연용 QR-Code</p>' +
									'<p class="item-list-middle2">수량 : ' +  QR_REQUEST_COUNT + '개</p>' +	
									'<p class="item-list-middle3">'+ cancelContent +'</p>' +				
								'</div>' +
								'<div class="ui-block-c">' +
									stateContent +
								'</div>' +									
							'</div>';
				
				
			
				
				$("#QrList_part").append(html);
				
				
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });	
			
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});	
});
