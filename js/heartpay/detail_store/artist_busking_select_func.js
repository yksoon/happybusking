function artist_select_go() {
    if (userLogin_chk() == false) {
        infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
        loadPage('login/login.jsp');
    } else {
        if (artist_chk() == false) {
            infoTxtBox('아티스트만 신청 가능합니다.');
            return;
        }
        else {
            if (team_chk() == false) {
                infoTxtBox('팀/솔로 등록 이후 가능합니다.');
                loadPage('team/team_create.jsp');
            }
        }
    }
    sessionStorage.removeItem('abs_team_no');
    sessionStorage.removeItem('abs_offerprice');

    $("html, body").css({ "overflow": "hidden", "height": "100%" });

    // $('#artist_busking_popup').on('scroll touchmove mousewheel', function (e) {
    //     e.preventDefault();
    //     e.stopPropagation();
    //     return false;
    // });

    $('#artist_busking_popup').load('/app_root/jsp/custom_select_box/artist_busking_select.jsp', function () {
        $('#artist_busking_popup').show();

        $('#header').hide();
        $('#footer').hide();
    });
    var user_no = $('#user_no').val();
    var perform_no = sessionStorage.getItem('sl_perform_no');
    // console.log(perform_no);
    // console.log('user_no : ' + user_no);


    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/detail_store/get_artist_busking_select.jsp',
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
                var BUSKINGSTATUS = $(this).find("BUSKINGSTATUS").text();
                var BUSINESS_WORKNAME = $(this).find("BUSINESS_WORKNAME").text();
                var SPACE_PICTURE = $(this).find("SPACE_PICTURE").text();
                var store_user_no = $(this).find("USER_NO").text();

                sessionStorage.setItem('apc_buskingDate', BUSKINGDATE);
                sessionStorage.setItem('apc_buskingTime', STARTINGTIME + ' - ' + FINISHINGTIME);
                //-----------------------------날짜--------------------------------------------
                $('.abs_title').empty();
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

                var abs_body_title = '<p>' + busking_month + '월 ' + busking_day + '일 공연 신청</p>';
                $('.abs_title').append(abs_body_title);
                //--------------------------------------------------------------------------------


                //------------------------------상업공간 정보--------------------------------------
                $('.abs_card_container').empty();
                if (BUSKINGSTATUS == '1' || BUSKINGSTATUS == '2') {
                    var buskingstatus = '신청불가';
                }
                else if (BUSKINGSTATUS == '3') {
                    var buskingstatus = '신청가능';
                }

                var abs_body_content_a_detail_info =
                    '<div class="abs_card_img_container">' +
                    '<div class="abs_card_img_box">' +
                    '<img id="simg' + PERFORM_NO + '" class="abs_card_img" src="#">' +
                    '</div>' +
                    '</div>' +
                    '<div class="abs_card">' +
                    '<div class="abs_card_top_container">' +
                    '<div class="abs_card_title">' +
                    '<p>' + BUSINESS_WORKNAME + '</p>' +
                    '</div>' +
                    '<div class="abs_card_confirm">' +
                    '<p>공간 정보 ></p>' +
                    '</div>' +
                    '</div>' +
                    '<div class="abs_card_time">' +
                    '<p>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</p>' +
                    '</div>' +
                    '<div class="abs_card_contract">' +
                    '<p>' + buskingstatus + '</p>' +
                    '</div>' +
                    '</div>';

                $('.abs_card_container').append(abs_body_content_a_detail_info);

                var space_pic = SPACE_PICTURE.split(',')[0];
                var new_img3 = 'upload/store/space/space' + store_user_no + "/" + space_pic;
                var imgSrc3 = getImagePromise(new_img3).then(value => {
                    $('#simg' + PERFORM_NO).attr('src', value);
                });


                $('.abs_price_container').empty();
                sessionStorage.setItem('abs_offerprice', OFFERPRICE);
                OFFERPRICE = OFFERPRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 	
                var abs_price_container =
                    '<div class="abs_price_container">' +
                    '<div class="abs_price_title">' +
                    '<p>공연비</p>' +
                    '</div>' +
                    '<div class="abs_price_total">' +
                    '<p>' + OFFERPRICE + ' 원</p>' +
                    '</div>' +
                    '</div>' +
                    '<div class="abs_price_container" style="margin-top: 10px;">' +
                    '<div class="abs_price_title">' +
                    '<p>잔여 공연비</p>' +
                    '</div>' +
                    '<div class="abs_price">' +
                    '<p style="color: #F76C4A;">' + OFFERPRICE + ' 원</p>' +
                    '</div>' +
                    '</div>';
                $('.abs_price_wrap').append(abs_price_container);
                //---------------------------------------------------------------------------------

                //------------------------------신청 팀 정보--------------------------------------
                $(DATA2).each(function (i) {
                    var USER_NO = $(this).find("USER_NO").text();
                    var TEAM_NO = $(this).find("TEAM_NO").text();
                    var TEAM_NAME = $(this).find("TEAM_NAME").text();
                    var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
                    var TINTRO_IMG = $(this).find("TINTRO_IMG").text();
                    var ARTIST_IMG = $(this).find("ARTIST_IMG").text();

                    sessionStorage.setItem('apc_teamName', TEAM_NAME);

                    $('.abs_team').empty();
                    var abs_team =
                        '<div class="abs_team_left_container">' +
                        '<div class="abs_card_img_box">' +
                        '<img id="aimg' + TEAM_NO + '" class="abs_card_img" src="#">' +
                        '</div>' +
                        '</div>' +
                        '<div class="abs_team_right_container">' +
                        '<div class="abs_team_name_con_2">' +
                        '<p class="abs_team_name">' + TEAM_NAME + '</p>' +
                        '<p class="abs_team_change">팀 변경</p>' +
                        '</div>' +
                        '<div class="abs_team_chk_con">' +
                        '<div class="abs_chk_container" style="margin-bottom: 0;">' +
                        '<input type="checkbox" name="abs_team_check" id="abs_team_check_all" data-role="none">' +
                        '<label for="abs_team_check_all"></label>' +
                        '</div>' +
                        '</div>' +
                        '</div>';
                    $('.abs_team').append(abs_team);

                    var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                    var imgSrc = getImagePromise(new_img).then(value => {
                        $('#aimg' + TEAM_NO).attr('src', value);
                    });

                    var abs_member =
                        '<div class="abs_member_section">' +
                        '<div class="abs_team_left_container">' +
                        '<div class="abs_card_img_box">' +
                        '<img id="aimg' + i + '" class="abs_card_img" src="#">' +
                        '</div>' +
                        '</div>' +
                        '<div class="abs_team_right_container">' +
                        '<div class="abs_team_name_con">' +
                        '<p class="abs_member_name">' + ARTIST_NAME + '</p>' +
                        '</div>' +
                        '<div class="abs_personal_price_container">' +
                        '<input class="personal_price" id="personal_price_' + USER_NO + '" value="0" data-role="none" readonly />' +
                        '<p>원</p>' +
                        '</div>' +
                        '<div class="abs_team_chk_con">' +
                        '<div class="abs_chk_container" style="margin-bottom: 0;">' +
                        '<input type="checkbox" name="abs_member_check" id="abs_member_check_' + USER_NO + '" data-role="none" value="' + USER_NO + '">' +
                        '<label for="abs_member_check_' + USER_NO + '"></label>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>';

                    var new_img2 = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;
                    var imgSrc2 = getImagePromise(new_img2).then(value => {
                        $('#aimg' + i).attr('src', value);
                    });

                    $('.abs_member').append(abs_member);

                    sessionStorage.setItem('abs_team_no', TEAM_NO);
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

            $(DATA3).each(function (i) {
                var CNT = $(this).find("CNT").text();

                cnt = CNT;
            })
        },//end success
        error: function (xhr, message, errorThrown) {
            //hideLoading();
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
        } // end error
    });

}

function abs_close_popup() {
    $("html, body").css({ "overflow": "auto", "height": "auto" });
    $('#artist_busking_popup').unbind('touchmove');

    $('#artist_busking_popup').hide();

    $('#header').show();
    $('#footer').show();
}




function artist_select_go_2(perform_no) {
    if (userLogin_chk() == false) {
        infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
        loadPage('login/login.jsp');
    } else {
        if (artist_chk() == false) {
            infoTxtBox('아티스트만 신청 가능합니다.');
            return;
        }
        else {
            if (team_chk() == false) {
                infoTxtBox('팀/솔로 등록 이후 가능합니다.');
                loadPage('team/team_create.jsp');
            }
        }
    }
    sessionStorage.removeItem('abs_team_no');
    sessionStorage.removeItem('abs_offerprice');

    $("html, body").css({ "overflow": "hidden", "height": "100%" });

    // $('#artist_busking_popup').on('scroll touchmove mousewheel', function (e) {
    //     e.preventDefault();
    //     e.stopPropagation();
    //     return false;
    // });

    $('#artist_busking_popup').load('/app_root/jsp/custom_select_box/artist_busking_select.jsp', function () {
        $('#artist_busking_popup').show();

        $('#header').hide();
        $('#footer').hide();
    });
    var user_no = $('#user_no').val();
    var perform_no = perform_no;
    // console.log(perform_no);
    // console.log('user_no : ' + user_no);


    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/detail_store/get_artist_busking_select.jsp',
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
                var BUSKINGSTATUS = $(this).find("BUSKINGSTATUS").text();
                var BUSINESS_WORKNAME = $(this).find("BUSINESS_WORKNAME").text();
                var SPACE_PICTURE = $(this).find("SPACE_PICTURE").text();
                var store_user_no = $(this).find("USER_NO").text();

                sessionStorage.setItem('apc_buskingDate', BUSKINGDATE);
                sessionStorage.setItem('apc_buskingTime', STARTINGTIME + '-' + FINISHINGTIME);
                //-----------------------------날짜--------------------------------------------
                $('.abs_title').empty();
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

                var abs_body_title = '<p>' + busking_month + '월 ' + busking_day + '일 공연 신청</p>';
                $('.abs_title').append(abs_body_title);
                //--------------------------------------------------------------------------------


                //------------------------------상업공간 정보--------------------------------------
                $('.abs_card_container').empty();
                if (BUSKINGSTATUS == '1' || BUSKINGSTATUS == '2') {
                    var buskingstatus = '신청불가';
                }
                else if (BUSKINGSTATUS == '3') {
                    var buskingstatus = '신청가능';
                }

                var abs_body_content_a_detail_info =
                    '<div class="abs_card_img_container">' +
                    '<div class="abs_card_img_box">' +
                    '<img id="simg' + PERFORM_NO + '" class="abs_card_img" src="#">' +
                    '</div>' +
                    '</div>' +
                    '<div class="abs_card">' +
                    '<div class="abs_card_top_container">' +
                    '<div class="abs_card_title">' +
                    '<p>' + BUSINESS_WORKNAME + '</p>' +
                    '</div>' +
                    '<div class="abs_card_confirm">' +
                    '<p>공간 정보 ></p>' +
                    '</div>' +
                    '</div>' +
                    '<div class="abs_card_time">' +
                    '<p>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</p>' +
                    '</div>' +
                    '<div class="abs_card_contract">' +
                    '<p>' + buskingstatus + '</p>' +
                    '</div>' +
                    '</div>';

                $('.abs_card_container').append(abs_body_content_a_detail_info);

                var space_pic = SPACE_PICTURE.split(',')[0];
                var new_img3 = 'upload/store/space/space' + store_user_no + "/" + space_pic;
                var imgSrc3 = getImagePromise(new_img3).then(value => {
                    $('#simg' + PERFORM_NO).attr('src', value);
                });


                $('.abs_price_container').empty();
                sessionStorage.setItem('abs_offerprice', OFFERPRICE);
                OFFERPRICE = OFFERPRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 	
                var abs_price_container =
                    '<div class="abs_price_container">' +
                    '<div class="abs_price_title">' +
                    '<p>공연비</p>' +
                    '</div>' +
                    '<div class="abs_price_total">' +
                    '<p>' + OFFERPRICE + ' 원</p>' +
                    '</div>' +
                    '</div>' +
                    '<div class="abs_price_container" style="margin-top: 10px;">' +
                    '<div class="abs_price_title">' +
                    '<p>잔여 공연비</p>' +
                    '</div>' +
                    '<div class="abs_price">' +
                    '<p style="color: #F76C4A;">' + OFFERPRICE + ' 원</p>' +
                    '</div>' +
                    '</div>';
                $('.abs_price_wrap').append(abs_price_container);
                //---------------------------------------------------------------------------------

                //------------------------------신청 팀 정보--------------------------------------
                $(DATA2).each(function (i) {
                    var USER_NO = $(this).find("USER_NO").text();
                    var TEAM_NO = $(this).find("TEAM_NO").text();
                    var TEAM_NAME = $(this).find("TEAM_NAME").text();
                    var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
                    var TINTRO_IMG = $(this).find("TINTRO_IMG").text();
                    var ARTIST_IMG = $(this).find("ARTIST_IMG").text();

                    sessionStorage.setItem('apc_teamName', TEAM_NAME);

                    $('.abs_team').empty();
                    var abs_team =
                        '<div class="abs_team_left_container">' +
                        '<div class="abs_card_img_box">' +
                        '<img id="aimg' + TEAM_NO + '" class="abs_card_img" src="#">' +
                        '</div>' +
                        '</div>' +
                        '<div class="abs_team_right_container">' +
                        '<div class="abs_team_name_con_2">' +
                        '<p class="abs_team_name">' + TEAM_NAME + '</p>' +
                        '<p class="abs_team_change">팀 변경</p>' +
                        '</div>' +
                        '<div class="abs_team_chk_con">' +
                        '<div class="abs_chk_container" style="margin-bottom: 0;">' +
                        '<input type="checkbox" name="abs_team_check" id="abs_team_check_all" data-role="none">' +
                        '<label for="abs_team_check_all"></label>' +
                        '</div>' +
                        '</div>' +
                        '</div>';
                    $('.abs_team').append(abs_team);

                    var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                    var imgSrc = getImagePromise(new_img).then(value => {
                        $('#aimg' + TEAM_NO).attr('src', value);
                    });

                    var abs_member =
                        '<div class="abs_member_section">' +
                        '<div class="abs_team_left_container">' +
                        '<div class="abs_card_img_box">' +
                        '<img id="aimg' + i + '" class="abs_card_img" src="#">' +
                        '</div>' +
                        '</div>' +
                        '<div class="abs_team_right_container">' +
                        '<div class="abs_team_name_con">' +
                        '<p class="abs_member_name">' + ARTIST_NAME + '</p>' +
                        '</div>' +
                        '<div class="abs_personal_price_container">' +
                        '<input class="personal_price" id="personal_price_' + USER_NO + '" value="0" data-role="none" readonly />' +
                        '<p>원</p>' +
                        '</div>' +
                        '<div class="abs_team_chk_con">' +
                        '<div class="abs_chk_container" style="margin-bottom: 0;">' +
                        '<input type="checkbox" name="abs_member_check" id="abs_member_check_' + USER_NO + '" data-role="none" value="' + USER_NO + '">' +
                        '<label for="abs_member_check_' + USER_NO + '"></label>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>';

                    var new_img2 = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;
                    var imgSrc2 = getImagePromise(new_img2).then(value => {
                        $('#aimg' + i).attr('src', value);
                    });

                    $('.abs_member').append(abs_member);

                    sessionStorage.setItem('abs_team_no', TEAM_NO);
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

            $(DATA3).each(function (i) {
                var CNT = $(this).find("CNT").text();

                cnt = CNT;
            })
        },//end success
        error: function (xhr, message, errorThrown) {
            //hideLoading();
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
        } // end error
    });

}