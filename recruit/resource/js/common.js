$(document).ready(function(){
	handerMoveExplan();
});

$(document).on('change', '#allchk', function(){
	if($(this).is(':checked') === true){
		$('input:checkbox[name=terms]').each(function(){
			this.checked = true;
		});
	} else {
		$('input:checkbox[name=terms]').each(function(){
			this.checked = false;
		});
	}
});

$(document).on('change', 'input:checkbox[name=terms]', function(){
	let res = true;
	
	$('input:checkbox[name=terms]').each(function(){
		if($(this).is(':checked') === false){
			res = false;
		}
	});
	
	$('#allchk').prop('checked', res);
});

$(document).on('click', '.logo', function(){
	sessionStorage.removeItem('mypbi-scroll');
});

$(document).on('click', '#back-btn', function(){
	history.go(-1);
});

$(document).on('click', '#rs-prev', function(){
	let explan = sessionStorage.getItem('explan');
	
	if(explan === null || explan === 'null' || explan === '') explan = '1';
	
	if(parseInt(explan) === 1) return;
	else explan = parseInt(explan)-1;
	
	sessionStorage.setItem('explan', explan);
	handerMoveExplan();
});


$(document).on('click', '#rs-next', function(){
	let explan = sessionStorage.getItem('explan');
	
	if(explan === null || explan === 'null' || explan === '') explan = '1';
	
	if(parseInt(explan) === 5) return;
	else explan = parseInt(explan)+1;
	
	sessionStorage.setItem('explan', explan);
	handerMoveExplan();
});

$(document).on('click', '.rs-menu', function(){
	$('.rs-menu').removeClass('rs-on');
	$(this).addClass('rs-on');
	
	const explan = $(this).attr('id').split('-')[1];
	sessionStorage.setItem('explan', explan);
	handerMoveExplan();
});

$(document).on('click', '#go-google', function(){
	handlerOpenQrPopup('/recruit/resource/img/popup/go-googlestore.svg');
});

$(document).on('click', '#go-apple', function(){
	handlerOpenQrPopup('/recruit/resource/img/popup/go-applestore.svg');
});

$(document).on('click', '.rs-app-qr, #rs-app-qr-img', function(){
	handlerCloseQrPopup();
});