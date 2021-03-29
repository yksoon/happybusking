var pf_no_temp = 0;
var team_no_temp = 0;
var reviewCount = 0;
var sortValue = "0";
//무한 스크롤을 위한 변수
var scrollCount = 0;
var addHeight = 715;
var team_no_temp;

function detail_perform_no(pf_no) {
	$('#sc_search_date').blur();
	//공연 정보 페이지를 다시 호출하기 위한 변수
	pf_no_temp = pf_no;
	loadPage('detail_performance/detail_performance.jsp');
}

//공연 상세페이지 > 후기에서 더보기 시 추가 로드
function detail_perfomr_reviewload(team_no, sort) {
	reviewCount = reviewCount + 5;
			
	var url = "/service/detail_performance/detail_performance_review.jsp";
	//var data = "pf_no="+pf_no_temp;
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data:{
			start:reviewCount,
			pf_no:pf_no_temp,
			sort:sort
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				$("#bottom_barr").text("No More Content");
				$("#bottom_barr").attr("onclick", "");
				$("#bottom_barr").css("color", "gray");
				
				return;
			}
			
			$(DATA).each(function(i) {
				var EPILOGUE_NO = $(this).find("EPILOGUE_NO").text();
				var PF_NO = $(this).find("PF_NO").text();
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var USER_NO = $(this).find("USER_NO").text();
				var EPILOGUE_IMG = $(this).find("EPILOGUE_IMG").text();
				var EPILOGUE_TITLE = $(this).find("EPILOGUE_TITLE").text();
				var EPILOGUE_CONTENT = $(this).find("EPILOGUE_CONTENT").text();
				var RATY_STAR = $(this).find("RATY_STAR").text();
				var EPILOGUE_DATE = $(this).find("EPILOGUE_DATE").text();
				var EPILOGUE_DEL = $(this).find("EPILOGUE_DEL").text();
				var CODE_DECLARE = $(this).find("CODE_DECLARE").text();
				var NICKNAME = $(this).find("NICKNAME").text();
				
				var d_img = '/img/test/' + EPILOGUE_IMG;
				
				content ='<div class="ui-grid-b dp_review_list" onclick="detail_review('+EPILOGUE_NO+');">'+
								'<div class="ui-block-a dp_rl_image">'+
								'<img src='+d_img+'>'+
							'</div>'+
							'<div class="ui-block-b" style="width: 60%;">'+
								'<div class="ui-grid-c dp_rl_conetnt_container">'+
									'<div class="ui-block-a dp_rl_cc_title">' + EPILOGUE_TITLE +'</div>'+
									'<div class="ui-block-b dp_rl_cc_ratydiv">'+
										'<div class="ui-grid-a">'+
											'<div class="ui-block-a dp_rl_cc_raty"><p id="tp' + count +'"></p></div>'+
											'<div class="ui-block-b dp_rl_cc_rcount">'+ RATY_STAR +'</div>'+
										'</div>'+
									'</div>'+
									'<div class="ui-block-c dp_rl_cc_content">' + EPILOGUE_CONTENT + '</div>'+
									'<div class="ui-block-d dp_rl_cc_text_container">'+
										'<p class="dp_rl_cc_tc_nickname">'+NICKNAME+'</p>'+
										'<p class="dp_rl_cc_tc_date">'+ EPILOGUE_DATE +'</p>'+
									'</div>'+
								'</div>'+
							'</div>'+
							'<div class="ui-block-c dp_rl_cc_btn">'+
								'<img src="/img/common/show_btn.png">'+
							'</div>'+
						'</div>';
				
				html = content;
				
				$('#detail_perform_tab').append(html);
					
				$(function() {
					$('#tp'+count).raty({
						score : RATY_STAR,
						readOnly : true
					});
				});
				count ++;
			});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
	});	
}
//최신순 <=> 별점순
function detail_perfomr_review_sort() {
	if ($("#sortname").text() == "최신순>") {
		$("#sortname").text("별점순>");
		
		$("#detail_perform_tab").empty();
		
		sortValue = "1";
		
		reviewCount = -5;
		
		
		$("#bottom_barr").text("See More");
		$("#bottom_barr").attr("onclick", "detail_perfomr_reviewload('1', sortValue);");
		$("#bottom_barr").css("color", "black");
		
		detail_perfomr_reviewload(pf_no_temp, sortValue);
	} else if ($("#sortname").text() == "별점순>"){
		$("#sortname").text("최신순>");
		
		$("#detail_perform_tab").empty();
		
		sortValue = "0";
		
		reviewCount = -5;
		
		$("#bottom_barr").text("See More");
		$("#bottom_barr").attr("onclick", "detail_perfomr_reviewload('1', sortValue);");
		$("#bottom_barr").css("color", "black");
		
		detail_perfomr_reviewload(pf_no_temp, sortValue);
	}
	
}


function detail_content_showAll(CHK){
	if(CHK == "1"){
		$('#tinfo_showBtn').attr('onclick', 'detail_content_showAll(0);')
		$("#detail_perform_content").css('height', '-webkit-fill-available');
	} else {
		$('#tinfo_showBtn').attr('onclick', 'detail_content_showAll(1);')
		$("#detail_perform_content").css('height', '65px');
	}
}


//공연정보 댓글 불러오기
function load_pf_reply(){
	var pf_no = pf_no_temp;
	var user_no = $('#user_no').val();
	$('#pd_reply_body').empty();
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/detail_performance/detail_performance_replylist.jsp',
		data : {
			pf_no : pf_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$('#pd_reply_body').html('<p class="pd_zero_count_text">해당 공연에 댓글이 없습니다. 댓글을 달아보세요!</p>');
				$('#pd_total_count').html(0);
				return;
			}
			
			$(DATA).each(function() {
				var PERFORM_REPLY_NO = $(this).find('PERFORM_REPLY_NO').text();
				var PERFORM_REPLY_DATE = $(this).find('PERFORM_REPLY_DATE').text();
				var PERFORM_REPLY_CONTENT = $(this).find('PERFORM_REPLY_CONTENT').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				var CNT = $(this).find('CNT').text();
				var CNT2 = $(this).find('CNT2').text();
				var USER_NO = $(this).find('USER_NO').text();
				
				var html = '<div class="pd_re_container" id="'+PERFORM_REPLY_NO+'">'+
								'<div class="pd_re_body">'+
								'<p class="pd_re_title">'+PERFORM_REPLY_CONTENT+'</p>'+
								
								'<div class="ui-grid-b pd_re_info">'+
									'<div class="ui-block-a pd_re_info_name">'+NICKNAME+' | '+PERFORM_REPLY_DATE+'</div>';
							if(CNT2 == 0){
								html += '<div class="ui-block-b pd_re_info_rebtn">답글달기</div>';
							} else {
								html += '<div class="ui-block-b pd_re_info_rebtn">답글'+CNT2+'개</div>';
							}
				
								html += '<div class="ui-block-c pd_re_info_delbtn_div">';
								
								if(USER_NO == user_no){
									html += '<div class="pd_re_del_btn">삭제 <img src="/img/common/close.png"></div>';
								}
								
								
								html += '</div>'+
								'</div>'+
							'</div>'+
							'<div class="pd_re_re_body">'+
								'<div class="ui-grid-a pd_re_re_inputbox">'+
									'<div class="ui-block-a pd_re_re_inputdiv">'+
										'<input class="pd_re_re_input" id="pd_re_reply_content_'+PERFORM_REPLY_NO+'" placeholder="답글을 작성해주세요">'+
									'</div>'+
									
									'<div class="ui-block-b" id="pd_re_re_input_btn">등록</div>'+
								'</div>';
								
								$.ajax({
									type: "GET",//url: "JSON/test.json",
									cache: false,
									url: '/service/detail_performance/detail_performance_rereplylist.jsp',
									data : {
										pf_no : pf_no,
										parent_no : PERFORM_REPLY_NO
									},
									contentType: "application/xml; charset=utf-8",
									dataType: "xml",
									timeout: 30000,
									async : false,
									success: function (data) {
										var ROOT = $(data).find('ROOT');
										var DATA = $(ROOT).find('DATA');
										
										if(DATA.length == 0){
											return;
										}
										
										$(DATA).each(function(){
											var PERFORM_REPLY_NO = $(this).find('PERFORM_REPLY_NO').text();
											var PERFORM_REPLY_DATE = $(this).find('PERFORM_REPLY_DATE').text();
											var PERFORM_REPLY_CONTENT = $(this).find('PERFORM_REPLY_CONTENT').text();
											var NICKNAME = $(this).find('NICKNAME').text();
											
											html += '<div class="pd_re_re_container">'+
														'<p class="pd_re_re">┗ '+PERFORM_REPLY_CONTENT+' <a id="pd_rere_closebtn">닫기</a></p>'+
														'<span class="pd_re_re_detail">'+
															'<a class="pd_re_re_name">'+NICKNAME+' | '+ PERFORM_REPLY_DATE +'</a>'+
														'</span>'+
													'</div>';
										});
									}
								});
								
								
							html += '</div>'+
						'</div>';
				
				$('#pd_reply_body').append(html);
				$('#pd_total_count').html(CNT);
			});
		}
	});
}