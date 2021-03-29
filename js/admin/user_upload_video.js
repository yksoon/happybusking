//공지사항 리스트 불러오기
function goUUV() {
	$('#admin_page_container').load('/app_admin/user_upload_video.jsp #uuv-list');

	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/get_user_upload_video.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			$('#uuv-table').empty();

			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			var header = '<tr>' +
				'<th style="width: 35px;">번호</th>' +
				'<th style="width: 200px;">업로드 한 유저</th>' +
				'<th style="width: 200px;">팀 이름</th>' +
				'<th style="width: 300px;">공연 장소(제목)</th>' +
				'<th style="width: 500px;">공연 내용</th>' +
				'<th style="width: 200px;">URL</th>' +
				'<th style="width: 100px;">업로드 날짜</th>' +
				'<th style="width: 95px;">상태</th>' +
				'</tr>';
			$('#uuv-table').append(header);


			if (DATA.length == 0) {
				$('#uuv-table').append('<tr><td colspan="7">업로드된 동영상이 없습니다.</td></tr>');
				return;
			}

			$(DATA).each(function (i) {
				var NO = $(this).find('NO').text();
				var VIDEO_UPLOAD_URL = $(this).find('VIDEO_UPLOAD_URL').text();
				var VIDEO_UPLOAD_TITLE = $(this).find('VIDEO_UPLOAD_TITLE').text();
				var VIDEO_UPLOAD_CONTENT = $(this).find('VIDEO_UPLOAD_CONTENT').text();
				var REGDATE = $(this).find('REGDATE').text().split(' ')[0];
				var NICKNAME = $(this).find('NICKNAME').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var STATE = $(this).find('STATE').text();

				var tr = '';
				var select = '';

				if (i === 0 || i % 2 === 0) tr = '<tr class="bg_whiteblue" id="' + NO + '">';
				else tr = '<tr id="' + NO + '">';

				//console.log(STATE);

				if (STATE === 'N') select = '<select class="uuv_state"><option class="uuv_option" value="N" selected>대기</option><option class="uuv_option y" value="Y">처리완료</option></select>';
				else select = '<select class="uuv_state"><option class="uuv_option" value="N">대기</option><option class="uuv_option y" value="Y" selected>처리완료</option></select>';

				var html = tr +
					'<td>' + (i + 1) + '</td>' +
					'<td>' + NICKNAME + '</td>' +
					'<td>' + TEAM_NAME + '</td>' +
					'<td>' + VIDEO_UPLOAD_TITLE + '</td>' +
					'<td>' + VIDEO_UPLOAD_CONTENT + '</td>' +
					'<td class="govideo" style="cursor: pointer;">' + VIDEO_UPLOAD_URL + '</td>' +
					'<td>' + REGDATE + '</td>' +
					'<td>' + select + '</td>' +
					'</tr>';

				$('#uuv-table').append(html);
			});
		},
		error: function (xhr) {
			console.log(xhr);
		}
	});

}

$(document).on('click', '.govideo', function () {
	const url = $(this).text();
	window.open(url, '_blank');
});

$(document).on('change', '.uuv_state', function () {
	const no = $(this).parents('tr').attr('id');
	const state = $(this).val();

	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/set_user_upload_video_state.jsp',
		data: {
			no: no,
			state: state
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete: function () {
			getNewWrite();
		}
	});
});