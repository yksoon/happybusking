$(document).on('click', '.menuitem', function(){
	const id = $(this).attr('id');
	const $target = $('.'+id);
	
	$('.menuitem').removeClass('menuon');
	$('.page').removeClass('pageon');
	$(this).addClass('menuon');
	$target.addClass('pageon');
	
	$(window).scrollTop(0);
});