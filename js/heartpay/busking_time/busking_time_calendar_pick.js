
$(document).ready(function () {
    var selectDateTemp_cal = sessionStorage.getItem('selectDateTemp');
    selectDateTemp_cal = new Array();
    sessionStorage.setItem('selectDateTemp_cal', selectDateTemp_cal);
});


var select_date;
// 날짜 클릭시
$(document).on("click", "td", function () {
    // console.log("hahha")
    select_date = new Date(today.getFullYear(), today.getMonth(), $(this).html());
    // console.log(select_date.getFullYear());
    // console.log(select_date.getMonth() + 1);
    // console.log(select_date.getDate());
    $(".calendar_table .select_day").removeClass("select_day");
    $(this).removeClass("select_day").addClass("select_day");
});


// 날짜 선택 누를시
$(document).on('click', '.btr_cal_footer', function () {
    // console.log(select_date);
    // console.log(typeof (select_date));
    // select_date = new Date(today.getFullYear(), today.getMonth(), $(this).html());


    // console.log(typeof (select_date));
    console.log(select_date);
    if (!select_date) {
        alert("날짜를 선택 해주세요.");
        return false;
    }

    $("html, body").css({ "overflow": "hidden", "height": "100%" });
    $("#busking_time_cal_popup").bind("touchmove", function (e) {
        e.preventDefault();
    });
    $("#busking_time_cal_popup .custom_select_popup").bind("touchmove", function (e) {
        e.stopPropagation();
    });

    $('#busking_time_cal_popup').load('/app_root/jsp/custom_select_box/busking_time_cal_popup.jsp', function () {
        // document.getElementById('busking_time_cal_popup').style.display = 'block';
        $('#busking_time_cal_popup').show();

        $('#header').hide();
        $('#footer').hide();

        var selectDateTemp_cal = sessionStorage.getItem('selectDateTemp_cal');
        if (selectDateTemp_cal == null || selectDateTemp_cal == '') {
            selectDateTemp_cal = new Array();
        } else {
            selectDateTemp_cal = selectDateTemp_cal.split(',');
        }
        var year = select_date.getFullYear();
        var month = select_date.getMonth() + 1;
        var date = select_date.getDate();

        selectDateTemp_cal.push(year + '-' + month + '-' + date);
        selectDateTemp_cal.join(',');
        sessionStorage.setItem('selectDateTemp_cal', selectDateTemp_cal);

        var selectDateTemp_cal = sessionStorage.getItem('selectDateTemp_cal');
        console.log(selectDateTemp_cal);
        console.log(typeof (selectDateTemp_cal));

        $('#select_date').append('<p class="bts_cal_body_title">' + month + '월 ' + date + '일 버스킹 일정</p>');

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
            $('#btr_cal_sHour').append(pr_Hour);
            $('#btr_cal_eHour').append(pr_Hour);
        }

        for (var i = 0; i <= 59; i++) {
            if ((i + "").length == 1) {
                var pr_Min = '<option value="0' + i + '">0' + i + '</option>';
            }
            else {
                var pr_Min = '<option value="' + i + '">' + i + '</option>';
            }
            $('#btr_cal_sMin').append(pr_Min);
            $('#btr_cal_eMin').append(pr_Min);
        }
        $('#btr_cal_sHour').val(pad(hour, 2)).trigger('change');
        $('#btr_cal_eHour').val(pad(hour, 2)).trigger('change');
        $('#btr_cal_sMin').val(pad(min, 2)).trigger('change');
        $('#btr_cal_eMin').val(pad(min, 2)).trigger('change');
    });


});