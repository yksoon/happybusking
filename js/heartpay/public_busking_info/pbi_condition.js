$(document).on('pageinit', '#pbi_condition', function(){
	get_pbi_condition();
});

$(document).on('change', '#apply_date_chk', function(){
	var target = $(this);
	if(target.is(':checked')){
		//alert('체크');
		$('.apply_date_text').find('input').val('');
		$('.apply_date_text').find('input').attr('readonly', true);
		$('.apply_date_text').find('span').addClass('pbicc_text_readonly');
	} else {
		//alert('해제');
		$('.apply_date_text').find('input').attr('readonly', false);
		$('.apply_date_text').find('span').removeClass('pbicc_text_readonly');
	}
});

$(document).on('change', '#perform_date_chk', function(){
	var target = $(this);
	if(target.is(':checked')){
		//alert('체크');
		$('.perform_date_text').find('input').val('');
		$('.perform_date_text').find('input').attr('readonly', true);
		$('.perform_date_text').find('span').addClass('pbicc_text_readonly');
	} else {
		//alert('해제');
		$('.perform_date_text').find('input').attr('readonly', false);
		$('.perform_date_text').find('span').removeClass('pbicc_text_readonly');
	}
});

$(document).on('keyup', '#pay', function(e){
	var pay = removeComma($(this).val());
	pay = numberWithCommas(pay);
	$(this).val(pay);
});

$(document).on('click', '#pbi_condition_apply', function(){
	pbi_condition_apply();
});

$(document).on('click', '.pbict_left span', function(){
	var id = $(this).attr('id');
	var target = $('.'+id);
	
	target.fadeIn('fast');
	
	setTimeout(function(){
		target.fadeOut();
	}, 2000);
});

$(document).on('click', '.pbi_adate_input', function(){
	var target = $('#apply_date_chk');
	
	if(target.is(':checked')){
		alert('전체기간 체크를 해제 해야 직접 입력 가능합니다.');
		return;
	}
});