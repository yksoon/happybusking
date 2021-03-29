function go_store_list() {
    loadPage('busking_time/store_list.jsp');
}

// 공연등록 버튼 클릭시
function go_sl_busking_time_reg() {
    if (userLogin_chk() == false) {
        alert('로그인 하시고 해당 서비스를 이용해주세요');
        loadPage('login/login.jsp');
    } else {
        if (!owner_chk()) {

            $('#custom_sl_popup').load('/app_root/jsp/custom_select_box/custom_store_list.jsp', function () {
                $("html, body").css({ "overflow": "hidden", "height": "100%" });

                $('#custom_sl_popup').show();

                $('#header').hide();
                $('#footer').hide();

                $('#sl_reg_perform_btn').hide();
            });

        } else {
            loadPage('busking_time/busking_time_reg_each.jsp');
        }
    }
}

// 방문객일경우 내공연보기 높이 조절
function visitors_css() {
    if (!owner_chk() && !artist_chk()) {
        if ($('.sl_header_second_menu_contant').css("display") == "none") {
            $('.sl_top_container').css("margin-top", "0px");
        } else if ($('.sl_header_second_menu_contant').css("display") == "block") {
            $('.sl_top_container').css("margin-top", "55px");
        }
    } else {
        return false
    }
}

// 검색 아이콘 클릭시 페이지 이동
function sl_toSearch() {
    loadPage('busking_time/store_list_search.jsp');
}

function sl_backbtn() {
    loadPage('busking_time/store_list.jsp');
}

function close_sl_popup() {
    $("html, body").css({ "overflow": "auto", "height": "auto" });
    $('#custom_sl_popup').unbind('touchmove');

    $('#custom_sl_popup').hide();

    $('#header').show();
    $('#footer').show();
    $('#sl_reg_perform_btn').show();
}

var sl_ranking_count;
// function show_my_store_list(slArea, slMonth, slGenre, artist, user_no, recruiting, recruited) {
function show_my_store_list() {
    $('.sl_content_container').empty();

    // if (!owner_chk() && artist_chk()) {
    //     var user_no = $('#user_no').val();
    // }
    // else if (!owner_chk() && !artist_chk()) {
    //     var user_no = ''
    // }
    // else if (owner_chk()) {
    //     var user_no = $('#user_no').val();
    // }
    // if ($("#my_perform_chk").is(":checked")) {
    //     var user_no = $('#user_no').val();
    //     var artist = artist;
    // }
    // else {
    //     var user_no = ''
    // }

    slArea = sessionStorage.getItem('slArea');
    slMonth = sessionStorage.getItem('slMonth');
    slGenre = sessionStorage.getItem('slGenre');
    user_no = sessionStorage.getItem('sl_user_no');
    artist = sessionStorage.getItem('sl_artist');
    recruiting = sessionStorage.getItem('sl_recruiting');
    recruited = sessionStorage.getItem('sl_recruited');

    // console.log(slArea);
    // console.log(slMonth);
    // console.log(slGenre);
    // console.log(user_no);
    var sl_Limit = sessionStorage.getItem('sl_Limit');
    var sl_Last = 20;

    if (sl_Limit === null || sl_Limit === 'null') {
        sl_Limit = 0;
        sessionStorage.setItem('sl_Limit', sl_Limit);
    } else {
        sl_Last = parseInt(sl_Limit) + 20;
        sl_Limit = 0;
    }



    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/busking_time/store_list.jsp',
        data: {
            user_no: user_no,
            slArea: slArea,
            slMonth: slMonth,
            slGenre: slGenre,
            artist: artist,
            recruiting: recruiting,
            recruited: recruited,
            sl_Limit: sl_Limit,
            sl_Last: sl_Last
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            // console.log(DATA.length);

            var sl_tab_container;
            if (DATA.length === 0) {
                sl_tab_container =
                    '<div class="sls_plz_search">' +
                    '<p>등록된 공연이 없습니다.</p>' +
                    '</div>';

                $('.sl_content_container').append(sl_tab_container);
            } else {
                let z = 0;
                $(DATA).each(function (i) {
                    z++;
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

                    $('.sl_content_container').append(sl_tab_container);
                    var space_pic = SPACE_PICTURE.split(',')[0];
                    var new_img = 'upload/store/space/space' + USER_NO + "/" + space_pic;
                    var imgSrc = getImagePromise(new_img).then(value => {
                        $('#aimg' + PERFORM_NO).attr('src', value);
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
        }, // end error
        complete: function () {
            var scroll = sessionStorage.getItem('sl_Scroll');
            if (scroll == null) {
                $(window).scrollTop(0);
            } else {
                $('html,body').animate({ scrollTop: scroll }, 'fast');
            }
        }
    });
}

// function getMore_store_list(slArea, slMonth, slGenre, artist, user_no, recruiting, recruited) {
function getMore_store_list() {
    slArea = sessionStorage.getItem('slArea');
    slMonth = sessionStorage.getItem('slMonth');
    slGenre = sessionStorage.getItem('slGenre');
    user_no = sessionStorage.getItem('sl_user_no');
    artist = sessionStorage.getItem('sl_artist');
    recruiting = sessionStorage.getItem('sl_recruiting');
    recruited = sessionStorage.getItem('sl_recruited');

    // console.log(slArea);
    // console.log(slMonth);
    // console.log(slGenre);
    // console.log(user_no);
    var sl_Limit = sessionStorage.getItem('sl_Limit');

    if (sl_Limit === null || sl_Limit === 'null') {
        sl_Limit = 20;
    } else {
        sl_Limit = parseInt(sl_Limit) + 20;
    }
    sessionStorage.setItem('sl_Limit', sl_Limit);


    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/busking_time/store_list.jsp',
        data: {
            user_no: user_no,
            slArea: slArea,
            slMonth: slMonth,
            slGenre: slGenre,
            artist: artist,
            recruiting: recruiting,
            recruited: recruited,
            sl_Limit: sl_Limit
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            // console.log(DATA.length);

            var sl_tab_container;
            let z = 0;
            $(DATA).each(function (i) {
                z++;
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

                $('.sl_content_container').append(sl_tab_container);
                var space_pic = SPACE_PICTURE.split(',')[0];
                var new_img = 'upload/store/space/space' + USER_NO + "/" + space_pic;
                var imgSrc = getImagePromise(new_img).then(value => {
                    $('#aimg' + PERFORM_NO).attr('src', value);
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
        }, // end error
        complete: function () {
        }
    });
}

// 전체탭 클릭시
function go_sl_all() {
    $('.sl_header_second_menu_contant').empty();
    $("input:radio[name='my_perform_radio']").removeAttr("checked");
    $("input:checkbox[id='my_perform_chk']").prop("checked", false);

    var sl_menu = '';
    $('.store_list_header_menu_container').empty();
    sl_menu = '<div class="store_list_menu ui-block-a">' +
        '<div class="sl_header_tab" style="border-bottom: 3px solid #8354C8; font: normal normal bold 15px/45px SpoqaHanSans; color: #8354C8;">' +
        '전체' +
        '</div>' +
        '</div>' +
        '<div class="store_list_menu ui-block-b">' +
        '<div class="sl_header_tab" onclick="go_sl_area()">' +
        '지역' +
        '</div>' +
        '</div>' +
        '<div class="store_list_menu ui-block-c">' +
        '<div class="sl_header_tab" onclick="go_sl_month()">' +
        '월별' +
        '</div>' +
        '</div>' +
        '<div class="store_list_menu ui-block-d">' +
        '<div class="sl_header_tab" onclick="go_sl_genre()">' +
        '장르' +
        '</div>' +
        '</div>';
    $('.store_list_header_menu_container').append(sl_menu);

    $('.slm_body_content').css("top", "134px");
    $('.sl_top_container').css('margin-top', '55px');
    $('.sl_header_second_menu_contant').css("display", "none");
    visitors_css();
    $('html').scrollTop(0); //페이지 최상단 이동

    sessionStorage.removeItem('slArea');
    sessionStorage.removeItem('slMonth');
    sessionStorage.removeItem('slGenre');
    sessionStorage.removeItem('sl_Scroll');
    sessionStorage.removeItem('sl_Limit');
    sessionStorage.removeItem('sl_user_no');
    sessionStorage.removeItem('sl_artist');
    sessionStorage.removeItem('sl_recruiting');
    sessionStorage.removeItem('sl_recruited');
    show_my_store_list();
}

// 지역탭 클릭시
function go_sl_area() {
    sessionStorage.removeItem('sl_user_no');
    sessionStorage.removeItem('sl_artist');
    sessionStorage.removeItem('sl_recruiting');
    sessionStorage.removeItem('sl_recruited');
    sessionStorage.removeItem('sl_Scroll');
    sessionStorage.removeItem('sl_Limit');
    $("input:radio[name='my_perform_radio']").removeAttr("checked");
    $("input:checkbox[id='my_perform_chk']").prop("checked", false);

    // var art = sessionStorage.getItem('sl_artist')
    // console.log('art ' + art);

    //초기 클릭시 서울로
    var slArea = sessionStorage.getItem('slArea');
    if (slArea == null) {
        slArea = '서울';
        sessionStorage.setItem('slArea', slArea);
    }
    sessionStorage.removeItem('slMonth');
    sessionStorage.removeItem('slGenre');

    show_my_store_list(slArea, '', '');

    var sl_menu = '';
    $('.store_list_header_menu_container').empty();
    sl_menu = '<div class="store_list_menu ui-block-a">' +
        '<div class="sl_header_tab" onclick="go_sl_all()">' +
        '전체' +
        '</div>' +
        '</div>' +
        '<div class="store_list_menu ui-block-b">' +
        '<div class="sl_header_tab"  style="border-bottom: 3px solid #8354C8; font: normal normal bold 15px/45px SpoqaHanSans; color: #8354C8;">' +
        '지역' +
        '</div>' +
        '</div>' +
        '<div class="store_list_menu ui-block-c">' +
        '<div class="sl_header_tab" onclick="go_sl_month()">' +
        '월별' +
        '</div>' +
        '</div>' +
        '<div class="store_list_menu ui-block-d">' +
        '<div class="sl_header_tab" onclick="go_sl_genre()">' +
        '장르' +
        '</div>' +
        '</div>';
    $('.store_list_header_menu_container').append(sl_menu);

    $('.sl_top_container').css('margin-top', '95px');
    $('.sl_header_second_menu_contant').css("display", "block");
    $('.slm_body_content').css("top", "174px");
    visitors_css();

    $('html').scrollTop(0); //페이지 최상단 이동

    $('.sl_header_second_menu_contant').empty();
    var sl_menu_touch = '';
    sl_menu_touch =
        '<div id="touchFlow4" class="nav_h_type">' +
        '<ul id="sl_area" style="padding: 0;">' +
        '</ul>' +
        '</div>';
    $('.sl_header_second_menu_contant').append(sl_menu_touch);

    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/common/get_area_code.jsp',
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function (i) {
                var AREA_NAME = $(this).find("AREA_NAME").text();
                if (AREA_NAME == slArea) {
                    var li_content = '<li class="area_on">' + AREA_NAME + '</li>';
                }
                else {
                    li_content = '<li value="' + AREA_NAME + '">' + AREA_NAME + '</li>';
                }
                $('#sl_area').append(li_content);

            }).promise().done(function () {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                touch_slide4();
            });
        },//end success
        error: function (xhr, message, errorThrown) {
            //hideLoading();
        } // end error
    });

    //지역탭에서 슬라이드바 선택시 
    $('#sl_area').delegate('li', "click", function () {
        var slArea = sessionStorage.getItem('slArea');
        if (slArea == null) {
            slArea = '서울';
        }

        sessionStorage.setItem('slArea', $(this).text());

        $('#sl_area li').removeClass('area_on');
        $(this).addClass('area_on');

        slArea = sessionStorage.getItem('slArea');
        var artist = sessionStorage.getItem('sl_artist');
        var user_no = sessionStorage.getItem('sl_user_no');
        var recruiting = sessionStorage.getItem('sl_recruiting');
        var recruited = sessionStorage.getItem('sl_recruited');

        show_my_store_list(slArea, '', '', artist, user_no, recruiting, recruited);
    });
}


// 월별 클릭시
var today = new Date();//오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
function go_sl_month() {
    sessionStorage.removeItem('sl_user_no');
    sessionStorage.removeItem('sl_artist');
    sessionStorage.removeItem('sl_recruiting');
    sessionStorage.removeItem('sl_recruited');
    sessionStorage.removeItem('sl_Scroll');
    sessionStorage.removeItem('sl_Limit');

    $("input:radio[name='my_perform_radio']").removeAttr("checked");
    $("input:checkbox[id='my_perform_chk']").prop("checked", false);

    // 초기 클릭시 현재 월 기준
    var slMonth = sessionStorage.getItem('slMonth');
    if (slMonth == null) {
        slMonth = moment(new Date(today.getFullYear(), today.getMonth())).format('MM');
        sessionStorage.setItem('slMonth', slMonth);
    }
    sessionStorage.removeItem('slArea');
    sessionStorage.removeItem('slGenre');

    show_my_store_list('', slMonth, '');

    var sl_menu = '';
    $('.store_list_header_menu_container').empty();
    sl_menu = '<div class="store_list_menu ui-block-a">' +
        '<div class="sl_header_tab" onclick="go_sl_all()">' +
        '전체' +
        '</div>' +
        '</div>' +
        '<div class="store_list_menu ui-block-b">' +
        '<div class="sl_header_tab" onclick="go_sl_area()">' +
        '지역' +
        '</div>' +
        '</div>' +
        '<div class="store_list_menu ui-block-c">' +
        '<div class="sl_header_tab" style="border-bottom: 3px solid #8354C8; font: normal normal bold 15px/45px SpoqaHanSans; color: #8354C8;">' +
        '월별' +
        '</div>' +
        '</div>' +
        '<div class="store_list_menu ui-block-d">' +
        '<div class="sl_header_tab" onclick="go_sl_genre()">' +
        '장르' +
        '</div>' +
        '</div>';
    $('.store_list_header_menu_container').append(sl_menu);

    $('.slm_body_content').css("top", "174px");
    $('.sl_top_container').css('margin-top', '95px');
    $('.sl_header_second_menu_contant').css("display", "block");
    visitors_css();
    $('html').scrollTop(0); //페이지 최상단 이동

    $('.sl_header_second_menu_contant').empty();
    var sl_menu_touch = '';
    sl_menu_touch =
        '<div id="touchFlow4" class="nav_h_type">' +
        '<ul id="sl_month" style="padding: 0;">' +
        '</ul>' +
        '</div>';
    $('.sl_header_second_menu_contant').append(sl_menu_touch);

    for (var i = 1; i <= 12; i++) {
        if ((i + "").length == 1) {
            var sl_month = '0' + i;
        }
        else {
            var sl_month = i + "";
        }

        if (sl_month == slMonth) {
            var li_content = '<li class="month_on">' + sl_month + '월</li>';
        }
        else {
            li_content = '<li value="' + sl_month + '">' + sl_month + '월</li>';
        }
        $('#sl_month').append(li_content);
    }
    $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
    touch_slide4();

    //월별탭에서 슬라이드바 선택시 
    $('#sl_month').delegate('li', "click", function () {
        var slMonth = sessionStorage.getItem('slMonth');

        sessionStorage.setItem('slMonth', $(this).text().substring(0, 2));

        $('#sl_month li').removeClass('month_on');
        $(this).addClass('month_on');

        slMonth = sessionStorage.getItem('slMonth');
        var artist = sessionStorage.getItem('sl_artist');
        var user_no = sessionStorage.getItem('sl_user_no');
        var recruiting = sessionStorage.getItem('sl_recruiting');
        var recruited = sessionStorage.getItem('sl_recruited');

        show_my_store_list('', slMonth, '', artist, user_no, recruiting, recruited);
    });
}

// 장르 클릭시
function go_sl_genre() {
    sessionStorage.removeItem('sl_user_no');
    sessionStorage.removeItem('sl_artist');
    sessionStorage.removeItem('sl_recruiting');
    sessionStorage.removeItem('sl_recruited');
    sessionStorage.removeItem('sl_Scroll');
    sessionStorage.removeItem('sl_Limit');

    $("input:radio[name='my_perform_radio']").removeAttr("checked");
    $("input:checkbox[id='my_perform_chk']").prop("checked", false);

    //초기 탭 클릭시 무조건 처음 li (음악) 선택
    var slGenre = sessionStorage.getItem('slGenre');
    if (slGenre == null) {
        slGenre = '음악';
        sessionStorage.setItem('slGenre', slGenre);
    }
    sessionStorage.removeItem('slArea');
    sessionStorage.removeItem('slMonth');

    show_my_store_list('', '', slGenre);

    var sl_menu = '';
    $('.store_list_header_menu_container').empty();
    sl_menu = '<div class="store_list_menu ui-block-a">' +
        '<div class="sl_header_tab" onclick="go_sl_all()">' +
        '전체' +
        '</div>' +
        '</div>' +
        '<div class="store_list_menu ui-block-b">' +
        '<div class="sl_header_tab" onclick="go_sl_area()">' +
        '지역' +
        '</div>' +
        '</div>' +
        '<div class="store_list_menu ui-block-c">' +
        '<div class="sl_header_tab" onclick="go_sl_month()">' +
        '월별' +
        '</div>' +
        '</div>' +
        '<div class="store_list_menu ui-block-d">' +
        '<div class="sl_header_tab" style="border-bottom: 3px solid #8354C8; font: normal normal bold 15px/45px SpoqaHanSans; color: #8354C8;">' +
        '장르' +
        '</div>' +
        '</div>';
    $('.store_list_header_menu_container').append(sl_menu);

    $('.slm_body_content').css("top", "174px;");
    $('.sl_top_container').css('margin-top', '95px');
    $('.sl_header_second_menu_contant').css("display", "block");
    visitors_css();

    $('html').scrollTop(0); //페이지 최상단 이동

    $('.sl_header_second_menu_contant').empty();
    var sl_menu_touch = '';
    sl_menu_touch =
        '<div id="touchFlow4" class="nav_h_type">' +
        '<ul id="sl_genre" style="padding: 0;">' +
        '</ul>' +
        '</div>';
    $('.sl_header_second_menu_contant').append(sl_menu_touch);

    //장르 터치슬라이드바 li추가부분
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/common/get_main_genre.jsp',
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function (i) {
                var MAIN_GENRE = $(this).find("MAIN_GENRE").text();

                if (MAIN_GENRE == slGenre) {
                    var li_content = '<li class="genre_on">' + MAIN_GENRE + '</li>';
                }
                else {
                    li_content = '<li value="' + MAIN_GENRE + '">' + MAIN_GENRE + '</li>';
                }
                $('#sl_genre').append(li_content);

            }).promise().done(function () {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
            });
        },//end success
        error: function (xhr, message, errorThrown) {
            //hideLoading();
        } // end error
    });

    //장르탭에서 슬라이드바 선택시
    $('#sl_genre').delegate('li', "click", function () {
        var slGenre = sessionStorage.getItem('slGenre');
        if (slGenre == null) {
            slGenre = '음악';
        }

        sessionStorage.setItem('slGenre', $(this).text());

        $('#sl_genre li').removeClass('genre_on');
        $(this).addClass('genre_on');

        slGenre = sessionStorage.getItem('slGenre');
        var artist = sessionStorage.getItem('sl_artist');
        var user_no = sessionStorage.getItem('sl_user_no');
        var recruiting = sessionStorage.getItem('sl_recruiting');
        var recruited = sessionStorage.getItem('sl_recruited');

        show_my_store_list('', '', slGenre, artist, user_no, recruiting, recruited);
    });
}


// 내공연 클릭시
function sl_my_perform() {
    if (owner_chk()) {
        var user_no = $('#user_no').val();
        sessionStorage.removeItem('sl_user_no');
        sessionStorage.removeItem('sl_artist');
        sessionStorage.removeItem('sl_recruiting');
        sessionStorage.removeItem('sl_recruited');
        sessionStorage.setItem('sl_user_no', user_no);

        show_my_store_list('', '', '', '', user_no);

        $('#store_list_myperform').css('display', 'none');
        $("html, body").css({ "overflow": "auto", "height": "auto" });

        $("input:checkbox[id='my_perform_chk']").prop("checked", true);
        $("#my_perform_chk").removeAttr("disabled");

    } else if (!owner_chk() && artist_chk()) {
        var user_no = $('#user_no').val();
        var artist = 'Y'
        sessionStorage.removeItem('sl_user_no');
        sessionStorage.removeItem('sl_artist');
        sessionStorage.removeItem('sl_recruiting');
        sessionStorage.removeItem('sl_recruited');
        sessionStorage.setItem('sl_user_no', user_no);
        sessionStorage.setItem('sl_artist', artist);

        show_my_store_list('', '', '', artist, user_no);

        $('#store_list_myperform').css('display', 'none');
        $("html, body").css({ "overflow": "auto", "height": "auto" });

        $("input:checkbox[id='my_perform_chk']").prop("checked", true);
        $("#my_perform_chk").removeAttr("disabled");

    }
}

// 모집중인 공연 클릭시
function sl_recruiting() {
    var recruiting = 'Y'
    sessionStorage.removeItem('sl_user_no');
    sessionStorage.removeItem('sl_artist');
    sessionStorage.removeItem('sl_recruiting');
    sessionStorage.removeItem('sl_recruited');
    sessionStorage.setItem('sl_recruiting', recruiting);

    show_my_store_list('', '', '', '', '', recruiting);


    $('#store_list_myperform').css('display', 'none');
    $("html, body").css({ "overflow": "auto", "height": "auto" });

    $("input:checkbox[id='my_perform_chk']").prop("checked", true);
    $("#my_perform_chk").removeAttr("disabled");

}

// 모집 완료 공연 클릭시
function sl_recruited() {
    var recruited = 'Y'
    sessionStorage.removeItem('sl_user_no');
    sessionStorage.removeItem('sl_artist');
    sessionStorage.removeItem('sl_recruiting');
    sessionStorage.removeItem('sl_recruited');
    sessionStorage.setItem('sl_recruited', recruited);

    show_my_store_list('', '', '', '', '', '', recruited);

    $('#store_list_myperform').css('display', 'none');
    $("html, body").css({ "overflow": "auto", "height": "auto" });

    $("input:checkbox[id='my_perform_chk']").prop("checked", true);
    $("#my_perform_chk").removeAttr("disabled");

}