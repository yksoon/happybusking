function getUserinfoList(){
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/user_info.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			$(DATA).each(function(i) {
				var USER_NO = $(this).find('USER_NO').text();
				var USER_ID = $(this).find('USER_ID').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				var USER_ACTIVE = $(this).find('USER_ACTIVE').text();
				var ARTIST_CHK = $(this).find('ARTIST_CHK').text();
				var BIRTH = $(this).find('BIRTH').text();
				var GENDER = $(this).find('GENDER').text();
				var LOGIN_CHK = $(this).find('LOGIN_CHK').text();
				var BUSKER_OATH = $(this).find('BUSKER_OATH').text();
				
				if(i===0 || i%2===0){
					var user_trtd = '<tr class="bg_whiteblue" id="'+USER_NO+'"><td>'+USER_NO+'</td><td class="user_id">'
					+ USER_ID +'</td><td>'
					+ NICKNAME+'</td><td>'
					+ARTIST_CHK+'</td><td>'
					+LOGIN_CHK+'</td><td>'
					+BUSKER_OATH+'</td></tr>';
				} else {
					var user_trtd = '<tr id="'+USER_NO+'"><td>'+USER_NO+'</td><td class="user_id">'
					+ USER_ID +'</td><td>'
					+ NICKNAME+'</td><td>'
					+ARTIST_CHK+'</td><td>'
					+LOGIN_CHK+'</td><td>'
					+BUSKER_OATH+'</td></tr>';
				}
				
				
				
				
				$('.user_table').append(user_trtd);	
				
			});
		},
		error: function(xhr){
			console.log(xhr);
		}
	});
	
	$('#admin_page_container').load('/app_admin/user_info.jsp #user_info_container');
}