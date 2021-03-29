$(document).on('pageinit', '#buskingzone_reg', function(){
	$('#buskingzone_content').textinput("option", "autogrow", false);
});

$(document).on('pageshow', '#buskingzone_reg', function(){
	getKakaoMap('37.6547557', '127.0605938');
});

//버스킹존 등록페이지에서 장소사진 +버튼 클릭시 
$(document).on('click', '#brc_main_image_btn_div', function(){
	$('#buskingzone_image').click();
});

//버스킹존 등록페이지에서 장소사진 변경시
$(document).on('change', '#buskingzone_image', function(){
	const uno = $('#user_no').val();
	const path = 'images/user/user'+uno;
	uploadFile('buskingzone_image', 'bi-main', path, function(fname){
		$('#fname').val(fname);
	});
});

//서브이미지 +버튼 클릭시
$(document).on('click', '#brc_sub_image_btn_div', function(){
	var mainChk = $('#fname').val();
	
	if(mainChk == ''){
		alert('대표이미지를 먼저 선택해주세요.');
		return;
	}
	
	$('#brc_sub_image').trigger('click');
});

//서브이미지 변경시
$(document).on('change', '#brc_sub_image', function(){
	for(var i = 0; i < 4; i++){
		$('#brc_sub_image_'+i).find('img').attr('src', '/img/test/noimage.gif');
	}

	const uno = $('#user_no').val();
	const path = 'images/user/user'+uno;
	uploadManyFile('brc_sub_image', 'brc_sub_image', path, function(url, filename){
		const $target = $('.brc_sub_image_div');
		const leng = $target.length;
		let emptyChk = '';
		
		for(var i=0; i<leng; i++){
			emptyChk = $('.brc_sub_image_div').eq(i).attr('id');
			
			if(emptyChk === undefined || emptyChk === 'undefined' || emptyChk === ''){
				$('.brc_sub_image_div').eq(i).find('img').attr('src', url);
				$('.brc_sub_image_div').eq(i).attr('id', filename);
				break;
			}
		}
	});
});

//지도에서 선택하기 텍스트 클릭시
$(document).on('click', '#brc_map_btn', function(){
	var showchk = $('#brc_map').css('display');
	
	if(showchk == 'none'){
		$('#brc_map').show();
	} else {
		$('#brc_map').hide();
	}
	
});

//버스킹존 등록페이지에서 등록하기 버튼 눌렀을 때
$(document).on('click', '.brc_insert_btn', function(){
	var bz_name = changeQuotes($('#buskingzone_name').val());
	var bz_image_text = $('#fname').val();
	var bz_sub_image_text = '';
	var bz_address = changeQuotes($('#address').val());
	var bz_detailaddr = changeQuotes($('#buskingzone_detailaddr').val());
	var bz_url = changeQuotes($('#buskingzone_url').val());
	var bz_contact = changeQuotes($('#buskingzone_contact').val());
	var bz_content = changeQuotes($('#buskingzone_content').val());
	var bz_latlng = $('#latlng').val();
	
	//서브 이미지가 비어있지 않은 경우에만
	let emptyChk = '';
	if($('#brc_sub_image').val() != ''){
		for(var i = 0; i < $('.brc_sub_image_div').length; i++){
			emptyChk = $('.brc_sub_image_div').eq(i).attr('id');
			if(emptyChk === undefined || emptyChk === 'undefined' || emptyChk === ''){
			} else {
				if(i === 0){
					bz_sub_image_text = emptyChk;
				} else {
					bz_sub_image_text = bz_sub_image_text + ',' + emptyChk;
				}
			}
		}
	}
	
	if(bz_name == ''){
		alert('버스킹존 이름을 입력해주세요.');
		$('#buskingzone_name').focus();
		return;
	} else if(bz_address == ''){
		alert('버스킹존 주소를 입력해주세요').
		$('#buskingzone_address').focus();
		return;
	} else if(bz_detailaddr == ''){
		alert('버스킹존 상세주소를 입력해주세요.');
		$('#buskingzone_detailladdr').focus();
		return;
	} else if(bz_content == ''){
		alert('버스킹존 상세정보를 입력해주세요.');
		$('#buskingzone_content').focus();
		return;
	}
	
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/buskingzone/buskingzone_reg.jsp',
		data : {
			bz_name: bz_name,
			bz_image_text: bz_image_text,
			bz_address: bz_address,
			bz_detailaddr: bz_detailaddr,
			bz_sub_image_text: bz_sub_image_text,
			bz_url: bz_url,
			bz_contact: bz_contact,
			bz_content: bz_content,
			bz_latlng: bz_latlng
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
					sessionStorage.setItem('bzchk', 'yes');
					alert(MSG);
					goBuskingzoneList();
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

