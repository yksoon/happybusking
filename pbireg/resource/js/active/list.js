$(document).ready(function(){
	getPbiList();
});

const getPbiList = () => {
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		async: false,
		url: '/service/public_busking_info/get_pbi_list_admin.jsp',
		dataType: "xml",
		timeout: 30000,
		beforeSend: function(){
			$('#popup_text').html('로딩중입니다.');
			$('#loading').show();
		},
		success: function (data) {
			$('#list').empty();
			
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				const PBI_NO = $(this).find('PBI_NO').text();
				const PBI_TITLE = $(this).find('PBI_TITLE').text();
				
				let html;
				html = '<div class="item" id="'+PBI_NO+'">' +
							'<p class="title">'+PBI_TITLE+'</p>' +
						'</div>';
				
				
				$('#list').append(html);
			});
		},
		error: function (xhr, message, errorThrown) {
			console.log(xhr);
			console.log(message);
			console.log(errorThrown);
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		}, // end error
		complete: function(){
			$('#loading').hide();
		}
	});
}

$(document).on('click', '.item', function(){
	const id = $(this).attr('id');
	const url = '/pbireg/page/update.jsp?id=' + id;
	
	location.href = url;
});