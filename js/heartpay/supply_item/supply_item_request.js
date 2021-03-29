//지원물품 조회
$(document).on('pageinit', '#supply_item_request', function() {
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	
	var height = window.innerHeight - 35;
	$('#si_req_terms').css('height', height+'px');
	
	var url = "/service/supply_item/supply_item_request.jsp";
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
			var DATA2 = $(ROOT).find('DATA2');



			$('#rq-team-select').empty();
			$("#rq-team-select").append('<option value="">팀 이름을 선택하세요</option>');			
			
			$('#rq-item-select').empty();
			$("#rq-item-select").append('<option value="">물품을 선택하세요</option>');
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var ITEM_NO = $(this).find("ITEM_NO").text();
				var ITEM_IMG = $(this).find("ITEM_IMG").text();
				var ITEM_NAME = $(this).find("ITEM_NAME").text();
				var ITEM_COUNT = $(this).find("ITEM_COUNT").text();
				
				if(DATA.length == 0){
					$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
					$('#rq-item-select').empty();
					$("#rq-item-select").append('<option value="">물품을 선택하세요</option>');
					
				}else{
				
					var html = 	'<option value="' + ITEM_NO + '">' + ITEM_NAME +'</option>';
					$("#rq-item-select").append(html);
					$("#rq-item-select").selectmenu("refresh");
				}
		
			});
			
			$(DATA2).each(function(i) {
				//XML 컬럼들 
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				
				if(DATA2.length == 0){
					$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
					$('#rq-team-select').empty();
					$("#rq-team-select").append('<option value="">팀 이름을 선택하세요</option>');	
				}else{
				
					var html = 	'<option value="' + TEAM_NO + '">' + TEAM_NAME +'</option>';
					$("#rq-team-select").append(html);
					$("#rq-team-select").selectmenu("refresh");
				}
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });	
			
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});
	
});



//물품 선택시 작업
$(document).on('change', '#rq-item-select', function(){
	var Item_No = $('#rq-item-select option:selected').val();
	
	if(Item_No == ""){
		infoTxtBox("물품을 선택해주세요");
		
		return;
	}
	
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/supply_item/selectItem.jsp";
	var data = "item_no=" + Item_No;
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		data: data,
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
				var ITEM_NO = $(this).find("ITEM_NO").text();
				var ITEM_IMG = $(this).find("ITEM_IMG").text();
				var ITEM_NAME = $(this).find("ITEM_NAME").text();
				var ITEM_COUNT = $(this).find("ITEM_COUNT").text();
				var MESSAGE = $(this).find("MESSAGE").text();
				
				if(MESSAGE == "F"){
					$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
					infoTxtBox("재고 없음");
					refreshSelectItemBox();
				}else if(MESSAGE == "S"){
					ITEM_IMG = "/img/supply_item/" + ITEM_IMG;
					
					var html = '<div class="ui-grid-b item-list-content" pattern="irForm" itemNumber="' + ITEM_NO  + '">' +
									'<div class="ui-block-a">' +
										'<img src="' + ITEM_IMG + '">' +
									'</div>' +
									'<div class="ui-block-b">' +
										'<p class="item-list-middle1">'+ ITEM_NAME + '</p>' +
							 			'<div class="ui-grid-b item-list-middle2">' +
											'<div class="ui-block-a">' +
												'<p class="irqCnt_middle1">수량</p>' +
											'</div>' +
											'<div class="ui-block-b">' +
												'<p class="irqCnt_middle2"><input type="text" class="onlyNumberStart" value="1"></p>' +
											'</div>' +
											'<div class="ui-block-c">' +
												'<p class="irqCnt_middle3">개</p>' +
											'</div>' +							
										'</div>' +	 					
									'</div>' +
									'<div class="ui-block-c">' +
										'<p class="irqDeleteBtn" onclick="DeleteIrList(' +  ITEM_NO  + ')">삭제</p>' +
									'</div>' +					
								'</div>';		
						
						
					$("#rq_selected_part").append(html);	
					$( ".onlyNumberStart" ).textinput();
					$('#rq-item-select option[value=' + ITEM_NO +']').remove();
					$("#rq-item-select").selectmenu("refresh");
					
				}
				
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});			
});


//물품선택 selectBox 새로고침
function refreshSelectItemBox(){
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/supply_item/supply_item_request.jsp";
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
			
			
			$('#rq-item-select').empty();
			$("#rq-item-select").append('<option value="">물품을 선택하세요</option>');
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var ITEM_NO = $(this).find("ITEM_NO").text();
				var ITEM_IMG = $(this).find("ITEM_IMG").text();
				var ITEM_NAME = $(this).find("ITEM_NAME").text();
				var ITEM_COUNT = $(this).find("ITEM_COUNT").text();
				
				if(DATA.length == 0){
					$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
					$('#rq-item-select').empty();
					$("#rq-item-select").append('<option value="">물품을 선택하세요</option>');
					
				}else{
					
					var html = 	'<option value="' + ITEM_NO + '">' + ITEM_NAME +'</option>';
					$("#rq-item-select").append(html);
					$("#rq-item-select").selectmenu("refresh");
				}
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				
				//내역에 있는거 selectbox 선택에서 제거하기(선택 못하게 방지)
				var attrNumber = $('#rq_selected_part div[pattern="irForm"]').length;
				for(var j=0; j<=attrNumber; j++){
					var itemNumber = $('#rq_selected_part div[pattern="irForm"]:eq(' + j + ')').attr("itemNumber");
					$("#rq-item-select option[value='" + itemNumber + "']").remove();
					$("#rq-item-select").selectmenu("refresh");							

				}
			
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});	
}


//삭제 버튼 클릭 시
function DeleteIrList(ItemNo){
	$('#rq_selected_part div[itemNumber="' + ItemNo + '"]').remove();
/*	var attrNumber = $('#rq_selected_part div[pattern="irForm"]').length;
	infoTxtBox(attrNumber);*/
	refreshSelectItemBox();
	

}



//신청하기 버튼 클릭 시
$(document).on('click', '#BtnIrInsertGo', function(){
	var team_no = $('#rq-team-select option:selected').val();
	var addr = $('#rq_supply_addr').val();
	var zip_code = $('#rq_supply_postcode').val();
	var detail_addr = $('#rq_supply_detail_addr').val();
	
	if(team_no == ""){
		infoTxtBox("팀을 선택해주세요");
		$('#rq-team-select').focus();
		return;
	}
	if(addr == ""){
		infoTxtBox("주소를 입력해주세요");
		$('#rq_supply_addr').focus();
		return;		
	}
	if(zip_code == ""){
		infoTxtBox("우편번호를 입력해주세요");
		$('#rq_supply_postcode').focus();
		return;		
	}
	if(detail_addr == ""){
		infoTxtBox("상세주소를 입력해주세요");
		$('#rq_supply_detail_addr').focus();
		return;		
	}

	var attrNumber = $('#rq_selected_part div[pattern="irForm"]').length;
	//infoTxtBox("사이즈 : " + attrNumber);
	
	if(attrNumber == 0){
		infoTxtBox("신청할 물품을 선택해주세요");
		$('#rq-item-select').focus();
		return;			
	}
	
	
	
	var SelectItemValues = [];
	for(var j=0; j<attrNumber; j++){
		var itemNumber = $('#rq_selected_part div[pattern="irForm"]:eq(' + j + ')').attr("itemNumber");
		var itemName = $('#rq_selected_part div[itemNumber="' + itemNumber + '"] .item-list-middle1').text();
		var itemCount = $('#rq_selected_part div[itemNumber="' + itemNumber + '"] .onlyNumberStart').val();
		if(itemCount == 0 || itemCount == ""){
			infoTxtBox("수량을 제대로 입력해주세요");
			$('#rq_selected_part div[itemNumber="' + itemNumber + '"] .onlyNumberStart').focus();
			return;				
		}
		
		var result = itemChk(itemNumber, itemCount);
		var resultSplit = result.split('@');
		
		if(resultSplit[0] == "false"){
			var msg = "";
			msg = resultSplit[1] + "(재고 수량 : " + resultSplit[2] + ")" + "</br>재고수량에 맞춰서 신청해주세요!";
			infoTxtBox(msg);
			$('#rq_selected_part div[itemNumber="' + itemNumber + '"] .onlyNumberStart').focus();
			return;	
		}

		

		SelectItemValues.push(itemNumber + "@" + itemCount);

	}
	//infoTxtBox(SelectItemValues.toString());
	
	if(!$('#si_req_checkbox').prop('checked')){
		infoTxtBox('공연물품지원 이용약관에 동의해주세요.');
		return;
	}
	
	var url = "/service/supply_item/supply_item_insert.jsp";
	var data = "team_no=" + team_no + "&addr=" + addr + "&zip_code=" + zip_code +
	   "&detail_addr=" + detail_addr + "&SelectItemArray=" + SelectItemValues;

	url = encodeURI(url);
	$.ajax({
	type: "GET",//url: "JSON/test.json",
	async: false,
	cache: false,
	url: url,
	data : data,
	contentType: "application/xml; charset=utf-8",
	dataType: "xml",
	timeout: 30000,
	success: function (data) {
		var ROOT = $(data).find("ROOT");
		var DATA = $(ROOT).find('DATA');
		if(DATA.length == 0){
			return;
		}

		
		$(DATA).each(function(i) {
			
			/* XML 컬럼들 */
			var RESULT = $(this).find("RESULT").text();
			var MESSAGE = $(this).find("MESSAGE").text();
			
			if(RESULT == "true"){
				infoTxtBox(MESSAGE);
				loadPage('supply_item/supply_item_state.jsp');
			}else if(RESULT == "false"){
				infoTxtBox(MESSAGE);
			}
		}).promise().done(function (){
		});
	}, // end success
	error: function (xhr, message, errorThrown) {
		//hideLoading();
	} // end error 
	});			
});


//지원물품 재고 체크 함수  
function itemChk(itemNo, itemCnt){
	
	var url = "/service/supply_item/supply_item_chk.jsp";
	var data = "item_no=" + itemNo + "&item_count=" + itemCnt;
	
	
	var resultValue = "";
	
	url = encodeURI(url);
	$.ajax({
	type: "GET",//url: "JSON/test.json",
	async: false,
	cache: false,
	url: url,
	data : data,
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
			var RESULT  = $(this).find("RESULT").text();
			var ITEM_NAME = $(this).find("ITEM_NAME").text();
			var ITEM_COUNT = $(this).find("ITEM_COUNT").text();
			
			if(RESULT == "false"){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				
				resultValue = RESULT + "@" + ITEM_NAME + "@" + ITEM_COUNT;
				//infoTxtBox(MESSAGE);
				
			}
			
	
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
		});
		
		
	}, // end success
	error: function (xhr, message, errorThrown) {
		$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
		//hideLoading();
	} // end error 
	});		
	
	return resultValue;
}

//지원물품 신청 약관 관련
$(document).on('click', '#si_req_checkbox_btn', function() {
	$('#si_req_checkbox').trigger('click');
});

$(document).on('click', '#si_req_checkboxView', function() {
	$("#si_req_terms").popup( "option" , "dismissible" , false);
	$("#si_req_terms" ).popup( "option", "overlayTheme", "b" );
	$("#si_req_terms" ).popup( "option", "positionTo", "window" );
	$('#si_req_terms').popup('open');
});

$(document).on('click', '#si_req_terms_close', function() {
	$('#si_req_terms').popup('close');
});
