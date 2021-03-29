
$(document).on('pageinit', '#busking_store_update', function() {
    var thisPage = 'register_store_update';
    sessionStorage.setItem('thisPage', thisPage);
    
    var perform_no = sessionStorage.getItem('sl_perform_no');
    console.log('공연번호 있니? -> ' + perform_no);
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/detail_store/detail_store.jsp',
		data: {
			perform_no:perform_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i) {
                var USER_NO = $(this).find('USER_NO').text();
                var SPACE_PICTURE = $(this).find('SPACE_PICTURE').text();
                var STAGE_PICTURE = $(this).find('STAGE_PICTURE').text();
                var ADDRESS = $(this).find('ADDRESS').text();
                var DETAIL_ADDR = $(this).find('DETAIL_ADDR').text();
                var OPERATIONHOUR = $(this).find('OPERATIONHOUR').text();
                var EQUIPMENT = $(this).find('EQUIPMENT').text();
                var MAIN_GENRE = $(this).find('MAIN_GENRE').text();
                var GENRE = $(this).find('GENRE').text();
                var PARKING_CHK = $(this).find('PARKING_CHK').text();
                var PERFORM_TIPBOX = $(this).find('PERFORM_TIPBOX').text();
                var MOBILE_TIPBOX = $(this).find('MOBILE_TIPBOX').text();
                var VIDEO_CHK = $(this).find('VIDEO_CHK').text();
                var MENU = $(this).find('MENU').text();
                var HASHTAG = $(this).find('HASHTAG').text();
                var ZONE_INFO = $(this).find('ZONE_INFO').text();
               // var LICENSE_PICTURE = $(this).find('LICENSE_PICTURE').text();
                var BUSINESS_WORKNAME = $(this).find('BUSINESS_WORKNAME').text();
                var BUSINESS_PHONE = $(this).find('BUSINESS_PHONE').text();
                var BUSINESS_REPRESENTIVE = $(this).find('BUSINESS_REPRESENTIVE').text();
                var BUSINESS_NO = $(this).find('BUSINESS_NO').text();
                var BUSKINGDATE = $(this).find('BUSKINGDATE').text();
                var STARTINGTIME = $(this).find('STARTINGTIME').text();
                var FINISHINGTIME = $(this).find('FINISHINGTIME').text();
                var OFFERPRICE = $(this).find('OFFERPRICE').text();
                var PERFORM_NO = $(this).find('PERFORM_NO').text();
                var BUSKINGSTATUS = $(this).find('BUSKINGSTATUS').text();
                var ARTIST_MATCHING = $(this).find('ARTIST_MATCHING').text();
                if(ARTIST_MATCHING != ''){
                    $('#artist_matching').val('Y');
                }else{
                    $('#artist_matching').val('N');
                }
				$('#business_workname').val(BUSINESS_WORKNAME);
                $('#business_representive').val(BUSINESS_REPRESENTIVE);
                $('#business_no').val(BUSINESS_NO);
                $('#address').val(ADDRESS);
                $('#address_detail').val(DETAIL_ADDR);
                $('#business_phone').val(BUSINESS_PHONE);
                $('#zone_info').val(ZONE_INFO);
                $('#perform_no').val(PERFORM_NO);
                var OPERATIONHOUR_SE =  OPERATIONHOUR.split('~');
                var OPERATIONHOUR_S = OPERATIONHOUR_SE[0];
                var OPERATIONHOUR_E = OPERATIONHOUR_SE[1];
                var OPERATIONHOUR_S_hm = OPERATIONHOUR_S.split(':');
                console.log(OPERATIONHOUR_E);
                var OPERATIONHOUR_E_hm = OPERATIONHOUR_E.split(':');
                $('#open_hour').val(OPERATIONHOUR_S_hm[0]);
                $('#open_minute').val(OPERATIONHOUR_S_hm[1]);
                $('#close_hour').val(OPERATIONHOUR_E_hm[0]);
                $('#close_minute').val(OPERATIONHOUR_E_hm[1]);
                $('#store_money_input_price').val(OFFERPRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ' 원');
                var HASHTAG_ck = HASHTAG.split(',');
                for(var i = 0; i < HASHTAG_ck.length; i++){
                    arrayHashTag.push(HASHTAG_ck[i]);

                    var hashtag_html =  '<div class="hashtag_individual_set"><div class="hashtag_individual">' + HASHTAG_ck[i] + '</div>' +
                                        '<div class="hashtag_close" onclick="delete_hashtag(' + i + ')">' +
                                        '<img class="icon_exit_b" src="/img/reg_store/exit_2.svg">' +
                                        '</div></div>';
                     $('#area_hashtag').append(hashtag_html);
                }
                $('#equipment').text(EQUIPMENT);
                if(PARKING_CHK == 'Y'){
                    $('#parking_chk1').prop('checked', true);
                    $('#parking_chk2').prop('checked', false);

                }
                else{
                    $('#parking_chk2').prop('checked', true);
                    $('#parking_chk1').prop('checked', false);

                }
                if(VIDEO_CHK == 'Y'){
                    $('#video_chk1').prop('checked', true);
                    $('#video_chk2').prop('checked', false);

                }
                else{
                    $('#video_chk2').prop('checked', true);
                    $('#video_chk1').prop('checked', false);

                }
                if(PERFORM_TIPBOX == 'Y'){
                    $('#tipbox_chk1').prop('checked', true);
                }
                else{
                    $('#tipbox_chk1').prop('checked', false);
                }
                if(MOBILE_TIPBOX == 'Y'){
                    $('#tipbox_chk2').prop('checked', true);
                }
                else{
                    $('#tipbox_chk2').prop('checked', false);
                }
                var GENRE_ck = GENRE.replace(', *',',');
                $('#text_genre').val( GENRE_ck)
                if(MAIN_GENRE != ''){
                    $('#main_genre').val(MAIN_GENRE) 
                }
                //console.log(BUSKINGDATE + " / " + STARTINGTIME + " / " + FINISHINGTIME);
                var BUSKINGDATE_ck = BUSKINGDATE.split('-');
                var STARTINGTIME_ck = STARTINGTIME.split(':');
                var FINISHINGTIME_ck =  FINISHINGTIME.split(':');
                
                if(SPACE_PICTURE != ''){
                    var sp_picture_array = SPACE_PICTURE.split(',');
                    var sp_img = '';
                    var sp_img_html = '';
                    var sp_img_selecter = '';
                    var sp_cnt = 1;
                        
                    for(var a = 0; a < sp_picture_array.length; a++){
                        var new_img = 'upload/store/space/space' + USER_NO + "/" + sp_picture_array[a];
                        
                        var imgSrc = getImagePromise(new_img).then(value => {
                            
                            if($('#bi-main_sp'+(sp_cnt)).attr('src') == '/img/test/noimage.gif'){
                                $('#bi-main_sp'+(sp_cnt)).attr('src',value);
                                //console.log("count-->" + a)
                            }
                            else{
                                sp_cnt =  sp_cnt + 1;
                                $('#bi-main_sp'+(sp_cnt)).attr('src',value);
                                //console.log("count-->" + a)
                            }
                            
                            
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
                               
                            });
                        });
                        
                        $('#fname_sp'+ (a + 1)).val(sp_picture_array[a])
                        $('#bi-main_sp'+(a + 1)).show();
                        $('div[name=sp_'+(a + 1)+']').show();
                    }
                    $('#upload_img_amount_sp').text(sp_picture_array.length)
                    f_sp_cont = sp_picture_array.length;
                }
                	
                if(STAGE_PICTURE != ''){
                    var st_pictur_array = STAGE_PICTURE.split(',');
                    var st_img = '';
                    var st_img_html = '';
                    var st_img_selecter = '';
                    var st_cnt = 1;
                        
                    for(var i = 0; i < st_pictur_array.length; i++){
                        var new_img = 'upload/store/stage/stage' + USER_NO + "/" + st_pictur_array[i];
                        
                        var imgSrc = getImagePromise(new_img).then(value => {
                            if($('#bi-main_st'+(st_cnt)).attr('src') == '/img/test/noimage.gif'){
                                $('#bi-main_st'+(st_cnt)).attr('src',value);
                            }
                            else{
                                st_cnt = st_cnt + 1;
                                $('#bi-main_st'+(st_cnt)).attr('src',value);
                            }
                            
                            var bdc_carousel;
                            bdc_carousel = $("#bdc_pfsc_ing_ul_st");
                            bdc_carousel.itemslide(
                                {
                                    left_sided: true,
                                    disable_clicktoslide: true
                                }
                            );
                            
                            bdc_carousel.on('changePos', function(e){
                                var ai = bdc_carousel.getActiveIndex() + 1;
                            });
                        });
                        $('#fname_st'+(i+1)).val(st_pictur_array[i])
                        $('#bi-main_st'+(i + 1)).show();
                        $('div[name=st_'+(i + 1)+']').show();
                    }
                    $('#upload_img_amount_st').text(st_pictur_array.length)
                    f_st_cont = st_pictur_array.length;					
                }
                if(MENU != ''){
                    var new_img = 'upload/store/menu/menu' + USER_NO + "/" + MENU;
                    
                    var imgSrc = getImagePromise(new_img).then(value => {
                        $('#bi-main_me1').attr('src',value);
                        $('#fname_me1').val(MENU)
                        $('#upload_img_amount_me').text(1)
                        f_me_cont = 1;
                    });
                    $('#bi-main_me1').css("visibility", "visible");
                    $('div[name=me_1]').show();
                }

                var selectDateTemp_cal = sessionStorage.getItem('selectDateTemp_cal');
                // console.log("s : " + selectDateTemp_cal + "->" + typeof (selectDateTemp_cal));
            
                if (selectDateTemp_cal == null || selectDateTemp_cal == '') {
                    // $("#re_perfom_date").attr("value", "");
                    // $("#start_time_input_hour").attr("value", "");
                    // $("#start_time_input_min").attr("value", "");
                    // $("#end_time_input_hour").attr("value", "");
                    // $("#end_time_input_min").attr("value", "");
                    // $('#re_perfom_date').val(BUSKINGDATE_ck[0] + "년 "+ BUSKINGDATE_ck[1] + "월 "+BUSKINGDATE_ck[2] + "일");
                    $('#re_perfom_date').val(BUSKINGDATE.substring(2));
                    $('#re_perfom_date_se').val(BUSKINGDATE);
                    $('#start_time_input_hour').val(STARTINGTIME_ck[0])
                    $('#start_time_input_min').val(STARTINGTIME_ck[1])
                    $('#end_time_input_hour').val(FINISHINGTIME_ck[0])
                    $('#end_time_input_min').val(FINISHINGTIME_ck[1])
                } else {
                    selectDateTemp_cal = selectDateTemp_cal.split(',');
                    console.log("session 날짜 : " + selectDateTemp_cal[0]);
                    console.log("session 공연시작/종료 : " + selectDateTemp_cal[1]);
            
                    var date = selectDateTemp_cal[0];
                    
                    date = date.split('-');
                    if(date[1].length == 1){
                        date[1] = '0'+date[1];
                    }
                    if(date[2].length == 1){
                        date[2] = '0'+date[2];
                    }
                    // var year = date[0];
                    // var month = date[1];
                    // var day = date[2];
            
                    // $("#re_perfom_date").attr("value", year + "년 " + month + "월 " + day + "일");
                    var date_ck = date[0] +'-'+date[1]+'-'+date[2];
                    date = date_ck.substring(2);
                    $("#re_perfom_date").attr("value",date);
                    $('#re_perfom_date_se').val(date_ck);
                    var time = selectDateTemp_cal[1];
                    time = time.split("/");
            
                    var sTime = time[0];
                    var eTime = time[1];
            
                    sTime = sTime.split(":");
                    var sHour = sTime[0];
                    var sMin = sTime[1];
            
                    eTime = eTime.split(":");
                    var eHour = eTime[0];
                    var eMin = eTime[1];
            
                    $("#start_time_input_hour").attr("value", sHour);
                    $("#start_time_input_min").attr("value", sMin);
            
                    $("#end_time_input_hour").attr("value", eHour);
                    $("#end_time_input_min").attr("value", eMin);
                    // $('#re_perfom_date_se').attr("value", year + "년 " + month + "월 " + day + "일");
                    $('#start_time_input_hour_se').attr("value", sHour);
                    $('#start_time_input_min_se').attr("value", sMin);
                    $('#end_time_input_hour_se').attr("value", eHour);
                    $('#end_time_input_min_se').attr("value", eMin);
                }
                var ARTIST_MATCHING_ck = ARTIST_MATCHING.split(',');
                var ARTIST_MATCHING_ONE = new Array();
                var ARTIST_MATCHING_TWO = new Array();
                var ARTIST_MATCHING_THREE = new Array();
                var ARTIST_MATCHING_FOUR = new Array();
                for (var a = 0; a < ARTIST_MATCHING_ck.length; a++) {
                    var ARTIST_ck = ARTIST_MATCHING_ck[a].split('/');
                    if (ARTIST_ck[1] == 1) {
                        ARTIST_MATCHING_ONE[a] = ARTIST_ck[0];
                    }
                    else if (ARTIST_ck[1] == 2) {
                        ARTIST_MATCHING_TWO[a] = ARTIST_ck[0];
                    }
                    else if (ARTIST_ck[1] == 3) {
                        ARTIST_MATCHING_THREE[a] = ARTIST_ck[0];
                    }
                    else if (ARTIST_ck[1] == 4) {
                        ARTIST_MATCHING_FOUR[a] = ARTIST_ck[0];
                    }
                }
                ARTIST_MATCHING_ONE = ARTIST_MATCHING_ONE.filter(function (item) {
                    return item !== null && item !== undefined && item !== '';
                });

                ARTIST_MATCHING_TWO = ARTIST_MATCHING_TWO.filter(function (item) {
                    return item !== null && item !== undefined && item !== '';
                });

                ARTIST_MATCHING_THREE = ARTIST_MATCHING_THREE.filter(function (item) {
                    return item !== null && item !== undefined && item !== '';
                });

                ARTIST_MATCHING_FOUR = ARTIST_MATCHING_FOUR.filter(function (item) {
                    return item !== null && item !== undefined && item !== '';
                });
                console.log("아티스트 매칭상황 1 ->" + ARTIST_MATCHING_ONE);
                console.log("아티스트 매칭상황 2 ->" + ARTIST_MATCHING_TWO);
                console.log("아티스트 매칭상황 3 ->" + ARTIST_MATCHING_THREE);
                console.log("아티스트 매칭상황 4 ->" + ARTIST_MATCHING_FOUR);
               
                console.log(" BUSKINGSTATUS?->" + BUSKINGSTATUS);
                var button_html;
                if(BUSKINGSTATUS == '3'){
                    button_html = '<div class="button_registration_a">삭제 하기</div>'+
                                  '<div class="button_registration_b">수정 완료</div>';
                }
                else if(BUSKINGSTATUS == '1'){
                    button_html = '<div class="button_registration_c">모집 완료</div>';
                }
                else if(BUSKINGSTATUS == '5'){
                    if(ARTIST_MATCHING_THREE ==''){
                        button_html = '<div class="button_registration_a">삭제 하기</div>'+
                        '<div class="button_registration_b">수정 완료</div>';
                    }
                    else{
                        button_html = '<div class="button_registration_c">공연 완료</div>';
                        
                    }
                }

                $('.button_registrations').append(button_html);
        
                
                
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			console.log(xhr);
			console.log(message);
			console.log(errorThrown);
		} // end error
	});
});

$(document).on('keyup', 'input[inputmode=numeric_a]', function (event) {
    //this.value = this.value.replace(/[^0-9]/g, '');   // 입력값이 숫자가 아니면 공백
    //this.value = this.value.replace(/,/g, '');          // ,값 공백처리
    //this.value = this.value.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,"); // 정규식을 이용해서 3자리 마다 , 추가 
    if(this.value == ''){
        $('.money_input_text_cancel').hide();
    }
    else{
        $('.money_input_text_cancel').show();
    }	
});
$(document).on('keydown', 'input[inputmode=numeric_a]', function (event) {
     
    var key = event.charCode || event.keyCode || 0;
    $text = $(this);
    return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
       
    
});
var team_total_price = '';

// function numchk(num){
//     num=new String(num);
//     num=num.replace(/,/gi,"");
//     if(num == ''){
//         $('.money_input_text_cancel').hide();
//     }
//     else{
//         $('.money_input_text_cancel').show();
//     }
//     return numchk1(num);
// }
// function numchk1(num){
//     var sign="";
//     if(isNaN(num)) {
//         alert("숫자만 입력할 수 있습니다.");
//         return'';
//     }
//     if(num==0) {
//         return num;
//     }

//     if(num<0){
//         num=num*(-1);
//         sign="-";
//     }
//     else{
//         num=num*1;
//     }
//     num = new String(num)
//     var temp="";
//     var pos=3;
//     num_len=num.length;
//     while (num_len>0){
//         num_len=num_len-pos;
//         if(num_len<0) {
//             pos=num_len+pos;
//             num_len=0;
//         }
//         temp=","+num.substr(num_len,pos)+temp;
//     }
    
//     return sign+temp.substr(1);	
// }
// 금액 입력 이벤트
//$(document).on('change', '#money_input_price', function (e) {
    // team_total_price = $('#money_input_price').val()
    // team_total_price = this.value.replace(/,/g, '');
    // if(this.value == ''){
    //     $('.money_input_text_cancel').hide();
    //    }
    //    else{
    //        var val_ck = this.value;
    //        console.log(val_ck);
    //        val_ck = val_ck + ' 원';
    //        this.value = val_ck;
    //    }
    // console.log("team_total_price 세션 : " + team_total_price);

    // sessionStorage.setItem('team_total_price', team_total_price);

    // var team_total_price = sessionStorage.getItem('team_total_price');
    // console.log("team_total_price test 세션 : " + team_total_price);
//});
$(document).on('focus', '#store_money_input_price', function(e){
    this.value = this.value.replace(' 원', '');
    this.value = this.value.replace(/,/g, '');
    // $('#store_money_input_price').prop('type','number');
});
$(document).on('focusout', '#store_money_input_price', function(e){
    if(this.value == ''){
        $('.money_input_text_cancel').hide();
       }else{
            // $('#store_money_input_price').prop('type','text');
           this.value = this.value.replace(/,/g, '');
           this.value = this.value.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
           var val_ck = this.value;
           console.log(val_ck);
           val_ck = val_ck + ' 원';
           this.value = val_ck;
       }
});
$(document).on('click', '.money_input_text_cancel', function(){
    $('.money_input_text_cancel').hide();
    document.getElementById("store_money_input_price").value = '';
    $('#store_money_input_price').focus();
});

$(document).on('click', '#busking_store_a_button', function(){	
    if($(this).attr('name') == 'plus'){
        $(this).css({'background':'url("/img/reg_store_update/reg_update_minus.svg")'});
        $(this).css({'background-size':'cover'});
        $(this).attr('name','minus');
        $('.busking_store_a').show()
    }
    else{
        $(this).css({'background':'url("/img/reg_store_update/reg_update_plus.svg")'});
        $(this).css({'background-size':'cover'});
        $(this).attr('name','plus');
        $('.busking_store_a').hide()
    }
    for(var a = 1; a <= 3; a++){
        var bdc_carousel;
        if(a == 1){
            bdc_carousel = $("#bdc_pfsc_ing_ul");
        }
        else if(a == 2){
            bdc_carousel = $("#bdc_pfsc_ing_ul_st");
        }
        else if(a == 3){
            bdc_carousel = $("#bdc_pfsc_ing_ul_me");
        }
    
        bdc_carousel.itemslide(
            {
                left_sided: true,
                disable_clicktoslide: true
            }
        );
    }
    bdc_carousel.on('changePos', function (_e) {
        var ai = bdc_carousel.getActiveIndex() + 1;
    
    }).promise().done(function (){
    
        var bdc_carousel;
        
        $(document).ready(function () {
            for(var a = 1; a <= 3; a++){
                var bdc_carousel;
                if(a == 1){
                    bdc_carousel = $("#bdc_pfsc_ing_ul");
                }
                else if(a == 2){
                    bdc_carousel = $("#bdc_pfsc_ing_ul_st");
                }
                else if(a == 3){
                    bdc_carousel = $("#bdc_pfsc_ing_ul_me");
                }
                bdc_carousel.itemslide(
                    {
                        left_sided: true,
                        disable_clicktoslide: true
                    }
                );
            }
            bdc_carousel.on('changePos', function(_e){
                var ai = bdc_carousel.getActiveIndex() + 1;
                
                //$('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
                //$('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
            });
        });
        
    });
	
});

$(document).on('click', '#busking_store_b_button', function(){	
    if($(this).attr('name') == 'plus'){
        $(this).css({'background':'url("/img/reg_store_update/reg_update_minus.svg")'});
        $(this).css({'background-size':'cover'});
        $(this).attr('name','minus');
        $('.busking_store_b').show()
    }
    else{
        $(this).css({'background':'url("/img/reg_store_update/reg_update_plus.svg")'});
        $(this).css({'background-size':'cover'});
        $(this).attr('name','plus');
        $('.busking_store_b').hide()
    }
   
	
});

$(document).on('click', '#busking_store_c_button', function(){	
    if($(this).attr('name') == 'plus'){
        $(this).css({'background':'url("/img/reg_store_update/reg_update_minus.svg")'});
        $(this).css({'background-size':'cover'});
        $(this).attr('name','minus');
        $('.busking_store_c').show()
        var thisPage = 'register_store_update';
        sessionStorage.setItem('thisPage', thisPage);
    }
    else{
        $(this).css({'background':'url("/img/reg_store_update/reg_update_plus.svg")'});
        $(this).css({'background-size':'cover'});
        $(this).attr('name','plus');
        $('.busking_store_c').hide()
    }	
});


// function viewDateSelectBox(){
// 	$('#busking_time_each_popup').load('/app_root/jsp/busking_time/busking_time_calendar_pick.jsp', function(){
// 		$('#busking_time_each_popup').show();
		
// 		$('#header').hide();
// 		$('#footer').hide();
		
	
// 	});
// }
$(document).on('click', '.button_registration_a', function() {
    var perform_no = $('#perform_no').val();
    var artist_matching = $('#artist_matching').val();
    var re_perfom_date_ck = $('#re_perfom_date').val()
    var re_perfom_date = re_perfom_date_ck.split('-');
    var date = re_perfom_date[1] + "월 " + re_perfom_date[2] + "일";
    var start_time_input_hour = $('#start_time_input_hour').val()
    var start_time_input_min = $('#start_time_input_min').val()
    var end_time_input_hour = $('#end_time_input_hour').val()
    var end_time_input_min = $('#end_time_input_min').val()
    var time = start_time_input_hour + ':' + start_time_input_min + '-' +  end_time_input_hour + ':' + end_time_input_min;
    let delete_msg = confirm(date + " " + time + " 공연이 삭제됩니다 정말 삭제하시겠습니까?");
    if(delete_msg){
        $.ajax({
            type: "POST",//url: "JSON/test.json",
            cache: false,
            url: '/service/reg_store/store_delete.jsp',
    
            data : {
                perform_no:perform_no,
                artist_matching:artist_matching
            },
            dataType: "xml",
            // async: false,
            timeout: 30000,
            beforeSend: function(){
                $.mobile.loading( 'show', { text: '삭제중입니다.', textVisible: true, theme: 'b', html: "" });
            },
            success: function (data) {
                var ROOT = $(data).find("ROOT");
                var DATA = $(ROOT).find('DATA');
                $(DATA).each(function(){
                    var RESULT = $(this).find('RESULT').text();
                    var MSG = $(this).find('MESSAGE').text();
                    
                    if(RESULT == 'true' || RESULT == 'TRUE'){
                        alert(MSG);
                        go_complete_reg_store_delete();
                    } else {
                        alert(MSG);
                        return;
                    }
                });
            }, // end success
            error: function (_xhr, _message, _errorThrown) {
                alert('잠시후 다시 시도해주세요.');
                console.log(_xhr);
                console.log(_message);
                console.log(_errorThrown);
                return;
                //hideLoading();
            }, // end error
            complete: function(){
                $.mobile.loading( 'hide', { text: '삭제중입니다.', textVisible: true, theme: 'b', html: "" });
                
                // sessionStorage.setItem('aname', $('#artist_name').val())
                // sessionStorage.setItem('acontent', $('#artist_intro').val());
                // setAimgCallback2(imgsrc);
                // go_team_create();
                //loadPage('reg_store/complete_reg_store.jsp');
            }
        });
    }else{
        return;
    }
});
$(document).on('click', '.button_registration_b', function() {
    // jsp 내 필드값 불러오기
    // 특수문자 제거
    var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi
    var perform_no = $('#perform_no').val();
    var user_ck = $('#user_no').val();
	var business_workname = $('#business_workname').val();
	var business_representive = $('#business_representive').val();
	var business_no = $('#business_no').val();
    var address = $('#address').val();
    var detail_addr = $('#address_detail').val();
    var business_phone = $('#business_phone').val();
    var open_hour = $('#open_hour').val();
    var open_minute = $('#open_minute').val();
    var close_hour = $('#close_hour').val();
    var close_minute = $('#close_minute').val();
    var operationhour = open_hour + ':' + open_minute + '~' + close_hour + ':' + close_minute;
    var equipment = $('#equipment').val();
    var text_genre_ck = $('#text_genre').val();
    var genre = text_genre_ck.replace(',*',', ');
    var main_genre = $('#main_genre').val();
    var zone_info = $('#zone_info').val();
    var parking_chk = "";
    var perform_tipbox = "";
    var mobile_tipbox = "";
    var video_chk = "";
    var space_picture = "";
    var stage_picture = "";
    var menu = "";
    let emptyChk = '';
    // 공연 모집 정보
    // var buskingdate_ck = $('#re_perfom_date').val().replace('년 ','-').replace('월 ','-').replace('일','');
    // var buskingdate_sp = buskingdate_ck.split('-');
    // if(buskingdate_sp[1].length == 1){
    //     buskingdate_sp[1] = '0'+buskingdate_sp[1];
    // }
    // if(buskingdate_sp[2].length == 1){
    //     buskingdate_sp[2] = '0'+buskingdate_sp[2];
    // }
    // var buskingdate = buskingdate_sp[0] + '-' + buskingdate_sp[1] + '-' + buskingdate_sp[2];
    var buskingdate = $('#re_perfom_date_se').val();
    // 요일
    var week = ['일', '월', '화', '수', '목', '금', '토'];
    var dayOfWeek = week[new Date(buskingdate).getDay()];
    var startingtime_h = $('#start_time_input_hour').val();
    var startingtime_m = $('#start_time_input_min').val();
    var finishingtime_h = $('#end_time_input_hour').val();
    var finishingtime_m = $('#end_time_input_min').val();
    var startingtime = startingtime_h + ':' + startingtime_m;
    var finishingtime = finishingtime_h + ':' + finishingtime_m;
    var offerprice = $('#store_money_input_price').val().replace(regExp,'').replace(' 원','');
                
    for(var i = 1; i < 11; i++){
        emptyChk = $('#fname_sp'+i).val();
        if(emptyChk === undefined || emptyChk === 'undefined' || emptyChk === ''){
        } else {
            if(i == 1){
                space_picture = emptyChk;
            } else {
                space_picture = space_picture + ',' + emptyChk;
            }
        }
    }
    for(var i = 1; i < 11; i++){
        emptyChk = $('#fname_st'+i).val();
        if(emptyChk === undefined || emptyChk === 'undefined' || emptyChk === ''){
        } else {
            if(i == 1){
                stage_picture = emptyChk;
            } else {
                stage_picture = stage_picture + ',' + emptyChk;
            }
        }
    }
    for(var i = 1; i < 11; i++){
        emptyChk = $('#fname_me'+i).val();
        if(emptyChk === undefined || emptyChk === 'undefined' || emptyChk === ''){
        } else {
            if(i == 1){
                menu = emptyChk;
            } else {
                menu = menu + ',' + emptyChk;
            }
        }
    }
	

    if($('#parking_chk1').is(":checked") == true){
        parking_chk = "Y";
    }else{
        parking_chk = "N";
    }
    if($('#video_chk1').is(":checked") == true){
        video_chk = "Y";
    }else{
        video_chk = "N";
    }
    if($('#tipbox_chk1').is(":checked") == true){
        perform_tipbox = "Y";
    }
    else{
        perform_tipbox = "";
    }
    if($('#tipbox_chk2').is(":checked") == true){
        mobile_tipbox = "Y";
    }
    else{
        mobile_tipbox = "";
    }
    // hashtag(배열)
    var hashtag = "";   
    var hashtag_ck = $('[class=hashtag_individual]').text();
    var hashtag_split = hashtag_ck.split('#');
    for(i = 1; i < hashtag_split.length; i++){
        if(i == 0){
            hashtag = "#"+hashtag_split[i]+',';
        }
        else if(i == hashtag_split.length - 1){
            hashtag  = hashtag +"#"+hashtag_split[i];
        }
        else{
            hashtag = hashtag+"#"+hashtag_split[i]+',';
        }
    }
    
    // if(wordchk1(business_workname) == 'N'){
    //     $('#business_workname').focus();
    //     return;
    // }
    // else{
    //     if(wordchk2(business_workname) == 'N'){
    //         $('#business_workname').focus();
    //         return;
    //     }
    // }
    // if(wordchk1(business_representive) == 'N'){
    //     $('#business_representive').focus();
    //     return;
    // }
    // else{
    //     if(wordchk2(business_representive) == 'N'){
    //         $('#business_representive').focus();
    //         return;
    //     }
    // }
    // if(wordchk1(address) == 'N'){
    //     $('#address').focus();
    //     return;
    // }
    // else{
    //     if(wordchk2(address) == 'N'){
    //         $('#address').focus();
    //         return;
    //     }
    // }
    // if(wordchk1(detail_addr) == 'N'){
    //     $('#address_detail').focus();
    //     return;
    // }
    // else{
    //     if(wordchk2(detail_addr) == 'N'){
    //         $('#address_detail').focus();
    //         return;
    //     }
    // }
    // if(wordchk1(equipment) == 'N'){
    //     $('#equipment').focus();
    //     return;
    // }
    // else{
    //     if(wordchk2(equipment) == 'N'){
    //         $('#equipment').focus();
    //         return;
    //     }
    // }
    // if(wordchk1(zone_info) == 'N'){
    //     $('#zone_info').focus();
    //     return;
    // }
    // else{
    //     if(wordchk2(zone_info) == 'N'){
    //         $('#zone_info').focus();
    //         return;
    //     }
    // }
    // img(business_다중 사진)
    // var business_license = $('#business_license').attr('src');
    // var space_picture = $('#space_picture').attr('src');
    // var stage_picture = $('#stagee_picture').attr('src');
    // var imgsrc = $('#menu').attr('src');
    var regPhone = /(01[0|1|6|9|7])[-](\d{3}|\d{4})[-](\d{4}$)/g;
    var regbusiness_no = /(\d{3})[-](\d{2})[-](\d{5}$)/g;
    var tionhour_ck = /(\d{2})/;
    var money_ck = /[^0-9]$/;


    if(money_ck.test(offerprice)){
        alert('잘못된 금액입니다.');
		$('#store_money_input_price').focus();
		return;
    }

	if(business_workname == ''){
        alert('상호명을 입력해주세요.');
		$('#business_workname').focus();
		return;
	}else if(business_representive == ''){
		alert('대표자명을 입력해주세요.');
		$('#business_representive').focus();
		return;
	}else if(business_no == ''){
		alert('사업자번호를 입력해주세요.');
		$('#business_no').focus();
		return;
	}else if(address == ''){
		alert('주소를 입력해주세요.');
		$('#address').focus();
		return;
	} else if(business_phone == ''){
		alert('연락처를 입력해주세요.');
		$('#business_phone').focus();
		return;
	} else if(open_hour == '' && open_minute == '' && close_hour == '' && close_minute == ''){
		alert('영업시간을 등록해주세요.');
		$('#open_hour').focus();
		return;
	}else if(equipment == ''){
		alert('지원장비를 입력해주세요.');
		$('#equipment').focus();
		return;
	}else if(zone_info == ''){
        alert('공간 소개를 입력해주세요.');
		$('#zone_info').focus();
		return;
    }else if(buskingdate == ''){
        alert('공연날짜를 입력해주세요.');
		return;
    }else if(startingtime_h == ''){
        alert('공연시간을 입력해주세요.');
		return;
    }else if(startingtime_m == ''){
        alert('공연시간을 입력해주세요.');
		return;
    }else if(finishingtime_h == ''){
        alert('공연시간을 입력해주세요.');
		return;
    }else if(finishingtime_m == ''){
        alert('공연시간을 입력해주세요.');
		return;
    }else if(offerprice == ''){
        alert('공연비를 입력해주세요.');
		$('#store_money_input_price').focus();
		return;
    }

    if(!tionhour_ck.test(open_hour)){
        alert('잘못된 영업시간입니다');
        $('#open_hour').focus();
        return;
    }
    if(!tionhour_ck.test(open_minute)){
        alert('잘못된 영업시간입니다');
        $('#open_minute').focus();
        return;
    }
    if(!tionhour_ck.test(close_hour)){
        alert('잘못된 영업시간입니다');
        $('#close_hour').focus();
        return;
    }
    if(!tionhour_ck.test(close_minute)){
        alert('잘못된 영업시간입니다');
        $('#close_minute').focus();
        return;
    }
    if(Number(open_hour) > 24 && Number(close_hour) > 24){
        alert('잘못된 영업시간입니다');
        return;
    }
    if( Number(open_minute) > 59 && Number(close_minute) > 59){
        alert('잘못된 영업시간입니다');
        return;
    }
    

  	if(!regPhone.test(business_phone)){
        alert('잘못된 유형의 연락처입니다');
        $('#business_phone').focus();
        return;
    }

    if(!regbusiness_no.test(business_no)){
        alert('잘못된 유형의 사업자번호입니다');
        $('#artist_intro').focus();
        return;
    }
    if ($('#fname_sp1').val() == '') {
        alert('대표사진을 등록해주세요.');
        return;
    }

    if ($('#fname_st1').val() == '') {
        alert('무대사진을 등록해주세요.');
        return;
    }
    
    $.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/store_name_chk.jsp',
		data: {
			business_workname: business_workname
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		//async: false,
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
            var USER_NO = $(DATA).find('USER_NO').text();
			if(DATA.length != 0){
                if(user_ck != USER_NO){
                    alert('중복된 상호명입니다. 다시 입력해주세요.');
                    $('#business_workname').val('');
                    $('#business_workname').focus();
                    return;
                }
			}
    //AJAX 로딩 표시
                    $.ajax({
                        type: "POST",//url: "JSON/test.json",
                        cache: false,
                        url: '/service/reg_store/store_update.jsp',
                        data : data,
                        data : {
                                business_workname:business_workname,
                                business_representive:business_representive,
                                business_no:business_no,
                                address:address,
                                detail_addr:detail_addr,
                                business_phone:business_phone,
                                operationhour:operationhour,
                                equipment:equipment,
                                hashtag:hashtag,
                                genre:genre,
                                main_genre:main_genre,
                                space_picture:space_picture,
                                stage_picture:stage_picture,
                                menu:menu,
                                zone_info:zone_info,
                                parking_chk:parking_chk,
                                mobile_tipbox:mobile_tipbox,
                                perform_tipbox:perform_tipbox,
                                video_chk:video_chk,
                                perform_no:perform_no,
                                buskingdate:buskingdate,
                                dayOfWeek:dayOfWeek,
                                startingtime:startingtime,
                                finishingtime:finishingtime,
                                offerprice:offerprice

                        },
                        dataType: "xml",
                        // async: false,
                        timeout: 30000,
                        beforeSend: function(){
                            $.mobile.loading( 'show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
                        },
                        success: function (data) {
                            var ROOT = $(data).find("ROOT");
                            var DATA = $(ROOT).find('DATA');
                            $(DATA).each(function(){
                                var RESULT = $(this).find('RESULT').text();
                                var MSG = $(this).find('MESSAGE').text();
                                
                                if(RESULT == 'true' || RESULT == 'TRUE'){
                                    alert(MSG);
                                    go_complete_reg_store_update();
                                } else {
                                    alert(MSG);
                                    return;
                                }
                            });
                        }, // end success
                        error: function (_xhr, _message, _errorThrown) {
                            alert('잠시후 다시 시도해주세요.');
                            console.log(_xhr);
                            console.log(_message);
                            console.log(_errorThrown);
                            return;
                            //hideLoading();
                        }, // end error
                        complete: function(){
                            $.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
                            
                            // sessionStorage.setItem('aname', $('#artist_name').val())
                            // sessionStorage.setItem('acontent', $('#artist_intro').val());
                            // setAimgCallback2(imgsrc);
                            // go_team_create();
                            //loadPage('reg_store/complete_reg_store.jsp');
                        }
                    });
                            
                
            }
        });     
    });