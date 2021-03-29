$(document).on('pageinit', '#share_item_reg', function(){
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/get_area_code.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i) {
				var AREA_NAME = $(this).find("AREA_NAME").text();

				area_select = '<option value="'+AREA_NAME+'">'+AREA_NAME+'</option>';
				
				$('#sir_main_area').append(area_select);
				//$('#sc_area li:firstchild').css('font-weight', 'bold');
				$('#sir_main_area').selectmenu("refresh", true);
				
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error
	});
});

//대표이미지 +버튼 클릭시 
$(document).on('click', '#sir_main_image_btn_div', function(){
	$('#sir_main_image').click();
});

//대표이미지 변경시
$(document).on('change', '#sir_main_image', function(){
	const no = $('#user_no').val();
	const path = 'images/user/user'+no;
	
	uploadFile('sir_main_image', 'mimg', path, function(){
		
	});
});

//서브이미지 +버튼 클릭시
$(document).on('click', '#sir_sub_image_btn_div', function(){
	var mainChk = $('#sir_main_image').val();
	
	if(mainChk == ''){
		alert('대표이미지를 먼저 선택해주세요.');
		return;
	}
	
	$('#sir_sub_image').click();
});

//서브이미지 변경시
$(document).on('change', '#sir_sub_image', function(){
	for(var i = 0; i < 4; i++){
		$('#sir_sub_image_'+i).find('img').attr('src', '/img/test/noimage.gif');
	}

	const no = $('#user_no').val();
	const path = 'images/user/user'+no;
	uploadManyFile('sir_sub_image', '', path, function(url, filename){
		const $target = $('.sir_sub_image_div');
		const leng = $target.length;
		
		for(var i=0; i < leng; i++){
			let emptyChk = $target.eq(i).find('img').attr('id');
			
			if(emptyChk === undefined || emptyChk === 'undefined' || emptyChk === ''){
				$target.eq(i).find('img').attr('id', filename);
				$target.eq(i).find('img').attr('src', url);
				break;
			}
		}
	});
});

//가격 입력시
$(document).on('keyup', '#si_price', function(){
	var str = $(this).val();
	str = removeComma(str);
	str = addComma(str);
	$(this).val(str);
});

//지역 메인 select 변경시
$(document).on('change', '#sir_main_area', function(){
	var area_key = $(this).val();
	$('#sir_sub_area').empty();
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/get_area_sub_code.jsp',
		data: {
			area_key: area_key
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i) {
				var AREA_VALUE = $(this).find("AREA_VALUE").text();
				
				if(i == 0){
					area_select = '<option value="'+AREA_VALUE+'" selected="selected">'+AREA_VALUE+'</option>';
				}else{
					area_select = '<option value="'+AREA_VALUE+'">'+AREA_VALUE+'</option>';
				}
				
				$('#sir_sub_area').append(area_select);
				//$('#sc_area li:firstchild').css('font-weight', 'bold');
				$('#sir_sub_area').selectmenu("refresh", true);
				
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error
	});
});

//등록하기 버튼 클릭시
$(document).on('click', '.sir_insert_btn', function(){
	var si_category = $('#si_category').val();
	var si_name = changeQuotes($('#si_name').val());
	var si_price_unit = $('#si_price_unit').val();
	var si_price = removeComma($('#si_price').val());
	var si_state = $('input[name="si_state"]:checked').val();
	var si_main_image_text = '';
	var si_sub_image_text = '';
	var si_content = changeQuotes($('#si_content').val());
	var si_main_area = $('#sir_main_area').val();
	var si_sub_area = $('#sir_sub_area').val();
	var si_delivery = $('input[name="si_delivery"]:checked').val();
	var si_contact = changeQuotes($('#si_contact').val());
	
	if(si_name == ''){
		alert('물품명을 입력해주세요.');
		return;
	}
	
	if(si_price == ''){
		alert('공유 가격을 입력해주세요.');
		return;
	}
	
	if(si_content == ''){
		alert('장비 설명을 입력해주세요.');
		return;
	}
	
	if($('#sir_main_image').val() == ''){
		alert('대표이미지를 등록해주세요.');
		return;
	} else {
		si_main_image_text = $('#sir_main_image')[0].files[0].name;		
	}
	
	
	if($('#sir_sub_image').val() != ''){
		var fileInput = document.getElementById('sir_sub_image');
		var files = fileInput.files;
		
		for(var i = 0; i < files.length; i++){
			if(i == 0){
				si_sub_image_text = files[i].name;
			} else {
				si_sub_image_text = si_sub_image_text + ',' + files[i].name;
			}
		}
	}
	
	if(si_delivery == ''){
		alert('전달 방식을 선택해주세요.');
		return;
	}
	
	if(si_contact == ''){
		alert('연락처를 입력해주세요.');
	}
	
	var si_place = si_main_area + ' ' + si_sub_area;
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/share_item/share_item_reg.jsp',
		data : {
			si_category: si_category,
			si_name: si_name,
			si_price_unit: si_price_unit,
			si_price: si_price,
			si_state: si_state,
			si_main_image_text: si_main_image_text,
			si_sub_image_text: si_sub_image_text,
			si_content: si_content,
			si_place: si_place,
			si_delivery: si_delivery,
			si_contact: si_contact
		},
		dataType: "xml",
		timeout: 30000,
		beforeSend: function(){
			$.mobile.loading( 'show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
		},
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var RESULT = $(this).find('RESULT').text();
				var MSG = $(this).find('MESSAGE').text();
				
				if(RESULT == 'true' || RESULT == 'TRUE'){
					sessionStorage.setItem('sichk', 'yes');
					alert(MSG);
					goShareItemList();
				} else {
					alert(MSG);
					return;
				}
			});
		},
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		}, // end error
		complete: function(){
			$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
		}
	});
});
