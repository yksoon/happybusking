$(document).on('click', '.pb-title-menu', function(){
	const str = $(this).attr('id');
	const $target = $('.' + str);
	
	let showChk = $target.css('display');
	
	if(showChk === 'none'){
		//숨겨져있는경우
		$target.slideDown('fast');
		$(this).find('.pm-arrow-icon').attr('src', '/img/panel_v2/up.svg');
	} else {
		//보이는 경우
		$target.slideUp('fast');
		$(this).find('.pm-arrow-icon').attr('src', '/img/panel_v2/down.svg');
	}
});


$(document).on('click', '.pb-top-menu', function(){
	const str = $(this).attr('id');
	const $target = $('.' + str);
	
	let showChk = $target.css('display');
	
	if(showChk === 'none'){
		//숨겨져있는경우
		$target.slideDown('fast');
		$(this).find('.pm-arrow-icon').attr('src', '/img/panel_v2/up.svg');
	} else {
		//보이는 경우
		$target.slideUp('fast');
		$(this).find('.pm-arrow-icon').attr('src', '/img/panel_v2/down.svg');
	}
});

$(document).on('click', '.p-blank', function(){
	$('#p-close').click();
});
