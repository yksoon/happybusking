const NoticeFunction = {
	GetNoticeList: function(search, start, type){
		let th = '<tr>' +
					'<th class="bg_r_gray ft_16 ft_l_black">No.</th>' +
					'<th class="bg_r_gray ft_16 ft_l_black">제목</th>' +
					'<th class="bg_r_gray ft_16 ft_l_black">작성일</th>' +
				'</tr>';
		$('#noticelist_table').empty();
		$('#noticelist_table').append(th);
		
		$.ajax({
			type: "GET",
			cache: false,
			async: false,
			url: '/cooperation/seoulmetro/adminpage/resource/service/notice/get_notice_list.jsp',
			data: {
				search : search,
				start : start,
				type : type
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				if(DATA.length == 0){
					$('#noticelist_table').append( '<tr><td colspan="3">검색 결과가 없습니다</td></tr>');
					return;
				}
				
				$(DATA).each(function(){
					var NOTICEID = $(this).find('NOTICEID').text();
					var NT_NO = $(this).find('NT_NO').text();
					var NT_TYPE = $(this).find('NT_TYPE').text();
					var NT_TITLE = $(this).find('NT_TITLE').text();
					var NT_REGDATE = $(this).find('NT_REGDATE').text().split(' ')[0];
					var CNT = $(this).find('CNT').text();
					
					let td = '<tr class="notice_item" id="'+NT_NO+'">' +
								'<td class="ft_15 cursorpointer">'+NOTICEID+'</td>' +
								'<td class="ft_15 cursorpointer">'+NT_TITLE+'</td>' +
								'<td class="ft_15 cursorpointer">'+NT_REGDATE+'</td>' +
							'</tr>';
					
					$('#noticelist_table').append(td);
					
					totaldata = CNT;
				});
			},
			error: function(x, h, r){
				console.log(x);
				console.log(h);
				console.log(r);
			}
		});
	},
	GetNoticeDetail: function(dno){
		$.ajax({
			type: "GET",
			cache: false,
			async: false,
			url: '/cooperation/seoulmetro/adminpage/resource/service/notice/get_notice_detail.jsp',
			data: {
				dno : dno
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				if(DATA.length == 0){
					alert('삭제된 게시글입니다.');
					history.go(-1);
					return;
				}
				
				$(DATA).each(function(){
					var NT_TITLE = $(this).find('NT_TITLE').text();
					var NT_CONTENT = $(this).find('NT_CONTENT').text();
					var NICKNAME = $(this).find('NICKNAME').text();
					var NT_REGDATE = $(this).find('NT_REGDATE').text().split(' ')[0];
					var PREV_NO = $(this).find('PREV_NO').text();
					var NEXT_NO = $(this).find('NEXT_NO').text();
					
					$('#nd_title').html(NT_TITLE);
					$('#nd_nickname').html(NICKNAME);
					$('#nd_date').html(NT_REGDATE);
					$('#nd_content').html(NT_CONTENT);
					
					$('.dt_prev').attr('id', PREV_NO);
					$('.dt_next').attr('id', NEXT_NO);
					
					if(PREV_NO == ''){
						$('#prev_title').html('이전글이 없습니다.');
						$('#prev_date').html('');
					} else  {
						NoticeFunction.GetNoticePrev(PREV_NO);
					}
					
					if(NEXT_NO == ''){
						$('#next_title').html('다음글이 없습니다.');
						$('#next_date').html('');
					} else {
						NoticeFunction.GetNoticeNext(NEXT_NO);
					}
				});
			},
			error: function(x, h, r){
				console.log(x);
				console.log(h);
				console.log(r);
			}
		});
	},
	GetNoticePrev: function(dno){
		$.ajax({
			type: "GET",
			cache: false,
			async: false,
			url: '/cooperation/seoulmetro/adminpage/resource/service/notice/get_notice_detail.jsp',
			data: {
				dno : dno
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				$(DATA).each(function(){
					var NT_TITLE = $(this).find('NT_TITLE').text();
					var NT_REGDATE = $(this).find('NT_REGDATE').text().split(' ')[0];
					
					$('#prev_title').html(NT_TITLE);
					$('#prev_date').html(NT_REGDATE);
				});
			},
			error: function(x, h, r){
				console.log(x);
				console.log(h);
				console.log(r);
			}
		});
	},
	GetNoticeNext: function(dno){
		$.ajax({
			type: "GET",
			cache: false,
			async: false,
			url: '/cooperation/seoulmetro/adminpage/resource/service/notice/get_notice_detail.jsp',
			data: {
				dno : dno
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				$(DATA).each(function(){
					var NT_TITLE = $(this).find('NT_TITLE').text();
					var NT_REGDATE = $(this).find('NT_REGDATE').text().split(' ')[0];
					
					$('#next_title').html(NT_TITLE);
					$('#next_date').html(NT_REGDATE);
				});
			},
			error: function(x, h, r){
				console.log(x);
				console.log(h);
				console.log(r);
			}
		});
	}
};