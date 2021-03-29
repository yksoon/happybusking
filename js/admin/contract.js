//고용보험 리스트 불러오기
function goContract() {
    $('#admin_page_container').load('/app_admin/contract.jsp #contract-list');

    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/admin/get_contract.jsp',
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            $('#contract-table').empty();

            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            var header = '<tr>' +
                '<th style="width: 150px;">사업자번호</th>' +
                '<th style="width: 150px;">사업장명</th>' +
                '<th style="width: 150px;">사업자명</th>' +
                '<th style="width: 50px;">사업자 연락처</th>' +
                '<th style="width: 50px;">사업자 주민번호</th>' +
                '<th style="width: 150px;">사업장 주소</th>' +
                '<th style="width: 150px;">사업자등록증</th>' +
                '<th style="width: 150px;">수임/반려</th>' +
                '<th style="width: 150px;">반려코드</th>' +
                '<th style="width: 100px;">저장</th>' +
                '</tr>';
            $('#contract-table').append(header);


            if (DATA.length == 0) {
                $('#contract-table').append('<tr><td colspan="7">사무위탁에 동의한 사업장이 없습니다.</td></tr>');
                return;
            }

            $(DATA).each(function (i) {
                var BUSINESS_NO = $(this).find('BUSINESS_NO').text();
                var BUSINESS_WORKNAME = $(this).find('BUSINESS_WORKNAME').text();
                var BUSINESS_REPRESENTIVE = $(this).find('BUSINESS_REPRESENTIVE').text();
                var BUSINESS_PHONE = $(this).find('BUSINESS_PHONE').text();
                var BUSINESS_REGIST_NO = $(this).find('BUSINESS_REGIST_NO').text().split(' ')[0];
                var ADDRESS = $(this).find('ADDRESS').text();
                var BUSINESS_LICENSE = $(this).find('BUSINESS_LICENSE').text();
                var USER_NO = $(this).find('USER_NO').text();
                var CONSIGNMENT_AGREE_ADMIN = $(this).find('CONSIGNMENT_AGREE_ADMIN').text();
                var RETURN_CODE = $(this).find('RETURN_CODE').text();

                var tr = '';
                var select = '';
                var chk = '';
                var btn = '';

                if (i === 0 || i % 2 === 0) tr = '<tr class="bg_whiteblue" id="' + USER_NO + '">';
                else tr = '<tr id="' + USER_NO + '">';

                //console.log(STATE);

                // if (STATE === 'N') select = '<select class="uuv_state"><option class="uuv_option" value="N" selected>대기</option><option class="uuv_option y" value="Y">처리완료</option></select>';
                // else select = '<select class="uuv_state"><option class="uuv_option" value="N">대기</option><option class="uuv_option y" value="Y" selected>처리완료</option></select>';

                chk = '<input type="radio" id="admin_contract_appointment_chk" name="admin_contract_appointment_chk_' + USER_NO + '" value="Y" /> 수임 <input type="radio" id="admin_contract_appointment_chk" name="admin_contract_appointment_chk_' + USER_NO + '" value="N" /> 반려';

                select = '<select class="returnCode" id="returnCode_' + USER_NO + '" style="width: 100px;"><option class="returnCode_option" value="" selected>선택</option><option class="returnCode_option y" value="1">타수임</option></select>';

                btn = '<button id="admin_contract_btn" onclick="admin_contract_btn(\'' + USER_NO + '\')">저장</button>';

                var html = tr +
                    '<td>' + BUSINESS_NO + '</td>' +
                    '<td>' + BUSINESS_WORKNAME + '</td>' +
                    '<td>' + BUSINESS_REPRESENTIVE + '</td>' +
                    '<td>' + BUSINESS_PHONE + '</td>' +
                    '<td>' + BUSINESS_REGIST_NO + '</td>' +
                    '<td>' + ADDRESS + '</td>' +
                    '<td class="goLicense" style="cursor: pointer;" onclick="goLicense(\'' + BUSINESS_LICENSE + '\')">보기</td>' +
                    '<td>' + chk + '</td>' +
                    '<td>' + select + '</td>' +
                    '<td>' + btn + '</td>' +
                    '</tr>';

                $('#contract-table').append(html);

                if (CONSIGNMENT_AGREE_ADMIN === 'Y') {
                    $('input[name="admin_contract_appointment_chk_' + USER_NO + '"]:radio[value="Y"]').prop('checked', true);
                }
                else if (CONSIGNMENT_AGREE_ADMIN === 'N') {
                    $('input[name="admin_contract_appointment_chk_' + USER_NO + '"]:radio[value="N"]').prop('checked', true);
                }

                if (!RETURN_CODE) {
                    $("#returnCode_" + USER_NO).val("").prop("selected", true);
                }
                else if (RETURN_CODE === '1') {
                    $("#returnCode_" + USER_NO).val("1").prop("selected", true);
                }
            });
        },
        error: function (xhr) {
            console.log(xhr);
        }
    });
}

// 저장버튼
function admin_contract_btn(user_no) {
    var con = confirm("저장 하시겠습니까?");

    if (!con) {
        return false;
    } else {
        // console.log(user_no);
        var consignment_agree_admin = $('input[name="admin_contract_appointment_chk_' + user_no + '"]:checked').val();  // 수임/반려 체크

        var return_code;    // 반려코드
        if (consignment_agree_admin === 'Y') {
            return_code = '';
        } else {
            return_code = $('#returnCode_' + user_no + ' option:selected').val();
        }

        $.ajax({
            type: "GET",
            cache: false,
            url: '/service/admin/set_contract.jsp',
            data: {
                user_no: user_no,
                consignment_agree_admin: consignment_agree_admin,
                return_code: return_code
            },
            contentType: "application/xml; charset=utf-8",
            dataType: "xml",
            timeout: 30000,
            complete: function () {
                alert("저장 되었습니다.")
            }
        });

    }
};



// 사업자등록증 보기
function goLicense(data) {
    var win = window.open();
    win.document.write('<iframe src="' + data + '" frameborder="0" style="border:0; top:0px; left:0px; bottom:0px; right:0px; width:100%; height:100%;" allowfullscreen></iframe>')
}



