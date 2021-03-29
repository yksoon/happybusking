function go_contract_list() {
    loadPage('busking_time_contract/busking_time_contract_list.jsp');
}


function get_btcl_select_date(search_year, search_month) {
    var user_no = $('#user_no').val();
    // console.log(user_no);

    if (search_month.length == '1') {
        search_month = '0' + search_month;
    }
    var search_date = search_year + '-' + search_month;

    if (userLogin_chk() == false) {
        alert('로그인 하시고 해당 서비스를 이용해주세요');
        loadPage('login/login.jsp');
    } else {
        if (owner_chk()) {
            get_btc_owner_list(user_no, search_date);
        } else {
            get_btc_artist_list(user_no, search_date);
        }
    }



}


function get_btc_owner_list(user_no, search_date) {
    var cont_stat_arr = [];
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/busking_time_contract/busking_time_contract_list_all.jsp',
        data: {
            user_no: user_no,
            search_date: search_date
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');
            var DATA2 = $(ROOT).find('DATA2');

            $(DATA).each(function (i) {
                var PERFORM_NO = $(this).find("PERFORM_NO").text();
                var TEAM_NAME = $(this).find("TEAM_NAME").text();
                var TEAM_NO = $(this).find("TEAM_NO").text();
                var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
                var DAYOFTHEWEEK = $(this).find("DAYOFTHEWEEK").text();
                var STARTINGTIME = $(this).find("STARTINGTIME").text();
                var FINISHINGTIME = $(this).find("FINISHINGTIME").text();
                var MATCHING_CHK = $(this).find("MATCHING_CHK").text();
                var TINTRO_IMG = $(this).find("TINTRO_IMG").text();

                var busking_day_arr = BUSKINGDATE.split('-');
                var busking_day = busking_day_arr[2];

                // console.log(busking_day);

                // console.log($('.btcl_day p').val());

                var sessBuskingDay = sessionStorage.getItem('busking_day');
                // console.log('ss' + sessBuskingDay);
                if (sessBuskingDay != busking_day + STARTINGTIME + FINISHINGTIME) {
                    sessionStorage.setItem('busking_day', busking_day + STARTINGTIME + FINISHINGTIME);
                    var btcl_mid_date_container =
                        '<div class="btcl_mid_date_container">' +
                        '<div class="btcl_day">' +
                        '<p>' + busking_day + '일(' + DAYOFTHEWEEK + ')</p>' +
                        '</div>' +
                        '<div class="btcl_dayofweek">' +
                        '<p>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</p>' +
                        '</div>'
                    '</div>';
                } else {
                    var btcl_mid_date_container = '';
                }
                $('.btcl_mid_container').append(btcl_mid_date_container);


                // console.log(MATCHING_CHK);
                // (1: 공연 승인, 2: 공연 거절, 3: 모집중, 4: 승인 대기, 5: 공연 완료)
                if (MATCHING_CHK == '1') {
                    var matching_chk = '승인 대기';
                }
                else if (MATCHING_CHK == '2') {
                    var matching_chk = '신청 취소';
                }
                else if (MATCHING_CHK == '3') {
                    var matching_chk = '공연 승인';
                }
                else if (MATCHING_CHK == '4') {
                    var matching_chk = '공연 거절';
                }

                if (TEAM_NO) {
                    var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                    var imgSrc = getImagePromise(new_img).then(value => {
                        $('#aimg' + PERFORM_NO).attr('src', value);
                        // console.log('#aimg' + PERFORM_NO);
                    });
                }

                var btcl_card_container =
                    '<div class="btcl_card_container" onclick="go_apply_detailPage(\'' + TEAM_NO + '\',\'' + PERFORM_NO + '\',\'' + MATCHING_CHK + '\',\'' + '' + '\' );">' +
                    '<div class="btcl_card_img_container">' +
                    '<div class="btcl_card_img_box">' +
                    '<img id="aimg' + PERFORM_NO + '" class="btcl_card_img">' +
                    '</div>' +
                    '</div>' +
                    '<div class="btcl_card">' +
                    '<div class="btcl_card_top_container">' +
                    '<div class="btcl_card_title">' +
                    '<p>' + TEAM_NAME + '</p>' +
                    '</div>' +
                    '<div class="btcl_card_confirm">' +
                    '<p>' + matching_chk + '</p>' +
                    '</div>' +
                    '</div>' +
                    // '<div class="btcl_card_time">' +
                    // '<p>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</p>' +
                    // '</div>' +
                    '<div class="btcl_card_contract">' +
                    '<p>계약 대기</p>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
                // '<input type="hidden" id="btcl_perform_no" value="<%=' + PERFORM_NO + ' %>">';

                $('.btcl_mid_container').append(btcl_card_container);


                $(DATA2).each(function (i) {
                    var CONTRACT_STATUS = $(this).find("CONTRACT_STATUS").text();

                    cont_stat_arr.push(CONTRACT_STATUS);
                    cont_stat_arr = Array.from(new Set(cont_stat_arr)); //중복 제거

                    console.log(PERFORM_NO + " " + CONTRACT_STATUS);

                    var contract_status;
                    if (cont_stat_arr.length === 1 && cont_stat_arr[0] === "1") {
                        contract_status = "전자계약 대기"
                    }
                    else if (cont_stat_arr.length === 2 || (cont_stat_arr.length === 1 && cont_stat_arr[0] === "2")) {
                        contract_status = "전자계약 진행중"
                    }
                    else if (cont_stat_arr.length === 1 && cont_stat_arr[0] === "3") {
                        contract_status = "전자계약 완료"
                    }
                    $('.btcl_card_contract').children("p").text(contract_status);

                });

            }).promise().done(function () {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                // console.log($('.btcl_card_container').length);
                sessionStorage.removeItem('busking_day');
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


function get_btc_artist_list(user_no, search_date) {
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/busking_time_contract/get_busking_time_contract_list_artist.jsp',
        data: {
            user_no: user_no,
            search_date: search_date
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function (i) {
                var USER_NO = $(this).find("USER_NO").text();
                var PERFORM_NO = $(this).find("PERFORM_NO").text();
                var TEAM_NO = $(this).find("TEAM_NO").text();
                var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
                var DAYOFTHEWEEK = $(this).find("DAYOFTHEWEEK").text();
                var STARTINGTIME = $(this).find("STARTINGTIME").text();
                var FINISHINGTIME = $(this).find("FINISHINGTIME").text();
                var MATCHING_CHK = $(this).find("MATCHING_CHK").text();
                var BUSINESS_WORKNAME = $(this).find("BUSINESS_WORKNAME").text();
                var SPACE_PICTURE = $(this).find("SPACE_PICTURE").text();

                var busking_day_arr = BUSKINGDATE.split('-');
                var busking_day = busking_day_arr[2];

                console.log(busking_day);

                // console.log($('.btcl_day p').val());

                var sessBuskingDay = sessionStorage.getItem('busking_day');

                if (sessBuskingDay != busking_day) {
                    sessionStorage.setItem('busking_day', busking_day);
                    var btcl_mid_date_container =
                        '<div class="btcl_mid_date_container">' +
                        '<div class="btcl_day">' +
                        '<p>' + busking_day + '일</p>' +
                        '</div>' +
                        '<div class="btcl_dayofweek">' +
                        '<p>' + DAYOFTHEWEEK + '요일</p>' +
                        '</div>'
                    '</div>';
                } else if (sessBuskingDay == busking_day) {
                    var btcl_mid_date_container =
                        '<div class="btcl_mid_date_container">' +
                        '<div class="btcl_day">' +
                        '<p>' + busking_day + '일</p>' +
                        '</div>' +
                        '<div class="btcl_dayofweek">' +
                        '<p>' + DAYOFTHEWEEK + '요일</p>' +
                        '</div>'
                    '</div>';
                }
                $('.btcl_mid_container').append(btcl_mid_date_container);


                // (1: 공연 승인, 2: 공연 거절, 3: 모집중, 4: 승인 대기, 5: 공연 완료)
                if (MATCHING_CHK == '1') {
                    var buskingstatus = '공연 신청'
                }
                else if (MATCHING_CHK == '2') {
                    var buskingstatus = '신청 취소'
                }
                else if (MATCHING_CHK == '3') {
                    var buskingstatus = '공연 승인'
                }
                else if (MATCHING_CHK == '4') {
                    var buskingstatus = '공연 거절'
                }
                else if (MATCHING_CHK == '공연완료') {
                    var buskingstatus = '공연 완료'
                }

                var space_pic = SPACE_PICTURE.split(',')[0];
                var new_img = 'upload/store/space/space' + USER_NO + "/" + space_pic;
                var imgSrc = getImagePromise(new_img).then(value => {
                    $('#aimg' + PERFORM_NO).attr('src', value);
                    console.log('#aimg' + PERFORM_NO);
                });
                var btcl_card_container =
                    '<div class="btcl_card_container" onclick="go_apply_detailPage(\'' + TEAM_NO + '\',\'' + PERFORM_NO + '\',\'' + MATCHING_CHK + '\');">' +
                    '<div class="btcl_card_img_container">' +
                    '<div class="btcl_card_img_box">' +
                    '<img id="aimg' + PERFORM_NO + '" class="btcl_card_img">' +
                    '</div>' +
                    '</div>' +
                    '<div class="btcl_card">' +
                    '<div class="btcl_card_top_container">' +
                    '<div class="btcl_card_title">' +
                    '<p>' + BUSINESS_WORKNAME + '</p>' +
                    '</div>' +
                    '<div class="btcl_card_confirm">' +
                    '<p>' + buskingstatus + '</p>' +
                    '</div>' +
                    '</div>' +
                    '<div class="btcl_card_time">' +
                    '<p>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</p>' +
                    '</div>' +
                    '<div class="btcl_card_contract">' +
                    '<p>계약 대기</p>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
                // '<input type="hidden" id="btcl_perform_no" value="<%=' + PERFORM_NO + ' %>">';

                $('.btcl_mid_container').append(btcl_card_container);

            }).promise().done(function () {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                sessionStorage.removeItem('busking_day');
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

function go_apply_detailPage(team_no, PERFORM_NO, MATCHING_CHK, BUSKINGSTATUS) {
    tno = team_no;
    sessionStorage.setItem('TNO', team_no);
    sessionStorage.setItem('btcl_perform_no', PERFORM_NO);
    sessionStorage.setItem('btcl_matching_chk', MATCHING_CHK);
    sessionStorage.setItem('btcl_buskingstatus', BUSKINGSTATUS);
    loadPage('busking_time_contract/busking_time_apply_detail.jsp');
}