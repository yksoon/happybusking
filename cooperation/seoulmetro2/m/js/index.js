$(document).ready(function(){
	const t = getParameterByName('team_no');
	const url = 'https://www.happybusking.com/app/appresult.jsp?team_no=' + t;
	
	if(t === '') return;
	
	getTeamInfo(t);
	$('#now_team_url').attr('onclick', 'goRanding(\''+url+'\')');
});

$('#instra_href').click(function() {

	$(location).attr('href','https://www.instagram.com/seoulmetro.official/');

});


$(window).scroll(function(e){
	const s = $(window).scrollTop();
	
	console.log(s);
	
	if(s === 0) {
		$('.header').removeClass('header-white');
		$('.logo').attr('src', './img/v2/logo1.png');
		$('.menu').attr('src', './img/v2/menu.png');
	} else {
		$('.header').addClass('header-white');
		$('.logo').attr('src', './img/v2/logo2.png');
		$('.menu').attr('src', './img/v2/menu2.png');
	}
});

$(document).on('click', '#menu', function(){
	$('.header').addClass('header-white');
	$('.logo').attr('src', './img/v2/logo2.png');
	$('.menu').hide();
	$('.close').show();
	$('#panel').slideDown('fast');
});

$(document).on('click', '#close', function(){
	handlerPanelClose();
});

$(document).on('click', '.panel__item', function(){
	const id = $(this).attr('id');
	
	handlerPanelClose();
	
	switch(id){
	case 'pi1':
		$(window).scrollTop(245);
		break;
	case 'pi2':
		$(window).scrollTop(710);
		break;
	case 'pi3':
		$(window).scrollTop(1230);
		break;
	case 'pi4':
		$(window).scrollTop(1640);
		break;
	case 'pi5':
		$(window).scrollTop(1640);
		break;
	}
});