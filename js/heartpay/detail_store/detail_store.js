//뒤로가기시 아티스트정보에서 탭 구분을 위함.

var store_info_pageNo = 1;

// var USER_NO = "";
// var SPACE_PICTURE = "";
// var STAGE_PICTURE = "";
// var ADDRESS = "";
// var DETAIL_ADDR = "";
// var OPERATIONHOUR = "";
// var BUSINESS_WORKNAME = "";
// var EQUIPMENT = "";
// var GENRE = "";
// var PARKING_CHK = "";
// var PERFORM_TIPBOX = "";
// var MOBILE_TIPBOX = "";
// var VIDEO_CHK = "";
// var MENU = "";
// var HASHTAG = "";
// var ZONE_INFO = "";

$(document).on('pageshow', '#detail_store', function () {
     var busking_click_ck = sessionStorage.getItem('busking_click_ck');
    console.log("디테일 버스킹에서 왔니? ->" + busking_click_ck);
    if(busking_click_ck =='Y'){
        //sessionStorage.removeItem('busking_click_ck');
        store_info_pageNo = 3
    }
    if (store_info_pageNo == 1) {
        $('#Go_st_introBtn').click();
    }
    else if (store_info_pageNo == 2) {
        $('#Go_st_menuBtn').click();
    }
    else if (store_info_pageNo == 3) {
        $('#Go_st_calBtn').click();
    }
    else if (store_info_pageNo == 4) {
        $('#Go_st_trafBtn').click();
    }
});
//테스트
$(document).on('click', '#Go_st_introBtn', function () {
    var perform_no = sessionStorage.getItem('sl_perform_no');
    store_info_pageNo = 1;
    var header_html = '<div class="ui-block-a-on" id="Go_st_introBtn">' +
        '<div class="store_menu_div_on">' +
        '<span>소개</span>' +
        '</div>' +
        '</div>' +
        '<div class="ui-block-b" id="Go_st_menuBtn">' +
        '<div class="haeder_menu_div_base">' +
        '<span>메뉴</span>' +
        '</div>' +
        '</div>' +
        '<div class="ui-block-c" id="Go_st_calBtn">' +
        '<div class="haeder_menu_div_base">' +
        '<span>일정</span>' +
        '</div>' +
        '</div>' +
        '<div class="ui-block-d" id="Go_st_trafBtn">' +
        '<div class="haeder_menu_div_base">' +
        '<span>교통</span>' +
        '</div>' +
        '</div>';


    $('.header_menu_container').html(header_html);
    $('#store_dtl_introduce').removeClass('store_dtl_introduce_m');
    $('#store_dtl_introduce').addClass('store_dtl_introduce');
    $('.store_dtl_butten').show()
    var intro_content_html = '<div class="store_dtl_introduce_t">' +
        '공간 소개' +
        '</div>' +
        '<div class="store_dtl_introduce_c">' +
        '</div>' +
        '<div class="store_dtl_introduce_ht_list">' +
        '</div>' +
        '<div class="store_dtl_introduce_t_a">' +
        '위치 정보' +
        '</div>' +
        '<div class="store_dtl_introduce_addr">' +
        '<div class="store_dtl_introduce_addr_l"></div>' +
        '<div class="store_dtl_introduce_addr_r" onclick="load_search_go()">|길찾기</div>' +
        '</div>' +
        '<div class="store_dtl_introduce_t_b">' +
        '영업 시간' +
        '</div>' +
        '<div class="store_dtl_introduce_time">' +
        '</div>';

    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/detail_store/detail_store.jsp',
        data: {
            perform_no: perform_no
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');
            console.log('success');
            $(DATA).each(function (i) {

                //var USER_NO = $(this).find('USER_NO').text();
                //var SPACE_PICTURE = $(this).find('SPACE_PICTURE').text();
                //var STAGE_PICTURE = $(this).find('STAGE_PICTURE').text();
                var ADDRESS = $(this).find('ADDRESS').text();
                var DETAIL_ADDR = $(this).find('DETAIL_ADDR').text();
                var OPERATIONHOUR = $(this).find('OPERATIONHOUR').text();
                // var EQUIPMENT = $(this).find('EQUIPMENT').text();
                // var GENRE = $(this).find('GENRE').text();
                // var PARKING_CHK = $(this).find('PARKING_CHK').text();
                // var PERFORM_TIPBOX = $(this).find('PERFORM_TIPBOX').text();
                // var MOBILE_TIPBOX = $(this).find('MOBILE_TIPBOX').text();
                // var VIDEO_CHK = $(this).find('VIDEO_CHK').text();
                //var MENU = $(this).find('MENU').text();
                var HASHTAG = $(this).find('HASHTAG').text();
                var ZONE_INFO = $(this).find('ZONE_INFO').text();
                // var LICENSE_PICTURE = $(this).find('LICENSE_PICTURE').text();
                //var BUSINESS_WORKNAME = $(this).find('BUSINESS_WORKNAME').text();

                $('.store_dtl_introduce').html(intro_content_html);
                $('.store_dtl_introduce_c').html(ZONE_INFO);
                $('.store_dtl_introduce_addr_l').html(ADDRESS + DETAIL_ADDR);
                $('.store_dtl_introduce_time').html(OPERATIONHOUR);

                if (HASHTAG != '') {
                    var hashtag_array = HASHTAG.split(',');
                    var hashtag_html = '';
                    for (var i = 0; i < hashtag_array.length; i++) {
                        hashtag_html = '<div class="store_dtl_introduce_ht">' + hashtag_array[i] + '</div>'
                        $('.store_dtl_introduce_ht_list').append(hashtag_html);
                    }
                }
                var inh = window.innerHeight;
                console.log("높이는? - >" + inh)
                $('#store_dtl').css({"height":inh - 132.5});
            })
        },
        error: function (xhr, message, errorThrown) {
            console.log("error");
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
            //alert(data);
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            // $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
            // sessionStorage.setItem('aname', $('#artist_name').val())
            // sessionStorage.setItem('acontent', $('#artist_intro').val());
            //setAimgCallback2(imgsrc);

            // go_team_create();
        }
    });

});

$(document).on('click', '#Go_st_menuBtn', function () {
    var perform_no = sessionStorage.getItem('sl_perform_no');
    if (store_info_pageNo == 2) {

    }
    else{
        store_info_pageNo = 2;
        var header_html = '<div class="ui-block-a" id="Go_st_introBtn">' +
            '<div class="haeder_menu_div_base">' +
            '<span>소개</span>' +
            '</div>' +
            '</div>' +
            '<div class="ui-block-b-on" id="Go_st_menuBtn">' +
            '<div class="store_menu_div_on">' +
            '<span>메뉴</span>' +
            '</div>' +
            '</div>' +
            '<div class="ui-block-c" id="Go_st_calBtn">' +
            '<div class="haeder_menu_div_base">' +
            '<span>일정</span>' +
            '</div>' +
            '</div>' +
            '<div class="ui-block-d" id="Go_st_trafBtn">' +
            '<div class="haeder_menu_div_base">' +
            '<span>교통</span>' +
            '</div>' +
            '</div>';
    
        $('.header_menu_container').html(header_html);
    
        var content_html = '<div class="store_dtl_introduce_t">메뉴판</div>' +
            '<div id="store_menu_imgs"></div>';
    
        $('.store_dtl_introduce').html(content_html);
        $('.store_dtl_butten').hide()
        $.ajax({
            type: "GET",
            cache: false,
            url: '/service/detail_store/detail_store.jsp',
            data: {
                perform_no: perform_no
            },
            contentType: "application/xml; charset=utf-8",
            dataType: "xml",
            timeout: 30000,
            success: function (data) {
                var ROOT = $(data).find('ROOT');
                var DATA = $(ROOT).find('DATA');
                console.log('success');
                $(DATA).each(function (i) {
                    var USER_NO = $(this).find('USER_NO').text();
                    var MENU = $(this).find('MENU').text();
                    if (MENU != '') {
                        var new_img = 'upload/store/menu/menu' + USER_NO + "/" + MENU;
    
                        var imgSrc = getImagePromise(new_img).then(value => {
                            me_img_html = '<img src="' + value + '" id="stroe_menu_img" style="width:96%">';
                            $('#store_menu_imgs').append(me_img_html);
                            // $('#store_menu_imgs').css({'background':'url("' + value + '")'});
                            // $('#store_menu_imgs').css({'background-size':'cover'});
    
                        });
                        $('#store_dtl_introduce').removeClass('store_dtl_introduce');
                        $('#store_dtl_introduce').addClass('store_dtl_introduce_m');
                    }
                    else {
                        var me_no_img_html = '등록된 메뉴판이 없습니다.';
                        $('#store_menu_imgs').append(me_no_img_html);
                    }
                    var inh = window.innerHeight;
                    console.log("높이는? - >" + inh)
                    $('#store_dtl').css({"height":inh - 132.5});
                })
            },
            error: function (xhr, message, errorThrown) {
                console.log("error");
                console.log(xhr);
                console.log(message);
                console.log(errorThrown);
                //alert(data);
                return;
                //hideLoading();
            }, // end error
            complete: function () {
                // $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
                // sessionStorage.setItem('aname', $('#artist_name').val())
                // sessionStorage.setItem('acontent', $('#artist_intro').val());
                //setAimgCallback2(imgsrc);
    
                // go_team_create();
            }
        });
    }
    
});

//공연 상세 페이지 이미지 클릭시 팝업으로 크게 보여주기 
$(document).on('click', '#store_menu_imgs', function(){
	//documentScroll = '0px';
	
	//var popupPosition = $(this).attr('id');
	var src = $('#stroe_menu_img').attr('src');
	$('#team_img_popup').append('<img id="tip_picture_img"/>');
	$('#tip_picture_img').attr('src', src);
	$("#team_img_popup").show();
	//$('#team_img_popup').css('top', documentScroll);
	
	var el = document.querySelector('#tip_picture_img');
	new PinchZoom.default(el, {
		
	});
});

$(document).on('click', '#Go_st_calBtn', function () {
    var store_user = $('#store_user_no').val()
    store_info_pageNo = 3;
    var header_html = '<div class="ui-block-a" id="Go_st_introBtn">' +
        '<div class="haeder_menu_div_base">' +
        '<span>소개</span>' +
        '</div>' +
        '</div>' +
        '<div class="ui-block-b" id="Go_st_menuBtn">' +
        '<div class="haeder_menu_div_base">' +
        '<span>메뉴</span>' +
        '</div>' +
        '</div>' +
        '<div class="ui-block-c-on" id="Go_st_calBtn">' +
        '<div class="store_menu_div_on">' +
        '<span>일정</span>' +
        '</div>' +
        '</div>' +
        '<div class="ui-block-d" id="Go_st_trafBtn">' +
        '<div class="haeder_menu_div_base">' +
        '<span>교통</span>' +
        '</div>' +
        '</div>';

    $('#store_dtl_introduce').removeClass('store_dtl_introduce_m');
    $('#store_dtl_introduce').addClass('store_dtl_introduce');
    $('.header_menu_container').html(header_html);
    $('.store_dtl_butten').hide()
    var content_html = '<div class="store_dtl_introduce_t_cal">' +
        '<div class="store_date_select_container">' +
        '<div class="store_year_select">' +
        ' <div class="store_ui-select">' +
        '<div id="store_year_select-button" class="store_ui-btn">' +
        '<span id="store_y"></span>' +
        '<select id="store_year_select">' +
        '</select>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '<div class="store_month_select">' +
        ' <div class="store_ui-select">' +
        '<div id="store_month_select-button" class="store_ui-btn">' +
        '<span id="store_m"></span>' +
        '<select id="store_month_select">' +
        ' </select>' +
        '</div>' +
        '</div>' +
        '</div>' +
        ' <img src="/img/panel_v2/down.svg" class="store_down_arrow">' +
        '<div class="store_date_buskingstatus_ck">'+
        ' <input type="checkbox" name="buskingstatus_ck" id="buskingstatus_ck" data-role="none" >'+
        '<label for="buskingstatus_ck"><div class="buskingstatus_ck_value">모집중 공연</div><span></span></label>'+
        '</div>'+
        '</div>' +
        '</div>' +
        '<div class="store_dtl_cal" id="store_dtl_cal">' +
        '</div>';
    $('.store_dtl_introduce').html(content_html);
    //오늘 날짜 가져오기
    var Now = new Date();

    var year = Now.getFullYear();
    var month = Now.getMonth() + 1;

    for (var i = year; i < year + 3; i++) {
        var pr_year = '<option value="' + i + '">' + i + '년</option>';
        $('#store_year_select').append(pr_year);
    }

    for (var i = 1; i <= 12; i++) {
        if ((i + "").length == 1) {
            var pr_month = '<option value="0' + i + '">0' + i + '월</option>';
        }
        else {
            var pr_month = '<option value="' + i + '">' + i + '월</option>';
        }
        $('#store_month_select').append(pr_month);
    }
    $('#store_year_select').val(year).trigger('change');
    $('#store_month_select').val(pad(month, 2)).trigger('change');

    var search_year = $('#store_year_select').val();
    var search_month = $('#store_month_select').val();
    $("#store_y").text(search_year + "년");
    $("#store_m").text(search_month + "월");
    if (search_month.substr(0, 1) == '0') {
        search_month = search_month.substring(1);
    }


    $("#store_month_select").trigger('change');
    $("#store_year_select").trigger('change');
    //get_store_select_date(search_year, search_month);
    $('#store_month_select').change(function () {
        $(".store_dtl_cal").empty();

        var search_year = $('#store_year_select').val();
        var search_month = $('#store_month_select').val();
        $("#store_y").text(search_year + "년");
        $("#store_m").text(search_month + "월");
        console.log(search_month);
        // console.log(typeof (search_month));

        if (search_month.substr(0, 1) == '0') {
            search_month = search_month.substring(1);
        }
        console.log(search_year);
        console.log(search_month);

        get_store_select_date(search_year, search_month);
    });
    $('#store_year_select').change(function () {
        $(".store_dtl_cal").empty();

        var search_year = $('#store_year_select').val();
        var search_month = $('#store_month_select').val();
        $("#store_y").text(search_year + "년");
        $("#store_m").text(search_month + "월");
        // console.log(search_month);
        // console.log(typeof (search_month));

        if (search_month.substr(0, 1) == '0') {
            search_month = search_month.substring(1);
        }
        console.log(search_year);
        console.log(search_month);

        get_store_select_date(search_year, search_month);
    });
    $('#buskingstatus_ck').change(function () {
        $(".store_dtl_cal").empty();

        var search_year = $('#store_year_select').val();
        var search_month = $('#store_month_select').val();
        $("#store_y").text(search_year + "년");
        $("#store_m").text(search_month + "월");
        // console.log(search_month);
        // console.log(typeof (search_month));

        if (search_month.substr(0, 1) == '0') {
            search_month = search_month.substring(1);
        }
        console.log(search_year);
        console.log(search_month);

        get_store_select_date(search_year, search_month);
    });
    get_store_select_date(search_year, search_month);
});

function get_store_select_date(search_year, search_month) {
    var busking_click_ck = sessionStorage.getItem('busking_click_ck');
    
    if(busking_click_ck =='Y'){
        var store_user_no = sessionStorage.getItem('busking_user_no');
        var buskingstatus_ck = 'N';
    }
    else{
        var store_user_no = $('#store_user_no').val();
        if($('#buskingstatus_ck').prop("checked")){
            $('#buskingstatus_ck').val("Y");
        }
        else{
            $('#buskingstatus_ck').val("N");
        }
        var buskingstatus_ck = $('#buskingstatus_ck').val()
        console.log('체크박스->' + buskingstatus_ck);
       
    }
    
    
    
    sessionStorage.removeItem('busking_click_ck');
    sessionStorage.removeItem('busking_user_no');
    if (search_month.length == '1') {
        search_month = '0' + search_month;
    }
    var search_date = search_year + '-' + search_month;
    
    if (userLogin_chk() == false) {
        alert('로그인 하시고 해당 서비스를 이용해주세요');
        loadPage('login/login.jsp');
    } else {
        $.ajax({
            type: "GET",
            cache: false,
            url: '/service/detail_store/detail_store_calList.jsp',
            data: {
                store_user_no: store_user_no,
                buskingstatus_ck: buskingstatus_ck,
                search_date: search_date
            },
            contentType: "application/xml; charset=utf-8",
            dataType: "xml",
            timeout: 30000,
            success: function (data) {
                var ROOT = $(data).find('ROOT');
                var DATA = $(ROOT).find('DATA');

                $(DATA).each(function (i) {
                    var PERFORM_NO = $(this).find("PERFORM_NO").text();
                    var TEAM_NAME = $(this).find("TEAM_NAME").text();
                    var TEAM_NO = $(this).find("TEAM_NO").text();
                    var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
                    var DAYOFTHEWEEK = $(this).find("DAYOFTHEWEEK").text();
                    var STARTINGTIME = $(this).find("STARTINGTIME").text();
                    var FINISHINGTIME = $(this).find("FINISHINGTIME").text();
                    var TINTRO_IMG = $(this).find("TINTRO_IMG").text();
                    var SPACE_PICTURE = $(this).find("SPACE_PICTURE").text();
                    var BUSKINGSTATUS = $(this).find("BUSKINGSTATUS").text();
                    var busking_day_arr = BUSKINGDATE.split('-');
                    var busking_day = busking_day_arr[2];
                    var ARTIST_MATCHING = $(this).find('ARTIST_MATCHING').text();
                    

                    // console.log($('.btcl_day p').val());

                    // var sessBuskingDay = sessionStorage.getItem('busking_day');
                    // console.log('ss' + sessBuskingDay);
                    // if (sessBuskingDay != busking_day) {
                    //     sessionStorage.setItem('busking_day', busking_day);
                    //     var btcl_mid_date_container =
                    //         '<div class="btcl_mid_date_container">' +
                    //         '<div class="btcl_day">' +
                    //         '<p>' + busking_day + '일</p>' +
                    //         '</div>' +
                    //         '<div class="btcl_dayofweek">' +
                    //         '<p>' + DAYOFTHEWEEK + '요일</p>' +
                    //         '</div>'
                    //     '</div>';
                    // } else {
                    //     var btcl_mid_date_container = '';
                    // }
                    // $('.store_dtl_cal').append(btcl_mid_date_container);

                    var sessBuskingDay = sessionStorage.getItem('busking_day');
                    // console.log('ss' + sessBuskingDay);
                    if (sessBuskingDay != busking_day + STARTINGTIME + FINISHINGTIME) {
                        sessionStorage.setItem('busking_day', busking_day + STARTINGTIME + FINISHINGTIME);
                        var btcl_mid_date_container =
                            '<div class="btcl_mid_date_container">' +
                            '<div class="btcl_day">' +
                            '<p>' + busking_day + '일(' + DAYOFTHEWEEK + ')</p>' +
                            '</div>' +
                            '<div class="btcl_dayofweek">' +
                            '<p>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</p>' +
                            '</div>'
                        '</div>';
                    } else {
                        var btcl_mid_date_container = '';
                    }
                    $('.store_dtl_cal').append(btcl_mid_date_container);
                    //console.log(MATCHING_CHK);
                    // (1: 공연 승인, 2: 공연 거절, 3: 모집중, 4: 승인 대기, 5: 공연 완료)
                    // if (MATCHING_CHK == '1') {
                    //     var matching_chk = '승인 대기';
                    // }
                    // else if (MATCHING_CHK == '2') {
                    //     var matching_chk = '신청 취소';
                    // }
                    // else if (MATCHING_CHK == '3') {
                    //     var matching_chk = '공연 승인';
                    // }
                    // else if (MATCHING_CHK == '4') {
                    //     var matching_chk = '공연 거절';
                    // }
                    if (BUSKINGSTATUS == '3') {
                        BUSKINGSTATUS = '모집중';
                        var nowperform = "신청 가능";
                    }
                    else if (BUSKINGSTATUS == '2') {
                        BUSKINGSTATUS = '모집중';
                        var nowperform = "신청 가능";
                    }
                    else if (BUSKINGSTATUS == '4') {
                        BUSKINGSTATUS = '모집중';
                        var nowperform = "신청 가능";
                    }
                    else if (BUSKINGSTATUS == '1') {
                        BUSKINGSTATUS = TEAM_NAME;
                        var nowperform = "공연 확정";
                    }
                    else if (BUSKINGSTATUS == '5') {
                        BUSKINGSTATUS = TEAM_NAME;
                        var nowperform = "공연 완료";
                    }
                    else if (BUSKINGSTATUS == '모집마감') {

                        var nowperform = "공연 마감";
                    }

                    if (nowperform == "신청 가능") {
                        var color_ck = '<p class="nowperform_ok">' + nowperform + '</p>'
                    } else {
                        var color_ck = '<p>' + nowperform + '</p>'
                    }

                    if (TEAM_NO) {
                        var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                        var imgSrc = getImagePromise(new_img).then(value => {
                            $('#aimg' + PERFORM_NO).attr('src', value);
                            console.log('#aimg' + PERFORM_NO);
                        });
                    }
                    else {
                        var user_no = $('#store_user_no').val();
                        var sp_picture_array = SPACE_PICTURE.split(',');
                        var new_img = 'upload/store/space/space' + user_no + "/" + sp_picture_array[0];
                        var imgSrc = getImagePromise(new_img).then(value => {
                            $('#aimg' + PERFORM_NO).attr('src', value);
                            console.log('#aimg' + PERFORM_NO);
                        });
                    }
                    var busking_onclick;
                    var user_ck = $('#user_no').val();
                    var ARTIST_MATCHING_ck = ARTIST_MATCHING.split(',');
                    var ARTIST_MATCHING_ONE = new Array();
                    var ARTIST_MATCHING_TWO = new Array();
                    var ARTIST_MATCHING_THREE = new Array();
                    var ARTIST_MATCHING_FOUR = new Array();
                    for (var a = 0; a < ARTIST_MATCHING_ck.length; a++) {
                        var ARTIST_ck = ARTIST_MATCHING_ck[a].split('/');
                        if (ARTIST_ck[1] == 1) {
                            ARTIST_MATCHING_ONE[a] = ARTIST_ck[0];
                        }
                        else if (ARTIST_ck[1] == 2) {
                            ARTIST_MATCHING_TWO[a] = ARTIST_ck[0];
                        }
                        else if (ARTIST_ck[1] == 3) {
                            ARTIST_MATCHING_THREE[a] = ARTIST_ck[0];
                        }
                        else if (ARTIST_ck[1] == 4) {
                            ARTIST_MATCHING_FOUR[a] = ARTIST_ck[0];
                        }
                    }
                    ARTIST_MATCHING_ONE = ARTIST_MATCHING_ONE.filter(function (item) {
                        return item !== null && item !== undefined && item !== '';
                    });
    
                    ARTIST_MATCHING_TWO = ARTIST_MATCHING_TWO.filter(function (item) {
                        return item !== null && item !== undefined && item !== '';
                    });
    
                    ARTIST_MATCHING_THREE = ARTIST_MATCHING_THREE.filter(function (item) {
                        return item !== null && item !== undefined && item !== '';
                    });
    
                    ARTIST_MATCHING_FOUR = ARTIST_MATCHING_FOUR.filter(function (item) {
                        return item !== null && item !== undefined && item !== '';
                    });
                    console.log("아티스트 매칭상황 1 ->" + ARTIST_MATCHING_ONE);
                    console.log("아티스트 매칭상황 2 ->" + ARTIST_MATCHING_TWO);
                    console.log("아티스트 매칭상황 3 ->" + ARTIST_MATCHING_THREE);
                    console.log("아티스트 매칭상황 4 ->" + ARTIST_MATCHING_FOUR);
                    console.log(ARTIST_MATCHING_ONE.indexOf(user_ck));
                    console.log(" BUSKINGSTATUS?->" + BUSKINGSTATUS);
                    
                    if(BUSKINGSTATUS == '모집중'){
                        if(user_no == user_ck){
                            busking_onclick = '<div class="btcl_card_container" >';
                        }
                        else{

                            if (ARTIST_MATCHING_ONE.indexOf(user_ck) != -1) {
                                nowperform = "신청 완료";
                                color_ck = '<p class="nowperform_cancel">' + nowperform + '</p>';
                                busking_onclick = '<div class="btcl_card_container" onclick="artist_cancel_go()">';
                            }
                            else{
                                busking_onclick = '<div class="btcl_card_container" onclick="artist_select_go_2(\''+ PERFORM_NO +'\')">';
                            }
                        }
                        
                    }
                    else{
                        busking_onclick = '<div class="btcl_card_container" >';
                    }

                    var btcl_card_container =

                        busking_onclick +
                        '<div class="btcl_card_img_container">' +
                        '<div class="btcl_card_img_box">' +
                        '<img id="aimg' + PERFORM_NO + '" class="btcl_card_img">' +
                        '</div>' +
                        '</div>' +
                        '<div class="btcl_card">' +
                        '<div class="btcl_card_top_container">' +
                        '<div class="btcl_card_title">' +
                        '<p>' + BUSKINGSTATUS + '</p>' +
                        '</div>' +
                        // '<div class="btcl_card_confirm">' +
                        // '<p>' + matching_chk + '</p>' +
                        // '</div>' +
                        '</div>' +
                        // '<div class="btcl_card_time">' +
                        // '<p>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</p>' +
                        // '</div>' +
                        '<div class="btcl_card_contract">' +
                        color_ck +
                        '</div>' +
                        '</div>' +
                        '</div>';
                    // '<input type="hidden" id="btcl_perform_no" value="<%=' + PERFORM_NO + ' %>">';

                    $('.store_dtl_cal').append(btcl_card_container);
                    var inh = window.innerHeight;
                    console.log("높이는? - >" + inh)
                    $('#store_dtl_cal').css({"height":inh - 371});
                }).promise().done(function () {
                    $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                    // console.log($('.btcl_card_container').length);
                    sessionStorage.removeItem('busking_day');
                });
                if(DATA.length == 0){
                      var y = $("#store_y").text();
                      var m = $("#store_m").text();
                      var store_dtl_cal_no = '<div class="store_dtl_cal_no">'+ y +' ' + m +' 일정이 없습니다.</div>';

                      $('.store_dtl_cal').append(store_dtl_cal_no);
                }
            },//end success
            error: function (xhr, message, errorThrown) {
                //hideLoading();
                console.log(xhr);
                console.log(message);
                console.log(errorThrown);
            } // end error
        });
    }



}
$(document).on('click', '#buskingstatus_ck', function () {
    
 });
$(document).on('click', '#Go_st_trafBtn', function () {
    var perform_no = sessionStorage.getItem('sl_perform_no');
    store_info_pageNo = 4;
    var header_html = '<div class="ui-block-a" id="Go_st_introBtn">' +
        '<div class="haeder_menu_div_base">' +
        '<span>소개</span>' +
        '</div>' +
        '</div>' +
        '<div class="ui-block-b" id="Go_st_menuBtn">' +
        '<div class="haeder_menu_div_base">' +
        '<span>메뉴</span>' +
        '</div>' +
        '</div>' +
        '<div class="ui-block-c" id="Go_st_calBtn">' +
        '<div class="haeder_menu_div_base">' +
        '<span>일정</span>' +
        '</div>' +
        '</div>' +
        '<div class="ui-block-d-on" id="Go_st_trafBtn">' +
        '<div class="store_menu_div_on">' +
        '<span>교통</span>' +
        '</div>' +
        '</div>';
    $('#store_dtl_introduce').removeClass('store_dtl_introduce_m');
    $('#store_dtl_introduce').addClass('store_dtl_introduce');
    $('.header_menu_container').html(header_html);

    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/detail_store/detail_store.jsp',
        data: {
            perform_no: perform_no
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');
            console.log('success');
            $(DATA).each(function (i) {
                var ADDRESS = $(this).find('ADDRESS').text();
                var DETAIL_ADDR = $(this).find('DETAIL_ADDR').text();
                var BUSINESS_WORKNAME = $(this).find('BUSINESS_WORKNAME').text();
                $('.store_dtl_butten').hide()
                var content_html = '<div class="store_dtl_introduce_t">교통 안내</div><br>' +
                    '<div id="map"></div>' +
                    '<div class="store_dtl_introduce_c">' +
                    '</div>';
                $('.store_dtl_introduce').html(content_html);
                //detail_getKakaoMap('37.6547557', '127.0605938');
                var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                    mapOption = {
                        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                        level: 3 // 지도의 확대 레벨
                    };

                // 지도를 생성합니다    
                var map = new kakao.maps.Map(mapContainer, mapOption);

                // 주소-좌표 변환 객체를 생성합니다
                //var geocoder = new kakao.maps.services.Geocoder();

                // 주소로 좌표를 검색합니다
                // geocoder.addressSearch(ADDRESS, function(result, status) {

                // // 정상적으로 검색이 완료됐으면 
                // if (status === kakao.maps.services.Status.OK) {
                var latlng = $('#latlng').val();


                var coords = new kakao.maps.LatLng(latlng.split(',')[1], latlng.split(',')[0]);
                // $('#latlng').val(result[0].x + ',' + result[0].y);
                // // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                // // 인포윈도우로 장소에 대한 설명을 표시합니다
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;">' + BUSINESS_WORKNAME + '</div>'
                });
                infowindow.open(map, marker);

                // // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
                // } 
                // }); 
                // console.log("교통정보니?->" + kakao.maps.MapTypeId.TRAFFIC);
                var ps = new kakao.maps.services.Places();
                var bounds = map.getBounds(); 
                // 키워드로 장소를 검색합니다
                keyword_data = ADDRESS.split('(');
                console.log(bounds);
                //ps.categorySearch('SW8', placesSearchCB,{location:coords,radius:1000,sort:daum.maps.services.SortBy.DISTANCE});
                ps.keywordSearch('역 출구', placesSearchCB,{location:coords,radius:1000,sort:kakao.maps.services.SortBy.DISTANCE});
                var addr_html = '<div class="store_dtl_introduce_c_aa"><p class="store_dtl_introduce_c_a">주소</p><div class="store_dtl_introduce_c_bb" >' + ADDRESS + '</div></div>' +
                '<div class="store_dtl_introduce_c_a">장소</div><div class="store_dtl_introduce_c_b">' + DETAIL_ADDR + '</div>';
                $('.store_dtl_introduce_c').append(addr_html);
     
            })
        },
        error: function (xhr, message, errorThrown) {
            console.log("error");
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
            //alert(data);
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            // $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
            // sessionStorage.setItem('aname', $('#artist_name').val())
            // sessionStorage.setItem('acontent', $('#artist_intro').val());
            //setAimgCallback2(imgsrc);

            // go_team_create();
        }
    });
    // 페이지 처음 로드시 지도 뿌려줌  


});

function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        //displayPlaces(data);
        console.log(data);
        console.log(data[0]);
        var subway_name = data[0].place_name;
        var subway_distance = data[0].distance + 'm';
        // 페이지 번호를 표출합니다
        //displayPagination(pagination);
        var subway = '<div class="store_dtl_introduce_c_a">지하철</div><div class="store_dtl_introduce_c_b">' + subway_name + '(약 ' + subway_distance + ')' + '</div>'+
                     '<button class="detail_getdirection_btn" onclick="load_search_go()">길찾기</button>';
        
    }else{
        var subway = '<button class="detail_getdirection_btn" onclick="load_search_go()">길찾기</button>';
    }
    $('.store_dtl_introduce_c').append(subway); 
    // else if (status === kakao.maps.services.Status.ZERO_RESULT) {

    //     alert('검색 결과가 존재하지 않습니다.');
    //     return;

    // } 
    // else if (status === kakao.maps.services.Status.ERROR) {

    //     alert('검색 결과 중 오류가 발생했습니다.');
    //     return;

    // }
}
// function detail_getKakaoMap(x, y) {
//     $('#map').empty();

//     var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
//         mapOption = {
//             center: new kakao.maps.LatLng(x, y), // 지도의 중심좌표
//             level: 3 // 지도의 확대 레벨
//         };

//     // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
//     var map = new kakao.maps.Map(mapContainer, mapOption);

//     //지도를 클릭한 위치에 표출할 마커
//     var marker = new kakao.maps.Marker({
//         // 초기에는 지도 중심부에 마커 생성
//         position: map.getCenter()
//     });
//     marker.setMap(map);

//     // 지도 클릭 이벤트 
//     kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
//         mapClickEvent(mouseEvent, marker);
//     });
// }

// // 주소검색
// function detail_open_execDaumPostcode(ID) {
//     $("input, textarea").blur();
//     var element_layer = document.getElementById(ID);
//     console.log(element_layer);
//     var page = $('.ui-page').attr('id');
//     var basic_txt = "";
//     setTimeout(function () {
//         basic_txt = $('#address').val();
//         new daum.Postcode({
//             oncomplete: function (data) {
//                 var addr = data.address;
//                 var fullAddr = data.address;
//                 var extraAddr = '';
//                 if (data.addressType === 'R') {
//                     if (data.bname !== '') {
//                         extraAddr += data.bname;
//                     }
//                     if (data.buildingName !== '') {
//                         extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
//                     }
//                     fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
//                 }
//                 //data.zonecode

//                 $('#address').val(fullAddr);
//                 $('#postcode').val(data.zonecode);

//                 var nowpage = $('.ui-page').attr('id');
//                 if (nowpage == 'detail_store') {
//                     searchKakaoMap(addr);
//                 }

//                 element_layer.style.display = 'none';
//             },
//             width: '100%',
//             height: '100%',
//             maxSuggestItems: 5,
//         }).embed(element_layer, {
//             q: basic_txt
//         });

//         element_layer.style.display = 'block';
//         detail_initLayerPosition(ID);
//     }, 500);
// }

// // 주소검색 팝업 레이어
// function detail_initLayerPosition(ID) {
//     var element_layer = document.getElementById(ID);
//     var width = 300;
//     var height = 400;
//     var borderWidth = 5;
//     element_layer.style.width = width + 'px';
//     element_layer.style.height = height + 'px';
//     element_layer.style.border = borderWidth + 'px solid';
//     element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth) + 'px';
//     element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth) + 'px';
// }

// 길찾기
// $(document).on('click', '.detail_getdirection_btn', function () {

//     // var place = document.getElementById('#address');
//     // var latlng = document.getElementById('#latlng');

//     var place = $('.store_dtl_introduce_c_bb').text();
//     var latlng = $('#latlng').val();

//     console.log(place);
//     console.log(latlng);

//     var x = latlng.split(',')[1];
//     var y = latlng.split(',')[0];
//     load_search3(place, x, y);
// });
function load_search_go() {
    var place = $('#r_addr').val();
    var latlng = $('#latlng').val();

    console.log(place);
    console.log(latlng);

    var x = latlng.split(',')[1];
    var y = latlng.split(',')[0];
    load_search3(place, x, y);
}
// 길찾기 -> 카카오맵 이동
function load_search3(place, x, y) {
    console.log(place);
    //var url = 'http://map.daum.net/link/to/' + place + ',' + y +','+ x + '&new';
    //window.open = cordova.InAppBrowser.open;

    // url 생성을 위한 장소명 가공
    place = place.replace(/ /g, '');
    place = place.replace(',', '')
    var url = 'https://map.kakao.com/link/to/' + place + ',' + x + ',' + y;

    console.log(url);
    console.log(navigator.userAgent);
    console.log(navigator.userAgent.match(/iPhone|iPod|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i));
    //window.open(url, '_blank', 'location=yes,usewkwebview=yes');
    //var ref = cordova.InAppBrowser.open(encodeURI(url), '_blank', 'location=yes');
    // var ref = cordova.InAppBrowser.open(url, '_system', 'location=yes');
    // ref;

    // 웹 브라우저(크롬) 접속시
    if (navigator.userAgent.match(/iPhone|iPod|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null ||
        navigator.userAgent.match(/LG|SAMSUNG|Samsung/) != null) {
        window.open(url);
    } else {    // 앱(웹뷰)으로 접속시
        var ref = cordova.InAppBrowser.open(url, '_system', 'location=yes');
        ref;
    }
}


$(document).on('pageinit', '#detail_store', function () {
    var perform_no = sessionStorage.getItem('sl_perform_no');
    sessionStorage.setItem('btcl_perform_no', perform_no)
    console.log("세션스토리지 공연번호->" + perform_no);
    store_info_pageNo = 1;
    var header_html = '<div class="ui-block-a-on" id="Go_st_introBtn">' +
        '<div class="store_menu_div_on">' +
        '<span>소개</span>' +
        '</div>' +
        '</div>' +
        '<div class="ui-block-b" id="Go_st_menuBtn">' +
        '<div class="haeder_menu_div_base">' +
        '<span>메뉴</span>' +
        '</div>' +
        '</div>' +
        '<div class="ui-block-c" id="Go_st_calBtn">' +
        '<div class="haeder_menu_div_base">' +
        '<span>일정</span>' +
        '</div>' +
        '</div>' +
        '<div class="ui-block-d" id="Go_st_trafBtn">' +
        '<div class="haeder_menu_div_base">' +
        '<span>교통</span>' +
        '</div>' +
        '</div>';

    $('.header_menu_container').html(header_html);


    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/detail_store/detail_store.jsp',
        data: {
            perform_no: perform_no
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');
            console.log('success');
            $(DATA).each(function (i) {
                var USER_NO = $(this).find('USER_NO').text();
                var SPACE_PICTURE = $(this).find('SPACE_PICTURE').text();
                var STAGE_PICTURE = $(this).find('STAGE_PICTURE').text();
                var ADDRESS = $(this).find('ADDRESS').text();
                var DETAIL_ADDR = $(this).find('DETAIL_ADDR').text();
                var OPERATIONHOUR = $(this).find('OPERATIONHOUR').text();
                // var EQUIPMENT = $(this).find('EQUIPMENT').text();
                // var GENRE = $(this).find('GENRE').text();
                // var PARKING_CHK = $(this).find('PARKING_CHK').text();
                // var PERFORM_TIPBOX = $(this).find('PERFORM_TIPBOX').text();
                // var MOBILE_TIPBOX = $(this).find('MOBILE_TIPBOX').text();
                // var VIDEO_CHK = $(this).find('VIDEO_CHK').text();
                var MENU = $(this).find('MENU').text();
                var HASHTAG = $(this).find('HASHTAG').text();
                var ZONE_INFO = $(this).find('ZONE_INFO').text();
                // var LICENSE_PICTURE = $(this).find('LICENSE_PICTURE').text();
                var BUSINESS_WORKNAME = $(this).find('BUSINESS_WORKNAME').text();
                // var BUSINESS_PHONE = $(this).find('BUSINESS_PHONE').text();
                var ARTIST_MATCHING = $(this).find('ARTIST_MATCHING').text();
                var user_ck = $('#user_no').val();
                var BUSKINGSTATUS = $(this).find('BUSKINGSTATUS').text();
                imgwidth = window.innerWidth;
                // var new_img = 'upload/store/menu/menu' + USER_NO + "/" 
                var SPACE_PICTURE_split = SPACE_PICTURE.split(',');
                var STAGE_PICTURE_split = STAGE_PICTURE.split(',');
                var store_imgs = SPACE_PICTURE_split.length + STAGE_PICTURE_split.length
                

                if (SPACE_PICTURE != '') {
                    var sp_picture_array = SPACE_PICTURE.split(',');
                    var sp_img = '';
                    var sp_img_html = '';
                    var sp_img_selecter = '';


                    for (var i = 0; i < sp_picture_array.length; i++) {
                        var new_img = 'upload/store/space/space' + USER_NO + "/" + sp_picture_array[i];

                        var imgSrc = getImagePromise(new_img).then(value => {
                            sp_img_html = '<li>' +
                                '<div class="bdc_image_div">' +
                                '<img class="store_dtl_img" src="' + value + '" alt="Los Angeles" style="width:' + imgwidth + 'px; max-width: none; height: 295px;">' +
                                '</div>' +
                                '</li>';

                            $('#bdc_pfsc_ing_ul').append(sp_img_html);


                            const cnt = $('#bdc_img_selecter').find('li').length;

                            sp_img_selecter = '<li id="bdc_img_selecter_' + (cnt + 1) + '">' + (cnt + 1) + ' / ' + store_imgs + '</li>';
                            $('#bdc_img_selecter').append(sp_img_selecter);


                            var bdc_carousel;
                            bdc_carousel = $("#bdc_pfsc_ing_ul");
                            bdc_carousel.itemslide(
                                {
                                    left_sided: true,
                                    disable_clicktoslide: true
                                }
                            );

                            bdc_carousel.on('changePos', function (e) {
                                var ai = bdc_carousel.getActiveIndex() + 1;

                                $('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
                                $('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
                            });
                        });

                    }
                    var title_img = 'upload/store/space/space' + USER_NO + "/" + sp_picture_array[0];
                    var imgSrc = getImagePromise(title_img).then(value => {
                        sp_img = '<img id="store_title_img" src="' + value + '" alt="Los Angeles" style="width:52px; max-width: none; height:52px;">';
                        $('#store_dtl_title_img').append(sp_img);
                    });
                }
                if (STAGE_PICTURE != '') {
                    var st_pictur_array = STAGE_PICTURE.split(',');
                    var st_img = '';
                    var st_img_html = '';
                    var st_img_selecter = '';

                    for (var i = 0; i < st_pictur_array.length; i++) {
                        var new_img = 'upload/store/stage/stage' + USER_NO + "/" + st_pictur_array[i];

                        var imgSrc = getImagePromise(new_img).then(value => {
                            st_img_html = '<li>' +
                                '<div class="bdc_image_div">' +
                                '<img class="store_dtl_img" src="' + value + '" alt="Los Angeles" style="width:' + imgwidth + 'px; max-width: none; height: 295px;">' +
                                '</div>' +
                                '</li>';

                            $('#bdc_pfsc_ing_ul').append(st_img_html);

                            const cnt = $('#bdc_img_selecter').find('li').length;

                            st_img_selecter = '<li id="bdc_img_selecter_' + (cnt + 1) + '">' + (cnt + 1) + ' / ' + store_imgs + '</li>';
                            $('#bdc_img_selecter').append(st_img_selecter);
                            //$('#bdc_img_selecter_cunt').text('1 / '+(cnt+1));

                            var bdc_carousel;
                            bdc_carousel = $("#bdc_pfsc_ing_ul");
                            bdc_carousel.itemslide(
                                {
                                    left_sided: true,
                                    disable_clicktoslide: true
                                }
                            );

                            bdc_carousel.on('changePos', function (e) {
                                var ai = bdc_carousel.getActiveIndex() + 1;

                                $('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
                                $('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
                            });
                        });

                    }
                }
                $('.store_dtl_title_j_b').html(BUSINESS_WORKNAME);
                $('.store_dtl_introduce_c').html(ZONE_INFO);
                $('.store_dtl_introduce_addr_l').html(ADDRESS + DETAIL_ADDR);
                $('.store_dtl_introduce_time').html(OPERATIONHOUR);
                var user_ck = $('#user_no').val();
                if (USER_NO == user_ck) {
                    var store_butten_html = '';
                    store_butten_html = '<div class="store_dtl_butten_a" onclick="go_update_store()">공연 수정하기</div>' +
                        '<div class="store_dtl_butten_b" onclick="go_contract_list()">공연 신청자보기</div>';
                    $('.store_dtl_butten').append(store_butten_html);
                }
                var ARTIST_MATCHING_ck = ARTIST_MATCHING.split(',');
                var ARTIST_MATCHING_ONE = new Array();
                var ARTIST_MATCHING_TWO = new Array();
                var ARTIST_MATCHING_THREE = new Array();
                var ARTIST_MATCHING_FOUR = new Array();
                for (var a = 0; a < ARTIST_MATCHING_ck.length; a++) {
                    var ARTIST_ck = ARTIST_MATCHING_ck[a].split('/');
                    if (ARTIST_ck[1] == 1) {
                        ARTIST_MATCHING_ONE[a] = ARTIST_ck[0];
                    }
                    else if (ARTIST_ck[1] == 2) {
                        ARTIST_MATCHING_TWO[a] = ARTIST_ck[0];
                    }
                    else if (ARTIST_ck[1] == 3) {
                        ARTIST_MATCHING_THREE[a] = ARTIST_ck[0];
                    }
                    else if (ARTIST_ck[1] == 4) {
                        ARTIST_MATCHING_FOUR[a] = ARTIST_ck[0];
                    }
                }
                ARTIST_MATCHING_ONE = ARTIST_MATCHING_ONE.filter(function (item) {
                    return item !== null && item !== undefined && item !== '';
                });

                ARTIST_MATCHING_TWO = ARTIST_MATCHING_TWO.filter(function (item) {
                    return item !== null && item !== undefined && item !== '';
                });

                ARTIST_MATCHING_THREE = ARTIST_MATCHING_THREE.filter(function (item) {
                    return item !== null && item !== undefined && item !== '';
                });

                ARTIST_MATCHING_FOUR = ARTIST_MATCHING_FOUR.filter(function (item) {
                    return item !== null && item !== undefined && item !== '';
                });
                console.log("아티스트 매칭상황 1 ->" + ARTIST_MATCHING_ONE);
                console.log("아티스트 매칭상황 2 ->" + ARTIST_MATCHING_TWO);
                console.log("아티스트 매칭상황 3 ->" + ARTIST_MATCHING_THREE);
                console.log("아티스트 매칭상황 4 ->" + ARTIST_MATCHING_FOUR);
                console.log(ARTIST_MATCHING_ONE.indexOf(user_ck));
                console.log(" BUSKINGSTATUS?->" + BUSKINGSTATUS);
                
                if (USER_NO != user_ck && artist_chk() && BUSKINGSTATUS == '3') {
                    var store_butten_html = '';
                    if (ARTIST_MATCHING_ONE.indexOf(user_ck) != -1) {

                        store_butten_html = '<div class="store_dtl_butten_artist_m_one" onclick="artist_cancel_go()">신청 취소</div>'+
                                            '<div class="store_dtl_butten_artist_m_too" onclick="go_contract_list()">신청 내역 확인</div>';
                    }
                    else{
                        store_butten_html = '<div class="store_dtl_butten_artist" onclick="artist_select_go()">공연 신청</div>';
                    }

                    // if (ARTIST_MATCHING_TWO.indexOf(user_ck) != -1) {

                    // }
                    
                    // if (ARTIST_MATCHING_FOUR.indexOf(user_ck) != -1) {

                    // }
                    
                    
                }
                if (ARTIST_MATCHING_THREE.indexOf(user_ck) != -1 && BUSKINGSTATUS == '1') {
                    store_butten_html = '<div class="store_dtl_butten_artist_m_one_t" >취소 불가</div>'+
                    '<div class="store_dtl_butten_artist_m_too" onclick="go_contract_list()">신청 내역 확인</div>';
                }
                $('.store_dtl_butten').append(store_butten_html);
                //$('#bdc_img_selecter_cunt').text('1 / '+ $('#bdc_img_selecter').find('li').length);
                if (HASHTAG != '') {
                    var hashtag_array = HASHTAG.split(',');
                    var hashtag_html = '';
                    for (var i = 0; i < hashtag_array.length; i++) {
                        hashtag_html = '<div class="store_dtl_introduce_ht">' + hashtag_array[i] + '</div>'
                        $('.store_dtl_introduce_ht_list').append(hashtag_html);
                    }
                }

                // 주소-좌표 변환 객체를 생성합니다
                var geocoder = new kakao.maps.services.Geocoder();
                // 주소로 좌표를 검색합니다
                geocoder.addressSearch(ADDRESS, function (result, status) {

                    // 정상적으로 검색이 완료됐으면 
                    if (status === kakao.maps.services.Status.OK) {

                        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                        $('#latlng').val(result[0].x + ',' + result[0].y);
                    }
                });
                $('#r_addr').val(ADDRESS);
                $('#store_user_no').val(USER_NO);
                var inh = window.innerHeight;
                console.log("높이는? - >" + inh)
                $('#store_dtl').css({"height":inh - 132.5});
               
                // var busking_click_ck = sessionStorage.getItem('busking_click_ck');
                // console.log("디테일 버스킹에서 왔니? ->" + busking_click_ck);
                // if(busking_click_ck =='Y'){
                //     sessionStorage.removeItem('busking_click_ck');
                //     $("#Go_st_calBtn").trigger("click");
                // }
                // window.addEventListener('scroll', function () {
                //     const thispage = $('div[data-role=page]').attr('id');

                //     if (thispage === 'detail_store') {
                //         const scroll = $(window).scrollTop();
                //         if (scroll > 1) {
                           
                //         } else {
                         
                //         }
                //     }
                // });    
            }).promise().done(function () {

                var bdc_carousel;

                $(document).ready(function () {
                    bdc_carousel = $("#bdc_pfsc_ing_ul");
                    bdc_carousel.itemslide(
                        {
                            left_sided: true,
                            disable_clicktoslide: true
                        }
                    );

                    // $('#imge_li_bt_left').click(function(){
                    //     bdc_carousel.previousSlide();
                    // });
                    
                    // $('#imge_li_bt_right').click(function(){
                    //     bdc_carousel.nextSlide();
                    // });    
                    
                    bdc_carousel.on('changePos', function (e) {
                        var ai = bdc_carousel.getActiveIndex() + 1;

                        $('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
                        $('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
                        $('.bdc_img_active').show()

                    });
                    
                    
                });

                var bz_no = $('#bz_no').val();
                getBuskingzoneReply(bz_no);

               
            });
        },
        error: function (xhr, message, errorThrown) {
            console.log("error");
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
            //alert(data);
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            // $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
            // sessionStorage.setItem('aname', $('#artist_name').val())
            // sessionStorage.setItem('acontent', $('#artist_intro').val());
            //setAimgCallback2(imgsrc);

            // go_team_create();
           
        }
    });
});
//공연 수정하기
function go_update_store() {
    loadPage('reg_store/register_store_update.jsp');
}
// function artist_cal_cancel(){
//     let cancel_msg = confirm("이미 신청한 공연입니다 취소하시겠습니까?");
//     if(cancel_msg){
//         //artist_cancel_go();
//     }
//     else{
//         return;
//     }
// }
//공연 신청자 보기
// function go_busking_contract_list() {
//     loadPage('busking_time_contract/busking_time_contract_list.jsp');
// }
//버스킹공간정보
// function go_detail_store_busking() {
//     loadPage('detail_store/detail_store_busking.jsp');
// }
$(document).on('click', '.abs_card_confirm', function(){
    loadPage('detail_store/detail_store_busking.jsp');
});
$(document).on('click', '.abc_card_confirm', function(){
    loadPage('detail_store/detail_store_busking.jsp');
});
//아티스트 팀 체크
function team_chk() {
    var res = false;

    $.ajax({
        type: "GET",
        cache: false,
        async: false,
        url: '/service/common/artist_team_chk.jsp',
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            if (DATA.length === 0) {
                res = false;
                return false;
            }

            $(DATA).each(function () {
                var TEAM_NO = $(this).find('TEAM_NO').text();

                if (TEAM_NO === '') {
                    res = false;
                    return false;
                } else {
                    res = true;
                    return true;
                }
            });

        }
    });

    return res;
}

// $(window).on("scroll", function(){
//     var scrollValue = $(document).scrollTop(); 
//     console.log(scrollValue);
// });
// var ovf, slider;

// $(function(){
//     ovf = this.getElementById("store_dtl");
//     slider = this.getElementById("top_bdc_pfsc_ing_body");
//     winResize();
//     $(window).bind({resize: winResize});
// });

// function winResize(){   
//     ovf.style.top = slider.offsetHeight + "px";
// }


// function artist_select_go(){
//     $("html, body").css({ "overflow": "hidden", "height": "100%" });

//     // $('#artist_busking_popup').on('scroll touchmove mousewheel', function (e) {
//     //     e.preventDefault();
//     //     e.stopPropagation();
//     //     return false;
//     // });

//     $('#artist_busking_popup').load('/app_root/jsp/custom_select_box/artist_busking_select.jsp', function () {
//         $('#artist_busking_popup').show();

//         $('#header').hide();
//         $('#footer').hide();
//     });
// }


// //글 삭제버튼 클릭시
// $(document).on('click', '#bdc_del_btn', function(){
// 	var bz_no = $('#bz_no').val();

// 	var conf = confirm('버스킹존 게시글을 삭제하시겠습니까?');
// 	if(!conf){
// 		return;
// 	}

// 	$.ajax({
// 		type: "GET",//url: "JSON/test.json",
// 		cache: false,
// 		url: '/service/buskingzone/buskingzone_del.jsp',
// 		data : {
// 			bz_no : bz_no
// 		},
// 		contentType: "application/xml; charset=utf-8",
// 		dataType: "xml",
// 		async : false,
// 		timeout: 30000
// 	});

// 	history.go(-1);
// });

// //길찾기 버튼 클릭시
// $(document).on('click', '.bdc_getdirection_btn', function(){
// 	var place = $('#bz_place').val();
// 	var x = $('#bz_x').val();
// 	var y = $('#bz_y').val();
// 	load_search(place, x, y);
// });

// //댓글 등록 버튼 클릭시
// $(document).on('click', '#bdc_re_insertbtn', function(){
// 	var login_chk = userLogin_chk();
// 	if(login_chk == false){
// 		infoTxtBox('로그인 후 댓글입력이 가능합니다.');
// 		return;
// 	}

// 	var bz_no = $('#bz_no').val();
// 	var bz_reply_content = $('#bdc_reply_content').val();

// 	if(bz_reply_content == ''){
// 		alert('댓글을 입력해주세요.');
// 		$('#bdc_reply_content').focus();
// 		return;
// 	}

// 	$.ajax({
// 		type: "GET",//url: "JSON/test.json",
// 		cache: false,
// 		url: '/service/buskingzone/buskingzone_reply_insert.jsp',
// 		data : {
// 			bz_no : bz_no,
// 			bz_reply_content : bz_reply_content
// 		},
// 		contentType: "application/xml; charset=utf-8",
// 		dataType: "xml",
// 		async : false,
// 		timeout: 30000
// 	});

// 	$('#bdc_reply_content').val('');
// 	getBuskingzoneReply(bz_no);
// });

// //댓글 삭제버튼 클릭시
// $(document).on('click', '.bdc_re_del_btn', function(){
// 	var conf = confirm('댓글을 삭제하시겠습니까 ?');
// 	if(!conf){
// 		return;
// 	}

// 	var bz_reply_no = $(this).parents('.bdc_re_container').attr('id');

// 	$.ajax({
// 		type: "GET",//url: "JSON/test.json",
// 		cache: false,
// 		url: '/service/buskingzone/buskingzone_reply_del.jsp',
// 		data : {
// 			bz_reply_no : bz_reply_no
// 		},
// 		contentType: "application/xml; charset=utf-8",
// 		dataType: "xml",
// 		async : false,
// 		timeout: 30000
// 	});

// 	var bz_no = $('#bz_no').val();
// 	getBuskingzoneReply(bz_no);
// });

// //답글달기 버튼 클릭시
// $(document).on('click', '.bdc_re_info_rebtn', function(){
// 	var bz_reply_no = $(this).parents('.bdc_re_container').attr('id');
// 	$('.bdc_re_re_body_' + bz_reply_no).show();
// });

// //답글 부분 등록버튼 클릭시
// $(document).on('click', '#bdc_re_re_input_btn', function(){
// 	var login_chk = userLogin_chk();
// 	if(login_chk == false){
// 		infoTxtBox('로그인 후 댓글입력이 가능합니다.');
// 		return;
// 	}

// 	var bz_no = $('#bz_no').val();
// 	var parent = $(this).parents('.bdc_re_container').attr('id');
// 	var bz_rereply_content = $(this).parents('.bdc_re_container').find('.bdc_re_re_input').val();

// 	if(bz_rereply_content == ''){
// 		alert('답글을 입력해주세요.');
// 		$('#bdc_reply_content').focus();
// 		return;
// 	}

// 	$.ajax({
// 		type: "GET",//url: "JSON/test.json",
// 		cache: false,
// 		url: '/service/buskingzone/buskingzone_rereply_insert.jsp',
// 		data : {
// 			bz_no : bz_no,
// 			parent : parent,
// 			bz_rereply_content : bz_rereply_content
// 		},
// 		contentType: "application/xml; charset=utf-8",
// 		dataType: "xml",
// 		async : false,
// 		timeout: 30000
// 	});

// 	$(this).parents('.bdc_re_container').find('.bdc_re_re_input').val('');
// 	getBuskingzoneReply(bz_no);
// });

// //답글 닫기버튼 클릭시
// $(document).on('click', '#bdc_rere_closebtn', function(){
// 	$(this).parents('.bdc_re_re_body').hide();
// });

