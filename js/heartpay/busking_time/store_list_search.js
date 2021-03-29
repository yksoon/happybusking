// 검색창에 입력후 엔터
$(document).on('keyup', '#sls_search_bar', function (e) {

    // 검색어 입력시 생기는 X버튼
    if ($('#sls_search_bar').val() != "") {
        var sls_input_cancel =
            '<img class="sls_input_cancel_img" id="sls_input_cancel" src="/img/store/storeList_search_cancel.svg" />';

        if ($('.sls_input_cancel_img').length === 0) {
            $('.sls_input_cancel_div').append(sls_input_cancel);
        }
    } else {
        $('.sls_input_cancel_div').empty();
    }

    //엔터 누를시
    if (e.keyCode == 13) {
        var sls_search_result = $(this).val()
        // console.log(sls_search_result);

        show_my_store_list_2('', '', '', sls_search_result)
    }
});

// 취소버튼 눌렀을시
$(document).on('click', '#sls_cancel', function () {
    if ($('#sls_search_bar').val() == '' || $('#sls_search_bar').val('') == null) {
        sl_backbtn();
    } else {
        $('#sls_search_bar').val('');   // 내용지우기
        $('.sls_input_cancel_div').empty();
    }
});

// 엑스 버튼 누를 시
$(document).on('click', '#sls_input_cancel', function () {
    $('#sls_search_bar').val("");
    $('.sls_input_cancel_div').empty();
    $('.sls_result_content').empty();
    var sls_plz_search =
        '<div class="sls_plz_search">' +
        '<p>검색어를 입력하세요</p>' +
        '</div>';
    $('.sls_result_content').append(sls_plz_search);
})



function show_my_store_list_2(slArea, slMonth, slGenre, sls_search_result) {
    $('.sls_result_content').empty();

    // if (!owner_chk() && artist_chk()) {
    //     var user_no = $('#user_no').val();
    // }
    // else if (!owner_chk() && !artist_chk()) {
    //     var user_no = ''
    // }
    // else if (owner_chk()) {
    //     var user_no = $('#user_no').val();
    // }
    if ($("#my_perform_chk").is(":checked")) {
        var user_no = $('#user_no').val();
    }
    else {
        var user_no = ''
    }

    slArea = sessionStorage.getItem('slArea');
    slMonth = sessionStorage.getItem('slMonth');
    slGenre = sessionStorage.getItem('slGenre');

    // console.log(slArea);
    // console.log(slMonth);
    // console.log(slGenre);
    // console.log(user_no);

    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/busking_time/store_list.jsp',
        data: {
            user_no: user_no,
            slArea: slArea,
            slMonth: slMonth,
            slGenre: slGenre,
            sls_search_result: sls_search_result
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            var sl_tab_container;
            if (DATA.length === 0) {
                sl_tab_container =
                    '<div class="sls_plz_search">' +
                    '<p>검색 결과가 없습니다.</p>' +
                    '</div>';

                $('.sls_result_content').append(sl_tab_container);
            } else {
                $(DATA).each(function (i) {
                    var PERFORM_NO = $(this).find("PERFORM_NO").text();
                    var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
                    var STARTINGTIME = $(this).find("STARTINGTIME").text();
                    var FINISHINGTIME = $(this).find("FINISHINGTIME").text();
                    var TEAM_NAME = $(this).find("TEAM_NAME").text();
                    var BUSINESS_WORKNAME = $(this).find("BUSINESS_WORKNAME").text();
                    var ADDRESS = $(this).find("ADDRESS").text();
                    var HASHTAG = $(this).find("HASHTAG").text();
                    var BUSKINGSTATUS = $(this).find("BUSKINGSTATUS").text();
                    var USER_NO = $(this).find("USER_NO").text();
                    var SPACE_PICTURE = $(this).find("SPACE_PICTURE").text();



                    var busking_day_arr = BUSKINGDATE.split('-');

                    if (busking_day_arr[1].length == 1) {
                        var busking_day_month = '0' + busking_day_arr[1];
                    } else {
                        var busking_day_month = busking_day_arr[1];
                    }

                    if (busking_day_arr[2].length == 1) {
                        var busking_day_date = '0' + busking_day_arr[2];
                    } else {
                        var busking_day_date = busking_day_arr[2];
                    }
                    var busking_day = busking_day_month + '-' + busking_day_date;

                    // console.log(busking_day);

                    // console.log($('.btcl_day p').val());


                    var addr_spl = ADDRESS.split(" ");
                    var addr = addr_spl[0] + " " + addr_spl[1];

                    // 팀 상태
                    if (TEAM_NAME == '' || TEAM_NAME == null) {
                        var team_name = "모집중";
                    } else {
                        var team_name = TEAM_NAME;
                    }

                    var hash_arr = HASHTAG.split(",");
                    let hash = '';
                    for (i = 0; i < hash_arr.length; i++) {
                        hash = hash + hash_arr[i] + '&nbsp&nbsp&nbsp';
                    }

                    var buskingstatus = '';
                    // (1: 공연 승인, 2: 공연 거절, 3: 모집중, 4: 승인 대기, 5: 공연 완료)
                    if (BUSKINGSTATUS == '1') {
                        buskingstatus =
                            '<div class="sl_recruitment_status" style="border: 1px solid #9899AC; color: #666;">' +
                            '모집완료' +
                            '</div>';
                    }
                    else if (BUSKINGSTATUS == '3') {
                        buskingstatus =
                            '<div class="sl_recruitment_status" style="border: 1px solid #8355c8; color: #8355c8;">' +
                            '모집중' +
                            '</div>';
                    }
                    else if (BUSKINGSTATUS == '5') {
                        buskingstatus =
                            '<div class="sl_recruitment_status" style="border: 1px solid #9899AC; color: #666;">' +
                            '공연완료' +
                            '</div>';
                    }
                    else if (BUSKINGSTATUS == '모집마감') {
                        buskingstatus =
                            '<div class="sl_recruitment_status" style="border: 1px solid #9899AC; color: #666;">' +
                            '모집마감' +
                            '</div>';
                    }


                    sl_tab_container =
                        '<div class="sl_tab_container" id="sl_tab_container">' +
                        '<div class="sl_tab_container_left">' +
                        '<img class ="sl_tab_container_img" id="aimg' + PERFORM_NO + '">' +
                        '</div>' +
                        '<div class="sl_tab_container_right">' +
                        '<div class="sl_tab_container_right_left">' +
                        '<div class="sl_tab_title_container">' +
                        buskingstatus +
                        '<p class="sl_store_name">' +
                        BUSINESS_WORKNAME +
                        '</p>' +
                        '</div>' +
                        '<div class="sl_addr">' +
                        addr +
                        '</div>' +
                        '<div class="sl_perform_team">' +
                        '공연팀 : ' + team_name +
                        '</div>' +
                        '<div class="sl_hashtag_container">' +
                        '<span class="sl_hashtag">' + hash + '</span>' +
                        '</div>' +
                        '</div>' +
                        '<div class="sl_tab_container_right_right">' +
                        '<div class="sl_perform">' +
                        '<div class="sl_perform_date">' +
                        busking_day +
                        '</div>' +
                        '<div class="sl_perform_time sl_startime">' +
                        STARTINGTIME +
                        '</div>' +
                        '<div class="sl_perform_time sl_endtime">' +
                        FINISHINGTIME +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '<input type="hidden" value="' + PERFORM_NO + '" id="sl_perform_no">' +
                        '</div>';

                    $('.sls_result_content').append(sl_tab_container);

                    var space_pic = SPACE_PICTURE.split(',')[0];
                    var new_img = 'upload/store/space/space' + USER_NO + "/" + space_pic;
                    var imgSrc = getImagePromise(new_img).then(value => {
                        $('#aimg' + PERFORM_NO).attr('src', value);
                        // console.log('#aimg' + PERFORM_NO);
                    });

                }).promise().done(function () {
                    $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                });
            }
        },//end success
        error: function (xhr, message, errorThrown) {
            //hideLoading();
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
        } // end error
    });
}