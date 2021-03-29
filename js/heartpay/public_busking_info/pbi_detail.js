$(document).on('pageshow', '#pbi_detail', function(){
	getPublicBuskingInfoDetail();
});

function goKoicaInsert(){
	loadPage('jsp/koica/insert_koica.jsp');
}

$(document).on('click', '.pbi_ds_img', function(){
	$('.pbi_image_popup').show();
});

$(document).on('click', '.pbi_image_popup', function(){
	$('.pbi_image_popup').hide();
});

$(document).on('click', '.pbi_download', function(){
	const path = $(this).attr('id');
	
});