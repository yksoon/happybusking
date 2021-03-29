$(document).on('click', '#bts_cal_back', function () {
    sessionStorage.removeItem('selectDateTemp_cal');

    $("html, body").css({ "overflow": "auto", "height": "auto" });
    $('#busking_time_cal_popup').unbind('touchmove');

    $('#busking_time_cal_popup').hide();

    $('#header').show();
    $('#footer').show();
});

$(document).on('click', '#bts_cal_time_add', function () {

    $('#bts_cal_perform').after(
        '<div class="bts_cal_perform_container" id="bts_cal_perform" style="margin-top:30px;">' +
        '<div class="bts_cal_perform_cell perform_start">' +
        '<div class="bts_cal_perform_p_title">' +
        '<p class="bts_cal_perform_p">공연시작</p>' +
        '</div>' +
        '<div class="bts_cal_perform_time start_time" style="color: #8354C8;">' +
        '<select name="btr_cal_sHour_2" id="btr_cal_sHour_2" name="btr_cal_sHour_2">' +
        '</select>' +
        ' : ' +
        '<select name="btr_cal_sMin_2" id="btr_cal_sMin_2" name="btr_cal_sMin_2">' +
        '</select>' +
        '</div>' +
        '</div>' +
        '<div class="bts_cal_perform_cell perform_end">' +
        '<div class="bts_cal_perform_p_title">' +
        '<p class="bts_cal_perform_p">공연종료</p>' +
        '</div>' +
        '<div class="bts_cal_perform_time end_time" style="color: #8354C8;">' +
        '<select name="btr_cal_eHour_2" id="btr_cal_eHour_2" name="btr_cal_eHour_2">' +
        '</select>' +
        ' : ' +
        '<select name="btr_cal_eMin_2" id="btr_cal_eMin_2" name="btr_cal_eMin_2">' +
        '</select>' +
        '</div>' +
        '</div>' +
        '</div>');
    var Now = new Date();
    var hour = Now.getHours();
    var min = Now.getMinutes();

    for (var i = 0; i <= 23; i++) {
        if ((i + "").length == 1) {
            var pr_Hour = '<option value="0' + i + '">0' + i + '</option>';
        }
        else {
            var pr_Hour = '<option value="' + i + '">' + i + '</option>';
        }
        $('#btr_cal_sHour_2').append(pr_Hour);
        $('#btr_cal_eHour_2').append(pr_Hour);
    }

    for (var i = 0; i <= 59; i++) {
        if ((i + "").length == 1) {
            var pr_Min = '<option value="0' + i + '">0' + i + '</option>';
        }
        else {
            var pr_Min = '<option value="' + i + '">' + i + '</option>';
        }
        $('#btr_cal_sMin_2').append(pr_Min);
        $('#btr_cal_eMin_2').append(pr_Min);
    }
    $('#btr_cal_sHour_2').val(pad(hour, 2)).trigger('change');
    $('#btr_cal_eHour_2').val(pad(hour, 2)).trigger('change');
    $('#btr_cal_sMin_2').val(pad(min, 2)).trigger('change');
    $('#btr_cal_eMin_2').val(pad(min, 2)).trigger('change');
});

// $(document).on('click', '#bts_cal_footer', function () {
//     var selected_sHour = $('#btr_cal_sHour').val();
//     var selected_eHour = $('#btr_cal_eHour').val();
//     var selected_sMin = $('#btr_cal_sMin').val();
//     var selected_eMin = $('#btr_cal_eMin').val();

//     var select_sTime = selected_sHour + ":" + selected_sMin;
//     var select_eTime = selected_eHour + ":" + selected_eMin;

//     var perform_time = select_sTime + "/" + select_eTime;

//     console.log(perform_time);

//     var selectDateTemp_cal = sessionStorage.getItem('selectDateTemp_cal');
//     if (selectDateTemp_cal == null || selectDateTemp_cal == '') {
//         selectDateTemp_cal = new Array();
//     } else {
//         selectDateTemp_cal = selectDateTemp_cal.split(',');
//     }

//     selectDateTemp_cal.push(perform_time);
//     selectDateTemp_cal.join(',');

//     console.log(selectDateTemp_cal);

//     sessionStorage.setItem('selectDateTemp_cal', selectDateTemp_cal);   //세션 저장

//     $("html, body").css({ "overflow": "auto", "height": "auto" });
//     $('#busking_time_cal_popup').unbind('touchmove');

//     $('#busking_time_cal_popup').hide();

//     $('#header').show();
//     $('#footer').show();

//     loadPage('busking_time/busking_time_reg_each.jsp');
// });

function bts_cal_footer_btn() {
    var selected_sHour = $('#btr_cal_sHour').val();
    var selected_eHour = $('#btr_cal_eHour').val();
    var selected_sMin = $('#btr_cal_sMin').val();
    var selected_eMin = $('#btr_cal_eMin').val();

    var select_sTime = selected_sHour + ":" + selected_sMin;
    var select_eTime = selected_eHour + ":" + selected_eMin;

    var perform_time = select_sTime + "/" + select_eTime;

    console.log(perform_time);

    var selectDateTemp_cal = sessionStorage.getItem('selectDateTemp_cal');
    if (selectDateTemp_cal == null || selectDateTemp_cal == '') {
        selectDateTemp_cal = new Array();
    } else {
        selectDateTemp_cal = selectDateTemp_cal.split(',');
    }

    selectDateTemp_cal.push(perform_time);
    selectDateTemp_cal.join(',');

    console.log(selectDateTemp_cal);

    sessionStorage.setItem('selectDateTemp_cal', selectDateTemp_cal);   //세션 저장

    var thisPage = sessionStorage.getItem('thisPage')
    console.log(thisPage);
    if (thisPage == 'busking_time_reg_each') {
        $("html, body").css({ "overflow": "auto", "height": "auto" });
        $('#busking_time_cal_popup').unbind('touchmove');

        $('#busking_time_cal_popup').hide();

        $('#header').show();
        $('#footer').show();

        sessionStorage.removeItem('thisPage');
        loadPage('busking_time/busking_time_reg_each.jsp');
    } else if (thisPage == 'register_store_update') {
        $("html, body").css({ "overflow": "auto", "height": "auto" });
        $('#busking_time_cal_popup').unbind('touchmove');

        $('#busking_time_cal_popup').hide();

        $('#header').show();
        $('#footer').show();

        sessionStorage.removeItem('thisPage');
        loadPage('reg_store/register_store_update.jsp');
    }
}