let map;
let markers = [];
let geocoder = new kakao.maps.services.Geocoder();

$(document).ready(function(){
	getKakaoMap(37.519505, 126.930483);
});

$(document).on('click', '#change-image', function(){
	$('#image').click();
});

$(document).on('change', '#image', function(){
	const uno = $('#user_no').val();
	const path = 'images/user/user'+uno;
	
	uploadFile('image', 'none', path, function(){
		const file = $('#image').val().split('\\');
		const filename = file[file.length - 1];
		
		$('#change-image').val(filename);
	});
});

$(document).on('click', '#text_genre', function(){
	viewGenreSelectBox();
});

$(document).on('click', '#no_pay', function(){
	if($(this).is(':checked')){
		$('#transportation').prop('checked', false);
		$('#transportation').attr('disabled', true);
		$('#pay').val('');
		$('#pay').attr('readonly', true);
		$('#pay').addClass('bg-gray');
		$('#pay_max').val('');
		$('#pay_max').attr('readonly', true);
		$('#pay_max').addClass('bg-gray');
	} else {
		$('#transportation').prop('checked', false);
		$('#transportation').attr('disabled', false);
		$('#pay').attr('readonly', false);
		$('#pay').removeClass('bg-gray');
		$('#pay_max').attr('readonly', false);
		$('#pay_max').removeClass('bg-gray');
	}
});

$(document).on('click', '#add-hall-btn', function(){
	$('#add-hall').click();
});

$(document).on('change', '#add-hall', function(){
	const uno = $('#user_no').val();
	const path = 'images/user/user'+uno;
	uploadManyFile('add-hall', '', path, function(url, f){
		const $target = $('.hall-box');
		const leng = $target.length;
		
		for(var i=0; i < leng; i++){
			let emptyChk = $target.eq(i).attr('id');
			
			if(emptyChk === f) break;
			
			if(emptyChk === undefined || emptyChk === 'undefined' || emptyChk === ''){
				$target.eq(i).attr('id', f);
				$target.eq(i).find('.rimg').attr('src', url);
				$target.eq(i).find('.rimg').show();
				$target.eq(i).find('.cancel').show();
				break;
			}
		}
	});
});

$(document).on('click', '#add-product-btn', function(){
	$('#add-product').click();
});

$(document).on('change', '#add-product', function(){
	const uno = $('#user_no').val();
	const path = 'images/user/user'+uno;
	uploadManyFile('add-product', '', path, function(url, f){
		const $target = $('.product-box');
		const leng = $target.length;
		
		for(var i=0; i < leng; i++){
			let emptyChk = $target.eq(i).attr('id');
			
			if(emptyChk === f) break;
			
			if(emptyChk === undefined || emptyChk === 'undefined' || emptyChk === ''){
				$target.eq(i).attr('id', f);
				$target.eq(i).find('.rimg').attr('src', url);
				$target.eq(i).find('.rimg').show();
				$target.eq(i).find('.cancel').show();
				break;
			}
		}
	});
});

$(document).on('click', '.cancel', function(){
	const $target = $(this).parents('.img-box');
	
	$target.removeAttr('id');
	$target.find('.rimg').remove();
	$target.append('<img class="rimg hidden" />');
	$(this).hide();
});