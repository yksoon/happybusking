$(document).on('pageinit', '#supply_item_state', function(){
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/supply_item/supply_item_state.jsp";
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
				$("#IsList_part").empty();
				$("#IsList_part").html('<div id="main_cont" class="noViewBtn" >내용이 없습니다.</div>');
				return;
			}
			
			$("#IsList_part").empty();
			
			var grpNo = "";
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var ITEM_REQUEST_NO = $(this).find("ITEM_REQUEST_NO").text();
				var ITEM_REQUEST_GRP_NO = $(this).find("ITEM_REQUEST_GRP_NO").text();
				var ITEM_NO = $(this).find("ITEM_NO").text();
				var ITEM_REQUEST_COUNT = $(this).find("ITEM_REQUEST_COUNT").text();
				var ITEM_REQUEST_DATE = $(this).find("ITEM_REQUEST_DATE").text();
				var ITEM_REQUEST_STATE = $(this).find("ITEM_REQUEST_STATE").text();
				var ITEM_IMG = $(this).find("ITEM_IMG").text();
				var ITEM_NAME = $(this).find("ITEM_NAME").text();	
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				
				
				//시간에서 초 빼기
				//var IR_DATE = ITEM_REQUEST_DATE.substring(0, 11);
				
				//특정 날짜에서 요일 구하기
	/*			var week = ['일', '월', '화', '수', '목', '금', '토'];
				var dayOfWeek = week[new Date(IR_DATE).getDay()];
				
				IR_DATE = IR_DATE.replace(/-/g, '/');
				
				IR_DATE = IR_DATE + "(" + dayOfWeek + ")";*/
				
				//이미지 경로
				var img_src = "/img/supply_item/" + ITEM_IMG;
				
				
				
				var date_part = "";
				
				if(i == 0){
					date_part = '<p class="ShowIsTeam">' + TEAM_NAME + '<span class="ShowIsDate">' +  ITEM_REQUEST_DATE + '</span></p>';
					
					grpNo = ITEM_REQUEST_GRP_NO;
					
					$("#IsList_part").append(date_part);					
				}
				
				if(grpNo != ITEM_REQUEST_GRP_NO){
					date_part = '<p class="ShowIsTeam">' + TEAM_NAME + '<span class="ShowIsDate">' +  ITEM_REQUEST_DATE + '</span></p>';
					
					grpNo = ITEM_REQUEST_GRP_NO;
					
					$("#IsList_part").append(date_part);
				}
				
				var stateContent = "";
				var canceContent = "";
				
				if(ITEM_REQUEST_STATE == "W"){
					stateContent = '<p class="isWating">접수대기</p>';
					canceContent = '<span class="srqCancel" onclick="BtnSirDelete('+ ITEM_REQUEST_NO + ',' + ITEM_NO + ',' + ITEM_REQUEST_COUNT +')">신청취소</span>';
				}if(ITEM_REQUEST_STATE == "I"){
					stateContent = '<p class="isIng">진행중</p>';
					canceContent = '<span>취소불가</span>';
				}else if(ITEM_REQUEST_STATE == "S"){
					stateContent = '<p class="isFinish">발송완료</p>';
					canceContent = '<span>취소불가</span>';
				}
				
				var html = 	'<div class="ui-grid-a itemStateContent">' +
								'<div class="ui-block-a">' +
									'<img src="' + img_src + '">' +
								'</div>' +
								'<div class="ui-block-b">' +
									'<p class="item-list-middle1">' + ITEM_NAME + '</p>' +
									'<p class="item-list-middle2">수량 : ' +  ITEM_REQUEST_COUNT + '개</p>' +	
									'<p class="item-list-middle3">'+ canceContent +'</p>' +				
								'</div>' +
								'<div class="ui-block-c">' +
									stateContent +
								'</div>' +									
							'</div>';
				
				
			
				
				$("#IsList_part").append(html);
				
				
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });	
			
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});	
});

//신청 취소
function BtnSirDelete(itemRequestNo, itemNo, itemRequestCount){
	/*infoTxtBox(itemRequestNo);
	infoTxtBox(itemNo);
	infoTxtBox(itemRequestCount);*/
	
	confirmBox('해당물품을 신청 취소 하시겠습니까?', deleteItem);
	
	function deleteItem(){
	
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/supply_item/request_item_cancel.jsp";
	var data = "item_request_no=" + itemRequestNo + "&item_no=" + itemNo + "&item_count=" + itemRequestCount;
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		data : data,
		url: url,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
				return;
			}
			
			$(DATA).each(function(i) {
				/* XML 컬럼들 */
				var RESULT = $(this).find("RESULT").text();
				var MESSAGE = $(this).find("MESSAGE").text();
				
				
				if(RESULT == "true"){	
					$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
					infoTxtBox(MESSAGE);
					go_siState();
				
				}else if(RESULT == "false"){
					$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
					infoTxtBox(MESSAGE);
					
				}
				
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});		
	
	}	
}