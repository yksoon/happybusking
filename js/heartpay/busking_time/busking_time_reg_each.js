$(document).on('pageinit', '#busking_time_reg_each', function () {
    var thisPage = 'busking_time_reg_each';
    sessionStorage.setItem('thisPage', thisPage);
    sessionStorage.removeItem('team_total_price');
    sessionStorage.removeItem('selected_team_no');
    sessionStorage.removeItem('selected_team_name');
    sessionStorage.removeItem('designatedTeamChk');

    var designatedTeamChk = 'N';
    sessionStorage.setItem('designatedTeamChk', designatedTeamChk);

    var selectDateTemp_cal = sessionStorage.getItem('selectDateTemp_cal');
    // console.log("s : " + selectDateTemp_cal + "->" + typeof (selectDateTemp_cal));

    if (selectDateTemp_cal == null || selectDateTemp_cal == '') {
        $("#re_perfom_date").attr("value", "");

        $("#start_time_input_hour").attr("value", "");
        $("#start_time_input_min").attr("value", "");

        $("#end_time_input_hour").attr("value", "");
        $("#end_time_input_min").attr("value", "");
    } else {
        selectDateTemp_cal = selectDateTemp_cal.split(',');
        console.log("session 날짜 : " + selectDateTemp_cal[0]);
        console.log("session 공연시작/종료 : " + selectDateTemp_cal[1]);

        var date = selectDateTemp_cal[0];
        date = date.split('-');

        var year = date[0];
        var month = date[1];
        var day = date[2];

        $("#re_perfom_date").attr("value", year + "년 " + month + "월 " + day + "일");

        var time = selectDateTemp_cal[1];
        time = time.split("/");

        var sTime = time[0];
        var eTime = time[1];

        sTime = sTime.split(":");
        var sHour = sTime[0];
        var sMin = sTime[1];

        eTime = eTime.split(":");
        var eHour = eTime[0];
        var eMin = eTime[1];

        $("#start_time_input_hour").attr("value", sHour);
        $("#start_time_input_min").attr("value", sMin);

        $("#end_time_input_hour").attr("value", eHour);
        $("#end_time_input_min").attr("value", eMin);
    }


});

$(document).on('click', '#re_perfom_date', function () {
    sessionStorage.removeItem('selectDateTemp_cal');
    loadPage('busking_time/busking_time_calendar_pick.jsp');
});

$(document).on('click', '.re_team', function () {
    $("html, body").css({ "overflow": "hidden", "height": "100%" });
    // $("#busking_time_each_popup").bind("touchmove", function (e) {
    //     e.preventDefault();
    // });
    // $("#busking_time_each_popup .custom_select_popup").bind("touchmove", function (e) {
    //     e.stopPropagation();
    // });

    $('#busking_time_each').on('scroll touchmove mousewheel', function (e) {
        e.preventDefault();
        e.stopPropagation();
        return false;
    });

    $('#busking_time_each_popup').load('/app_root/jsp/custom_select_box/busking_time_each_team.jsp', function () {
        $('#busking_time_each_popup').show();

        $('#header').hide();
        $('#footer').hide();
    });
});

// 금액 입력 3자리 단위 콤마
$(document).on('keyup', '#money_input_price', function (event) {
    this.value = this.value.replace(/[^0-9]/g, '');   // 입력값이 숫자가 아니면 공백
    this.value = this.value.replace(/,/g, '');          // ,값 공백처리
    this.value = this.value.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 	

    team_total_price = $('#money_input_price').val()
    team_total_price = this.value.replace(/,/g, '');

    // console.log("team_total_price 세션 : " + team_total_price);

    sessionStorage.setItem('team_total_price', team_total_price);

    var team_total_price = sessionStorage.getItem('team_total_price');
    console.log("team_total_price test 세션 : " + team_total_price);
});

var team_total_price = '';

// 금액 입력 이벤트
$(document).on('change', '#money_input_price', function (e) {
    team_total_price = $('#money_input_price').val()
    team_total_price = this.value.replace(/,/g, '');

    // console.log("team_total_price 세션 : " + team_total_price);

    sessionStorage.setItem('team_total_price', team_total_price);

    var team_total_price = sessionStorage.getItem('team_total_price');
    console.log("team_total_price test 세션 : " + team_total_price);
});

$(document).on('blur', '#money_input_price', function () {
    team_total_price = $('#money_input_price').val()
    team_total_price = this.value.replace(/,/g, '');

    // console.log("team_total_price 세션 : " + team_total_price);

    sessionStorage.setItem('team_total_price', team_total_price);

    var team_total_price = sessionStorage.getItem('team_total_price');
    console.log("team_total_price test 세션 : " + team_total_price);
});


// 공연요청 버튼
$(document).on('click', '#re_footer', function () {



    if ($('#re_perfom_date').val() == null || $('#re_perfom_date').val() == '') {
        alert("날짜를 선택하세요.");
        return false;
    }
    else if ($('#money_input_price').val() == null || $('#money_input_price').val() == '') {
        alert("공연비를 입력하세요.");
        return false;
    }

    var selectDateTemp_cal = sessionStorage.getItem('selectDateTemp_cal');
    var team_total_price = sessionStorage.getItem('team_total_price');
    var selected_team_no = sessionStorage.getItem('selected_team_no');
    // var selected_team_name = $('.re_team').val();
    var selected_team_name = sessionStorage.getItem('selected_team_name');
    var designatedTeamChk = sessionStorage.getItem('designatedTeamChk');
    var user_no = $('#user_no').val();


    // 공연번호
    var performTime = selectDateTemp_cal.split(',')
    var performTimeDate = performTime[0].split('-');
    if (performTimeDate[1].length == 1) {
        var performTimeMonth = '0' + performTimeDate[1];
    } else {
        var performTimeMonth = performTimeDate[1];
    }

    if (performTimeDate[2].length == 1) {
        var performTimeDay = '0' + performTimeDate[2];
    } else {
        var performTimeDay = performTimeDate[2];
    }


    performTimeDate = performTimeDate[0] + performTimeMonth + performTimeDay;

    var performTime_2 = $('#start_time_input_hour').val() + $('#start_time_input_min').val();


    var PERFORM_NO = user_no + performTimeDate + performTime_2;

    // 요일
    var week = ['일', '월', '화', '수', '목', '금', '토'];
    var dayOfWeek = week[new Date(performTime[0]).getDay()];

    // 공연날짜
    var busking_date = performTime[0];

    // 공연시작시간, 종료시간
    var starting_time_arr = performTime[1];
    starting_time_arr = starting_time_arr.split('/');

    var starting_time = starting_time_arr[0];
    var finishing_time = starting_time_arr[1];

    // 지정팀 선택시 자동 공연 승인
    // (1: 승인 완료, 2: 승인 거절, 3: 모집중, 4: 승인 대기)
    if (designatedTeamChk == 'Y') {
        var busking_status = '1'
    } else {
        var busking_status = '3'
    }

    console.log(selectDateTemp_cal);
    console.log(team_total_price);
    console.log("선택된 팀번호 : " + selected_team_no);
    console.log("선택된 팀이름 : " + selected_team_name);
    console.log("선택된 팀여부 : " + designatedTeamChk);
    console.log(user_no);
    console.log(PERFORM_NO);
    console.log(performTimeDate);
    console.log(dayOfWeek);
    console.log(starting_time);
    console.log(finishing_time);



    var conf = confirm('공연 일정을 등록하시겠습니까 ? ');
    if (!conf) {
        return false;
    }

    $.ajax({
        type: "POST",//url: "JSON/test.json",
        cache: false,
        sync: false,
        url: '/service/busking_time/busking_time_reg.jsp',
        //data : data,
        data: {
            perform_no: PERFORM_NO,
            busking_date: busking_date,
            starting_time: starting_time,
            finishing_time: finishing_time,
            day_of_the_week: dayOfWeek,
            offer_price: team_total_price,
            team_no: selected_team_no,
            team_name: selected_team_name,
            user_no: user_no,
            busking_status: busking_status
        },
        dataType: "xml",
        timeout: 30000,
        beforeSend: function () {
            $.mobile.loading('show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
        },
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');


        }, // end success
        error: function (xhr, message, errorThrown) {
            // console.log(xhr);
            // console.log(message);
            // console.log(errorThrown);
            alert('잠시후 다시 시도해주세요.');
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            showLoading('hide', '등록중입니다');
        }
    }).promise().done(function () {
        $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });

        if (designatedTeamChk == 'Y') {
            var user_no_arr = [];
            var perform_no_e;
            var team_no_e;
            var team_name_e;
            var business_representive_e;
            var buskingdate_e;
            $.ajax({
                type: "GET",//url: "JSON/test.json",
                cache: false,
                async: false,
                url: '/service/busking_time/select_perform_confirm.jsp',
                //data : data,
                data: {
                    team_no: selected_team_no,
                    user_no: user_no,
                    perform_no: PERFORM_NO
                },
                dataType: "xml",
                timeout: 30000,
                beforeSend: function () {
                    showLoading('show', '등록중입니다');
                },
                success: function (data) {
                    var ROOT = $(data).find('ROOT');
                    var DATA = $(ROOT).find('DATA');

                    $(DATA).each(function (i) {
                        var A_USER_NO = $(this).find("USER_NO").text();
                        var A_PERFORM_NO = $(this).find("PERFORM_NO").text();
                        var TEAM_NO = $(this).find("TEAM_NO").text();
                        var TEAM_NAME = $(this).find("TEAM_NAME").text();
                        var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
                        var BUSINESS_REPRESENTIVE = $(this).find("BUSINESS_REPRESENTIVE").text();
                        var MATCHING_CHK = '3';

                        user_no_arr.push(A_USER_NO);
                        perform_no_e = A_PERFORM_NO;
                        team_no_e = TEAM_NO;
                        team_name_e = TEAM_NAME;
                        buskingdate_e = BUSKINGDATE;
                        business_representive_e = BUSINESS_REPRESENTIVE;
                        insert_reg_perform(A_USER_NO, A_PERFORM_NO, TEAM_NO, MATCHING_CHK, team_total_price);
                    })
                }, // end success
                error: function (xhr, message, errorThrown) {
                    console.log(xhr);
                    console.log(message);
                    console.log(errorThrown);
                    alert('잠시후 다시 시도해주세요.');
                    return;
                    //hideLoading();
                }, // end error
                complete: function () {

                }
            }).promise().done(function () {

                console.log("art_arr " + user_no_arr)
                user_no_arr = user_no_arr.toString();
                $.ajax({
                    type: 'GET',
                    cache: false,
                    url: '/service/busking_time_contract/set_busking_time_confirm.jsp',
                    data: {
                        perform_no: perform_no_e,
                        user_no_arr: user_no_arr,
                        team_no: team_no_e,
                        team_name: team_name_e,
                        business_representive: business_representive_e,
                        buskingdate: buskingdate_e
                    },
                    contentType: "application/xml; charset=utf-8",
                    dataType: "xml",
                    timeout: 30000,
                    success: function (data) {
                        var ROOT = $(data).find('ROOT');
                        var DATA = $(ROOT).find('DATA');
                        var MESSAGE = $(DATA).find('MESSAGE');

                        $(DATA).each(function () {
                            console.log(MESSAGE);
                        })
                    }
                });

            })
        }
        go_complete_reg_busking_time();
    });

});