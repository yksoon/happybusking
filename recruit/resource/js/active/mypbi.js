$(document).ready(function(){
	const uno = $('#uno').val();
	
	if(uno === null || uno === 'null' || uno === ''){
		$('.go-reg-btn').addClass('bg-ldgray');
		$('.go-reg-btn').attr('onclick', 'noLogin();');
		$('#n-login').show();
		$('#y-login').hide();
		$('.go-recruit-info').show();
		$('.go-login').show();
	} else {
		$('.go-reg-btn').addClass('bg-purple');
		$('.go-reg-btn').attr('onclick', 'goReg();');
		$('#y-login').show();
		$('#n-login').hide();
		$('.go-login').hide();
		
		let currentPage = (getParam('currentpage') == '') ? '1' : getParam('currentpage');
		
		let start = (parseInt(currentPage) - 1) * 10;
		getPbiList(start);
		
		const datacnt = sessionStorage.getItem('ml-data-cnt');
		PagingFunction.Paging(datacnt, 10, 3, currentPage); 
	}
});

$(document).on('click', '.mi-body', function(){
	const id = $(this).parents('.ml-item').attr('id');
	goPbiUpdate(id);
});


$(document).on('click', '.ml-item', function(){
	const mlTitle = $(this).find('.ml-title').text();
	const scroll = $(window).scrollTop();
	sessionStorage.setItem('ml-title', mlTitle);
	sessionStorage.setItem('mypbi-scroll', scroll);
});