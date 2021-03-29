//공지사항 리스트로 이동
function goNoticeList(){
	loadPage('notice/notice_list.jsp');
}

//공지사항 상세로 이동
function goNoticeDetail(){
	var scroll = $(window).scrollTop();
	sessionStorage.setItem('ntScroll', scroll);
	
	loadPage('notice/notice_detail.jsp');
}

//공지사항 리스트
function getNoticeList(type){
	var start = sessionStorage.getItem('ntStart');
	var limit = sessionStorage.getItem('ntLimit');
	
	if(start == null){
		start = 0;
		sessionStorage.setItem('ntStart', start);
	}
	
	if(limit == null){
		limit = 15;
		sessionStorage.setItem('ntLimit', limit);
	}
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/notice/get_notice_list.jsp',
		data: {
			type : type,
			start : start,
			limit : limit
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#notice_list_contianer').empty();
			
			if(DATA.length == 0){
				$('#main_cont').text('작성된 공지사항이 없습니다.');
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").show();
				return;
			} else if((DATA.length % 15) == 0){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "getMoreNoticeList('"+type+"')");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").show();
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function(){
				var NT_NO = $(this).find('NT_NO').text();
				var NT_TYPE = $(this).find('NT_TYPE').text();
				var NT_TITLE = $(this).find('NT_TITLE').text();
				var NT_REGDATE = $(this).find('NT_REGDATE').text();
				var NT_DEL = $(this).find('NT_DEL').text();
				var NT_VIEWCOUNT = $(this).find('NT_VIEWCOUNT').text();
				var RCOUNT = $(this).find('RCOUNT').text();
				
				if(NT_TYPE == 'N'){
					NT_TYPE = '전체공지';
				} else if(NT_TYPE == 'A'){
					NT_TYPE = '아티스트공지';
				} else if(NT_TYPE == 'T'){
					NT_TYPE = '팀공지';
				}
				
				var html = '<div class="npc_list_container" id="'+NT_NO+'">'+
								'<div class="npc_lc_title">['+NT_TYPE+']'+NT_TITLE+'</div>'+
								'<div class="ui-grid-c npc_lc_content">'+
									'<div class="ui-block-a npc_lc_date">'+NT_REGDATE+'</div>'+
									'<div class="ui-block-b npc_lc_viewcount">조회수:'+NT_VIEWCOUNT+'</div>'+
									'<div class="ui-block-c npc_lc_replyimage">'+
										'<img src="/img/board/reply.png">'+
									'</div>'+
									'<div class="ui-block-d npc_lc_replycount">'+RCOUNT+'</div>'+
								'</div>'+
							'</div>';
				
				$('#notice_list_contianer').append(html);
			});
		},
		error: function(xhr){
			console.log(xhr);
		},
		complete: function(){
			var scroll = sessionStorage.getItem('ntScroll');
			$('html,body').animate({scrollTop: scroll}, 'fast');
		}
	});
}

//더보기 구현해야함
function getMoreNoticeList(type){
	var limit = sessionStorage.getItem('ntLimit');
	
	var start = limit;
	limit = parseInt(limit) + 15;
	sessionStorage.setItem('ntLimit', limit);
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/notice/get_notice_list.jsp',
		data: {
			type : type,
			start : start,
			limit : limit
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 15){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "getMoreNoticeList('"+type+"')");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").show();
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function(){
				var NT_NO = $(this).find('NT_NO').text();
				var NT_TYPE = $(this).find('NT_TYPE').text();
				var NT_TITLE = $(this).find('NT_TITLE').text();
				var NT_REGDATE = $(this).find('NT_REGDATE').text();
				var NT_DEL = $(this).find('NT_DEL').text();
				var NT_VIEWCOUNT = $(this).find('NT_VIEWCOUNT').text();
				var RCOUNT = $(this).find('RCOUNT').text();
				
				if(NT_TYPE == 'N'){
					NT_TYPE = '전체공지';
				} else if(NT_TYPE == 'A'){
					NT_TYPE = '아티스트공지';
				} else if(NT_TYPE == 'T'){
					NT_TYPE = '팀공지';
				}
				
				var html = '<div class="npc_list_container" id="'+NT_NO+'">'+
								'<div class="npc_lc_title">['+NT_TYPE+']'+NT_TITLE+'</div>'+
								'<div class="ui-grid-c npc_lc_content">'+
									'<div class="ui-block-a npc_lc_date">'+NT_REGDATE+'</div>'+
									'<div class="ui-block-b npc_lc_viewcount">조회수:'+NT_VIEWCOUNT+'</div>'+
									'<div class="ui-block-c npc_lc_replyimage">'+
										'<img src="/img/board/reply.png">'+
									'</div>'+
									'<div class="ui-block-d npc_lc_replycount">'+RCOUNT+'</div>'+
								'</div>'+
							'</div>';
				
				$('#notice_list_contianer').append(html);
			});
		}
	});
}

//공지사항 상세정보
function getNoticeDetail(){
	var ntNo = sessionStorage.getItem('ntNo');
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/notice/get_notice_detail.jsp',
		data: {
			ntNo : ntNo
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var NT_NO = $(this).find('NT_NO').text();
				var NT_TYPE = $(this).find('NT_TYPE').text();
				var NT_TITLE = $(this).find('NT_TITLE').text();
				var NT_CONTENT = $(this).find('NT_CONTENT').text();
				var NT_REGDATE = $(this).find('NT_REGDATE').text();
				var NT_VIEWCOUNT = $(this).find('NT_VIEWCOUNT').text();
				var RCOUNT = $(this).find('RCOUNT').text();
				
				if(NT_TYPE == 'N'){
					NT_TYPE = '전체공지';
				} else if(NT_TYPE == 'A'){
					NT_TYPE = '아티스트공지';
				} else if(NT_TYPE == 'T'){
					NT_TYPE = '팀공지';
				}
				
				NT_VIEWCOUNT = '조회수: ' + NT_VIEWCOUNT;
				
				var title = '[' + NT_TYPE + ']' + NT_TITLE;
				$('.ndc_title').html(title);
				$('.ndc_date').html(NT_REGDATE);
				$('.ndc_vcount').html(NT_VIEWCOUNT);
				
				$('#ndc_content_container').html(NT_CONTENT);
				
				$('#ndc_rtc_count').html(RCOUNT);
				
				getNoticeReply();
			});
		}, 
		error: function(xhr){
			console.log(xhr);
		},
		complete: function(){
			const $target = $('#ndc_content_container').find('img');
			
			$target.each(function(i){
				var src = $target.eq(i).attr('src').split('/');
				src = src[src.length-1];
				
				var new_img = 'upload/images/user/user0/' + src;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
			    	 $target.eq(i).attr('src', value);
			     });
			});
		}
	});
}

//공지사항에 해당하는 댓글 가져오기
function getNoticeReply(){
	var ntNo = sessionStorage.getItem('ntNo');
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/notice/get_notice_reply.jsp',
		data: {
			ntNo : ntNo
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$('.ndc_rbc_no_text').show();
				return;
			}
			$('.ndc_rbc_no_text').hide();
			$('#ndc_reply_body_contianer').empty();
			
			$(DATA).each(function(i){
				var USER_NO = $(this).find('USER_NO').text();
				var NT_NO = $(this).find('NT_NO').text();
				var NTR_NO = $(this).find('NTR_NO').text();
				var NTR_CONTENT = $(this).find('NTR_CONTENT').text();
				var NTR_REGDATE = $(this).find('NTR_REGDATE').text();
				var NTR_DEL = $(this).find('NTR_DEL').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				var CNT = $(this).find('CNT').text();
				var delBtn = '';
				
				var uno = $('#uno').val();
				
				if(uno == USER_NO){
					//글쓴 사람이면
					delBtn = '<span class="ndc_rbc_list_delbtn" id="'+NTR_NO+'"><img src="/img/common/close.png">삭제</span>';
				}
				
				if(NTR_DEL == 'Y'){
					var html = '<div class="ndc_rbc_list_container">'+
									'<div class="ndc_rbc_list_content">삭제된 댓글입니다.</div>'+
									'<div class="ui-grid-b ndc_rbc_list_info">'+
										'<div class="ui-block-a ndc_rbc_list_name">'+NICKNAME+' | '+NTR_REGDATE+'</div>'+
										'<div class="ui-block-b ndc_rbc_list_rebtn"></div>'+
										'<div class="ui-block-c ndc_rbc_list_delbtn_div">'+
										'</div>'+
									'</div>'+
								'</div>';
				} else {
					var html = '<div class="ndc_rbc_list_container">'+
									'<div class="ndc_rbc_list_content">'+NTR_CONTENT+'</div>'+
									'<div class="ui-grid-b ndc_rbc_list_info">'+
										'<div class="ui-block-a ndc_rbc_list_name">'+NICKNAME+' | '+NTR_REGDATE+'</div>'+
										'<div class="ui-block-b ndc_rbc_list_rebtn"></div>'+
										'<div class="ui-block-c ndc_rbc_list_delbtn_div">'+
										 	delBtn+
										'</div>'+
									'</div>'+
								'</div>';
				}
				
				$('#ndc_reply_body_contianer').append(html);
				
				if(i == 0){
					$('#ndc_rtc_count').text(CNT);
				}
			});
		}, 
		error: function(xhr){
			console.log(xhr);
		}
	});
}