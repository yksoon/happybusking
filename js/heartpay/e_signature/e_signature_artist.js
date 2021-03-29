var signaturePad;
var CONTRACT_PRICE;

$(document).on('pageinit', '#e_signature_artist', function () {
    var perform_no = sessionStorage.getItem('btcl_perform_no');
    // console.log(perform_no);
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/e_signature/get_perform.jsp',
        data: {
            perform_no: perform_no
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function (i) {
                var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
                var STARTINGTIME = $(this).find("STARTINGTIME").text();
                var FINISHINGTIME = $(this).find("FINISHINGTIME").text();

                $('#esa_perform_date').val(BUSKINGDATE);

                var starting_hour = STARTINGTIME.split(':')[0];
                var starting_min = STARTINGTIME.split(':')[1];
                $('#esa_pt_start_hour').val(starting_hour + ' 시');
                $('#esa_pt_start_min').val(starting_min + ' 분');

                var finishing_hour = FINISHINGTIME.split(':')[0];
                var finishing_min = FINISHINGTIME.split(':')[1];
                $('#esa_pt_end_hour').val(finishing_hour + ' 시');
                $('#esa_pt_end_min').val(finishing_min + ' 분');

            });
        },
        complete: function () {
            var canvas = $("#esa_signature-pad")[0];
            signaturePad = new SignaturePad(canvas, {
                backgroundColor: 'rgb(246, 246, 248)'
            });

            function resizeCanvas() {
                var ratio = Math.max(window.devicePixelRatio || 1, 1);

                canvas.width = canvas.offsetWidth * ratio;
                canvas.height = canvas.offsetHeight * ratio;
                canvas.getContext("2d").scale(ratio, ratio);

                signaturePad.clear();
            }

            window.onresize = resizeCanvas;
            resizeCanvas();
        }
    });

});

// 새로고침 버튼을 눌렀을 시
$(document).on('click', '#esa_refresh', function () {
    signaturePad.clear();
});

// 서명완료 버튼 눌렀을 시
$(document).on('click', '#esa_footer', function () {

    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth() + 1
    var day = date.getDate();
    if (month < 10) {
        month = "0" + month;
    }
    if (day < 10) {
        day = "0" + day;
    }

    var today = year + "-" + month + "-" + day;

    // console.log(today);
    var contract_date = today;


    if ($('#esa_name_input').val() == '' || $('#esa_name_input').val() == null) {
        alert("이름을 입력 해주세요");
        return false
    }
    if ($('#esa_registration_num_first').val() == '' || $('#esa_registration_num_first').val() == null) {
        alert("주민등록번호를 입력 해주세요");
        return false
    }
    if ($('#esa_registration_num_sec').val() == '' || $('#esa_registration_num_sec').val() == null) {
        alert("주민등록번호를 입력 해주세요");
        return false
    }
    if ($('#esa_post_no').val() == '' || $('#esa_post_no').val() == null) {
        alert("주소를 입력 해주세요");
        return false
    }
    if ($('#esa_registration_num_first').val().length != 6) {
        alert("생년월일을 올바르게 입력해주세요");
        return false
    }
    if ($('#esa_registration_num_sec').val().length != 7) {
        alert("주민등록번호 뒷자리를 올바르게 입력해주세요");
        return false
    }
    var selected_option = $('#esa_bank_name_select option:selected').val();
    if (selected_option == 'no_select') {
        alert("은행을 선택해주세요");
        return false
    }
    if ($('#esa_bank_number_input').val() == '' || $('#esa_bank_number_input').val() == null) {
        alert("계좌번호를 입력해주세요");
        return false
    }
    if ($('#esa_bank_user_input').val() == '' || $('#esa_bank_user_input').val() == null) {
        alert("예금주명을 입력해주세요");
        return false
    }

    // console.log($('#esa_name_input').val());
    // console.log($('#esa_registration_num_first').val());
    // console.log($('#esa_registration_num_sec').val());
    // console.log($('#esa_post_no').val());
    // console.log($('#esa_adress').val());

    var contract_artist = $('#esa_name_input').val();
    var contract_resident_reg_num = $('#esa_registration_num_first').val() + '-' + $('#esa_registration_num_sec').val();
    var contract_artist_addr = $('#esa_post_no').val() + ' ' + $('#esa_adress').val();
    var contract_bank_name = selected_option;
    var contract_bank_number = $('#esa_bank_number_input').val();
    var contract_bank_user = $('#esa_bank_user_input').val();

    var data = signaturePad.toDataURL('image/png');
    // console.log(typeof (data));  // String
    var image = data;
    if (image == "data:,") {
        alert("서명을 해주세요");
        return false
    } else {
        var artist_sign = image
    }
    CONTRACT_PRICE = sessionStorage.getItem('btad_personal_price');
    contract_price = CONTRACT_PRICE.replace(/[^\d]+/g, '');   //콤마제거

    var perform_no = sessionStorage.getItem('btcl_perform_no');
    var user_no = $('#user_no').val();

    console.log(contract_artist);
    console.log(contract_resident_reg_num);
    console.log(contract_artist_addr);
    console.log(artist_sign);
    console.log(contract_price);
    console.log(contract_date);
    console.log(perform_no);
    console.log(user_no);

    sessionStorage.setItem('es_con_user_no', user_no);
    $.ajax({
        type: "POST",
        cache: false,
        url: '/service/e_signature/set_e_signature_artist.jsp',
        data: {
            contract_artist: contract_artist,
            contract_resident_reg_num: contract_resident_reg_num,
            contract_artist_addr: contract_artist_addr,
            artist_sign: artist_sign,
            contract_price: contract_price,
            contract_date: contract_date,
            perform_no: perform_no,
            contract_bank_name: contract_bank_name,
            contract_bank_number: contract_bank_number,
            contract_bank_user: contract_bank_user,
            user_no: user_no
        },
        dataType: "xml",
        timeout: 30000,
        beforeSend: function () {
            $.mobile.loading('show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
        },
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            var contract_chk = [];
            $(DATA).each(function (i) {
                var CONTRACT_STATUS = $(this).find("CONTRACT_STATUS").text();

                contract_chk.push(CONTRACT_STATUS);

            }).promise().done(function () {
                contract_chk = Array.from(new Set(contract_chk)); //중복 제거
                // console.log("첵첵첵");
                // console.log(contract_chk);

                if (contract_chk.length == 1) {
                    $.ajax({
                        type: "POST",//url: "JSON/test.json",
                        cache: false,
                        url: '/service/push_perform_contract/owner_request_contract.jsp',
                        //data : data,
                        data: {
                            perform_no: perform_no
                        },
                        dataType: "xml",
                        timeout: 30000,
                        success: function (data) {
                            // console.log("여기까지 옴");
                        }
                    })
                }

                loadPage('e_signature/e_sign_complete_art.jsp');
            });
        },
        error: function (xhr, message, errorThrown) {
            alert('잠시후 다시 시도해주세요.');
            return;
            //hideLoading();
        } // end error
    });
});

$(document).on('click', '#esca_confirm_list_btn', function () {
    loadPage('busking_time_contract/busking_time_contract_list.jsp');
})