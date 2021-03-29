//공지사항 리스트 불러오기
function getNoticeList(){
	$('.npc_table').empty();
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/notice_list.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			var header =  '<tr>'+
						    '<th>공지대상</th>'+ 
							'<th>작성자</th>'+
							'<th>제목</th>'+
							'<th>작성일</th>'+
						    '<th>삭제여부</th>'+
						  '</tr>';
			$('.npc_table').append(header);
			
			
			if(DATA.length == 0){
				$('.npc_table').append('<tr><td colspan="5">작성된 공지사항이 없습니다.</td></tr>');
				return;
			}
			
			$(DATA).each(function(){
				var NT_NO = $(this).find('NT_NO').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				var NT_TYPE = $(this).find('NT_TYPE').text();
				var NT_TITLE = $(this).find('NT_TITLE').text();
				var NT_REGDATE = $(this).find('NT_REGDATE').text();
				var NT_DEL = $(this).find('NT_DEL').text();
				
				if(NT_TYPE == 'N'){
					NT_TYPE = '전체';
				} else if(NT_TYPE == 'A'){
					NT_TYPE = '아티스트';
				} else if(NT_TYPE == 'T'){
					NT_TYPE = '팀';
				} else {
					NT_TYPE = 'NAN';
				}
				
				var html =   '<tr id="'+NT_NO+'">'+
							    '<td>'+NT_TYPE+'</td>'+ 
								'<td>'+NICKNAME+'</td>'+
								'<td>'+NT_TITLE+'</td>'+
								'<td>'+NT_REGDATE+'</td>'+
							    '<td>'+NT_DEL+'</td>'+
							  '</tr>';
				
				$('.npc_table').append(html);
			});
		}
	});
	
	$('#admin_page_container').load('/app_admin/notice_list.jsp #notice_page_container');
}

//공지사항 작성 클릭시
$(document).on('click', '#npc_write_btn', function(){
	window.open('/app_admin/notice_popup.jsp', '_blank', 'width=850, height=850');
});

//공지사항 팝업에서 작성버튼 클릭시
$(document).on('click', '#npc_p_btn', function(){
	var ntType = $('#nt_type').val();
	var ntTitle = changeQuotes($('#nt_title').val());
	var ntContent = changeQuotes($('#summernote').summernote('code'));
	var ntNo = $('#ntNo').val();
	
	if(ntContent.length > 13000){
		alert('13000자 이상 입력할 수 없습니다. (html 태그 포함)');
	}
	
	$.ajaxSettings.traditional = true;
	var formData = new FormData();
	formData.append('ntNo', ntNo);
	formData.append('ntType', ntType);
	formData.append('ntTitle', ntTitle);
	formData.append('ntContent', ntContent);
	
	var url;
	if(ntNo == null || ntNo == ''){
		url = '/service/admin/notice_write.jsp';
	} else {
		url = '/service/admin/notice_update.jsp';
	}
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: url,
		//data : data,
		data : formData,
		processData: false,
		contentType: false,
		dataType: "xml",
		async: false,
		timeout: 30000,
		success : function(data){
			
		},
		error: function(xhr){
			console.log(xhr);
		},
		complete: function(){
			alert('작성 완료');
			window.close();
		}
	});
});

//공지사항 목록 클릭시
$(document).on('click', '.npc_table tr', function(){
	var noticeNo = $(this).attr('id');
	window.open('/app_admin/notice_popup.jsp?noticeNo='+noticeNo, '_blank', 'width=850, height=850');
});



//푸시 보내기 창으로
$(document).on('click', '#npc_push_btn', function(){
	window.open('/app_admin/send_push.jsp', '_blank', 'width=850, height=850');
});

//푸시 보내기 버튼 클릭시
$(document).on('click', '#psendbtn', function(){
	var ptype = $('#ptype').val();
	var ptitle = $('#ptitle').val();
	var pcontent = $('#pcontent').val();
	
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/admin_push.jsp',
		data:{
			ptype: ptype,
			ptitle: ptitle,
			pcontent: pcontent
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			
		},
		error: function(xhr){
			console.log(xhr);
		},
		complete: function(){
			alert('작성 완료');
			window.close();
		}
	});
});