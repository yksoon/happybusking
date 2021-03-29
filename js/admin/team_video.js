function goVideoList(){
	$('#admin_page_container').load('/app_admin/team_video.jsp #team-video-container');
	getVideoList();
}

function getVideoList(){
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/get_team_video_list.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#tvc-table').empty();
			
			var table_header = '<tr>'+
									'<th class="tvc-num">번호</th>'+
									'<th class="tvc-tname">팀명</th>'+
									'<th class="public-url">기존URL</th>'+
									'<th class="change-url">수정할URL</th>'+
									'<th class="tvc-file">파일명</th>'+
									'<th class="tvc-btn">기타</th>'+
								'</tr>'; 
				
			$('#tvc-table').append(table_header);
			
			$(DATA).each(function(i){
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var TINTRO_VIDEO = $(this).find('TINTRO_VIDEO').text();
				var TEAM_VIDEO = $(this).find('TEAM_VIDEO').text();
				
				var table_body_tr;
				if(i === 0 || i % 2 === 0){
					table_body_tr = '<tr class="bg_whiteblue" id="'+TEAM_NO+'">';
				} else {
					table_body_tr = '<tr id="'+TEAM_NO+'">';
				}
				
				var table_body_save;
				if(TEAM_VIDEO === ''){
					table_body_save = '<td><button class="tvc-save" id="save" disabled>저장</button></td>';
				} else {
					table_body_save = '<td><button class="tvc-save" id="save">저장</button></td>';
				}
				
				var table_body = table_body_tr+
									'<td>'+(i+1)+'</td>'+
									'<td>'+TEAM_NAME+'</td>'+
									'<td class="team-video-public-url">'+TINTRO_VIDEO+'</td>'+
									'<td><input type="text" data-role="none" class="tv-url-input" id="vurl"/></td>'+
									'<td class="team-video-url">'+TEAM_VIDEO+'</td>'+
									table_body_save+
								'</tr>';
				
				$('#tvc-table').append(table_body);
			});
		},
		error: function(xhr){
			console.log(xhr);
		}
	});
}

function setVideoUrl(url, tno){
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/set_team_video.jsp',
		data: {
			url: url,
			tno: tno
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		error: function(xhr){
			console.log(xhr);
		},
		complete : function(data){
			getNewWrite();
			getVideoList();
		}
	});
}

$(document).on('click', '.team-video-url', function(){
	const fname = $(this).text();
	const url = '/upload/video/' + fname;
	if(fname === '') return;
	
	var imgSrc = getImagePromise(url).then(value => {
		window.open(value, '_blank');
     });
});


$(document).on('click', '.team-video-public-url', function(){
	const url = $(this).text();
	if(url === '') return;
	
	window.open(url, '_blank');
});

$(document).on('click', '.tvc-save', function(){
	const $target = $(this).parents('tr');
	const url = $target.find('#vurl').val();
	const tno = $target.attr('id');
	
	if(url === ''){
		alert('수정할 URL을 입력해주세요.');
		$target.find('#vurl').focus();
		return;
	}
	
	setVideoUrl(url, tno);
});

$(document).on('keyup', '.tv-url-input', function(){
	const str = $(this).val();
	const $target = $(this).parents('tr').find('#save');
	
	if(str === ''){
		$target.attr('disabled', true);
	} else {
		$target.attr('disabled', false);
	}
});