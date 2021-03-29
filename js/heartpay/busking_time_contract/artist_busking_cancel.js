function artist_cancel_go() {
    $("html, body").css({ "overflow": "hidden", "height": "100%" });

    // $('#artist_busking_popup').on('scroll touchmove mousewheel', function (e) {
    //     e.preventDefault();
    //     e.stopPropagation();
    //     return false;
    // });

    $('#artist_busking_cancel_popup').load('/app_root/jsp/custom_select_box/artist_busking_cancel.jsp', function () {
        $('#artist_busking_cancel_popup').show();

        $('#header').hide();
        $('#footer').hide();
    });

    var user_no = $('#user_no').val();
    var perform_no = sessionStorage.getItem('btcl_perform_no');
    // console.log(perform_no);
    // console.log('user_no : ' + user_no);


    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/busking_time_contract/get_artist_busking_cancel.jsp',
        data: {
            perform_no: perform_no,
            user_no: user_no
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');
            var DATA2 = $(ROOT).find('DATA2');
            var DATA3 = $(ROOT).find('DATA3');

            $(DATA).each(function (i) {
                var PERFORM_NO = $(this).find("PERFORM_NO").text();
                var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
                var STARTINGTIME = $(this).find("STARTINGTIME").text();
                var FINISHINGTIME = $(this).find("FINISHINGTIME").text();
                var DAYOFTHEWEEK = $(this).find("DAYOFTHEWEEK").text();
                var OFFERPRICE = $(this).find("OFFERPRICE").text();
                var MATCHING_CHK = $(this).find("MATCHING_CHK").text();
                var BUSINESS_WORKNAME = $(this).find("BUSINESS_WORKNAME").text();
                var SPACE_PICTURE = $(this).find("SPACE_PICTURE").text();
                var store_user_no = $(this).find("USER_NO").text();

                sessionStorage.setItem('cpc_buskingDate', BUSKINGDATE);
                sessionStorage.setItem('cpc_buskingTime', STARTINGTIME + ' - ' + FINISHINGTIME);
                //-----------------------------날짜--------------------------------------------
                $('.abc_title').empty();
                var busking_date = BUSKINGDATE.split("-");
                if (busking_date[1].substring(0, 1) == "0") {
                    var busking_month = busking_date[1].substring(1, 2);
                } else {
                    var busking_month = busking_date[1]
                }

                if (busking_date[2].substring(0, 1) == "0") {
                    var busking_day = busking_date[2].substring(1, 2);
                } else {
                    var busking_day = busking_date[2]
                }

                var abc_body_title = '<p>' + busking_month + '월 ' + busking_day + '일 공연 취소</p>';
                $('.abc_title').append(abc_body_title);
                //--------------------------------------------------------------------------------


                //------------------------------상업공간 정보--------------------------------------
                $('.abc_card_container').empty();
                if (MATCHING_CHK == '1') {
                    var buskingstatus = '신청 완료';
                } else {
                    var buskingstatus = '신청 완료';
                }

                var abc_body_content_a_detail_info =
                    '<div class="abc_card_img_container">' +
                    '<div class="abc_card_img_box">' +
                    '<img id="simg' + PERFORM_NO + '" class="abc_card_img" src="#">' +
                    '</div>' +
                    '</div>' +
                    '<div class="abc_card">' +
                    '<div class="abc_card_top_container">' +
                    '<div class="abc_card_title">' +
                    '<p>' + BUSINESS_WORKNAME + '</p>' +
                    '</div>' +
                    '<div class="abc_card_confirm">' +
                    '<p>공간 정보 ></p>' +
                    '</div>' +
                    '</div>' +
                    '<div class="abc_card_time">' +
                    '<p>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</p>' +
                    '</div>' +
                    '<div class="abc_card_contract">' +
                    '<p>' + buskingstatus + '</p>' +
                    '</div>' +
                    '</div>';

                $('.abc_card_container').append(abc_body_content_a_detail_info);

                var space_pic = SPACE_PICTURE.split(',')[0];
                var new_img3 = 'upload/store/space/space' + store_user_no + "/" + space_pic;
                var imgSrc3 = getImagePromise(new_img3).then(value => {
                    $('#simg' + PERFORM_NO).attr('src', value);
                });


                $('.abc_price_container').empty();
                sessionStorage.setItem('abc_offerprice', OFFERPRICE);
                OFFERPRICE = OFFERPRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 	
                var abc_price_container =
                    '<div class="abc_price_container">' +
                    '<div class="abc_price_title">' +
                    '<p>공연비</p>' +
                    '</div>' +
                    '<div class="abc_price_total">' +
                    '<p>' + OFFERPRICE + ' 원</p>' +
                    '</div>' +
                    '</div>';
                // '<div class="abc_price_container" style="margin-top: 10px;">' +
                // '<div class="abc_price_title">' +
                // '<p>잔여 공연비</p>' +
                // '</div>' +
                // '<div class="abc_price">' +
                // '<p style="color: #F76C4A;">' + OFFERPRICE + ' 원</p>' +
                // '</div>' +
                // '</div>';
                $('.abc_price_wrap').append(abc_price_container);
                //---------------------------------------------------------------------------------

                //------------------------------신청 팀 정보--------------------------------------
                $(DATA2).each(function (i) {
                    var USER_NO = $(this).find("USER_NO").text();
                    var TEAM_NO = $(this).find("TEAM_NO").text();
                    var TEAM_NAME = $(this).find("TEAM_NAME").text();
                    var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
                    var TINTRO_IMG = $(this).find("TINTRO_IMG").text();
                    var ARTIST_IMG = $(this).find("ARTIST_IMG").text();
                    var PERFORM_CHK = $(this).find("PERFORM_CHK").text();
                    var PERSONAL_PRICE = $(this).find("PERSONAL_PRICE").text();

                    sessionStorage.setItem('cpc_teamName', TEAM_NAME);

                    PERSONAL_PRICE = PERSONAL_PRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 

                    $('.abc_team').empty();
                    var abc_team =
                        '<div class="abc_team_left_container">' +
                        '<div class="abc_card_img_box">' +
                        '<img id="aimg' + TEAM_NO + '" class="abc_card_img" src="#">' +
                        '</div>' +
                        '</div>' +
                        '<div class="abc_team_right_container">' +
                        '<div class="abc_team_name_con_2">' +
                        '<p class="abc_team_name">' + TEAM_NAME + '</p>' +
                        '<p class="abc_team_change">팀 변경</p>' +
                        '</div>' +
                        '<div class="abc_team_chk_con">' +
                        '<div class="abc_chk_container" style="margin-bottom: 0;">' +
                        '<input type="checkbox" name="abc_team_check" id="abc_team_check_all" data-role="none">' +
                        '<label for="abc_team_check_all"></label>' +
                        '</div>' +
                        '</div>' +
                        '</div>';
                    $('.abc_team').append(abc_team);

                    var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                    var imgSrc = getImagePromise(new_img).then(value => {
                        $('#aimg' + TEAM_NO).attr('src', value);
                    });

                    var abc_member =
                        '<div class="abc_member_section">' +
                        '<div class="abc_team_left_container">' +
                        '<div class="abc_card_img_box">' +
                        '<img id="aimg' + i + '" class="abc_card_img" src="#">' +
                        '</div>' +
                        '</div>' +
                        '<div class="abc_team_right_container">' +
                        '<div class="abc_team_name_con">' +
                        '<p class="abc_member_name">' + ARTIST_NAME + '</p>' +
                        '</div>' +
                        '<div class="abc_personal_price_container">' +
                        '<input class="personal_price" id="personal_price_' + USER_NO + '" value="' + PERSONAL_PRICE + '" data-role="none" readonly />' +
                        '<p>원</p>' +
                        '</div>' +
                        '<div class="abc_team_chk_con">' +
                        '<div class="abc_chk_container" style="margin-bottom: 0;">' +
                        '<input type="checkbox" name="abc_member_check" id="abc_member_check_' + USER_NO + '" data-role="none" value="' + USER_NO + '">' +
                        '<label for="abc_member_check_' + USER_NO + '"></label>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>';

                    var new_img2 = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;
                    var imgSrc2 = getImagePromise(new_img2).then(value => {
                        $('#aimg' + i).attr('src', value);
                    });

                    $('.abc_member').append(abc_member);

                    if (PERFORM_CHK == 'Y') {
                        $('#abc_member_check_' + USER_NO).prop("checked", true);
                        $('#abc_team_check_all').prop("checked", true);
                        $('#abc_member_check_' + USER_NO).attr("disabled", true);
                        $('#abc_team_check_all').attr("disabled", true);
                    }

                    sessionStorage.setItem('abc_team_no', TEAM_NO);
                    // $(DATA3).each(function (i) {
                    //     // var CNT = $(this).find("CNT").text();
                    //     // var offer = OFFERPRICE.replace(/[^\d]+/g, '');  // 콤마 제거

                    //     // var personal_price = parseInt(offer / CNT);

                    //     // personal_price = String(personal_price).replace(/\B(?=(\d{3})+(?!\d))/g, ",");  //콤마 다시 추가

                    //     // // console.log(CNT);
                    //     // // console.log(offer);
                    //     // // console.log(personal_price);

                    //     // $('#personal_price_' + USER_NO).val(personal_price);
                    // });
                });
            }).promise().done(function () {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
            });
        },//end success
        error: function (xhr, message, errorThrown) {
            //hideLoading();
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
        } // end error
    });
}


$(document).on('click', '#abc_footer', function () {
    // alert('신청취소당');
    var user_no = $('#user_no').val();
    var perform_no = sessionStorage.getItem('btcl_perform_no');

    // console.log(user_no);
    // console.log(perform_no);

    var con_chk = confirm("공연 신청을 취소하시겠습니까?")
    if (con_chk == true) {
        $.ajax({
            type: "GET",
            cache: false,
            url: '/service/busking_time_contract/del_busking_time_cancel.jsp',
            data: {
                perform_no: perform_no,
                user_no: user_no
            },
            contentType: "application/xml; charset=utf-8",
            dataType: "xml",
            timeout: 30000,
            success: function (data) {
                var ROOT = $(data).find('ROOT');
                var DATA = $(ROOT).find('DATA');

                $(DATA).each(function (i) {

                }).promise().done(function () {
                    $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                    alert("신청 취소 완료");
                });
            }
        });
        loadPage('busking_time_contract/complete_cancel_busking.jsp');
    }
    else if (con_chk == false) {
        return false;
    }

});


$(document).on('pageinit', '#cancel_perform_complete', function () {
    var team_name = sessionStorage.getItem('cpc_teamName');
    var busking_date = sessionStorage.getItem('cpc_buskingDate');
    var busking_time = sessionStorage.getItem('cpc_buskingTime');

    busking_date = busking_date.slice(2);
    busking_date = busking_date.replace(/-/g, '.');

    var cpc_notice_1 =
        '<p><span>아티스트명</span><span class="cpc_info">' + team_name + '</span></p>' +
        '<p><span>공연 일자</span><span class="cpc_info">' + busking_date + '</span></p>' +
        '<p><span>공연 시간</span><span class="cpc_info">' + busking_time + '</span></p>';

    $('.cpc_notice_1').append(cpc_notice_1);
});

$(document).on('click', '#cpc_confirm_list_btn', function () {
    loadPage('busking_time_contract/busking_time_contract_list.jsp');
});

function abc_close_popup() {
    $("html, body").css({ "overflow": "auto", "height": "auto" });
    $('#artist_busking_cancel_popup').unbind('touchmove');

    $('#artist_busking_cancel_popup').hide();

    $('#header').show();
    $('#footer').show();
}