// function go_reg_busking_time() {
//     // if (artist_chk() != "O") {
//     //     alert("사업주가 아닙니다");
//     // } else if (artist_chk() == "O") {
//     loadPage('busking_time/busking_time_reg.jsp');
//     // }
// }

// function go_reg_busking_time_all() {
//     loadPage('busking_time/busking_time_reg_all.jsp');
// }
function go_reg_busking_time_each() {
    if (!owner_chk()) {
        alert("사업주가 아닙니다");
        return false;
    } else {
        loadPage('busking_time/busking_time_reg_each.jsp');
    }
}
function go_busking_time_calendar_pick() {
    loadPage('busking_time/busking_time_calendar_pick.jsp');
}

function back_reg_busking_time() {
    loadPage('busking_time/busking_time_reg.jsp');
}

function go_complete_reg_busking_time() {
    loadPage('busking_time/complete_reg_busking_time.jsp');
}

function go_busking_time_contract_list() {
    loadPage('busking_time_contract/busking_time_contract_list.jsp');
}

// 지정팀 있는경우 화면 활성
function setDisplay() {
    var chkValue = $('input[type=radio][name=re_team]:checked').val();
    // console.log(chkValue);

    if (chkValue == '1') {
        $('#re_team_status').css('display', 'block');
        sessionStorage.removeItem('designatedTeamChk');

        var designatedTeamChk = 'Y';

        sessionStorage.setItem('designatedTeamChk', designatedTeamChk);
        designatedTeamChk = sessionStorage.getItem('designatedTeamChk');
        console.log('designatedTeamChk 세션 : ' + designatedTeamChk);
        return false;
    } else if (chkValue == '0') {
        $('#re_team_status').css('display', 'none');
        sessionStorage.removeItem('designatedTeamChk');

        var designatedTeamChk = 'N';

        sessionStorage.setItem('designatedTeamChk', designatedTeamChk);
        designatedTeamChk = sessionStorage.getItem('designatedTeamChk');
        console.log('designatedTeamChk 세션 : ' + designatedTeamChk);
        return false;
    }
};


function go_reg_busking_time_back() {
    var btrChk = sessionStorage.getItem('btrChk');
    if (btrChk == null || btrChk == '') {
        history.go(-1);
    } else {
        history.go(-3);
        sessionStorage.removeItem('btrChk');
    }
}



function insert_reg_perform(A_USER_NO, A_PERFORM_NO, TEAM_NO, MATCHING_CHK, team_total_price) {

    $.ajax({
        type: "POST",//url: "JSON/test.json",
        cache: false,
        async: false,
        url: '/service/busking_time/reg_perform_confirm.jsp',
        //data : data,
        data: {
            user_no: A_USER_NO,
            perform_no: A_PERFORM_NO,
            team_no: TEAM_NO,
            matching_chk: MATCHING_CHK,
            team_total_price: team_total_price
        },
        // dataType: "xml",
        timeout: 30000,
        beforeSend: function () {
            showLoading('show', '등록중입니다');
        },
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function (i) {
                var RESULT = $(DATA).find('RESULT').text();
                var MESSAGE = $(DATA).find('MESSAGE').text();

                if (RESULT == 'TRUE' || RESULT == 'true') {
                    return
                }
                else {
                    alert(MESSAGE);
                    return;
                }
            });

        }, // end success
        error: function (xhr, message, errorThrown) {
            // console.log(xhr);
            // console.log(message);
            // console.log(errorThrown);
            // alert('잠시후 다시 시도해주세요.');
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            showLoading('hide', '등록중입니다');
        }
    });
}