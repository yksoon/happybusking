function getTeaminfoList(){
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/team_info.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i) {
				var TID = $(this).find('TID').text();
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var TEAM_INTRO = $(this).find('TEAM_INTRO').text();
				var CODE_AREA = $(this).find('CODE_AREA').text();
				var CODE_GENRE = $(this).find('CODE_GENRE').text();
				var TEAM_PAY = $(this).find('TEAM_PAY').text();
				var TINTRO_IMG = $(this).find('TINTRO_IMG').text();
				var TINTRO_VIDEO = $(this).find('TINTRO_VIDEO').text();
				
				var htmlI = '';
				var htmlV = '';
				
				htmlI = '<img class="timg" id="timg'+TEAM_NO+'" style="width: 40px; height: 25px; cursor: pointer;"/>';
				
				if(TINTRO_VIDEO != ''){
					htmlV = '<img class="tvideo" id="'+TINTRO_VIDEO+'" src="/recruit/resource/img/common/youtube.jpg" style="width: 40px; height: 25px; cursor: pointer;"/>';
				}
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#timg'+TEAM_NO).attr('src', value);
			     });
				
				if(i===0 || i%2===0){
					var team_trtd = '<tr class="bg_whiteblue" id="'+TID+'"><td>'
					+(i+1)+'</td><td>'
					+TEAM_NO+'</td><td class="team_id">'
					+ TEAM_NAME +'</td><td style="width: 50px;">'
					+CODE_AREA+'</td><td style="text-align: left; width: 270px;">'
					+CODE_GENRE+'</td><td style="text-align: left;">'
					+ TEAM_INTRO+'</td><td style="text-align: center;">'
					+ TEAM_PAY + '</td><td>'
					+ htmlI + '</td><td>'
					+ htmlV + '</td></tr>';
				} else {
					var team_trtd = '<tr id="'+TID+'"><td>'
					+(i+1)+'</td><td>'
					+TEAM_NO+'</td><td class="team_id">'
					+ TEAM_NAME +'</td><td style="width: 50px;">'
					+CODE_AREA+'</td><td style="text-align: left; width: 270px;">'
					+CODE_GENRE+'</td><td style="text-align: left;">'
					+ TEAM_INTRO+'</td><td style="text-align: center;">'
					+ TEAM_PAY + '</td><td>'
					+ htmlI + '</td><td>'
					+ htmlV + '</td></tr>';
				}
				
				
				
				$('.team_table').append(team_trtd);	
				
			});
		},
		error: function(xhr){
			console.log(xhr);
		}
	});
	
	$('#admin_page_container').load('/app_admin/team_info.jsp #team_info_container');
}

$(document).on('click', '.timg', function(){
	const url = $(this).attr('src');
	
	window.open(url, '_blank');
});

$(document).on('click', '.tvideo', function(){
	const url = $(this).attr('id');
	
	window.open(url, '_blank');
});