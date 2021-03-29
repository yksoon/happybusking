////////////////////////////////////////// 상업공간등록 관련된 js///////////////////////////////////////////////

// 넘어가야 할 페이지 영역
function go_reg_store() {
    loadPage('reg_store/promotion.jsp');
}
function go_form_reg_store() {
    if (userLogin_chk() == false) {
        infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
        loadPage('login/login.jsp');
    } else {
        if (owner_chk() == true) {
            infoTxtBox('이미 상업공간을 등록했습니다.');

            // 2021.02.18 추가
            loadPage('busking_time/store_list.jsp');
            return;
        }

        //로그인 시 상업공간 등록 들어갈 수 있도록 함
        loadPage('reg_store/register_store.jsp');

    }

}
var f_url_ck = "";

// 등록 이미지 등록 미리보기
// function readInputFile(input) {
//     if(input.files && input.files[0]) {
//         var reader = new FileReader();
//         reader.onload = function (e) {
//             $('#bi-main').attr('src', e.target.result);;
//         }
//         reader.readAsDataURL(input.files[0]);
//     }
// }
var selFile = document.querySelector('#business_license');



var license_image = "";
//사업자등록증사진 첨부 버튼 클릭시
$(document).on('click', '#brc_main_image_btn_div', function () {
    $('#business_license').click();
});
var license_blob = "";
//var formData = new FormData();
$(document).on('change', '#business_license', function () {
    if ($(this).val() === '') return;
    //readInputFile(this);
    var fileList = this.files;

    var reader = new FileReader();
    reader.readAsDataURL(fileList[0]);

    reader.onload = function () {
        document.querySelector('#bi-main').src = reader.result;

        //썸네일이미지 생성
        var tempImage = new Image(); //drawImage 메서드에 넣기 위해 이미지 객체화
        tempImage.src = reader.result; //data-uri를 이미지 객체에 주입
        tempImage.onload = function () {
            //리사이즈를 위해 캔버스 객체 생성
            var canvas = document.createElement('canvas');
            var canvasContext = canvas.getContext("2d");

            //캔버스 크기 설정
            canvas.width = 100; //가로 100px
            canvas.height = 100; //세로 100px

            //이미지를 캔버스에 그리기
            canvasContext.drawImage(this, 0, 0, 100, 100);
            //캔버스에 그린 이미지를 다시 data-uri 형태로 변환
            var data = canvas.toDataURL("image/png");
            license_image = data;

            // var block = test_image.split(';');
            // var contentType = block[0].split(':')[1];
            // var realData = block[1].split(',')[1];
            // license_blob = base64ToBlob(realData, contentType);
            //formData.append('uploadfile', blob);
            //formData.append('imgType', contentType);
            console.log(license_image);

            //썸네일 이미지 보여주기
            //document.querySelector('#bi-main').src = dataURI;

            //썸네일 이미지를 다운로드할 수 있도록 링크 설정
            //document.querySelector('#download').href = dataURI;
        };
    };
});


// var base64ToBlob = function(base64Data, contentType, sliceSize) {
//     contentType = contentType || '';
//     sliceSize = sliceSize || 512;

//     var byteCharacters = atob(base64Data);
//     var byteArrays = [];

//     for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
//         var slice = byteCharacters.slice(offset, offset + sliceSize);

//         var byteNumbers = new Array(slice.length);
//         for (var i = 0; i < slice.length; i++) {
//             byteNumbers[i] = slice.charCodeAt(i);
//         }

//         var byteArray = new Uint8Array(byteNumbers);
//         byteArrays.push(byteArray);
//     }

//     var blob = new Blob(byteArrays, { type: contentType });

//     return blob;
// }


// 이미지의 Blob를 폼 데이터 객체에 추가
//formData.append('uploadfile', blob);
//공간사진 첨부 버튼 클릭시
let f_st_cont = $('#upload_img_amount_st').text();
let f_me_cont = $('#upload_img_amount_me').text();
let f_sp_cont = $('#upload_img_amount_sp').text();


var sp_num = "";
var st_num = "";
var me_num = "";
$(document).on('click', '#brc_space_image_btn_div', function () {
    f_url_ck = 'sp';
    if ($('#upload_img_amount_sp').text() == '0') {
        f_sp_cont = 0;
    }
    if (f_sp_cont > $('#upload_img_amount_sp').text()) {
    }
    else {
        f_sp_cont = f_sp_cont + 1;
    }
    if (f_sp_cont >= 11) {
        alert('10장을 모두 등록하셨습니다.');
        return;
    }


    for (var i = 1; i < 11; i++) {

        if ($('#bi-main_sp' + i).attr('src') == '/img/test/noimage.gif') {

            var sp_numck = $('#bi-main_sp' + i).attr('id').split('p');
            sp_num = sp_numck[1];
            $('#space_picture').trigger('click');
            break;
        }

    }
    for (var a = 1; a <= 3; a++) {
        var bdc_carousel;
        if (a == 1) {
            bdc_carousel = $("#bdc_pfsc_ing_ul");
        }
        else if (a == 2) {
            bdc_carousel = $("#bdc_pfsc_ing_ul_st");
        }
        else if (a == 3) {
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

    }).promise().done(function () {

        var bdc_carousel;

        $(document).ready(function () {
            for (var a = 1; a <= 3; a++) {

                if (a == 1) {
                    bdc_carousel = $("#bdc_pfsc_ing_ul");
                }
                else if (a == 2) {
                    bdc_carousel = $("#bdc_pfsc_ing_ul_st");
                }
                else if (a == 3) {
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

                //$('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
                //$('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
            });
        });

    });

});
$(document).on('change', '#space_picture', function () {
    if ($(this).val() === '') return;
    $('#upload_img_amount_sp').text(f_sp_cont);
    readURL(this, 6, 4);
});
//무대사진 첨부 버튼 클릭시
$(document).on('click', '#brc_stage_image_btn_div', function () {
    f_url_ck = 'st';
    if ($('#upload_img_amount_st').text() == '0') {
        f_st_cont = 0;
    }
    if (f_st_cont > $('#upload_img_amount_st').text()) {
    }
    else {
        f_st_cont = f_st_cont + 1;
    }
    if (f_st_cont >= 11) {
        alert('10장을 모두 등록하셨습니다.');
        return;
    }

    for (var i = 1; i < 11; i++) {

        if ($('#bi-main_st' + i).attr('src') == '/img/test/noimage.gif') {

            var st_numck = $('#bi-main_st' + i).attr('id').split('t');
            st_num = st_numck[1];
            $('#stage_picture').trigger('click');
            break;
        }

    }
    for (var a = 1; a <= 3; a++) {
        var bdc_carousel;
        if (a == 1) {
            bdc_carousel = $("#bdc_pfsc_ing_ul");
        }
        else if (a == 2) {
            bdc_carousel = $("#bdc_pfsc_ing_ul_st");
        }
        else if (a == 3) {
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

    }).promise().done(function () {

        var bdc_carousel;

        $(document).ready(function () {
            for (var a = 1; a <= 3; a++) {
                var bdc_carousel;
                if (a == 1) {
                    bdc_carousel = $("#bdc_pfsc_ing_ul");
                }
                else if (a == 2) {
                    bdc_carousel = $("#bdc_pfsc_ing_ul_st");
                }
                else if (a == 3) {
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

                //$('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
                //$('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
            });
        });

    });
});
$(document).on('change', '#stage_picture', function () {
    if ($(this).val() === '') return;
    $('#upload_img_amount_st').text(f_st_cont);
    readURL(this, 6, 4);
});

//메뉴사진 첨부 버튼 클릭시
$(document).on('click', '#brc_menu_image_btn_div', function () {
    f_url_ck = 'me';
    if ($('#upload_img_amount_me').text() == '0') {
        f_me_cont = 0;
    }
    if (f_me_cont > $('#upload_img_amount_me').text()) {
    }
    else {
        f_me_cont = f_me_cont + 1;
    }
    if (f_me_cont >= 2) {
        alert('모두 등록하셨습니다.');
        return;
    }

    for (var i = 1; i < 11; i++) {

        if ($('#bi-main_me' + i).attr('src') == '/img/test/noimage.gif') {

            var me_numck = $('#bi-main_me' + i).attr('id').split('e');
            me_num = me_numck[1];
            $('#menu').trigger('click');
            break;
        }

    }
    for (var a = 1; a <= 3; a++) {
        var bdc_carousel;
        if (a == 1) {
            bdc_carousel = $("#bdc_pfsc_ing_ul");
        }
        else if (a == 2) {
            bdc_carousel = $("#bdc_pfsc_ing_ul_st");
        }
        else if (a == 3) {
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

    }).promise().done(function () {

        var bdc_carousel;

        $(document).ready(function () {
            for (var a = 1; a <= 3; a++) {
                var bdc_carousel;
                if (a == 1) {
                    bdc_carousel = $("#bdc_pfsc_ing_ul");
                }
                else if (a == 2) {
                    bdc_carousel = $("#bdc_pfsc_ing_ul_st");
                }
                else if (a == 3) {
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

                //$('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
                //$('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
            });
        });

    });

});
$(document).on('change', '#menu', function () {
    if ($(this).val() === '') return;
    $('#upload_img_amount_me').text(f_me_cont);
    readURL(this, 6, 4);
});
function go_complete_store() {
    //loadPage('reg_store/complete_reg_store.jsp');
}
function go_reg_busking_time() {
    loadPage('busking_time/busking_time_reg.jsp');
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//$(document).on('pageinit', '#busking_store_reg', function(){

// var bdc_main_img_html = '<li>' + '<div id="img_cancel" name="sp_1" ><img class="icon_exit_b" src="/img/reg_store/exit_2.svg" /></div>' + '<div class="bdc_image_div">' +
// '<img id="bi-main_sp1" alt="1번 사진은 대표사진입니다" style="width:126px; max-width: none; height:84px; opacity: 1;">' +
// '</div>' + '</li>';

//$('#bdc_pfsc_ing_ul').append(bdc_main_img_html);

// var bdc_main_img_html = '<li>' + '<div id="img_cancel" name="st_1" ><img class="icon_exit_b" src="/img/reg_store/exit_2.svg" /></div>' + '<div class="bdc_image_div">' +
//     '<img id="bi-main_st1" alt="1번 사진을 등록해주세요" style="width:126px; max-width: none; height:84px; opacity: 1;">' +
//     '</div>' + '</li>';

// $('#bdc_pfsc_ing_ul_st').append(bdc_main_img_html);

// var bdc_main_img_html = '<li>' + '<div id="img_cancel" name="me_1" ><img class="icon_exit_b" src="/img/reg_store/exit_2.svg" /></div>' + '<div class="bdc_image_div">' +
// '<img id="bi-main_me1" alt="1번 사진을 등록해주세요" style="width:126px; max-width: none; height:84px; opacity: 1;">' +
// '</div>' + '</li>';

// $('#bdc_pfsc_ing_ul_me').append(bdc_main_img_html);    
//$('#bdc_img_selecter').append('<li class="bdc_img_active" id="bdc_img_selecter_1"></li>');

// for(var i = 2; i <=10; i ++){
// var bz_sub_img_html = '';
// var bz_sub_img_html_st = '';
// var bz_sub_img_html_me = '';

// bz_sub_img_html = '<li>' + '<div id="img_cancel" name="sp_'+i+'" ><img class="icon_exit_b" src="/img/reg_store/exit_2.svg" /></div>' + '<div class="bdc_image_div">' +
// '<img id="bi-main_sp'+i+'" alt="'+i+'번 사진을 등록해주세요" style="width:126px; max-width: none; height:84px; opacity: 1;">' +
// '</div>' + '</li>';

// $('#bdc_pfsc_ing_ul').append(bz_sub_img_html);

// bz_sub_img_html_st = '<li>' + '<div id="img_cancel" name="st_'+i+'" ><img class="icon_exit_b" src="/img/reg_store/exit_2.svg" /></div>' + '<div class="bdc_image_div">' +
// '<img id="bi-main_st'+i+'" alt="'+i+'번 사진을 등록해주세요" style="width:126px; max-width: none; height:84px; opacity: 1;">' +
// '</div>' + '</li>';

// $('#bdc_pfsc_ing_ul_st').append(bz_sub_img_html_st);

// bz_sub_img_html_me = '<li>' + '<div id="img_cancel" name="me_'+i+'" ><img class="icon_exit_b" src="/img/reg_store/exit_2.svg" /></div>' + '<div class="bdc_image_div">' +
// '<img id="bi-main_me'+i+'" alt="'+i+'번 사진을 등록해주세요" style="width:126px; max-width: none; height:84px; opacity: 1;">' +
// '</div>' + '</li>';

// $('#bdc_pfsc_ing_ul_me').append(bz_sub_img_html_me);

// }
// const cnt = $('#bdc_img_selecter').find('li').length;

//bz_sub_img_selecter = '<li id="bdc_img_selecter_' + (cnt+1) + '"></li>';
//$('#bdc_img_selecter').append(bz_sub_img_selecter);





//});


// $(document).on('click', '#re_perfom_date', function () {
//     if($('#re_perfom_date').val() != '' ){
//         $('#re_perfom_date').val('')
//     }
//     sessionStorage.clear('selectDateTemp_cal');
//     loadPage('busking_time/busking_time_calendar_pick.jsp');
// });

// $(document).on('click', '#bts_cal_back', function () {


//     $("html, body").css({ "overflow": "auto", "height": "auto" });
//     $('#busking_time_cal_popup').unbind('touchmove');

//     $('#busking_time_cal_popup').hide();

//     $('#header').show();
//     $('#footer').show();
// });


// $(document).on('click', '#bts_cal_footer', function () {
//     //sessionStorage.removeItem('selectDateTemp_cal');
//     var selected_sHour = $('#btr_cal_sHour').val();
//     var selected_eHour = $('#btr_cal_eHour').val();
//     var selected_sMin = $('#btr_cal_sMin').val();
//     var selected_eMin = $('#btr_cal_eMin').val();

//     var select_sTime = selected_sHour + ":" + selected_sMin;
//     var select_eTime = selected_eHour + ":" + selected_eMin;

//     var perform_time = select_sTime + "/" + select_eTime;

//     console.log(perform_time);

//     var selectDateTemp_cal = sessionStorage.getItem('selectDateTemp_cal');
//     if (selectDateTemp_cal == null || selectDateTemp_cal == '') {
//         selectDateTemp_cal = new Array();
//     } else {
//         selectDateTemp_cal = selectDateTemp_cal.split(',');
//     }

//     selectDateTemp_cal.push(perform_time);
//     selectDateTemp_cal.join(',');

//     console.log(selectDateTemp_cal);

//     sessionStorage.setItem('selectDateTemp_cal', selectDateTemp_cal);   //세션 저장

//     $("html, body").css({ "overflow": "auto", "height": "auto" });
//     $('#busking_time_cal_popup').unbind('touchmove');

//     $('#busking_time_cal_popup').hide();

//     $('#header').show();
//     $('#footer').show();

//     loadPage('reg_store/register_store_update.jsp');
// });


$(document).on('click', '#img_cancel', function () {
    var cancel_ck = $(this).attr('name');
    var number_ck = cancel_ck.split('_');
    if (number_ck[0] == 'sp') {
        if ($('#bi-main_sp' + number_ck[1]).attr('src') == '/img/test/noimage.gif') {
            alert('사진이 없습니다.');
            return;
        }
        $(this).hide();
        $('#bi-main_sp' + number_ck[1]).attr('src', '/img/test/noimage.gif')
        $('#fname_sp' + number_ck[1]).removeAttr('value');
        $('#upload_img_amount_sp').text($('#upload_img_amount_sp').text() - 1);
        f_sp_cont = f_sp_cont - 1;
        if(number_ck[1] == '1'){
            $('#bi-main_sp' + number_ck[1]).css("visibility", "hidden" );
        }else{
            $('#bi-main_sp' + number_ck[1]).hide()
        }
        
    }
    else if (number_ck[0] == 'st') {
        if ($('#bi-main_st' + number_ck[1]).attr('src') == '/img/test/noimage.gif') {
            alert('사진이 없습니다.');
            return;
        }
        $(this).hide();
        $('#bi-main_st' + number_ck[1]).attr('src', '/img/test/noimage.gif')
        $('#fname_st' + number_ck[1]).removeAttr('value');
        $('#upload_img_amount_st').text($('#upload_img_amount_st').text() - 1);
        f_st_cont = f_st_cont - 1;
        if(number_ck[1] == '1'){
            $('#bi-main_st' + number_ck[1]).css("visibility", "hidden" );
        }else{
            $('#bi-main_st' + number_ck[1]).hide()
        }
        
    }
    else if (number_ck[0] == 'me') {
        if ($('#bi-main_me' + number_ck[1]).attr('src') == '/img/test/noimage.gif') {
            alert('사진이 없습니다.');
            return;
        }
        $(this).hide();
        $('#bi-main_me' + number_ck[1]).attr('src', '/img/test/noimage.gif')
        $('#fname_me' + number_ck[1]).removeAttr('value');
        $('#upload_img_amount_me').text($('#upload_img_amount_me').text() - 1);
        f_me_cont = f_me_cont - 1;
        if(number_ck[1] == '1'){
            $('#bi-main_me' + number_ck[1]).css("visibility", "hidden" );
        }else{
            $('#bi-main_me' + number_ck[1]).hide()
        }
        
    }

});

$("#equipment").on('keydown keyup', function () {
    $(this).height(1).height($(this).prop('scrollHeight') + 12);
});

$("#zone_info").on('keydown keyup', function () {
    $(this).height(1).height($(this).prop('scrollHeight') + 12);
});
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//상업공간 등록하기
$(document).on('click', '.button_registration', function () {
    // jsp 내 필드값 불러오기
    // input
    var business_workname = changeQuotes($('#business_workname').val());
    var business_representive = $('#business_representive').val();
    var business_no = $('#business_no').val();
    var address = $('#address').val();
    var detail_addr = changeQuotes($('#address_detail').val());
    var business_phone = $('#business_phone').val();
    var open_hour = $('#open_hour').val();
    var open_minute = $('#open_minute').val();
    var close_hour = $('#close_hour').val();
    var close_minute = $('#close_minute').val();
    var operationhour = open_hour + ':' + open_minute + '~' + close_hour + ':' + close_minute;
    var equipment = changeQuotes($('#equipment').val());
    var text_genre_ck = $('#text_genre').val();
    var genre = text_genre_ck.replace(',*', ', ');
    var main_genre = $('#main_genre').val();
    var zone_info = changeQuotes($('#zone_info').val());
    var parking_chk = "";
    var perform_tipbox = "";
    var mobile_tipbox = "";
    var video_chk = "";
    var space_picture = "";
    var stage_picture = "";
    var license_picture = license_image;
    var menu = "";
    let emptyChk = '';
    var store_jumin_a = $('#store_jumin_a').val();
    var store_jumin_b = $('#store_jumin_b').val();
    var business_regist_no = store_jumin_a + '-' + store_jumin_b;

    for (var i = 1; i < 11; i++) {
        emptyChk = $('#fname_sp' + i).val();
        if (emptyChk === undefined || emptyChk === 'undefined' || emptyChk === '') {
        } else {
            if (i == 1) {
                space_picture = emptyChk;
            } else {
                space_picture = space_picture + ',' + emptyChk;
            }
        }
    }
    for (var i = 1; i < 11; i++) {
        emptyChk = $('#fname_st' + i).val();
        if (emptyChk === undefined || emptyChk === 'undefined' || emptyChk === '') {
        } else {
            if (i == 1) {
                stage_picture = emptyChk;
            } else {
                stage_picture = stage_picture + ',' + emptyChk;
            }
        }
    }
    for (var i = 1; i < 11; i++) {
        emptyChk = $('#fname_me' + i).val();
        if (emptyChk === undefined || emptyChk === 'undefined' || emptyChk === '') {
        } else {
            if (i == 1) {
                menu = emptyChk;
            } else {
                menu = menu + ',' + emptyChk;
            }
        }
    }


    if ($('#parking_chk1').is(":checked") == true) {
        parking_chk = "Y";
    } else {
        parking_chk = "N";
    }
    if ($('#video_chk1').is(":checked") == true) {
        video_chk = "Y";
    } else {
        video_chk = "N";
    }
    if ($('#tipbox_chk1').is(":checked") == true) {
        perform_tipbox = "Y";
    }
    else {
        perform_tipbox = "";
    }
    if ($('#tipbox_chk2').is(":checked") == true) {
        mobile_tipbox = "Y";
    }
    else {
        mobile_tipbox = "";
    }
    // hashtag(배열)
    var hashtag = "";
    var hashtag_ck = $('[class=hashtag_individual]').text();
    var hashtag_split = hashtag_ck.split('#');
    for (i = 1; i < hashtag_split.length; i++) {
        if (i == 0) {
            hashtag = "#" + hashtag_split[i] + ',';
        }
        else if (i == hashtag_split.length - 1) {
            hashtag = hashtag + "#" + hashtag_split[i];
        }
        else {
            hashtag = hashtag + "#" + hashtag_split[i] + ',';
        }
    }
    
    // img(business_다중 사진)
    // var business_license = $('#business_license').attr('src');
    // var space_picture = $('#space_picture').attr('src');
    // var stage_picture = $('#stagee_picture').attr('src');
    // var imgsrc = $('#menu').attr('src');
    var regPhone = /(01[0|1|6|9|7])[-](\d{3}|\d{4})[-](\d{4}$)/g;
    var regbusiness_no = /(\d{3})[-](\d{2})[-](\d{5}$)/g;
    var tionhour_ck = /(\d{2})/;
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

    if (business_workname == '') {
        alert('상호명을 입력해주세요.');
        // alert($('#bi-main').attr('src'));
        $('#business_workname').focus();
        return;
    } else if (business_representive == '') {
        alert('대표자명을 입력해주세요.');
        $('#business_representive').focus();
        return;
    } else if (business_no == '') {
        alert('사업자번호를 입력해주세요.');
        $('#business_no').focus();
        return;
    } else if (address == '') {
        alert('주소를 입력해주세요.');
        $('#address').focus();
        return;
    }else if (detail_addr == '') {
        alert('상세주소를 입력해주세요.');
        $('#address_detail').focus();
        return;
    } else if (business_phone == '') {
        alert('연락처를 입력해주세요.');
        $('#business_phone').focus();
        return;
    } else if (open_hour == '' && open_minute == '' && close_hour == '' && close_minute == '') {
        alert('영업시간을 등록해주세요.');
        $('#open_hour').focus();
        return;
    } else if (equipment == '') {
        alert('지원장비를 입력해주세요.');
        $('#equipment').focus();
        return;
    } else if (zone_info == '') {
        alert('공간 소개를 입력해주세요.');
        $('#zone_info').focus();
        return;
    }

    if (!tionhour_ck.test(open_hour)) {
        alert('잘못된 영업시간입니다');
        $('#open_hour').focus();
        return;
    }
    if (!tionhour_ck.test(open_minute)) {
        alert('잘못된 영업시간입니다');
        $('#open_minute').focus();
        return;
    }
    if (!tionhour_ck.test(close_hour)) {
        alert('잘못된 영업시간입니다');
        $('#close_hour').focus();
        return;
    }
    if (!tionhour_ck.test(close_minute)) {
        alert('잘못된 영업시간입니다');
        $('#close_minute').focus();
        return;
    }
    if (Number(open_hour) > 24 && Number(close_hour) > 24) {
        alert('잘못된 영업시간입니다');
        return;
    }
    if (Number(open_minute) > 59 && Number(close_minute) > 59) {
        alert('잘못된 영업시간입니다');
        return;
    }


    if (!regPhone.test(business_phone)) {
        alert('잘못된 유형의 연락처입니다');
        $('#business_phone').focus();
        return;
    }

    if (!regbusiness_no.test(business_no)) {
        alert('잘못된 유형의 사업자번호입니다');
        $('#artist_intro').focus();
        return;
    }
    if($('#bi-main').attr('src') == undefined){
        alert('사업자등록증 사진을 첨부해주세요.');
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
    if ($('#store_jumin_a').val() == '') {
        alert('주민등록번호를 등록해주세요.');
        $('#store_jumin_a').focus();
        return;
    }if ($('#store_jumin_b').val() == '') {
        alert('주민등록번호를 등록해주세요.');
        $('#store_jumin_b').focus();
        return;
    }
    if (store_jumin_a.length != 6) {
        alert('잘못된 주민등록번호 입니다.');
        $('#store_jumin_a').focus();
        return;
    }if (store_jumin_b.length != 7 ) {
        alert('잘못된 주민등록번호 입니다.');
        $('#store_jumin_b').focus();
        return;
    }
    if (!$('#tm_agree').prop('checked')) {
        infoTxtBox('약관에 동의해주세요.');
        return;
    }
    if (!$('#tm_agree2').prop('checked')) {
        infoTxtBox('사무위탁에 동의해주세요.');
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
        async: false,
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            if (DATA.length != 0) {
                alert('중복된 상호명입니다. 다시 입력해주세요.');
                $('#business_workname').val('');
                $('#business_workname').focus();
                return;
            } else {
                //AJAX 로딩 표시
                $.ajax({
                    type: "POST",//url: "JSON/test.json",
                    cache: false,
                    url: '/service/reg_store/register_store.jsp',
                    data: data,
                    data: {
                        business_workname: business_workname,
                        business_representive: business_representive,
                        business_no: business_no,
                        license_picture: license_picture,
                        business_regist_no:business_regist_no,
                        address: address,
                        detail_addr: detail_addr,
                        business_phone: business_phone,
                        operationhour: operationhour,
                        equipment: equipment,
                        hashtag: hashtag,
                        genre: genre,
                        main_genre: main_genre,
                        space_picture: space_picture,
                        stage_picture: stage_picture,
                        menu: menu,
                        zone_info: zone_info,
                        parking_chk: parking_chk,
                        mobile_tipbox: mobile_tipbox,
                        perform_tipbox: perform_tipbox,
                        video_chk: video_chk

                    },
                    dataType: "xml",
                    async: false,
                    timeout: 30000,
                    beforeSend: function () {
                        $.mobile.loading('show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
                    },
                    success: function (data) {
                        var ROOT = $(data).find("ROOT");
                        var DATA = $(ROOT).find('DATA');
                        $(DATA).each(function () {
                            var RESULT = $(this).find('RESULT').text();
                            var MSG = $(this).find('MESSAGE').text();

                            if (RESULT == 'true' || RESULT == 'TRUE') {
                                alert(MSG);
                                go_complete_reg_store();
                            } else {
                                alert(MSG);
                                return;
                            }
                        });
                    }, // end success
                    error: function (_xhr, _message, _errorThrown) {
                        alert('잠시후 다시 시도해주세요.');
                        return;
                        //hideLoading();
                    }, // end error
                    complete: function () {
                        $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });

                        // sessionStorage.setItem('aname', $('#artist_name').val())
                        // sessionStorage.setItem('acontent', $('#artist_intro').val());
                        // setAimgCallback2(imgsrc);
                        // go_team_create();
                        //loadPage('reg_store/complete_reg_store.jsp');
                    }
                });

            }
        }
    });
});


////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 홍보 페이지 사진 영역 js
$(document).on('pageinit', '#busking_promotion', function () {

    var bdc_main_img_html = '<li id="slide_no1">' + '<div class="bdc_image_div">' +
        '<img src="/img/reg_store/promotion_slide1.png" alt="Los Angeles" style="width:295px; max-width: none; height:350px;">' +
        '<div class="promotion_in_img_text1"><span class="promotion_in_img_text_a">상업 공간 홍보</span><span class="promotion_in_img_text_b" style="margin-top: 6px;">상업 공간의 상세 정보와 메뉴,</span><span class="promotion_in_img_text_b">공연 일정을 소개해보세요</span></div>' +
        '</div>' + '</li>';

    $('#bdc_pfsc_ing_ul').append(bdc_main_img_html);
    $('#bdc_img_selecter').append('<li class="bdc_img_active" id="bdc_img_selecter_1">●</li>');


    var bz_sub_img_html = '';
    var bz_sub_img_selecter = '';

    bz_sub_img_html = '<li id="slide_no2">' + '<div class="bdc_image_div">' +
        '<img src="/img/reg_store/promotion_slide2.png" alt="Los Angeles" style="width:295px; max-width: none; height:350px;">' +
        '<div class="promotion_in_img_text2"><span class="promotion_in_img_text_a">공연 모집</span><span class="promotion_in_img_text_b" style="margin-top: 6px;">공간의 일정을 등록하고</span><span class="promotion_in_img_text_b">아티스트를 모집해보세요</span></div>'
    '</div>' + '</li>';

    $('#bdc_pfsc_ing_ul').append(bz_sub_img_html);
    bz_sub_img_selecter = '<li id="bdc_img_selecter_2">●</li>';
    $('#bdc_img_selecter').append(bz_sub_img_selecter);

    bz_sub_img_html = '<li id="slide_no3">' + '<div class="bdc_image_div">' +
        '<img src="/img/reg_store/promotion_slide3.png" alt="Los Angeles" style="width:295px; max-width: none; height:350px;">' +
        '<div class="promotion_in_img_text3"><span class="promotion_in_img_text_a">전자 계약</span><span class="promotion_in_img_text_b" style="margin-top: 6px;">예술인 고용보험 가입과</span><span class="promotion_in_img_text_b">체결을 경험해보세요</span></div>'
    '</div>' + '</li>';

    $('#bdc_pfsc_ing_ul').append(bz_sub_img_html);


    bz_sub_img_selecter = '<li id="bdc_img_selecter_3">●</li>';
    $('#bdc_img_selecter').append(bz_sub_img_selecter);

    bdc_main_img_html = '<li id="slide_no1_fk">' + '<div class="bdc_image_div">' +
    '<img src="/img/reg_store/promotion_slide1.png" alt="Los Angeles" style="width:295px; max-width: none; height:350px;">' +
    '</div>' + '</li>';

    $('#bdc_pfsc_ing_ul').append(bdc_main_img_html);

    $.ajax().always(function () {

        var bdc_carousel;

        $(document).ready(function () {

            bdc_carousel = $("#bdc_pfsc_ing_ul");
            bdc_carousel.itemslide(
                {
                    left_sided: true,
                    disable_clicktoslide: true
                }
            );

            bdc_carousel.on('changePos', function (_e) {
                var ai = bdc_carousel.getActiveIndex() + 1;

                $('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
                $('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
                if ($('#bdc_img_selecter_1').attr('class') == 'bdc_img_active') {
                    $("#busking_promotion").css({"background":"url(/img/reg_store/promotion_bg1_2x.png)50% 50%"});
                    $("#slide_no1").css({"margin-left":'40px'});
                    $("#slide_no1").css("visibility", "visible"); 
                    $("#slide_no1_fk").hide();
                    $("#fake_img").show();
                    $('.promotion_in_img_text2').hide();
                    $('.promotion_in_img_text3').hide();
                    $('.promotion_in_img_text1').show();
                }
                else if ($('#bdc_img_selecter_2').attr('class') == 'bdc_img_active') {
                    $("#busking_promotion").css({"background":"url(/img/reg_store/promotion_bg2_2x.png)50% 50%"});
                    $("#slide_no1").css({"margin-left":"40px"});
                    $("#slide_no1").css("visibility", "visible");
                    $("#slide_no1_fk").hide();
                    $("#fake_img").hide();
                    $('.promotion_in_img_text1').hide();
                    $('.promotion_in_img_text3').hide();
                    $('.promotion_in_img_text2').show(); 	
                }
                else if ($('#bdc_img_selecter_3').attr('class') == 'bdc_img_active') {
                    $("#busking_promotion").css({"background":"url(/img/reg_store/promotion_bg3_2x.png)50% 50%"});
                    $("#slide_no1").css({"margin-left":"82px"});
                    $("#slide_no1").css("visibility", "hidden"); 
                    $("#slide_no1_fk").show();
                    $("#fake_img").hide();
                    $('.promotion_in_img_text1').hide();
                    $('.promotion_in_img_text2').hide();
                    $('.promotion_in_img_text3').show();
                }
                
                if ($('#slide_no1_fk').attr('class') == 'itemslide-active') {
                    $('#slide_no1_fk').removeClass('itemslide-active');
                    
                }
            });
        });

    });



});
$(document).on('click', '.promotion_close_button', function () {
    history.go(-1);
});
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 해시태그 관련 js


// 배열 선언
var arrayHashTag = [];

// 해시태그 제어

// window.onpageshow = function(event) {
//     const nowpage = $('div[data-role=page]').attr('id');
//     var reload_ck = sessionStorage.getItem('reload_ck');
//     console.log("현재 reload_ck?" + reload_ck);
//     if (nowpage === 'busking_store_reg' || nowpage === 'busking_store_update') {
//         if(reload_ck == 'N' || reload_ck == null){
//             sessionStorage.removeItem('reload_ck');
//             sessionStorage.setItem('reload_ck', 'Y');
//             location.reload(true);
//         }
        
//     }
//     else{
//         sessionStorage.removeItem('reload_ck');
//         sessionStorage.setItem('reload_ck', 'N');
//     }
    
// }







// 해시태그 생성 기능
function add_hashtag() {
    var hashtag_cont_ck = $('div.hashtag_individual').length;
    re = /[~!@\#$%^&*\()\-=+_']/gi;
    var temp_hashtag = $('#hashtag').val();
    temp_hashtag = temp_hashtag.trim();
    if (temp_hashtag == '') {
        alert('해시태그를 등록해주세요.');
        return;
    }
    if (temp_hashtag == '#') {
        return;
    }
    // if(wordchk1(temp_hashtag) == 'N'){
    //     return;
    // }
    // else{
    //     if(wordchk2(temp_hashtag) == 'N'){
    //         return;
    //     }
    // }

    if (hashtag_cont_ck > 4) {
        alert('해시태그를 모두 등록하셨습니다.');
        return;
    }

    if (re.test(temp_hashtag)) {
        $('#hashtag').val(temp_hashtag.replace(re, ""));
    }



    // 해시태그 local 선언
    var area_hashtag = document.getElementById("area_hashtag");

    // input 값 호출 및 배열 삽입
    var hashTag = "#" + document.getElementById("hashtag").value;
    arrayHashTag.push(hashTag);
    console.log("현재 해쉬태그는?" + arrayHashTag);
    // js를 이용한 div 생성
    area_hashtag.innerHTML = "";
    for (var i = 0; i < arrayHashTag.length; i++) {
        if (arrayHashTag[i] == "") {
            continue;
        } else {
            area_hashtag.innerHTML += "<div class='hashtag_individual_set'><div class='hashtag_individual'>" + arrayHashTag[i] + "</div><div class='hashtag_close' onclick='delete_hashtag(" + i + ")'><img class='icon_exit_b' src='/img/reg_store/exit_2.svg' /></div></div>";
        }
    }

    // hashTag 내 value 확인(console.log())
    console.log("hastTag 전체 : " + arrayHashTag);
    for (var i = 0; i < arrayHashTag.length; i++) {
        if (arrayHashTag[i] == "") {
            continue;
        } else {
            console.log("arrayHashTag[" + i + "] : " + arrayHashTag[i]);
        }
    }

    // input 값 리셋
    document.getElementById("hashtag").value = "";
}

// 해시태그 삭제 기능
function delete_hashtag(i) {
    console.log("현재 해쉬태그는?" + arrayHashTag);
    delete arrayHashTag[i];
    arrayHashTag[i] = "";

    // 해시태그 리셋후 다시 출력
    area_hashtag.innerHTML = "";
    for (var i = 0; i < arrayHashTag.length; i++) {
        if (arrayHashTag[i] == "") {
            continue;
        } else {
            area_hashtag.innerHTML += "<div class='hashtag_individual_set'><div class='hashtag_individual'>" + arrayHashTag[i] + "</div><div class='hashtag_close' onclick='delete_hashtag(" + i + ")'><img class='icon_exit_b' src='/img/reg_store/exit_2.svg' /></div></div>";
        }
    }

    // hashTag 내 value 확인(console.log())
    console.log("삭제된 array : " + arrayHashTag);
    for (var i = 0; i < arrayHashTag.length; i++) {
        if (arrayHashTag[i] == "") {
            continue;
        } else {
            console.log("arrayHashTag[" + i + "] : " + arrayHashTag[i]);
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 완료 페이지 js(총 11페이지)
// 필요한 부분 가져가서 사용하면 됩니다.

// 완료 페이지 관리 영역
function go_complete_page() {
    loadPage('reg_store/manage_complete_page.jsp');
}

// 사업주(business) 영역
// 공간 등록 완료
function go_complete_reg_store() {
    loadPage('reg_store/complete_reg_store.jsp');
}
//공연 수정 완료
function go_complete_reg_store_update() {
    loadPage('reg_store/complete_reg_store_update.jsp');
}
//공연 삭제 완료
function go_complete_reg_store_delete() {
    loadPage('reg_store/complete_reg_store_delete.jsp');
}
// 등록 완료
// function go_complete_reg_busking_time() {
//     loadPage('reg_store/complete_reg_busking_time.jsp');
// }
// 공연 승인 완료
function go_complete_accept_busking() {
    loadPage('reg_store/complete_accept_busking.jsp');
}
// 공연 거절 완료
// function go_complete_reject_busking() {
//     loadPage('reg_store/complete_reject_busking.jsp');
// }
// 계약서 서명 완료
function go_complete_sign_contract_business() {
    loadPage('reg_store/complete_sign_contract_business.jsp');
}
// 수정 완료
// function go_complete_modify_busking_zone() {
//     loadPage('reg_store/complete_modify_busking_zone.jsp');
// }
// // 삭제 완료
// function go_complete_delete_busking_zone() {
//     loadPage('reg_store/complete_delete_busking_zone.jsp');
// }
//공연 일정으로
function goback_store_list() {
    loadPage('/busking_time/store_list.jsp');
}
// 아티스트(artist) 영역
// 쿠폰 복사 완료
function go_complete_copy_coupon() {
    loadPage('reg_store/complete_copy_coupon.jsp');
}
// 공연 신청 완료
function go_complete_apply_busking() {
    loadPage('reg_store/complete_apply_busking.jsp');
}
// 신청 취소 완료
function go_complete_cancel_busking() {
    loadPage('reg_store/complete_cancel_busking.jsp');
}
// 계약서 서명완료
function go_complete_sign_contract_artist() {
    loadPage('reg_store/complete_sign_contract_artist.jsp');
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////// 테스트를 위해 임시로 넣어둔 부분(사진 추가/리사이징/저장(파이어베이스(구글)))  ////////////////////

function go_image_working() {
    loadPage('test_1214/test_image_resizing.jsp');
}
function go_complete_busking_time_reg() {
    if (userLogin_chk() == false) {
        alert('로그인 하시고 해당 서비스를 이용해주세요');
        loadPage('login/login.jsp');
    } else {
        loadPage('busking_time/busking_time_reg_each.jsp');
    }    
}
//아티스트 되기 페이지
$(document).on('pageinit', '#test_artist_become', function () {
    /*var busker_oath = getCookie('busker_oath');
    var bocChk = sessionStorage.getItem('bocChk');
    if(busker_oath != 'Y'){
        if(bocChk != 'Y'){
            goBuskingOath();
        } else {
            alert('\'아티스트 되기\'등록 후 반드시 팀·솔로 등록을 해주세요!');
        }
    } else {
        alert('\'아티스트 되기\'등록 후 반드시 팀·솔로 등록을 해주세요!');
    }*/

    $('#test_artist_img').parents('.ui-corner-all').css('display', 'none');
});

$(document).on('click', '#test_artist_become_img', function () {
    $('#test_artist_img').click();
    console.log('sdsdsd')
});

$(document).on('change', '#test_artist_img', function () {
    if ($(this).val() === '') return;
    readURL(this, 2, 1);
});

//아티스트 등록하기
$(document).on('click', '.test_register_picture_btn', function () {

    var uploading_img = $('#img_name').val();
    var imgsrc = $('#img_preview').attr('src');

    //AJAX 로딩 표시
    $.ajax({
        type: "POST",//url: "JSON/test.json",
        cache: false,
        url: '/service/test_1214/test_image_resizing.jsp',
        //data : data,
        data: {
            uploading_img: uploading_img
        },
        dataType: "xml",
        async: false,
        timeout: 30000,
        beforeSend: function () {
            $.mobile.loading('show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
        },
        success: function (data) {
            var ROOT = $(data).find("ROOT");
            var DATA = $(ROOT).find('DATA');
            if (DATA.length == 0) {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                return;
            }
            alert('사진이 등록되었습니다.');

        }, // end success
        error: function (_xhr, _message, _errorThrown) {
            alert('잠시후 다시 시도해주세요.');
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
            sessionStorage.setItem('aname', $('#artist_name').val())
            sessionStorage.setItem('acontent', $('#artist_intro').val());
            setAimgCallback2(imgsrc);

            // go_team_create();
        }
    });

});
function store_maxLengthCheck(object) {
    if (object.value.length > object.maxLength) {
        object.value = object.value.slice(0, object.maxLength);
    }
}
$(document).on('keyup', '#store_jumin_b', function (event) {
    this.value = this.value.replace(/[^0-9]/g, '');   // 입력값이 숫자가 아니면 공백
});


// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//이미지 리사이징
// var test_cropper;

// const test_readURL = (input, w, h) => {

//     test_cropper = '';
//     $('#test_resize-image-container').show();
//     test_showImageLoading('사진을 불러오는중입니다.<br>잠시만 기다려주세요.<br>파일의 크기가 크면 오래 걸릴 수 있습니다.');
//     if (input.files && input.files[0]) {

//         let reader = new FileReader();

//         reader.onload = function (e) {
//             $('#test_ric-img').attr('src', e.target.result);

//             const image = document.getElementById('test_ric-img');

//             if (test_cropper === undefined || test_cropper === 'undefined' || test_cropper === '') {
//                 test_cropper = new Cropper(image, {
//                     autoCrop: true,  //true 로 설정
//                     aspectRatio: w / h,
//                     ready() {
//                         $('#test_loading-container').hide();
//                         // console.log(test_cropper);
//                     },
//                     crop(event) {
//                         /*console.log(event.detail.x);
//                         console.log(event.detail.y);
//                         console.log(event.detail.width);
//                         console.log(event.detail.height);
//                         console.log(event.detail.rotate);
//                         console.log(event.detail.scaleX);
//                         console.log(event.detail.scaleY);*/
//                     },
//                 });
//             }
//             test_cropper.replace(e.target.result);
//         }
//         reader.readAsDataURL(input.files[0]);
//     }
// }

// const test_resizeSave = (path) => {
//     // Upload cropped image to server if the browser supports `HTMLCanvasElement.toBlob`.
//     // The default value for the second parameter of `toBlob` is 'image/png', change it if necessary.
//     test_showImageLoading('사진을 저장중입니다.<br>잠시만 기다려주세요.');
//     test_cropper.getCroppedCanvas().toBlob((blob) => {
//         const filename = createRandomNum() + '.jpeg';

//         // Pass the image file name as the third parameter if necessary.
//         uploadResizeFile(blob, path, filename, function (f) {
//             var new_img = '/upload/' + path + '/' + f;

//             var imgSrc = getImagePromise(new_img).then(value => {
//                 $('#test_img_preview').attr('src', value);
//                 $('#test_img_name').val(filename);
//                 $('#test_resize-image-container').hide();
//                 test_cropper = '';
//             });
//         });

//         //$('#uploading').show();
//         // Use `jQuery.ajax` method for example
//         /*$.ajax('./image_save.jsp', {
//           method: 'POST',
//           data: formData,
//           processData: false,
//           contentType: false,
//           success: function() {
//           },
//           error: function() {
//               console.log('Upload error');
//           },
//           complete: function(){
//               setTimeout(function(){
//                   $('#uploading').hide();
//                   $('#result').attr('src', '/upload/'+filename);
//               }, 3000);
//           }
//         });*/
//     }, 'image/jpeg');
// }

// const test_showImageLoading = (msg) => {
//     $('#test_loading-message').html(msg);
//     $('#test_loading-container').show();
// }

// $(document).on('click', '#test_ric-cancel', function () {
//     $('#test_resize-image-container').hide();
//     test_cropper = '';
// })


// $(document).on('click', '#test_ric-save', function () {
//     const nowpage = $('div[data-role=page]').attr('id');

//     let no = '';
//     let path = '';

//     if (nowpage === 'test_artist_become') {
//         path = 'test';
//     } else {
//         alert('잘못된 접근입니다.\n다시 시도해주세요.');
//         return;
//     }

//     test_resizeSave(path);
// });
