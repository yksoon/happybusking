function go_siList(){
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
		} else {
			loadPage('artist_become/artist_become.jsp');
			$('#supply_item_list').trigger('create');
		}
	}
}

function go_siRequest(){
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
		} else {
			loadPage('supply_item/supply_item_request.jsp');
			$('#supply_item_request').trigger('create');
		}
	}
}

function go_siState(){
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
		} else {
			loadPage('supply_item/supply_item_state.jsp');
			$('#supply_item_state').trigger('create');
		}
	}
}


//지원물품 조회
$(document).on('pageinit', '#supply_item_list', function() {
	
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/supply_item/supply_item_list.jsp";
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
				
				return;
			}
			
			$("#supply_item_list_part").empty();
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var ITEM_NO = $(this).find("ITEM_NO").text();
				var ITEM_IMG = $(this).find("ITEM_IMG").text();
				var ITEM_NAME = $(this).find("ITEM_NAME").text();
				var ITEM_COUNT = $(this).find("ITEM_COUNT").text();
				
				
				ITEM_IMG = "/img/supply_item/" + ITEM_IMG
				
				var status = "";
				
				if(ITEM_COUNT == "0"){
					status = '<p class="item-list-statusOff"><span>불가능</span></p>';
				}else{
					status = '<p class="item-list-statusOn"><span>가능</span></p>';
				}
				
				ITEM_COUNT = "재고현황 : " + ITEM_COUNT + "개";
				
				var html = 	'<div class="ui-grid-b item-list-content">' +
								'<div class="ui-block-a" >' +
									'<img src="' + ITEM_IMG  + '">' +
								'</div>' +
								'<div class="ui-block-b">' +
									'<p class="item-list-middle1">' + ITEM_NAME + '</p>' +
									'<p class="item-list-middle2">' + ITEM_COUNT + '</p>' +
								'</div>' +
								'<div class="ui-block-c" >' +
									status +
								'</div>' +
							'</div>';
	
				$("#supply_item_list_part").append(html);
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });	
			
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});
	
});