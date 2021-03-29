$(document).on('pageinit', '#buskingzone_detail', function(){
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/buskingzone/get_buskingzone_detail.jsp',
		data: {
			bz_no: g_bz_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			
			$(DATA).each(function(i) {
				var BZ_NO = $(this).find('BZ_NO').text();
				var BZ_USER_NO = $(this).find('BZ_USER_NO').text();
				var BZ_NAME = $(this).find('BZ_NAME').text();
				var BZ_IMAGE = $(this).find('BZ_IMAGE').text();
				var BZ_SUB_IMAGE = $(this).find('BZ_SUB_IMAGE').text();
				var BZ_ADDRESS = $(this).find('BZ_ADDRESS').text();
				var BZ_DETAILADDR = $(this).find('BZ_DETAILADDR').text();
				var BZ_URL = $(this).find('BZ_URL').text();
				var BZ_CONTACT = $(this).find('BZ_CONTACT').text();
				var BZ_CONTENT = $(this).find('BZ_CONTENT').text();
				var BZ_LATLNG = $(this).find('BZ_LATLNG').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				
				$('#bz_place').val(BZ_ADDRESS);
				
				var imgwidth = window.innerWidth;
				
				if(BZ_IMAGE == ''){
					var bdc_main_img_html = '<li>'+
												'<div class="bdc_image_div">'+
													'<img src="/img/buskingzone/bzone_df.jpg" alt="Los Angeles" style="width:'+imgwidth+'px; max-width: none; height:'+imgwidth+'px;">'+
												'</div>'+
											   '</li>';
										
										$('#bdc_pfsc_ing_ul').append(bdc_main_img_html);
										$('#bdc_img_selecter').append('<li class="bdc_img_active" id="bdc_img_selecter_1">●</li>');
				} else {
										
					var new_img = 'upload/images/user/user' + BZ_USER_NO + "/" + BZ_IMAGE;
	                
				     var imgSrc = getImagePromise(new_img).then(value => {
						$('#img'+BZ_IMAGE).attr('src', value);
						
						var bdc_main_img_html = '<li>'+
								'<div class="bdc_image_div">'+
									'<img src="'+value+'" alt="Los Angeles" style="width:'+imgwidth+'px; max-width: none; height:'+imgwidth+'px;">'+
								'</div>'+
							   '</li>';
				
						$('#bdc_pfsc_ing_ul').append(bdc_main_img_html);
						$('#bdc_img_selecter').append('<li class="bdc_img_active" id="bdc_img_selecter_1">●</li>');
						

						
						if(BZ_SUB_IMAGE != ''){
							var bz_sub_img_array = BZ_SUB_IMAGE.split(',');
							var bz_sub_img = '';
							var bz_sub_img_html = '';
							var bz_sub_img_selecter = '';
								
							for(var i = 0; i < bz_sub_img_array.length; i++){
								var new_img = 'upload/images/user/user' + BZ_USER_NO + "/" + bz_sub_img_array[i];
				                
							     var imgSrc = getImagePromise(new_img).then(value => {
							    	 bz_sub_img_html = '<li>'+
										'<div class="sid_image_div">'+
											'<img src="'+value+'" alt="Los Angeles" style="width:'+imgwidth+'px; max-width: none; height:'+imgwidth+'px;">'+
										'</div>'+
									   '</li>';
					
									$('#bdc_pfsc_ing_ul').append(bz_sub_img_html);
									
									const cnt = $('#bdc_img_selecter').find('li').length;
									
									bz_sub_img_selecter = '<li id="bdc_img_selecter_'+(cnt+1)+'">●</li>';
									$('#bdc_img_selecter').append(bz_sub_img_selecter);
									

									var bdc_carousel;
									bdc_carousel = $("#bdc_pfsc_ing_ul");
									bdc_carousel.itemslide(
								    	{
								    		left_sided: true,
								    		disable_clicktoslide: true
								    	}
								    );
									
									bdc_carousel.on('changePos', function(e){
										var ai = bdc_carousel.getActiveIndex() + 1;
										
										$('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
										$('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
									});
							     });
								
							}					
						}			
				     });
				}
				
				BZ_ADDRESS = BZ_ADDRESS + ' ' + BZ_DETAILADDR;
				
				BZ_CONTENT = changeLineBreak(BZ_CONTENT);
				
				$('#bz_no').val(BZ_NO);
				
				var uno = $('#user_no').val();
				
				if(uno == BZ_USER_NO){
					$('#bdc_del_btn').show();
				}
				
				$('.bdc_body_title').html(BZ_NAME);
				$('#bdc_body_location').html(BZ_ADDRESS);
				$('#bdc_body_url').html(BZ_URL);
				$('#bdc_body_contact').html(BZ_CONTACT);
				$('.bdc_content_subject').html(BZ_CONTENT);
				$('#bdc_footer_name').html(NICKNAME);

				
				/////////////////////좌표 값으로 지도가져오는부분//////////////////////////
				var xPoint = BZ_LATLNG.split(',')[1];
				var yPoint = BZ_LATLNG.split(',')[0];
				
				getKakaoMap(xPoint, yPoint);
				//////////////////////////////////////////////////////////////////////
				$('#bz_x').val(xPoint);
				$('#bz_y').val(yPoint);
				

			}).promise().done(function (){

				var bdc_carousel;
				
				$(document).ready(function () {
					bdc_carousel = $("#bdc_pfsc_ing_ul");
					bdc_carousel.itemslide(
				    	{
				    		left_sided: true,
				    		disable_clicktoslide: true
				    	}
				    );
					
					bdc_carousel.on('changePos', function(e){
						var ai = bdc_carousel.getActiveIndex() + 1;
						
						$('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
						$('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
					});
				});
				
				var bz_no = $('#bz_no').val();
				getBuskingzoneReply(bz_no);
				
			});
		}
	});
});

//글 삭제버튼 클릭시
$(document).on('click', '#bdc_del_btn', function(){
	var bz_no = $('#bz_no').val();
	
	var conf = confirm('버스킹존 게시글을 삭제하시겠습니까?');
	if(!conf){
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/buskingzone/buskingzone_del.jsp',
		data : {
			bz_no : bz_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		async : false,
		timeout: 30000
	});
	
	history.go(-1);
});

//길찾기 버튼 클릭시
$(document).on('click', '.bdc_getdirection_btn', function(){
	var place = $('#bz_place').val();
	var x = $('#bz_x').val();
	var y = $('#bz_y').val();
	load_search(place, x, y);
});

//댓글 등록 버튼 클릭시
$(document).on('click', '#bdc_re_insertbtn', function(){
	var login_chk = userLogin_chk();
	if(login_chk == false){
		infoTxtBox('로그인 후 댓글입력이 가능합니다.');
		return;
	}
	
	var bz_no = $('#bz_no').val();
	var bz_reply_content = $('#bdc_reply_content').val();
	
	if(bz_reply_content == ''){
		alert('댓글을 입력해주세요.');
		$('#bdc_reply_content').focus();
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/buskingzone/buskingzone_reply_insert.jsp',
		data : {
			bz_no : bz_no,
			bz_reply_content : bz_reply_content
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		async : false,
		timeout: 30000
	});
	
	$('#bdc_reply_content').val('');
	getBuskingzoneReply(bz_no);
});

//댓글 삭제버튼 클릭시
$(document).on('click', '.bdc_re_del_btn', function(){
	var conf = confirm('댓글을 삭제하시겠습니까 ?');
	if(!conf){
		return;
	}
	
	var bz_reply_no = $(this).parents('.bdc_re_container').attr('id');
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/buskingzone/buskingzone_reply_del.jsp',
		data : {
			bz_reply_no : bz_reply_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		async : false,
		timeout: 30000
	});
	
	var bz_no = $('#bz_no').val();
	getBuskingzoneReply(bz_no);
});

//답글달기 버튼 클릭시
$(document).on('click', '.bdc_re_info_rebtn', function(){
	var bz_reply_no = $(this).parents('.bdc_re_container').attr('id');
	$('.bdc_re_re_body_' + bz_reply_no).show();
});

//답글 부분 등록버튼 클릭시
$(document).on('click', '#bdc_re_re_input_btn', function(){
	var login_chk = userLogin_chk();
	if(login_chk == false){
		infoTxtBox('로그인 후 댓글입력이 가능합니다.');
		return;
	}
	
	var bz_no = $('#bz_no').val();
	var parent = $(this).parents('.bdc_re_container').attr('id');
	var bz_rereply_content = $(this).parents('.bdc_re_container').find('.bdc_re_re_input').val();
	
	if(bz_rereply_content == ''){
		alert('답글을 입력해주세요.');
		$('#bdc_reply_content').focus();
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/buskingzone/buskingzone_rereply_insert.jsp',
		data : {
			bz_no : bz_no,
			parent : parent,
			bz_rereply_content : bz_rereply_content
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		async : false,
		timeout: 30000
	});
	
	$(this).parents('.bdc_re_container').find('.bdc_re_re_input').val('');
	getBuskingzoneReply(bz_no);
});

//답글 닫기버튼 클릭시
$(document).on('click', '#bdc_rere_closebtn', function(){
	$(this).parents('.bdc_re_re_body').hide();
});

