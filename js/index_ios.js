$(document).on('click', 'a', function(){
	var url = $(this).attr('href');
	
	var urlchk = url.split('://')[0];
	
	if(urlchk == 'http' || urlchk == 'https'){
		window.open(url, "_blank");
	} else {
		return;
	}
});