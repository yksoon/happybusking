$(document).on('pageinit', '#busking_time_apply_detail', function () {
    sessionStorage.removeItem('sessTeamName');
    var team_no = sessionStorage.getItem('TNO');
    // console.log(team_no);
    var perform_no = sessionStorage.getItem('btcl_perform_no');
    var matching_chk = sessionStorage.getItem('btcl_matching_chk');
    var buskingstatus = sessionStorage.getItem('btcl_buskingstatus');
    var user_no = $('#user_no').val();

    if (owner_chk()) {
        if (matching_chk == '1') { // 승인 대기일 경우
            btad_stand_by(team_no, perform_no);
        } else if (matching_chk == '4') {    // 거절된 공연
            btad_reject(team_no, perform_no);
        } else if (matching_chk == '3') {   // 승인(확정)된 공연
            btad_confirm(team_no, perform_no);
        }
    }
    else if (owner_chk() == false && artist_chk() == true) {    // 아티스트
        $('.btad_artist_info p').text("공간 정보 >");
        if (matching_chk == '1') { // 승인 대기일 경우
            btad_stand_by_art(user_no, perform_no);
        }
        else if (matching_chk == '3' || matching_chk == '공연완료') {
            btad_confirm_art(user_no, perform_no);
        }
    }


});

// 체크박스
$(document).on('change', 'input[name=btad_contract_check]', function () {
    if ($(this).is(":checked")) {
        var id = $(this).attr('id');
        id = id.split('_')[3];
        console.log(id);

        $('#btad_personal_price_input_' + id).css('background', '#ffffff');
        $('#btad_personal_price_input_' + id).removeAttr("readonly");
        $('#btad_personal_price_input_' + id).val('');
    } else {
        var id = $(this).attr('id');
        id = id.split('_')[3];
        console.log(id);

        $('#btad_personal_price_input_' + id).css('background', '#f4f4f4');
        $('#btad_personal_price_input_' + id).prop('readonly', true);
        $('#btad_personal_price_input_' + id).val('0');
    }
    var offerprice = sessionStorage.getItem("btad_offerprice");
    console.log(offerprice);
    console.log(typeof (offerprice));

    offerprice = offerprice.replace(/[^\d]+/g, '');   //콤마제거
    offerprice = parseInt(offerprice);


    var input_price_arr = [];
    $('.btad_personal_price_input').each(function () {
        var input_price = $(this).val().replace(/[^\d]+/g, '');     //콤마제거
        if (input_price == '') {
            input_price = 0;
        }
        input_price = parseInt(input_price);
        input_price_arr.push(input_price);
    });

    var input_total_price = 0;
    for (i = 0; i < input_price_arr.length; i++) {
        var i_price = input_price_arr[i];
        input_total_price = input_total_price + i_price;
    }

    var final_price = offerprice - input_total_price;
    final_price = String(final_price).replace(/\B(?=(\d{3})+(?!\d))/g, ",");    // 콤마 다시 추가

    $('.btad_remain_price').text(final_price + " 원");
    if (final_price == "0") {
        $('.abs_price p').css('color', '#333333');
    } else {
        $('.abs_price p').css('color', '#F76C4A');
    }
})

//인풋박스 이벤트 - 포커스 아웃
$(document).on('blur', '.btad_personal_price_input', function () {
    var offerprice = sessionStorage.getItem('btad_offerprice');
    offerprice = offerprice.replace(/[^\d]+/g, '');   //콤마제거
    offerprice = parseInt(offerprice);

    if (typeof (offerprice) == String) {
        offerprice = offerprice.replace(/[^\d]+/g, '');   //콤마제거
        offerprice = parseInt(offerprice);
    }


    var input_price_arr = [];
    $('.btad_personal_price_input').each(function () {
        var input_price = $(this).val().replace(/[^\d]+/g, '');     //콤마제거
        if (input_price == '') {
            input_price = 0;
        }
        input_price = parseInt(input_price);
        input_price_arr.push(input_price);
    });

    var input_total_price = 0;
    for (i = 0; i < input_price_arr.length; i++) {
        var i_price = input_price_arr[i];
        input_total_price = input_total_price + i_price;
    }

    var final_price = offerprice - input_total_price;
    final_price = String(final_price).replace(/\B(?=(\d{3})+(?!\d))/g, ",");    // 콤마 다시 추가

    $('.btad_remain_price').text(final_price + " 원");
    if (final_price == "0") {
        $('.btad_remain_price').css('color', '#333333');
    } else {
        $('.btad_remain_price').css('color', '#F76C4A');
    }

    var user_no_hidden = $('#user_no').val();

    var btad_personal_price = $('#btad_personal_price_input_' + user_no_hidden).val();
    sessionStorage.setItem('btad_personal_price', btad_personal_price);
    console.log(btad_personal_price);
});

// 인풋박스 이벤트
$(document).on('keyup', '.btad_personal_price_input', function (e) {
    var offerprice = sessionStorage.getItem('btad_offerprice');
    offerprice = offerprice.replace(/[^\d]+/g, '');   //콤마제거
    offerprice = parseInt(offerprice);

    if (e.keyCode == 13) {
        if (typeof (offerprice) == String) {
            offerprice = offerprice.replace(/[^\d]+/g, '');   //콤마제거
            offerprice = parseInt(offerprice);
        }


        var input_price_arr = [];
        $('.btad_personal_price_input').each(function () {
            var input_price = $(this).val().replace(/[^\d]+/g, '');     //콤마제거
            if (input_price == '') {
                input_price = 0;
            }
            input_price = parseInt(input_price);
            input_price_arr.push(input_price);
        });

        var input_total_price = 0;
        for (i = 0; i < input_price_arr.length; i++) {
            var i_price = input_price_arr[i];
            input_total_price = input_total_price + i_price;
        }

        var final_price = offerprice - input_total_price;
        final_price = String(final_price).replace(/\B(?=(\d{3})+(?!\d))/g, ",");    // 콤마 다시 추가

        $('.btad_remain_price').text(final_price + " 원");
        if (final_price == "0") {
            $('.btad_remain_price').css('color', '#333333');
        } else {
            $('.btad_remain_price').css('color', '#F76C4A');
        }

        var user_no_hidden = $('#user_no').val();

        var btad_personal_price = $('#btad_personal_price_input_' + user_no_hidden).val();
        sessionStorage.setItem('btad_personal_price', btad_personal_price);
        console.log(btad_personal_price);
    }
});
$(document).on('keyup', '.btad_personal_price_input', function (event) {
    this.value = this.value.replace(/[^0-9]/g, '');   // 입력값이 숫자가 아니면 공백
    this.value = this.value.replace(/,/g, '');          // ,값 공백처리
    this.value = this.value.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 	
});


// $(document).on("click", "#btad_footer_reject", function () {
//     loadPage('busking_time_contract/complete_reject_busking.jsp');
// });

$(document).on('pageinit', '#accept_busking_complete', function () {
    var team_name = sessionStorage.getItem('ab_complete_teamName');
    var busking_date = sessionStorage.getItem('ab_complete_buskingDate');
    var busking_time = sessionStorage.getItem('ab_complete_buskingTime');

    busking_date = busking_date.slice(2);
    busking_date = busking_date.replace(/-/g, '.');

    var ab_complete_notice_1 =
        '<p><span>아티스트명</span><span class="apc_info">' + team_name + '</span></p>' +
        '<p><span>공연 일자</span><span class="apc_info">' + busking_date + '</span></p>' +
        '<p><span>공연 시간</span><span class="apc_info">' + busking_time + '</span></p>';

    $('.ab_complete_notice_1').append(ab_complete_notice_1);
});


