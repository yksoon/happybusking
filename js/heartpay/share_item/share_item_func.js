var g_si_no;
function goShareItemList(){
	loadPage('share_item/share_item_list.jsp');
}

function goShareItemDetail(si_no){
	g_si_no = si_no;
	loadPage('share_item/share_item_detail.jsp');
}

function goShareItemReg(){
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	} else {
		loadPage('share_item/share_item_reg.jsp');
	}
}

function siBackBtn(){
	var sichk = sessionStorage.getItem('sichk');
	
	if(sichk == 'yes'){
		sessionStorage.removeItem('sichk');
		history.go(-3);
	} else {
		history.go(-1);
	}
}

function getShareItemList(si_category, si_search){
	$('#sil_content').empty();
	$.ajax({
		type: "GET",
		url: "/service/share_item/share_item_list.jsp",
		data:{
			si_category: si_category,
			si_search: si_search
		},
		contentType: "application/xml; charset=utf-8",
		success: function (result) {
			var ROOT = $(result).find("ROOT");
			var DATA = $(ROOT).find("DATA");
			
			if(DATA.length == 0){
				//alert('해당 카테고리에 목록이 존재하지 않습니다.');
				$('#sil_content').html('<div id="main_cont" class="noViewBtn" style="display: inline-block;">해당 카테고리에 목록이 존재하지 않습니다.</div>');
				return;
			}
			
			var list_count = 1;
			
			$(DATA).each(function(){
				var SI_NO = $(this).find('SI_NO').text();
				var SI_USER_NO = $(this).find('SI_USER_NO').text();
				var SI_NAME = $(this).find('SI_NAME').text();
				var SI_PRICE_UNIT = $(this).find('SI_PRICE_UNIT').text();
				var SI_PRICE = $(this).find('SI_PRICE').text();
				var SI_STATE = $(this).find('SI_STATE').text();
				var SI_MAIN_IMAGE = $(this).find('SI_MAIN_IMAGE').text();
				var SI_PLACE = $(this).find('SI_PLACE').text();
				var SI_DELIVERY = $(this).find('SI_DELIVERY').text();
				
				//var t_img = '/upload/user/user' + SI_USER_NO + "/" + SI_MAIN_IMAGE;
				
				var new_img = 'upload/images/user/user' + SI_USER_NO + "/" + SI_MAIN_IMAGE;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#simg'+SI_NO).attr('src', value);
			     });
				
				SI_PRICE = addComma(SI_PRICE);
				
				if(SI_DELIVERY == '택배배송'){
					SI_DELIVERY = '택';
				} else if(SI_DELIVERY == '퀵배달'){
					SI_DELIVERY = '퀵';
				} else if(SI_DELIVERY == '직배송') {
					SI_DELIVERY = '직';
				} else {
					SI_DELIVERY = '방';
				}
				
				if(list_count % 2 == 1){
					var html = '<div class="ui-block-a sil_content_div" onclick="goShareItemDetail('+SI_NO+');">'+
								'<div class="sil_content_image">'+
									'<img id="simg'+SI_NO+'">'+
								'</div>'+
								'<div class="sil_content_title">'+SI_NAME+'</div>'+
								'<div class="ui-grid-a">'+
									'<div class="ui-block-a sil_content_state">'+SI_STATE+'</div>'+
									'<div class="ui-block-b sil_content_unit">'+
										'('+SI_PRICE_UNIT+')<pre class="sil_content_price">'+SI_PRICE+'</pre>원'+
									'</div>'+	
								'</div>'+
								'<div class="ui-grid-a">'+
									'<div class="ui-block-a sil_content_delivery">'+SI_DELIVERY+'</div>'+
									'<div class="ui-block-b sil_content_area">'+SI_PLACE+'</div>'+
								'</div>'+
							'</div>';
				} else {
					var html = '<div class="ui-block-b sil_content_div" onclick="goShareItemDetail('+SI_NO+');">'+
								'<div class="sil_content_image">'+
								'<img id="simg'+SI_NO+'">'+
								'</div>'+
								'<div class="sil_content_title">'+SI_NAME+'</div>'+
								'<div class="ui-grid-a">'+
									'<div class="ui-block-a sil_content_state">'+SI_STATE+'</div>'+
									'<div class="ui-block-b sil_content_unit">'+
									'('+SI_PRICE_UNIT+')<pre class="sil_content_price">'+SI_PRICE+'</pre>원'+
									'</div>'+	
								'</div>'+
								'<div class="ui-grid-a">'+
									'<div class="ui-block-a sil_content_delivery">'+SI_DELIVERY+'</div>'+
									'<div class="ui-block-b sil_content_area">'+SI_PLACE+'</div>'+
								'</div>'+
							'</div>';
				}
				
				$('#sil_content').append(html);
				list_count++;
			});
		}
	});
}

function getShareItemDetail(si_no){
	$('#sid_pfsc_ing_ul').empty();
	$('#sid_img_selecter').empty();
	$.ajax({
		type: "GET",
		url: "/service/share_item/share_item_detail.jsp",
		data:{
			si_no: si_no
		},
		contentType: "application/xml; charset=utf-8",
		success: function (result) {
			var ROOT = $(result).find("ROOT");
			var DATA = $(ROOT).find("DATA");
			
			
			$(DATA).each(function(){
				var SI_NO = $(this).find('SI_NO').text();
				var SI_USER_NO = $(this).find('SI_USER_NO').text();
				var SI_NAME = $(this).find('SI_NAME').text();
				var SI_PRICE_UNIT = $(this).find('SI_PRICE_UNIT').text();
				var SI_PRICE = $(this).find('SI_PRICE').text();
				var SI_STATE = $(this).find('SI_STATE').text();
				var SI_MAIN_IMAGE = $(this).find('SI_MAIN_IMAGE').text();
				var SI_SUB_IMAGE = $(this).find('SI_SUB_IMAGE').text();
				var SI_PLACE = $(this).find('SI_PLACE').text();
				var SI_DELIVERY = $(this).find('SI_DELIVERY').text();
				var SI_CONTENT = $(this).find('SI_CONTENT').text();
				var SI_CONTACT = $(this).find('SI_CONTACT').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				
				SI_CONTENT = changeLineBreak(SI_CONTENT);
				
				SI_PRICE = addComma(SI_PRICE);
				
				$('#si_no').val(SI_NO);
				
				var user_no = $('#user_no').val();
				
				if(user_no == SI_USER_NO){
					$('#si_del_btn').show();
				}
				
				$('#sid_user_name').html(NICKNAME);
				$('#sid_product_name').html(SI_NAME);
				$('#sid_product_rank').html(SI_STATE);
				$('#sid_product_period').html('(' + SI_PRICE_UNIT + ')');
				$('#sid_product_price_text').html(SI_PRICE);
				$('#sid_si_delivery').html(SI_DELIVERY);
				$('#sid_si_place').html(SI_PLACE);
				$('#sid_si_content').html(SI_CONTENT);
				$('#sid_si_contact').html(SI_CONTACT);
				
				var imgwidth = window.innerWidth-30;
				
				//var si_main_img = '/upload/user/user' + SI_USER_NO + "/" + SI_MAIN_IMAGE;
				
				var new_img = 'upload/images/user/user' + SI_USER_NO + "/" + SI_MAIN_IMAGE;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
			    	 var si_main_img_html = '<li>'+
											'<div class="sid_image_div">'+
												'<img src="'+value+'" alt="Los Angeles" style="width:'+imgwidth+'px; max-width: none; height:'+imgwidth+'px;">'+
											'</div>'+
										   '</li>';
					
					$('#sid_pfsc_ing_ul').append(si_main_img_html);
					$('#sid_img_selecter').append('<li class="sid_img_active" id="sid_img_selecter_1">●</li>');
					
					
					if(SI_SUB_IMAGE != ''){
						var si_sub_img_array = SI_SUB_IMAGE.split(',');
						var si_sub_img = '';
						var si_sub_img_html = '';
						var si_sub_img_selecter = '';
							
						for(var i = 0; i < si_sub_img_array.length; i++){
							//si_sub_img = '/upload/user/user' + SI_USER_NO + "/" + si_sub_img_array[i];
							var new_img = 'upload/images/user/user' + SI_USER_NO + "/" + si_sub_img_array[i];
			                
						     var imgSrc = getImagePromise(new_img).then(value => {
						    	 si_sub_img_html = '<li>'+
									'<div class="sid_image_div">'+
										'<img src="'+value+'" alt="Los Angeles" style="width:'+imgwidth+'px; max-width: none; height:'+imgwidth+'px;">'+
									'</div>'+
								   '</li>';
				
									$('#sid_pfsc_ing_ul').append(si_sub_img_html);
									
									const cnt = $('#sid_pfsc_ing_ul').find('li').length;
									console.log(cnt);
									
									si_sub_img_selecter = '<li id="sid_img_selecter_'+(cnt)+'">●</li>';
									$('#sid_img_selecter').append(si_sub_img_selecter);
									
									var sid_carousel;
									
									$(document).ready(function () {
										sid_carousel = $("#sid_pfsc_ing_ul");
										sid_carousel.itemslide(
									    	{
									    		left_sided: true,
									    		disable_clicktoslide: true
									    	}
									    );
										
										sid_carousel.on('changePos', function(e){
											var ai = sid_carousel.getActiveIndex() + 1;
											
											$('#sid_img_selecter').find('li').removeClass('sid_img_active');
											$('#sid_img_selecter_' + ai).addClass('sid_img_active');
										});
									});
									
						     });
							
							
						}
					}
					
			     });
			     
			}).promise().done(function (){
			});
		}
	});
}

function getShareItemReplyList(si_no){
	var user_no = $('#user_no').val();
	$.ajax({
		type: "GET",
		url: "/service/share_item/share_item_reply_list.jsp",
		data:{
			si_no: si_no
		},
		contentType: "application/xml; charset=utf-8",
		success: function (result) {
			var ROOT = $(result).find("ROOT");
			var DATA = $(ROOT).find("DATA");
			
			$('#sid_reply_body').empty();
			
			
			$(DATA).each(function(){
				var SI_REPLY_NO = $(this).find('SI_REPLY_NO').text();
				var SI_REPLY_USER_NO = $(this).find('SI_REPLY_USER_NO').text();
				var SI_REPLY_CONTENT = $(this).find('SI_REPLY_CONTENT').text();
				var SI_REPLY_DATE = $(this).find('SI_REPLY_DATE').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				var R_CNT = $(this).find('R_CNT').text();
				var RR_CNT = $(this).find('RR_CNT').text();
				
				$('#sid_re_total_count').html(R_CNT);
				
				html = '<div class="sid_re_container" id="'+SI_REPLY_NO+'">'+
							'<div class="sid_re_body">'+
								'<p class="sid_re_title">'+SI_REPLY_CONTENT+'</p>'+
								'<div class="ui-grid-b sid_re_info">'+
									'<div class="ui-block-a sid_re_info_name">'+NICKNAME+' | '+SI_REPLY_DATE+'</div>'+
									'<div class="ui-block-b sid_re_info_rebtn">답글'+RR_CNT+'개</div>';
				
							if(user_no == SI_REPLY_USER_NO){
								html += '<div class="ui-block-c sid_re_info_delbtn_div"><div class="sid_re_del_btn">삭제<img src="/img/common/close.png"></div></div>';
							} else {
								html += '<div class="ui-block-c sid_re_info_delbtn_div"></div>';
							}
						html += '</div>'+
							'</div>'+
							'<div class="sid_re_re_body">'+
								'<div class="ui-grid-a sid_re_re_inputbox">'+
									'<div class="ui-block-a sid_re_re_inputdiv">'+
										'<input class="sid_re_re_input" id="sid_re_reply_content" placeholder="답글을 작성해주세요">'+
									'</div>'+
									'<div class="ui-block-b sid_re_re_input_btn" id="sid_re_re_input_btn">등록</div>'+
								'</div>';
				
						$.ajax({
							type: "GET",//url: "JSON/test.json",
							cache: false,
							url: '/service/share_item/share_item_rereply_list.jsp',
							data : {
								si_no: si_no,
								parent_no : SI_REPLY_NO
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
									var SI_REPLY_NO = $(this).find('SI_REPLY_NO').text();
									var SI_REPLY_CONTENT = $(this).find('SI_REPLY_CONTENT').text();
									var SI_REPLY_DATE = $(this).find('SI_REPLY_DATE').text();
									var NICKNAME = $(this).find('NICKNAME').text();
									
									html += '<div class="sid_re_re_container">'+
												'<p class="sid_re_re">┗ '+SI_REPLY_CONTENT+' <a id="sid_rere_closebtn">닫기</a></p>'+
												'<span class="sid_re_re_detail">'+
													'<a class="sid_re_re_name">'+NICKNAME+' | '+SI_REPLY_DATE+'</a>'+
												'</span>'+
											'</div>';
								});
							}
						});
					html += '</div>'+
						'</div>';
				
				$('#sid_reply_body').append(html);
			});
		}
	});
}