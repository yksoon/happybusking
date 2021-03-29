//뒤로가기시 아티스트정보에서 탭 구분을 위함.
var store_info_pageNo = 1;
$(document).on('pageshow', '#test_store', function(){

    if(store_info_pageNo == 1){
        $('#Go_st_introBtn').click();
    }
    else if(store_info_pageNo == 2){
        $('#Go_st_menuBtn').click();
    }
    else if(store_info_pageNo == 3){
        $('#Go_st_calBtn').click();
    }
    else if(store_info_pageNo == 4){
        $('#Go_st_trafBtn').click();
    }
}); 
//테스트

$(document).on('pageinit', '#test_store', function(){
    const test_no = '2101050856328420';
    store_info_pageNo = 1;
    var header_html = '<div class="ui-block-a" id="Go_st_introBtn">'+
        '<div class="haeder_menu_div_on">'+
            '<span>소개</span>'+
        '</div>'+
    '</div>'+
    '<div class="ui-block-b" id="Go_st_menuBtn">'+
        '<div class="haeder_menu_div_base">'+
            '<span>메뉴</span>'+
        '</div>'+
    '</div>'+
    '<div class="ui-block-c" id="Go_st_calBtn">'+
        '<div class="haeder_menu_div_base">'+
            '<span>일정</span>'+
        '</div>'+
    '</div>'+
    '<div class="ui-block-d" id="Go_st_trafBtn">'+
        '<div class="haeder_menu_div_base">'+
            '<span>교통</span>'+
        '</div>'+
    '</div>';

    $('.header_menu_container').html(header_html);
       
    console.log(test_no);
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/test_store/test_store.jsp',
		data: {
			test_no:test_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			console.log('success');
			$(DATA).each(function(i) {
				var USER_NO = $(this).find('USER_NO').text();
                var SPACE_PICTURE = $(this).find('SPACE_PICTURE').text();
                var STAGE_PICTURE = $(this).find('STAGE_PICTURE').text();
				var ADDRESS = $(this).find('ADDRESS').text();
				var OPERATIONHOUR = $(this).find('OPERATIONHOUR').text();
				var EQUIPMENT = $(this).find('EQUIPMENT').text();
				var GENRE = $(this).find('GENRE').text();
				var PARKING_CHK = $(this).find('PARKING_CHK').text();
				var PERFORM_TIPBOX = $(this).find('PERFORM_TIPBOX').text();
				var MOBILE_TIPBOX = $(this).find('MOBILE_TIPBOX').text();
                var VIDEO_CHK = $(this).find('VIDEO_CHK').text();
                var MENU = $(this).find('MENU').text();
				var HASHTAG = $(this).find('HASHTAG').text();
				var ZONE_INFO = $(this).find('ZONE_INFO').text();
                var LICENSE_PICTURE = $(this).find('LICENSE_PICTURE').text();
                var BUSINESS_WORKNAME = $(this).find('BUSINESS_WORKNAME').text();
				var BUSINESS_PHONE = $(this).find('BUSINESS_PHONE').text();
				var imgwidth = window.innerWidth;
					// var new_img = 'upload/store/menu/menu' + USER_NO + "/" 
                    
                
						
                if(SPACE_PICTURE != ''){
                    var sp_picture_array = SPACE_PICTURE.split(',');
                    var sp_img = '';
                    var sp_img_html = '';
                    var sp_img_selecter = '';
                    
                        
                    for(var i = 0; i < sp_picture_array.length; i++){
                        var new_img = 'upload/store/space/space' + USER_NO + "/" + sp_picture_array[i];

                        var imgSrc = getImagePromise(new_img).then(value => {
                                sp_img_html = '<li>'+
                                '<div class="bdc_image_div">'+
                                    '<img src="'+value+'" alt="Los Angeles" style="width:'+imgwidth+'px; max-width: none; height:'+imgwidth+'px;">'+
                                '</div>'+
                                '</li>';
            
                            $('#bdc_pfsc_ing_ul').append(sp_img_html);
                            if(i == 0){
                                sp_img = '<img src="'+value+'" alt="Los Angeles" style="width:50px; max-width: none; height:50px;">';
                                $('.store_dtl_title_img').append(sp_img)
                            }
                            const cnt = $('#bdc_img_selecter').find('li').length;
                            
                            sp_img_selecter = '<li id="bdc_img_selecter_'+(cnt+1)+'">●</li>';
                            $('#bdc_img_selecter').append(sp_img_selecter);
                            

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
                if(STAGE_PICTURE != ''){
                    var st_pictur_array = STAGE_PICTURE.split(',');
                    var st_img = '';
                    var st_img_html = '';
                    var st_img_selecter = '';
                        
                    for(var i = 0; i < st_pictur_array.length; i++){
                        var new_img = 'upload/store/stage/stage' + USER_NO + "/" + st_pictur_array[i];
                        
                        var imgSrc = getImagePromise(new_img).then(value => {
                                st_img_html = '<li>'+
                                '<div class="bdc_image_div">'+
                                    '<img src="'+value+'" alt="Los Angeles" style="width:'+imgwidth+'px; max-width: none; height:'+imgwidth+'px;">'+
                                '</div>'+
                                '</li>';
            
                            $('#bdc_pfsc_ing_ul').append(st_img_html);
                            
                            const cnt = $('#bdc_img_selecter').find('li').length;
                            
                            st_img_selecter = '<li id="bdc_img_selecter_'+(cnt+1)+'">●</li>';
                            $('#bdc_img_selecter').append(st_img_selecter);
                            

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
                $('.store_dtl_title_j_b').html(BUSINESS_WORKNAME);	
				$('.store_dtl_introduce_c').html(ZONE_INFO);
                $('.store_dtl_introduce_addr_l').html(ADDRESS);
                $('.store_dtl_introduce_time').html(OPERATIONHOUR);
                
				if(HASHTAG != ''){
                    var hashtag_array = HASHTAG.split(',');
                    var hashtag_html = '';
                    for(var i = 0; i < hashtag_array.length; i++){
                        hashtag_html = '<div class="store_dtl_introduce_ht">'+ hashtag_array[i] + '</div>'
                        $('.store_dtl_introduce_ht_list').append(hashtag_html);
                    }    
                }
				

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
        },
        error: function (xhr, message, errorThrown) {
            console.log("error");
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
            //alert(data);
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            // $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
            // sessionStorage.setItem('aname', $('#artist_name').val())
            // sessionStorage.setItem('acontent', $('#artist_intro').val());
            //setAimgCallback2(imgsrc);

            // go_team_create();
        }
	});
});

// //글 삭제버튼 클릭시
// $(document).on('click', '#bdc_del_btn', function(){
// 	var bz_no = $('#bz_no').val();
	
// 	var conf = confirm('버스킹존 게시글을 삭제하시겠습니까?');
// 	if(!conf){
// 		return;
// 	}
	
// 	$.ajax({
// 		type: "GET",//url: "JSON/test.json",
// 		cache: false,
// 		url: '/service/buskingzone/buskingzone_del.jsp',
// 		data : {
// 			bz_no : bz_no
// 		},
// 		contentType: "application/xml; charset=utf-8",
// 		dataType: "xml",
// 		async : false,
// 		timeout: 30000
// 	});
	
// 	history.go(-1);
// });

// //길찾기 버튼 클릭시
// $(document).on('click', '.bdc_getdirection_btn', function(){
// 	var place = $('#bz_place').val();
// 	var x = $('#bz_x').val();
// 	var y = $('#bz_y').val();
// 	load_search(place, x, y);
// });

// //댓글 등록 버튼 클릭시
// $(document).on('click', '#bdc_re_insertbtn', function(){
// 	var login_chk = userLogin_chk();
// 	if(login_chk == false){
// 		infoTxtBox('로그인 후 댓글입력이 가능합니다.');
// 		return;
// 	}
	
// 	var bz_no = $('#bz_no').val();
// 	var bz_reply_content = $('#bdc_reply_content').val();
	
// 	if(bz_reply_content == ''){
// 		alert('댓글을 입력해주세요.');
// 		$('#bdc_reply_content').focus();
// 		return;
// 	}
	
// 	$.ajax({
// 		type: "GET",//url: "JSON/test.json",
// 		cache: false,
// 		url: '/service/buskingzone/buskingzone_reply_insert.jsp',
// 		data : {
// 			bz_no : bz_no,
// 			bz_reply_content : bz_reply_content
// 		},
// 		contentType: "application/xml; charset=utf-8",
// 		dataType: "xml",
// 		async : false,
// 		timeout: 30000
// 	});
	
// 	$('#bdc_reply_content').val('');
// 	getBuskingzoneReply(bz_no);
// });

// //댓글 삭제버튼 클릭시
// $(document).on('click', '.bdc_re_del_btn', function(){
// 	var conf = confirm('댓글을 삭제하시겠습니까 ?');
// 	if(!conf){
// 		return;
// 	}
	
// 	var bz_reply_no = $(this).parents('.bdc_re_container').attr('id');
	
// 	$.ajax({
// 		type: "GET",//url: "JSON/test.json",
// 		cache: false,
// 		url: '/service/buskingzone/buskingzone_reply_del.jsp',
// 		data : {
// 			bz_reply_no : bz_reply_no
// 		},
// 		contentType: "application/xml; charset=utf-8",
// 		dataType: "xml",
// 		async : false,
// 		timeout: 30000
// 	});
	
// 	var bz_no = $('#bz_no').val();
// 	getBuskingzoneReply(bz_no);
// });

// //답글달기 버튼 클릭시
// $(document).on('click', '.bdc_re_info_rebtn', function(){
// 	var bz_reply_no = $(this).parents('.bdc_re_container').attr('id');
// 	$('.bdc_re_re_body_' + bz_reply_no).show();
// });

// //답글 부분 등록버튼 클릭시
// $(document).on('click', '#bdc_re_re_input_btn', function(){
// 	var login_chk = userLogin_chk();
// 	if(login_chk == false){
// 		infoTxtBox('로그인 후 댓글입력이 가능합니다.');
// 		return;
// 	}
	
// 	var bz_no = $('#bz_no').val();
// 	var parent = $(this).parents('.bdc_re_container').attr('id');
// 	var bz_rereply_content = $(this).parents('.bdc_re_container').find('.bdc_re_re_input').val();
	
// 	if(bz_rereply_content == ''){
// 		alert('답글을 입력해주세요.');
// 		$('#bdc_reply_content').focus();
// 		return;
// 	}
	
// 	$.ajax({
// 		type: "GET",//url: "JSON/test.json",
// 		cache: false,
// 		url: '/service/buskingzone/buskingzone_rereply_insert.jsp',
// 		data : {
// 			bz_no : bz_no,
// 			parent : parent,
// 			bz_rereply_content : bz_rereply_content
// 		},
// 		contentType: "application/xml; charset=utf-8",
// 		dataType: "xml",
// 		async : false,
// 		timeout: 30000
// 	});
	
// 	$(this).parents('.bdc_re_container').find('.bdc_re_re_input').val('');
// 	getBuskingzoneReply(bz_no);
// });

// //답글 닫기버튼 클릭시
// $(document).on('click', '#bdc_rere_closebtn', function(){
// 	$(this).parents('.bdc_re_re_body').hide();
// });

