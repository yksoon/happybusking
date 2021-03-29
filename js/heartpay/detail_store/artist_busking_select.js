var sel_chk = [];

var all = [];

var cnt; // artist_busking_select_func.js 에서 받아옴

$(document).on('click', '#abs_team_check_all', function () { //만약 전체 선택 체크박스가 체크된상태일경우 
    var offerprice = sessionStorage.getItem('abs_offerprice');
    offerprice = offerprice.replace(/[^\d]+/g, '');   //콤마제거
    offerprice = parseInt(offerprice);

    if ($('#abs_team_check_all').prop("checked")) {

        $('.personal_price').css('background', '#FFFFFF');
        $('.personal_price').css('border', '1px solid #E9E9F7');
        $('.personal_price').removeAttr("readonly");

        //해당화면에 전체 checkbox들을 체크해준다 
        $("input[type=checkbox]").prop("checked", true);
        // console.log("모든체크");

        $('[name="abs_member_check"]:checked').each(function () {
            sel_chk.push($(this).val());
        });

        // 짝수일 경우에만 1/n 자동계산 기능 활성
        if ((cnt % 2 == 0) || (cnt === '1')) {
            sel_chk = Array.from(new Set(sel_chk)); //중복 제거
            // console.log(sel_chk);

            var CNT = sel_chk.length
            var personal_price2 = offerprice / CNT;
            personal_price = String(personal_price2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");  //콤마 다시 추가

            // console.log(CNT);
            // console.log(offer);
            // console.log(personal_price);

            for (i = 0; i < sel_chk.length; i++) {
                var USER_NO = sel_chk[i];
                $('#personal_price_' + USER_NO).val(personal_price);
            }

            // $('#personal_price_' + USER_NO).val(personal_price);
            var total_price = offerprice - (personal_price2 * CNT)
            $('.abs_price p').text(total_price + " 원");
            if (total_price == "0") {
                $('.abs_price p').css('color', '#333333');
            } else {
                $('.abs_price p').css('color', '#F76C4A');
            }
        }

    } else {
        //해당화면에 모든 checkbox들의 체크를해제시킨다. 
        $("input[type=checkbox]").prop("checked", false);
        console.log("모든체크해제");
        sel_chk = [];
        // console.log(sel_chk);
        $('.personal_price').val("0");
        $('.personal_price').css('background', '#F9F9FB');
        $('.personal_price').css('border', 'none');
        $('.personal_price').prop('readonly', true);

        var offer_price = String(offerprice).replace(/\B(?=(\d{3})+(?!\d))/g, ",");  //콤마 다시 추가
        $('.abs_price p').text(offer_price + " 원");

        $('.abs_price p').css('color', '#F76C4A');
    }


});

// 체크 이벤트
$(document).on('change', '[name="abs_member_check"]', function () {
    var offerprice = sessionStorage.getItem('abs_offerprice');
    offerprice = offerprice.replace(/[^\d]+/g, '');   //콤마제거
    offerprice = parseInt(offerprice);

    var input_u_no = $(this).attr('id');
    var u_no = input_u_no.split('_')[3];
    var chk_id = '#personal_price_' + u_no

    if ($(this).is(":checked")) {
        $(chk_id).css('background', '#FFFFFF');
        $(chk_id).css('border', '1px solid #E9E9F7');
        $(chk_id).val('0');
        $(chk_id).removeAttr("readonly");
        sel_chk.push($(this).val());
    } else {
        while (true) {
            var search = sel_chk.indexOf($(this).val());
            if (search != -1) {
                sel_chk.splice(search, 1); // "A"를 찾아서 삭제한다.
            } else {
                break;
            }
        }
        $(chk_id).val('0');
        $(chk_id).css('background', '#F9F9FB');
        $(chk_id).css('border', 'none');
        $(chk_id).prop('readonly', true);

        var input_price_arr = [];
        $('.personal_price').each(function () {
            var input_price = $(this).val();
            if (input_price != '0') {
                input_price = $(this).val().replace(/[^\d]+/g, '');     //콤마제거
            }
            input_price = parseInt(input_price);
            input_price_arr.push(input_price);
        });

        // console.log(input_price_arr);

        var input_total_price = 0;
        for (i = 0; i < input_price_arr.length; i++) {
            var i_price = input_price_arr[i];
            input_total_price = input_total_price + i_price;
        }

        var final_price = offerprice - input_total_price;
        final_price = String(final_price).replace(/\B(?=(\d{3})+(?!\d))/g, ",");    // 콤마 다시 추가

        $('.abs_price p').text(final_price + " 원");
        if (final_price == "0") {
            $('.abs_price p').css('color', '#333333');
        } else {
            $('.abs_price p').css('color', '#F76C4A');
        }

        // console.log(final_price);
    }

    // 전체 체크박스 불들어오게 하기
    all.length = 0;
    $('input[name=abs_member_check').each(function () {
        var chk;
        if ($(this).is(':checked')) {
            chk = 1;
            all.push(chk);
        } else {
            chk = 0;
            all.push(chk);
        }
        all = Array.from(new Set(all)); //중복 제거
    });

    if (all.length == 1 && all[0] == 0) {
        $("#abs_team_check_all").prop("checked", false);
    }
    else if (all.length != 1) {
        $("#abs_team_check_all").prop("checked", true);
    }

    // console.log(all);
});

//인풋박스 이벤트 - 엔터
$(document).on('keyup', '.personal_price', function (e) {
    var offerprice = sessionStorage.getItem('abs_offerprice');
    offerprice = offerprice.replace(/[^\d]+/g, '');   //콤마제거
    offerprice = parseInt(offerprice);

    if (e.keyCode == 13) {
        if (typeof (offerprice) == String) {
            offerprice = offerprice.replace(/[^\d]+/g, '');   //콤마제거
            offerprice = parseInt(offerprice);
        }


        var input_price_arr = [];
        $('.personal_price').each(function () {
            var input_price = $(this).val().replace(/[^\d]+/g, '');     //콤마제거
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

        $('.abs_price p').text(final_price + " 원");
        if (final_price == "0") {
            $('.abs_price p').css('color', '#333333');
        } else {
            $('.abs_price p').css('color', '#F76C4A');
        }
    }
});

//인풋박스 이벤트 - 포커스 아웃
$(document).on('blur', '.personal_price', function () {
    var offerprice = sessionStorage.getItem('abs_offerprice');
    offerprice = offerprice.replace(/[^\d]+/g, '');   //콤마제거
    offerprice = parseInt(offerprice);

    if (typeof (offerprice) == String) {
        offerprice = offerprice.replace(/[^\d]+/g, '');   //콤마제거
        offerprice = parseInt(offerprice);
    }


    var input_price_arr = [];
    $('.personal_price').each(function () {
        var input_price = $(this).val().replace(/[^\d]+/g, '');     //콤마제거
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

    $('.abs_price p').text(final_price + " 원");
    if (final_price == "0") {
        $('.abs_price p').css('color', '#333333');
    } else {
        $('.abs_price p').css('color', '#F76C4A');
    }
});

$(document).on('keyup', '.personal_price', function (event) {
    this.value = this.value.replace(/[^0-9]/g, '');   // 입력값이 숫자가 아니면 공백
    this.value = this.value.replace(/,/g, '');          // ,값 공백처리
    this.value = this.value.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 	
});
$(document).on('click', '.personal_price', function () {
    var input_u_no = $(this).attr('id');
    var u_no = input_u_no.split('_')[2];
    var chk_id = 'abs_member_check_' + u_no

    if ($('#' + chk_id).prop("checked")) {
        $(this).css('background', '#FFFFFF');
        $(this).css('border', '1px solid #E9E9F7');
        $(this).val('');
        $(this).removeAttr("readonly");
    }
});


// 공연 신청 버튼
$(document).on('click', '#abs_footer', function () {
    var offerprice = sessionStorage.getItem('abs_offerprice');
    // offerprice = offerprice.replace(/[^\d]+/g, '');   //콤마제거
    var perform_no = sessionStorage.getItem('sl_perform_no');
    var team_no = sessionStorage.getItem('abs_team_no');
    var price_chk = $('.abs_price p').text().slice(0, -2);
    // price_chk = parseInt(price_chk);
    // console.log(price_chk + "aaaaa");

    if (price_chk != "0") {
        alert("지정된 공연비가 일치하지 않습니다.\n공연비를 다시 입력해주세요.");
        return false;
    }

    var delchk = []; // key 값을 담을 배열
    //삭제 key value
    // chk라는 클래스를 가진 체크박스 중에 체크가 된
    // object들을 찾아서 delchk라는 배열에 담는다.
    $('[name="abs_member_check"]:checked').each(function () {
        delchk.push($(this).val());
    });

    for (i = 0; i < delchk.length; i++) {
        var user_no = delchk[i];
        var personal_price = $('#personal_price_' + user_no).val().replace(/[^\d]+/g, '');
        // offerprice = String(offerprice);

        console.log(user_no + ', ' + personal_price + ', ' + perform_no + ', ' + team_no + ', ' + offerprice);

        $.ajax({
            type: "POST",//url: "JSON/test.json",
            cache: false,
            url: '/service/detail_store/set_artist_busking_select.jsp',
            //data : data,
            data: {
                perform_no: perform_no,
                team_no: team_no,
                user_no: user_no,
                offerprice: offerprice,
                personal_price: personal_price
            },
            dataType: "xml",
            timeout: 30000,
            beforeSend: function () {
                showLoading('show', '등록중입니다');
            },
            success: function (data) {



            }, // end success
            error: function (xhr, message, errorThrown) {
                // console.log(xhr);
                // console.log(message);
                // console.log(errorThrown);
            }, // end error
            complete: function () {
                // showLoading('hide', '등록중입니다');
                // alert("신청 성공");
            }
        }).promise().done(function () {
            $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
        });
    }

    // 사업주에게 푸쉬
    $.ajax({
        type: "POST",//url: "JSON/test.json",
        cache: false,
        url: '/service/push_perform_contract/owner_perform_receive.jsp',
        //data : data,
        data: {
            perform_no: perform_no,
            team_no: team_no
        },
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            // console.log("여기까지 옴");
        }
    })

    loadPage('detail_store/application_perform_complete.jsp');
});


$(document).on('pageinit', '#application_perform_complete', function () {
    var team_name = sessionStorage.getItem('apc_teamName');
    var busking_date = sessionStorage.getItem('apc_buskingDate');
    var busking_time = sessionStorage.getItem('apc_buskingTime');

    busking_date = busking_date.slice(2);
    busking_date = busking_date.replace(/-/g, '.'); // -를 .으로 바꿔줌

    var apc_notice_1 =
        '<p><span>아티스트명</span><span class="apc_info">' + team_name + '</span></p>' +
        '<p><span>공연 일자</span><span class="apc_info">' + busking_date + '</span></p>' +
        '<p><span>공연 시간</span><span class="apc_info">' + busking_time + '</span></p>';

    $('.apc_notice_1').append(apc_notice_1);
});
