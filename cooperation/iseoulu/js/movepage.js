$(document).on('click', '.hv_2', function(){
	var str = $(this).attr('id');
	location.href='/cooperation/iseoulu/view/product/plist.jsp?pCategory=' + str;
});