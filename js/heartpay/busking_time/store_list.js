var sl_menu = '';
var slArea = '';
var slMonth = '';
var slGenre = '';

$(document).on('pageinit', '#store_list', function () {
    if (!owner_chk() && !artist_chk()) {    // 관객일경우 내공연 버튼 안보임
        $('.sl_top_container').empty();
    }
    slMonth = moment(new Date(today.getFullYear(), today.getMonth())).format('MM');
    sessionStorage.setItem('slMonth', slMonth);

    slArea = sessionStorage.setItem('slArea', '서울');
    slGenre = sessionStorage.setItem('slGenre', '음악');

    // console.log('페이지init');

    $('.store_list_header_menu_container').empty();
    sl_menu = '<div class="store_list_menu ui-block-a">' +
        '<div class="sl_header_tab" style="border-bottom: 3px solid #8354C8; font: normal normal bold 15px/45px SpoqaHanSans; color: #8354C8;" >' +
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

    // show_all_store_list();
    go_sl_all();

    $('.sl_header_second_menu_contant').css("display", "none");
});

$(document).ready(function () {
    sessionStorage.removeItem('sl_user_no');
    sessionStorage.removeItem('sl_artist');
    sessionStorage.removeItem('sl_recruiting');
    sessionStorage.removeItem('sl_recruited');

    if (!$("input:checkbox[id='my_perform_chk']").is(":checked")) {
        $("input:checkbox[id='my_perform_chk']").attr("disabled", true);
    }

    $("#my_perform_chk").change(function () {
        // console.log($('#my_perform_chk').val());
        if (!$("input:checkbox[id='my_perform_chk']").is(":checked")) {
            $("input:radio[name='my_perform_radio']").removeAttr("checked");

            sessionStorage.removeItem('sl_user_no');
            sessionStorage.removeItem('sl_artist');
            show_my_store_list();

            $("input:checkbox[id='my_perform_chk']").attr("disabled", true);
        }
    });
});

// // 내 공연 보기 텍스트 클릭시
// var popupchk = '';
// $(document).on('click', '.my_perform_chk_span', function () {
//     if (popupchk == '') {
//         popupchk = 'Y';
//         $('#store_list_myperform').css('display', 'block');
//         $("html, body").css({ "overflow": "hidden", "height": "100%" });
//     } else if (popupchk == 'Y') {
//         popupchk = '';
//         $('#store_list_myperform').css('display', 'none');
//         $("html, body").css({ "overflow": "auto", "height": "auto" });
//     }
//     console.log('popupchk : ' + popupchk);
// });



// 공연등록 버튼
$(document).on('click', '#sl_reg_perform_btn', function () {
    go_sl_busking_time_reg();
});

// 팝업 내 상업 공간 등록 버튼
$(document).on('click', '#slp_confirm_btn', function () {
    $("html, body").css({ "overflow": "auto", "height": "auto" });

    $('#header').show();
    $('#footer').show();

    loadPage('reg_store/promotion.jsp');
});


//슬라이드바에서 선택한 메뉴 값 가져오기
// $(document).on('click', '.sl_header_tab', function () {
// //지역탭에서 슬라이드바 선택시 
// $('#sl_area').delegate('li', "click", function () {
//     var slArea = sessionStorage.getItem('slArea');
//     if (slArea == null) {
//         slArea = '서울';
//     }

//     sessionStorage.setItem('slArea', $(this).text());

//     $('#sl_area li').removeClass('area_on');
//     $(this).addClass('area_on');


// });

// //장르탭에서 슬라이드바 선택시
// $('#sl_genre').delegate('li', "click", function () {
//     var slGenre = sessionStorage.getItem('slGenre');
//     if (slGenre == null) {
//         slGenre = '음악';
//     }

//     sessionStorage.setItem('slGenre', $(this).text());

//     $('#sl_genre li').removeClass('genre_on');
//     $(this).addClass('genre_on');

//     // get_artist_ranking();
// });

// //월별탭에서 슬라이드바 선택시 
// $('#sl_month').delegate('li', "click", function () {
//     var slMonth = sessionStorage.getItem('slMonth');

//     sessionStorage.setItem('slMonth', $(this).text().substring(0, 2));

//     $('#sl_month li').removeClass('month_on');
//     $(this).addClass('month_on');

//     console.log($(this).text().substring(0, 2));
// });
// });


// 상세보기로 이동
$(document).on('click', '#sl_tab_container', function () {
    // var sl_perform_no = $(this).sl_tab_container('#sl_perform_no').val();
    var sl_perform_no = $(this).children('#sl_perform_no').val();
    //console.log(sl_perform_no);
    sessionStorage.setItem('sl_perform_no', sl_perform_no);
    loadPage('detail_store/detail_store.jsp');
});

//리스트 클릭시 스크롤 유지
$(document).on('click', '.sl_tab_container', function () {
    var scroll = $(window).scrollTop();
    sessionStorage.setItem('sl_Scroll', scroll);
});

$(document).on('click', '#my_perform_sel', function () {
    $('#header').removeClass('ui-fixed-hidden');
})

$(document).on('change', '#my_perform_sel', function () {
    var sel = $("#my_perform_sel option:selected").val();

    if (sel == 'sl_no_sel') {
        go_sl_all();
    }
    else if (sel == 'sl_all_sel') {
        sl_my_perform();
    }
    else if (sel == 'sl_recruiting') {
        sl_recruiting();
    }
    else if (sel == 'sl_recruited') {
        sl_recruited();
    }
});