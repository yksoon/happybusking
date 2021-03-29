$(document).ready(function () {
    var selectDateTemp = sessionStorage.getItem('selectDateTemp');
    selectDateTemp = new Array();
    sessionStorage.setItem('selectDateTemp', selectDateTemp);
});

//요일 아이템 클릭시
$(document).on('click', '.btra_item', function () {
    var selectChk = $(this).attr('class').split(' ');
    selectChk = selectChk[selectChk.length - 1];

    // console.log($(this).text());
    var selectValue = $(this).text();


    var selectDateTemp = sessionStorage.getItem('selectDateTemp');
    if (selectDateTemp == null || selectDateTemp == '') {
        selectDateTemp = new Array();
    } else {
        selectDateTemp = selectDateTemp.split(',');
    }
    // console.log("1 " + selectDateTemp);


    var nowPage = $('.ui-page').attr('id');

    if (selectChk == 'btra_item_on') {

        //선택 되어있는 경우
        //선택 해제해야함
        $(this).removeClass('btra_item_on');

        if (nowPage == 'busking_time_reg_all') {

            //var allChk = $(this).parents('.all_chk_div').find('.btra_item_all').attr('class').split(' ');
            var tab = $(this).parents('.ra_date').attr('class').split(' ');
            tab = tab[tab.length - 1];

            // if (tab == 'holiday' || tab == 'is_next') {
            //     return
            // } else {
            //     var allChk = $(this).parents('.ra_date').find('.btra_item_all').attr('class').split(' ');
            //     //console.log(allChk);
            //     allChk = allChk[allChk.length - 1];

            //     // if (allChk == 'btra_item_on') {
            //     //     $(this).parents('.ra_date').find('.btra_item_all').removeClass('btra_item_on');
            //     // }
            // }
            console.log($(this).parents('.ra_date').find('.btra_item_on').length)
            if ($(this).parents('.ra_date').find('.btra_item_on').length == 1) {
                $(this).parents('.ra_date').find('.btra_item_all').removeClass('btra_item_on');
            }
        }

        selectDateTemp.splice(selectDateTemp.indexOf(selectValue), 1);
        console.log("제거: " + selectDateTemp);

    } else {
        //선택 해제되어있는 경우
        //선택 해야함

        $(this).addClass('btra_item_on');

        // 날짜 선택시 일괄등록의 상태 변경
        if (nowPage == 'busking_time_reg_all') {
            var itemTotalLength = $(this).parents('.ra_date_chk').find('.btra_item').length;
            var selectTotalLength = $(this).parents('.ra_date_chk').find('.btra_item_on').length;

            // if (itemTotalLength == selectTotalLength) {
            //     $(this).parents('.ra_date').find('.btra_item_all').addClass('btra_item_on');
            // }
            if (selectTotalLength) {
                $(this).parents('.ra_date').find('.btra_item_all').addClass('btra_item_on');
            }
        }
        console.log("추가: " + selectDateTemp);

        selectDateTemp.push(selectValue);
        selectDateTemp.join(',');


        // console.log(typeof (selectDateTemp));

        // sessionStorage.setItem('selectDateTemp', selectDateTemp);
    }
    sessionStorage.setItem('selectDateTemp', selectDateTemp);
    console.log("총: " + selectDateTemp);

});

// //요일 '일괄등록' 아이템 클릭시
// $(document).on('click', '.btra_item_all', function () {
//     var selectDateTemp = sessionStorage.getItem('selectDateTemp');
//     if (selectDateTemp == null || selectDateTemp == '') {
//         selectDateTemp = new Array();
//     } else {
//         selectDateTemp = selectDateTemp.split(',');
//     }

//     var selectChk = $(this).attr('class').split(' ');
//     selectChk = selectChk[selectChk.length - 1];

//     var str;

//     if (selectChk == 'btra_item_on') {
//         //선택되어있는 경우
//         //선택 해제 해줘야함
//         $(this).removeClass('btra_item_on');
//         var selectLength = $(this).parents('.ra_date').find('.btra_item_on').length;
//         for (i = 0; i < selectLength; i++) {
//             str = $(this).parents('.ra_date').find('.btra_item_on').eq(i).attr('id');
//             selectDateTemp.splice(selectDateTemp.indexOf(str), 1);

//             // console.log(str);

//             sessionStorage.setItem('selectDateTemp', selectDateTemp);

//             if (str == '1' || str == '2') {
//                 vocalinstRemoveClass('gsb_main_vocal');
//                 vocalinstRemoveClass('gsb_main_instrument');
//             }
//         }

//         $(this).parents('.ra_date').find('.btra_item_on').removeClass('btra_item_on');

//     } else {
//         //선택되어있지 않은 경우
//         //선택 해줘야함
//         $(this).addClass('btra_item_on');
//         var selectLength = $(this).parents('.ra_date').find('.btra_item').length;

//         for (i = 0; i < selectLength; i++) {
//             str = $(this).parents('.ra_date').find('.btra_item').eq(i).attr('id');

//             var selectChkForID = $('#' + str).attr('class').split(' ');
//             selectChkForID = selectChkForID[selectChkForID.length - 1];

//             if (selectChkForID != 'btra_item_on') {
//                 selectDateTemp.push(str);
//             }
//         }
//         $(this).parents('.ra_date').find('.btra_item').addClass('btra_item_on');
//         selectDateTemp.join(',');

//         sessionStorage.setItem('selectDateTemp', selectDateTemp);
//     }
// });


// 일괄등록 누를시
$(document).on('click', '.all_chk', function () {

    $("html, body").css({ "overflow": "hidden", "height": "100%" });
    $("#busking_time_select_popup").bind("touchmove", function (e) {
        e.preventDefault();
    });
    $("#busking_time_select_popup .custom_select_popup").bind("touchmove", function (e) {
        e.stopPropagation();
    });

    var selectChk = $(this).attr('class').split(' ');
    selectChk = selectChk[selectChk.length - 1];

    var holi_check = $('.holiday .ra_date_chk').length;
    console.log(holi_check);
    // console.log(selectChk);
    console.log(typeof (selectChk));

    if (selectChk == 'btra_item_on') {
        $('#busking_time_select_popup').load('/app_root/jsp/custom_select_box/busking_time_select.jsp', function () {
            // document.getElementById('busking_time_select_popup').style.display = 'block';
            $('#busking_time_select_popup').show();

            $('#header').hide();
            $('#footer').hide();

            var selectDateTemp = sessionStorage.getItem('selectDateTemp');
            console.log(selectDateTemp);

            $('#select_date').append('<p class="bts_body_title">' + selectDateTemp + '요일 일정 등록</p>');
        });
    } else if (selectChk != 'btra_item_on') {
        alert("일괄 등록할 요일을 선택 해주세요");
    }

});
