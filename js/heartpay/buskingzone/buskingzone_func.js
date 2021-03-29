function goBuskingzoneList(){
	loadPage('buskingzone/buskingzone_list.jsp');
}

var g_bz_no;
function goBuskingzoneDetail(bz_no){
	g_bz_no = bz_no;
	var scroll = $(window).scrollTop();
	sessionStorage.setItem('bz_scroll', scroll);
	loadPage('buskingzone/buskingzone_detail.jsp');
}

function goBuskingzoneReg(){
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	} else {
		loadPage('buskingzone/buskingzone_reg.jsp');
	}
}

function bzBackBtn(){
	var bzchk = sessionStorage.getItem('bzchk');
	
	if(bzchk == 'yes'){
		sessionStorage.removeItem('bzchk');
		history.go(-3);
	} else {
		history.go(-1);
	}
}

function getBuskingzoneList(sarea, keyword, limit, lastlimit){
	if(sarea == '전국'){
		sarea = '';
	} else if(sarea == '충남'){
		sarea = '충청남도';
	} else if(sarea == '충북'){
		sarea = '충청북도';
	} else if(sarea == '전남'){
		sarea = '전라남도';
	} else if(sarea == '전북'){
		sarea = '전라북도';
	} else if(sarea == '경남'){
		sarea = '경상남도';
	} else if(sarea == '경북'){
		sarea = '경상북도';
	}
    
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/buskingzone/get_buskingzone_list.jsp',
		data: {
			bz_addr: sarea,
			keyword: keyword,
			limit: limit,
			lastlimit: lastlimit
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#sbl_content_list').empty();
			
			if(DATA.length == 0){
				$("#main_cont").text("해당 지역에 등록된 버스킹존이 없습니다.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function() {
				var BZ_NO = $(this).find('BZ_NO').text();
				var BZ_USER_NO = $(this).find('BZ_USER_NO').text();
				var BZ_NAME = $(this).find('BZ_NAME').text();
				var BZ_IMAGE = $(this).find('BZ_IMAGE').text();
				var BZ_ADDRESS = $(this).find('BZ_ADDRESS').text();
				var BZ_CONTENT = $(this).find('BZ_CONTENT').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				
				if(BZ_IMAGE != ''){
					var new_img = 'upload/images/user/user' + BZ_USER_NO + "/" + BZ_IMAGE;
	                
				     var imgSrc = getImagePromise(new_img).then(value => {
						$('#img'+BZ_NO).attr('src', value);
				     });
				}
				
				var bz_addr_array = BZ_ADDRESS.split(' ');
				BZ_ADDRESS = bz_addr_array[0] + ' ' + bz_addr_array[1];
				
				BZ_CONTENT = BZ_CONTENT.split('<br/>').join('');
				
				var html = '<div class="ui-grid-b sbl_content" onclick="goBuskingzoneDetail('+BZ_NO+');">'+
								'<div class="ui-block-a sbl_content_img">';
								
							if(BZ_IMAGE == ''){
								html += '<img src="/img/buskingzone/bzone_df.jpg">';
							} else {
								html += '<img id="img'+BZ_NO+'">';
							}
								
									
							html += '</div>'+
								'<div class="ui-block-b sbl_content_info">'+
									'<div class="sbl_ci_title">'+BZ_NAME+'</div>'+
									'<div class="sbl_ci_location">'+BZ_ADDRESS+'</div>'+
									'<div class="sbl_ci_description">'+BZ_CONTENT+'</div>'+			
									'<div class="sbl_ci_id"><i class="fa fa-user"></i> <a>'+NICKNAME+'</a></div>'+
								'</div>'+
								'<div class="ui-block-c sbl_content_further">'+
									'<img class="sbl_cf_btn" src="/img/common/show_btn.svg">'+
								'</div>'+
							'</div>';
				
				$('#sbl_content_list').append(html);
			});
		},
		complete: function(){
			var scroll = sessionStorage.getItem('bz_scroll');
			
			if(scroll == null || scroll == ''){
				$('html,body').animate({scrollTop: 0}, 'fast');
			} else {
				$('html,body').animate({scrollTop: scroll}, 'fast');
			}
		}
	});
}

function getMoreBuskingzoneList(){
	var sarea = sessionStorage.getItem('bzlArea');
	var keyword = sessionStorage.getItem('bzlKeyword');
	var limit = sessionStorage.getItem('bzlLimit');
	
	if(sarea == null || sarea == '전국'){
		sarea = '';
	} else if(sarea == '충남'){
		sarea = '충청남도';
	} else if(sarea == '충북'){
		sarea = '충청북도';
	} else if(sarea == '전남'){
		sarea = '전라남도';
	} else if(sarea == '전북'){
		sarea = '전라북도';
	} else if(sarea == '경남'){
		sarea = '경상남도';
	} else if(sarea == '경북'){
		sarea = '경상북도';
	}
	
	if(keyword == null){
		keyword = '';
	}
	
	if(limit == null){
		limit = 20;
	} else {
		limit = (limit * 1) + 20;
	}
	
	sessionStorage.setItem('bzlLimit', limit);
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/buskingzone/get_buskingzone_list.jsp',
		data: {
			bz_addr: sarea,
			keyword: keyword,
			limit: limit,
			lastlimit: '0'
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$("#main_cont").text("해당 지역에 등록된 버스킹존이 없습니다.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else if(DATA.length == 20){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "getMoreBuskingzoneList()");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").css('display', 'inline-block');
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function() {
				var BZ_NO = $(this).find('BZ_NO').text();
				var BZ_USER_NO = $(this).find('BZ_USER_NO').text();
				var BZ_NAME = $(this).find('BZ_NAME').text();
				var BZ_IMAGE = $(this).find('BZ_IMAGE').text();
				var BZ_ADDRESS = $(this).find('BZ_ADDRESS').text();
				var BZ_CONTENT = $(this).find('BZ_CONTENT').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				

				var bz_img = '/upload/user/user' + BZ_USER_NO + "/" + BZ_IMAGE;
				
				if(BZ_IMAGE != ''){
					var new_img = 'upload/images/user/user' + BZ_USER_NO + "/" + BZ_IMAGE;
	                
				     var imgSrc = getImagePromise(new_img).then(value => {
						$('#img'+BZ_NO).attr('src', value);
				     });
				}
				
				
				var bz_addr_array = BZ_ADDRESS.split(' ');
				BZ_ADDRESS = bz_addr_array[0] + ' ' + bz_addr_array[1];
				
				BZ_CONTENT = BZ_CONTENT.split('<br/>').join('');
				
				var html = '<div class="ui-grid-b sbl_content" onclick="goBuskingzoneDetail('+BZ_NO+');">'+
								'<div class="ui-block-a sbl_content_img">';
								
							if(BZ_IMAGE == ''){
								html += '<img src="/img/buskingzone/bzone_df.jpg">';
							} else {
								html += '<img id="img'+BZ_NO+'">';
							}
								
									
							html += '</div>'+
								'<div class="ui-block-b sbl_content_info">'+
									'<div class="sbl_ci_title">'+BZ_NAME+'</div>'+
									'<div class="sbl_ci_location">'+BZ_ADDRESS+'</div>'+
									'<div class="sbl_ci_description">'+BZ_CONTENT+'</div>'+			
									'<div class="sbl_ci_id"><i class="fa fa-user"></i> <a>'+NICKNAME+'</a></div>'+
								'</div>'+
								'<div class="ui-block-c sbl_content_further">'+
									'<img class="sbl_cf_btn" src="/img/common/show_btn.svg">'+
								'</div>'+
							'</div>';
				
				$('#sbl_content_list').append(html);
			});
		}
	});
}

function getBuskingzoneReply(bz_no){
	$('#bdc_reply_body').empty();
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/buskingzone/buskingzone_reply_list.jsp',
		data : {
			bz_no : bz_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$('#bdc_reply_body').html('<p class="bdc_zero_count_text">버스킹존에 대한 댓글을 남겨주세요.</p>');
				$('#bdc_total_count').html(0);
				return;
			}
			
			$(DATA).each(function() {
				var BZ_REPLY_NO = $(this).find('BZ_REPLY_NO').text();
				var BZ_REPLY_DATE = $(this).find('BZ_REPLY_DATE').text();
				var BZ_REPLY_CONTENT = $(this).find('BZ_REPLY_CONTENT').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				var CNT = $(this).find('CNT').text();
				var CNT2 = $(this).find('CNT2').text();
				var USER_NO = $(this).find('USER_NO').text();
				
				var uno = $('#user_no').val();
				
				var html = '<div class="bdc_re_container" id="'+BZ_REPLY_NO+'">'+
								'<div class="bdc_re_body">'+
								'<p class="bdc_re_title">'+BZ_REPLY_CONTENT+'</p>'+
								'<div class="ui-grid-b bdc_re_info">'+
									'<div class="ui-block-a bdc_re_info_name">'+NICKNAME+' | '+BZ_REPLY_DATE+'</div>';
							
							if(CNT2 == 0){
								html += '<div class="ui-block-b bdc_re_info_rebtn">답글달기</div>';
							} else {
								html += '<div class="ui-block-b bdc_re_info_rebtn">답글'+CNT2+'개</div>';
							}
							html += '<div class="ui-block-c bdc_re_info_delbtn_div">';
									if(uno == USER_NO){
										html += '<div class="bdc_re_del_btn">삭제 <img src="/img/common/close.png"></div>';
									}
							html+=	'</div>'+
								'</div>'+
							'</div>'+
							'<div class="bdc_re_re_body bdc_re_re_body_'+BZ_REPLY_NO+'">'+
								'<div class="ui-grid-a bdc_re_re_inputbox">'+
									'<div class="ui-block-a bdc_re_re_inputdiv">'+
										'<input class="bdc_re_re_input" id="" placeholder="답글을 작성해주세요">'+
									'</div>'+
									'<div class="ui-block-b" id="bdc_re_re_input_btn">등록</div>'+
								'</div>';
								
								$.ajax({
									type: "GET",//url: "JSON/test.json",
									cache: false,
									url: '/service/buskingzone/buskingzone_rereply_list.jsp',
									data : {
										bz_no : bz_no,
										parent_no : BZ_REPLY_NO
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
											var BZ_REPLY_NO = $(this).find('BZ_REPLY_NO').text();
											var BZ_REPLY_DATE = $(this).find('BZ_REPLY_DATE').text();
											var BZ_REPLY_CONTENT = $(this).find('BZ_REPLY_CONTENT').text();
											var NICKNAME = $(this).find('NICKNAME').text();
											
											html += '<div class="bdc_re_re_container">'+
														'<p class="bdc_re_re">┗ '+BZ_REPLY_CONTENT+' <a id="bdc_rere_closebtn">닫기</a></p>'+
														'<span class=bdc_re_re_detail">'+
															'<a class="bdc_re_re_name">'+NICKNAME+' | '+BZ_REPLY_DATE+'</a>'+
														'</span>'+
													'</div>';
										});
									}
								});
								
						html += '</div>'+
						'</div>';
				
				$('#bdc_reply_body').append(html);
				$('#bdc_total_count').html(CNT);
			});
		}
	});
}