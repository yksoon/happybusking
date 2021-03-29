$(document).on('pagebeforeshow', '#index', function () {
    //initFirebase();
    /*const target = document.getElementById('header_panel_btn');
    target.addEventListener('click', panelOpenHandler);*/
});


$(document).on('pageinit', '#index', function () {
    window.addEventListener('scroll', function () {
        const thispage = $('div[data-role=page]').attr('id');

        if (thispage === 'index') {
            let mypage = $('#ih-mypage').attr('src').split('/');
            mypage = mypage[mypage.length - 1].split('-')[0];

            const scroll = $(window).scrollTop();
            if (scroll > 1) {
                $('#index_header').css('background', '#ffffff');
                $('#ih-logo').attr('src', '/img/index/v2/logo-gray.svg');
                $('#hi-panel').attr('src', '/img/index/v2/menu-gray.svg');
                if (mypage === 'mypage1') {
                    $('#ih-mypage').attr('src', '/img/index/v2/mypage1-gray.svg');
                }
                else {
                    $('#ih-mypage').attr('src', '/img/index/v2/mypage2-gray.svg');
                }
            } else {
                $('#index_header').css('background', 'none');
                $('#ih-logo').attr('src', '/img/index/v2/logo-white.svg');
                $('#hi-panel').attr('src', '/img/index/v2/menu-white.svg');
                if (mypage === 'mypage1') {
                    $('#ih-mypage').attr('src', '/img/index/v2/mypage1-white.svg');
                }
                else {
                    $('#ih-mypage').attr('src', '/img/index/v2/mypage2-white.svg');
                }
            }
        }
    });
    indexNewBoardChk();
    endPerformChk();

    // 방문객수 카운트 하는 로직
    $(function () {
        $.getJSON("https://api.ipify.org?format=jsonp&callback=?",
            function (json) {
                // console.log("My public IP address is: ", json.ip);
                // console.log(typeof (json.ip));
                ip_address = json.ip

                // console.log(ip_address);
                if (ip_address === '1.212.49.178') {
                    console.log("무야호~")
                } else {
                    var ip_address_session_get = sessionStorage.getItem("ip_address");
                    if (ip_address_session_get != ip_address) {
                        var visitor_today_2 = visitor_today();
                        // console.log(visitor_today_2);

                        $.ajax({
                            type: "GET",
                            cache: false,
                            url: '/service/visitor_count/get_visitor_count.jsp',
                            data: {
                                visitor_date: visitor_today_2
                            },
                            contentType: "application/xml; charset=utf-8",
                            dataType: "xml",
                            timeout: 30000,
                            success: function (data) {
                                var ROOT = $(data).find('ROOT');
                                var DATA = $(ROOT).find('DATA');

                                if (DATA.length == 0) {
                                    new_visitor_count(visitor_today_2);
                                } else {
                                    $(DATA).each(function (i) {
                                        var VISITOR_DATE = $(this).find("VISITOR_DATE").text();
                                        var VISITOR_COUNT = $(this).find("VISITOR_COUNT").text();

                                        // console.log(VISITOR_DATE);
                                        // console.log(VISITOR_COUNT);

                                        VISITOR_COUNT = parseInt(VISITOR_COUNT) + 1;
                                        plus_visitor_count(visitor_today_2, VISITOR_COUNT);
                                    })
                                }

                            }
                        });
                        sessionStorage.setItem("ip_address", ip_address);
                    } else {
                        return false;
                    }

                }
            }
        );
    });
});
/////////////////////////////////////////////////////////// 방문객수 함수 /////////////////////////////
function visitor_today() {
    var date = new Date();
    var year = String(date.getFullYear());
    var month = String(date.getMonth() + 1);
    var day = String(date.getDate());

    if (month.length === 1) {
        month = "0" + month;
    }
    if (day.length === 1) {
        day = "0" + day;
    }
    var today = (year + "-" + month + "-" + day);
    // console.log(today);
    return today;
}

function new_visitor_count(visitor_today_2) {
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/visitor_count/set_visitor_count.jsp',
        data: {
            visitor_date: visitor_today_2,
            difference: "Y"
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {

        }
    });
}

function plus_visitor_count(visitor_today_2, visitor_count) {
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/visitor_count/set_visitor_count.jsp',
        data: {
            visitor_date: visitor_today_2,
            visitor_count: visitor_count,
            difference: "N"
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {

        }
    });
}
/////////////////////////////////////////////////////////////////////////////////////////

$(document).on('click', '#header_panel_btn, #iib_panel', function () {
    panelOpenHandler();
});

function panelOpenHandler() {
    var newFree = sessionStorage.getItem('newFree');
    var newTeamApply = sessionStorage.getItem('newTeamApply');
    var newTogether = sessionStorage.getItem('newTogether');
    var newNt = sessionStorage.getItem('newNt');
    var newPbi = sessionStorage.getItem('newPbi');
    var newBz = sessionStorage.getItem('newBz');
    var newRt = sessionStorage.getItem('newRt');


    if (newFree === 'Y') $('.free_new_image').show();
    else $('.free_new_image').hide();

    if (newTeamApply === 'Y') $('.teamapply_new_image').show();
    else $('.teamapply_new_image').hide();

    if (newTogether === 'Y') $('.together_new_image').show();
    else $('.together_new_image').hide();

    if (newNt === 'Y') $('#notice_new_image').show();
    else $('#notice_new_image').hide();

    if (newPbi === 'Y') $('#pbi_new_image').show();
    else $('#pbi_new_image').hide();

    if (newBz === 'Y') $('#bz_new_image').show();
    else $('#bz_new_image').hide();

    if (newRt === 'Y') $('#si_new_image').show();
    else $('#si_new_image').hide();
}

function indexNewBoardChk() {
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/common/new_board_chk.jsp',
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function () {
                var BOARD_CATEGORY = $(this).find('BOARD_CATEGORY').text();
                var NOTICE_CNT = $(this).find('NOTICE_CNT').text();
                var PBI_CNT = $(this).find('PBI_CNT').text();
                var BZ_CNT = $(this).find('BZ_CNT').text();
                var SI_CNT = $(this).find('SI_CNT').text();

                if (BOARD_CATEGORY === '1') {
                    $('#iib_new_board').show();
                    sessionStorage.setItem('newFree', 'Y');
                } else if (BOARD_CATEGORY === '2') {
                    $('#iib_new_board').show();
                    sessionStorage.setItem('newTeamApply', 'Y');
                } else if (BOARD_CATEGORY === '3') {
                    $('#iib_new_board').show();
                    sessionStorage.setItem('newTogether', 'Y');
                } else {
                    $('#iib_new_board').hide();
                    sessionStorage.setItem('newFree', 'N');
                    sessionStorage.setItem('newTeamApply', 'N');
                    sessionStorage.setItem('newTogether', 'N');
                }

                if (parseInt(NOTICE_CNT) > 0) {
                    sessionStorage.setItem('newNt', 'Y');
                } else {
                    sessionStorage.setItem('newNt', 'N');
                }

                if (parseInt(PBI_CNT) > 0) {
                    $('#iib_new_apply').show();
                    sessionStorage.setItem('newPbi', 'Y');
                } else {
                    $('#iib_new_apply').hide();
                    sessionStorage.setItem('newPbi', 'N');
                }

                if (parseInt(BZ_CNT) > 0) {
                    $('#iib_new_bz').show();
                    sessionStorage.setItem('newBz', 'Y');
                } else {
                    $('#iib_new_bz').hide();
                    sessionStorage.setItem('newBz', 'N');
                }

                if (parseInt(SI_CNT) > 0) {
                    $('#iib_new_rt').show();
                    sessionStorage.setItem('newRt', 'Y');
                } else {
                    $('#iib_new_rt').hide();
                    sessionStorage.setItem('newRt', 'N');
                }
            });
        },
        error: function (xhr) {
            console.log(xhr);
        }
    });
}



$(document).on('focus', '#text_genre', function () {
    $(this).blur();
});

$(document).on('blur', 'input, textarea, select', function () {
    var nowScroll = $(window).scrollTop();
    $(window).scrollTop(scroll);
});

$(document).on('pageshow', '#index', function () {
    $.mobile.loading('hide', {
        text: '로딩중...',
        textVisible: false,
        theme: 'z',
        html: ""
    });

    team_info_pageNo = 1;

    sessionStorage.setItem('bzlLimit', '0');
    sessionStorage.removeItem('prqstate');
    sessionStorage.removeItem('bocChk');

    ////////////////아티스트 관련 세션 삭제////////////////////
    sessionStorage.removeItem('a_ranking_count');
    sessionStorage.removeItem('aEndCount');
    sessionStorage.removeItem('arankScroll');
    sessionStorage.removeItem('arankArea');
    sessionStorage.removeItem('arankGenre');
    sessionStorage.removeItem('arankPageNum');
    //////////////////////////////////////////////////////

    ////////////////공연일정 관련 세션 삭제////////////////////
    sessionStorage.removeItem('pfIndex');
    sessionStorage.removeItem('pfSearch');
    sessionStorage.removeItem('pfSearchDate');
    sessionStorage.removeItem('pfSearchDateText');
    sessionStorage.removeItem('scLimit');
    sessionStorage.removeItem('pfSearchArea');
    sessionStorage.removeItem('pfSearchGenre');
    sessionStorage.removeItem('pfScroll');
    //////////////////////////////////////////////////////

    ////////////////공지사항 관련 세션 삭제////////////////////
    sessionStorage.removeItem('ntScroll');
    sessionStorage.removeItem('ntStart');
    sessionStorage.removeItem('ntLimit');
    ///////////////////////////////////////////////////////

    ////////////////공연요청 관련 세션 삭제////////////////////
    sessionStorage.removeItem('tname');
    sessionStorage.removeItem('tgenre');
    sessionStorage.removeItem('tarea');
    sessionStorage.removeItem('tsmoney');
    sessionStorage.removeItem('temoney');
    sessionStorage.removeItem('ttype');
    sessionStorage.removeItem('selectindex');
    sessionStorage.removeItem('prqScroll');
    sessionStorage.removeItem('textGenre');
    ///////////////////////////////////////////////////////

    ////////////////장르 셀렉트 관련 세션 삭제////////////////////
    sessionStorage.removeItem('selectGenre');
    sessionStorage.removeItem('selectGenreTemp');
    ///////////////////////////////////////////////////////

    ////////////////버스킹 행사 일정 관련 세션 삭제////////////////////
    sessionStorage.removeItem('pbiMenu');
    sessionStorage.removeItem('pbiSearchTitle');
    sessionStorage.removeItem('pbiSearchDate');
    sessionStorage.removeItem('pbiScroll');
    sessionStorage.removeItem('pbiLimit');
    ///////////////////////////////////////////////////////

    ////////////////모바일 팁박스 관련 세션 삭제////////////////////
    sessionStorage.removeItem('scPage');
    sessionStorage.removeItem('scName');
    sessionStorage.removeItem('scGenre');
    sessionStorage.removeItem('scArea');
    sessionStorage.removeItem('scLimit');
    sessionStorage.removeItem('scLimitEnd');
    sessionStorage.removeItem('scScroll');
    ///////////////////////////////////////////////////////

    ////////////////버스킹존 관련 세션 삭제////////////////////
    sessionStorage.removeItem('bzlLimit');
    sessionStorage.removeItem('bz_scroll');
    sessionStorage.removeItem('bzlArea');
    sessionStorage.removeItem('bzlKeyword');
    ///////////////////////////////////////////////////////

    ////////////////게시판 관련 세션 삭제////////////////////
    sessionStorage.removeItem('tbLimit');
    ///////////////////////////////////////////////////////


    ////////////////메트로 스캔 관련 세션 삭제////////////////////
    sessionStorage.removeItem('surveychk');
    ///////////////////////////////////////////////////////

    var url = window.location.href;
    var qs = url.split('?');
    var qsf = String(qs[1]).split('&');
    var qsfg = String(qsf[0]).split('=');
    var qsfc = String(qsf[1]).split('=');
    if (qsfg[1] == 'L') {
        toHome();
    } else if (qsfg[1] == 'J') {
        toHome();
        infoTxtBox('회원가입이 완료되었습니다');
    } else if (qsfg[1] == 'F') {
        toHome();
        infoTxtBox('로그인 실패하였습니다');
    }


    var memberSChk = sessionStorage.getItem('memberSChk');
    if (memberSChk == null || memberSChk == '') {
        var coachChk = $('#coachMarkPopup-screen').css('display');
        var popupChk = $('#indexEventPopup-screen').css('display');
        var popupChk2 = $('#indexEventPopup2-screen').css('display');

        if (coachChk == 'none' && popupChk == 'none' && popupChk2 == 'none') {
            $.ajax({
                type: "GET",
                cache: false,
                url: '/service/common/member_status_chk.jsp',
                contentType: "application/xml; charset=utf-8",
                dataType: "xml",
                timeout: 30000,
                success: function (data) {
                    var ROOT = $(data).find('ROOT');
                    var DATA = $(ROOT).find('DATA');

                    $(DATA).each(function () {
                        var RESULT = $(this).find('RESULT').text();
                        if (RESULT == 'FALSE') {
                            sessionStorage.setItem('memberSChk', 'yes');
                            var conf = confirm('멤버 수락 요청이 왔습니다.\n지금 수락하시겠습니까?');
                            if (!conf) {
                                return;
                            } else {
                                go_team_create_status();
                            }
                        }
                    });
                }
            });
        }
    }

    //FOOTER CSS///////////////////////////////////////////////////
    /*$('.footer_home_txt').css('color', '#8d5cb1');
    $('.footer_home_txt').css('font-weight', 'bold');
    $('.footer_home_img').attr('src', '/img/test/m_home2.svg');*/
    ///////////////////////////////////////////////////////////////
    var carousel;
    carousel = $("#index_pfsc_ing_ul");
    carousel.itemslide(
        {
            left_sided: true,
            disable_clicktoslide: true
        }
    );
    carousel.reload();
});

$(document).on('pagehide', '#index', function () {
    var chk_result = mobile_pc_chk();
    if (chk_result == true) {
        document.addEventListener('deviceready', onDeviceReady2, false);

        function onDeviceReady2() {
            if (device.platform.toLowerCase() == "android") {
                $('html').css('overflow', 'unset');
            }
        }
    }
    //FOOTER CSS
    /*$('.footer_home_img').attr('src', '/img/test/m_home.svg');*/
});

$(document).on('pageinit', '#index', function () {
    var appFristStart = getCookie('appFristStart');

    if (appFristStart == null || appFristStart == 'null' || appFristStart == '') {
        var popheight = $('body').css('height');
        $('#coachMarkPopup-popup').css('height', popheight);

        $("#coachMarkPopup").popup("option", "dismissible", false);
        $("#coachMarkPopup").popup("option", "overlayTheme", "b");
        $("#coachMarkPopup").popup("option", "positionTo", "window");
        $('#coachMarkPopup').popup('open');

        $('#coachMarkPopup-screen').css('height', '100%');
        $('html').css('overflow', 'hidden');
    } else {
        //앱을 처음 실행하는 경우가 아닐때 이벤트 팝업 열어주기
        //다시보지않기 체크 후 닫으면 그 후로 실행 안되어야함. cookie 활용
        $.ajax({
            type: "GET",
            cache: false,
            url: '/service/common/get_main_popup.jsp',
            contentType: "application/xml; charset=utf-8",
            dataType: "xml",
            timeout: 30000,
            success: function (data) {
                var ROOT = $(data).find('ROOT');
                var DATA = $(ROOT).find('DATA');

                $(DATA).each(function () {
                    var MP_STATE = $(this).find('MP_STATE').text();
                    var MP_URL = $(this).find('MP_URL').text();
                    var MP_COOKIE = $(this).find('MP_COOKIE').text();
                    var MP_WIDTH = $(this).find('MP_WIDTH').text();
                    var MP_HEIGHT = $(this).find('MP_HEIGHT').text();

                    if (MP_STATE == '0' || MP_STATE == 0) {
                        return;
                    }

                    var sessionChk = getCookie(MP_COOKIE);

                    if (sessionChk != 'Y') {
                        $('#iep_image').attr('src', MP_URL);

                        /*var popheight = $('body').css('height');
                        $('#coachMarkPopup-popup').css('height' , popheight);
                    	
                        $("#indexEventPopup").popup( "option" , "dismissible" , false);
                        $("#indexEventPopup" ).popup( "option", "overlayTheme", "a" );
                        $("#indexEventPopup" ).popup( "option", "positionTo", "window" );
                        $('#indexEventPopup').popup('open');
                    	
                    	
                        $('#indexEventPopup-popup').css({
                           "top": (($(window).height()-MP_HEIGHT)/2+$(window).scrollTop())+"px",
                            "left": (($(window).width()-MP_WIDTH)/2+$(window).scrollLeft())+"px"
                        });
                    	
                        $('#indexEventPopup-screen').css('height', '100%');*/
                        $('#indexEventPopup').show();

                        $('header').hide();
                        $('footer').hide();

                        $('html').css('overflow', 'hidden');
                    }
                });
            },
            error: function (xhr) {
                console.log(xhr);
            }
        });
    }

    sessionStorage.removeItem('spcys');	//후원완료 페이지 뒤로가기 관련 세션 삭제

    search_temp = '';
    seartch_date_temp = '';
    perform_sc_index = 1;
    sc_genre = '발라드';
    a_ranking_sc = '';
    a_ranking_sc_temp = '';

    // $.ajax({
    //     type: "GET",
    //     cache: false,
    //     url: '/service/common/get_main_popup.jsp',
    //     contentType: "application/xml; charset=utf-8",
    //     dataType: "xml",
    //     timeout: 30000,
    //     success: function (data) {
    //         var ROOT = $(data).find('ROOT');
    //         var DATA = $(ROOT).find('DATA');
    //         if(DATA.length === 0){
    //             var perform_schedule = 'NO';
    //         }
    //         else{
    //             var perform_schedule = 'YES';
    //         }
    //     },
    //     error: function (xhr) {
    //         console.log(xhr);
    //     }
    // });

    $.ajax({
        type: "GET",
        cache: false,
        async: false,
        url: '/service/performance_schedule/perform_schedule_index.jsp',
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {

            $('#index_pfsc_ing_ul').empty();

            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');
            $(DATA).each(function (i) {
                if (i < 5) {
                    var BUSINESS_WORKNAME = $(this).find('BUSINESS_WORKNAME').text();
                    var USER_NO = $(this).find('USER_NO').text();
                    var SPACE_PICTURE = $(this).find('SPACE_PICTURE').text();
                    var STARTINGTIME = $(this).find('STARTINGTIME').text();
                    var FINISHINGTIME = $(this).find('FINISHINGTIME').text();
                    var TEAM_NAME = $(this).find('TEAM_NAME').text();
                    var ADDRESS = $(this).find('ADDRESS').text();
                    var BUSKINGDATE = $(this).find('BUSKINGDATE').text();
                    var BUSKINGSTATUS = $(this).find('BUSKINGSTATUS').text();
                    var sp_picture_array = SPACE_PICTURE.split(',');
                    //var p_img = '/upload/team/team' + TEAM_NO + "/" + PF_IMG;
                    //var new_img = 'upload/images/team/team' + TEAM_NO + "/" + PF_IMG;
                    var new_img = 'upload/store/space/space' + USER_NO + "/" + sp_picture_array[0];
                    var imgSrc = getImagePromise(new_img).then(value => {
                        $('#mpimg' + i).attr('src', value);
                    });
                    // var result = getDday(PF_DATE);

                    // if (result == 0) {
                    //     result = 'D-day';
                    //     result = '<p class="icb-dday"><span>' + result + '</span></p>';
                    // } else if (result < 0) {
                    //     result = '';
                    // } else {
                    //     result = 'D-' + result;
                    //     result = '<p class="icb-dday"><span>' + result + '</span></p>';
                    // }
                    if (BUSKINGSTATUS == '3') {
                        BUSKINGSTATUS = '모집중';
                    }
                    else if (BUSKINGSTATUS == '2') {
                        BUSKINGSTATUS = '모집중';
                    }
                    else if (BUSKINGSTATUS == '4') {
                        BUSKINGSTATUS = '모집중';
                    }
                    else if (BUSKINGSTATUS == '1') {
                        BUSKINGSTATUS = '모집완료';
                    }
                    else if (BUSKINGSTATUS == '5') {
                        BUSKINGSTATUS = '공연완료';
                    }
                    else if (BUSKINGSTATUS == '모집마감') {
                    }

                    if (TEAM_NAME == '') {
                        if (BUSKINGSTATUS == '모집마감') {
                            TEAM_NAME = '모집마감';
                        }
                        else {
                            TEAM_NAME = '모집중';
                        }
                    }


                    var html = '<li class="icb-item" onclick="go_store_list()">' +
                        '<div class="icb-item-container">' +
                        '<div class="icb-status">' + BUSKINGSTATUS + '</div>' +
                        '<div class="icb-image_ov">' +
                        '<div class="icb-image">' +
                        '<img id="mpimg' + i + '"/>' +
                        //result +
                        '</div>' +
                        '</div>' +
                        '<div class="icb-sname">' + BUSINESS_WORKNAME + '</div>' +
                        '<div class="icb-date">' + BUSKINGDATE + '</div>' +
                        '<div class="icb-addr">' + ADDRESS + '</div>' +
                        '<div class="icb-time-s">' + STARTINGTIME + '</div>' +
                        '<div class="icb-tname">' + TEAM_NAME + '</div>' +
                        '<div class="icb-time-e">' + FINISHINGTIME + '</div>' +
                        '</div>' +
                        '</li>';

                    $('#index_pfsc_ing_ul').append(html);
                }
                else {

                }

            }).promise().done(function () {
                // var htmlTmp = '<li class="icb-item-last">' +
                //     '<div class="ui-grid-b index_pfsc_ing_content" id="index_pfsc_moreview_btn">' +
                //     '<div class="ui-block-a">' +
                //     '<img src="/img/index_main/more_view.jpg">' +
                //     '<pre>공연일정<br>더보기</pre>' +
                //     '</div>' +
                //     '<div class="ui-block-b"></div>' +
                //     '<div class="ui-block-c"></div>' +
                //     '</div>' +
                //     '</li>';
                // $('#index_pfsc_ing_ul').append(htmlTmp);

                var carousel;

                carousel = $("#index_pfsc_ing_ul");
                carousel.itemslide(
                    {
                        left_sided: true,
                        disable_clicktoslide: true
                    }
                );
                carousel.reload();
            });
        }
    });


    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/artist_ranking/artist_ranking_index.jsp',
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');
            if (DATA.length > 15) {
                var preview_count = 15;
            } else {
                var preview_count = DATA.length;
            }
            $('#index_chart_container').empty();
            $(DATA).each(function (i) {
                var TEAM_NO = $(this).find('TEAM_NO').text();
                var TEAM_NAME = $(this).find('TEAM_NAME').text();
                var CODE_GENRE = $(this).find('CODE_GENRE').text();
                var TINTRO_IMG = $(this).find('TINTRO_IMG').text();
                var BELONG = $(this).find('BELONG').text();
                var t_img = '/upload/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                if (preview_count >= 1) {
                    var index_chart_count = i + 1;
                    //'<div class="index_chart__raty" id="index_chart_t_raty_' + index_chart_count + '"></div>' 추후에 별점 추가할때 필요

                    var belong_content;

                    if (BELONG == '') {
                        belong_content = '<p class="ait_text ait_perform" id="index_chart_t_index_chart_' + index_chart_count + '"></p>';
                    } else {
                        belong_content = '<p class="ait_text ait_belong">' + BELONG + '</p>' +
                            '<p class="ait_middle">&nbsp;|&nbsp;</p>' +
                            '<p class="ait_text ait_perform" id="index_chart_t_index_chart_' + index_chart_count + '"></p>';
                    }


                    var index_chart_content = '<div class="index_chart_item" onclick="go_team_infoPage(\'' + TEAM_NO + '\');">' +
                        '<div class="ici-left">' +
                        '<p class="ici-rank">' + index_chart_count + '</p>' +
                        '<img class="ici-image" id="maimg' + i + '">' +
                        '<div class="ici-text-box">' +
                        '<p class="ici-tname">' + TEAM_NAME + '</p>' +
                        '<p class="ici-genre">' + CODE_GENRE + '</p>' +
                        '</div>' +
                        '</div>' +
                        '<div class="ici-right">' +
                        '<img class="ici-icon" src="/img/index/v2/more-menu-gray.svg"/>' +
                        '</div>' +
                        '</div>';

                    /* var index_chart_content = '<div class="artist_list_container">' +
                                                 '<div class="alc_ranknum">' + index_chart_count + '</div>' + 
                                                 '<div class="alc_thumbnail">' + 
                                                     '<img id="maimg'+i+'">' + 
                                                 '</div>' +
                                                 '<div class="alc_info_text">'+
                                                     '<p class="ait_teamname">' + TEAM_NAME + '</p>' +
                                                       belong_content +
                                                     '<p class="ait_text ait_genre">' + CODE_GENRE + '</p>' +
                                                 '</div>'+
                                                 '<div class="alc_icon">' + 
                                                     '<img src="/img/common/show_btn.svg">' +
                                                 '</div>'+
                                               '</div>';*/

                    $('#index_chart_container').append(index_chart_content);

                    /* if (PF_DATE != '') {
                         $('#index_chart_t_index_chart_' + index_chart_count).html(PF_DATE + ' 공연');
                     } else {
                         $('#index_chart_t_index_chart_' + index_chart_count).html('공연예정없음');
                     }*/

                    /*if (RATY_STAR > 0) {
                        $('#index_chart_t_raty_' + index_chart_count).raty({
                            readOnly: true,
                            score: RATY_STAR
                        });
                        $('#index_chart_t_raty_' + index_chart_count).append('<a>&#40;' + RATY_STAR + '&#41;</a>');
                    }*/
                }

                var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;

                var imgSrc = getImagePromise(new_img).then(value => {
                    $('#maimg' + i).attr('src', value);
                });
            });
        },
        error: function (xhr, message, errorThrown) {
            infoTxtBox(xhr);
            infoTxtBox(message);
            infoTxtBox(errorThrown);
        },
        complete: function () {
            $.ajax({
                type: "GET",
                cache: false,
                async: false,
                url: '/service/common/get_team_all_cnt.jsp',
                contentType: "application/xml; charset=utf-8",
                dataType: "xml",
                timeout: 30000,
                success: function (data) {
                    var ROOT = $(data).find('ROOT');
                    var DATA = $(ROOT).find('DATA');

                    $(DATA).each(function () {
                        var ALL_CNT = $(this).find('ALL_CNT').text();

                        var mainCont = '<div class="moreViewBtn" id="moreview_btn" onclick="go_artist_ranking();">' +
                            ALL_CNT + '팀&nbsp&nbsp더보기' +
                            '</div>';
                        $('#index_chart_container').append(mainCont);
                    });

                }
            });


        }
    });
});

$(document).on('swipeup', '#index', function () {
    $('.event_banner').fadeOut('fast');
});

$(document).on('swipedown', '#index', function () {
    $('.event_banner').fadeIn('fast');
});

//메인쪽 행사일정 더보기 버튼 클릭시
$(document).on('click', '#index_pfsc_moreview_btn', function () {
    /*goPublicBuskingInfoList();*/
    go_perform_schedule();
});

//앱 설명서 버튼클릭시//////////////////////////////////////////////////////////////////////////
//이전 버튼 클릭시
$(document).on('click', '#cmp_prev_btn', function () {
    var maxpage = 4;
    var nowpage = 0;
    var prevpage = 0;

    for (var i = 1; i <= maxpage; i++) {
        var nowpagename = 'cmp_page_' + i;
        var nowpageshowchk = $('#' + nowpagename).css('display');

        if (nowpageshowchk != 'none') {
            nowpage = i;
            prevpage = i - 1;
            break;
        }
    }

    if (prevpage == 1) {
        $('#cmp_prev_btn').hide();
    }

    if (nowpage <= maxpage) {
        $('#cmp_next_btn').show();
        $('#cmp_close_btn').hide();
    }

    $('#cmp_page_' + nowpage).hide();
    $('#cmp_page_' + prevpage).show();
});


//다음 버튼 클릭시
$(document).on('click', '#cmp_next_btn', function () {
    var maxpage = 4;		//전체 페이지수
    var nowpage = 0;
    var nextpage = 0;

    for (var i = 1; i <= maxpage; i++) {
        var nowpagename = 'cmp_page_' + i;
        var nowpageshowchk = $('#' + nowpagename).css('display');

        if (nowpageshowchk != 'none') {
            nowpage = i;
            nextpage = i + 1;
            break;
        }
    }

    if (nowpage == 0) {
        return;
    }

    if (nextpage == maxpage) {
        $('#cmp_next_btn').hide();
        $('#cmp_close_btn').show();
    }

    if (nextpage > 1) {
        $('#cmp_prev_btn').show();
    }

    $('#cmp_page_' + nowpage).hide();
    $('#cmp_page_' + nextpage).show();
});

//닫기버튼 클릭시
$(document).on('click', '#cmp_close_btn', function () {
    setCookie('appFristStart', 'zero', '365');
    $('html').css('overflow', 'scroll');
    $('#coachMarkPopup').popup('close');

    var popheight = $('body').css('height');
    $('#coachMarkPopup-popup').css('height', popheight);

    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/common/get_main_popup.jsp',
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function () {
                var MP_STATE = $(this).find('MP_STATE').text();
                var MP_URL = $(this).find('MP_URL').text();
                var MP_COOKIE = $(this).find('MP_COOKIE').text();
                var MP_WIDTH = $(this).find('MP_WIDTH').text();
                var MP_HEIGHT = $(this).find('MP_HEIGHT').text();

                if (MP_STATE == '0' || MP_STATE == 0) {
                    return;
                }

                var sessionChk = getCookie(MP_COOKIE);

                if (sessionChk != 'Y') {
                    $('#iep_image').attr('src', MP_URL);
                    $('footer').hide();
                    $('header').hide();

                    $('#indexEventPopup').show();
                    $('html').css('overflow', 'hidden');

                }
            });
        },
        error: function (xhr) {
            console.log(xhr);
        }
    });
});

//이벤트 팝업 바로가기 버튼 추가
$(document).on('click', '#iep_image', function () {
    $('html').css('overflow', 'scroll');
    $('footer').show();
    $('header').show();
    $('#indexEventPopup').hide();
    //goEventPage();

});
//이벤트 팝업 닫기버튼 클릭시
$(document).on('click', '#indexEventPopupClose', function () {
    if ($('#indexEventPopupChk').prop('checked')) {
        $.ajax({
            type: "GET",
            cache: false,
            url: '/service/common/get_main_popup.jsp',
            contentType: "application/xml; charset=utf-8",
            dataType: "xml",
            timeout: 30000,
            async: false,
            success: function (data) {
                var ROOT = $(data).find('ROOT');
                var DATA = $(ROOT).find('DATA');

                $(DATA).each(function () {
                    var MP_COOKIE = $(this).find('MP_COOKIE').text();

                    setCookie(MP_COOKIE, 'Y', 365);

                    $('html').css('overflow', 'scroll');
                    $('footer').show();
                    $('header').show();
                    $('#indexEventPopup').hide();
                });
            }
        });
    } else {
        $('html').css('overflow', 'scroll');
        $('header').show();
        $('footer').show();
        $('#indexEventPopup').hide();
    }
});

////////////////////////////////////////////////////////////////////////////////////////////

//장르별 클릭시 
$(document).on('click', '.index_pfsc_genre_content', function () {
    var select_genre = $(this).parents('li').find('p').text();
    perform_sc_index = 3;
    sc_genre = select_genre;
    go_perform_schedule();
});

function touch_slide2() {
    $("#touchFlow2").touchFlow({
        initComplete: function (e) {
            $("#throw_nav_debug").prepend('touchFlow init !!<br>');
        },
        stopped: function (e) {
            $("#throw_nav_debug").prepend('touchFlow stopped. posX : ' + e.posX + ' !!<br>');
        },
        resizeend: function (e) {
            $("#throw_nav_debug").prepend('Window resizeend. listW : ' + this.listw + ' !!<br>');
        }
    });
    $("#touchFlow2").touchFlow({
        axis: "x",
        page: $("#touchFlow2 li.on").index()
    });
}

function touch_slide3() {
    $("#touchFlow3").touchFlow({
        initComplete: function (e) {
            $("#throw_nav_debug").prepend('touchFlow init !!<br>');
        },
        stopped: function (e) {
            $("#throw_nav_debug").prepend('touchFlow stopped. posX : ' + e.posX + ' !!<br>');
        },
        resizeend: function (e) {
            $("#throw_nav_debug").prepend('Window resizeend. listW : ' + this.listw + ' !!<br>');
        }
    });
    $("#touchFlow3").touchFlow({
        axis: "x",
        page: $("#touchFlow3 li.on").index()
    });
}

function touch_slide4() {
    $("#touchFlow4").touchFlow({
        initComplete: function (e) {
            $("#throw_nav_debug").prepend('touchFlow init !!<br>');
        },
        stopped: function (e) {
            $("#throw_nav_debug").prepend('touchFlow stopped. posX : ' + e.posX + ' !!<br>');
        },
        resizeend: function (e) {
            $("#throw_nav_debug").prepend('Window resizeend. listW : ' + this.listw + ' !!<br>');
        }
    });
    $("#touchFlow4").touchFlow({
        axis: "x",
        page: $("#touchFlow4 li.on").index()
    });
}

function touch_slide5() {
    $("#touchFlow5").touchFlow({
        initComplete: function (e) {
            $("#throw_nav_debug").prepend('touchFlow init !!<br>');
        },
        stopped: function (e) {
            $("#throw_nav_debug").prepend('touchFlow stopped. posX : ' + e.posX + ' !!<br>');
        },
        resizeend: function (e) {
            $("#throw_nav_debug").prepend('Window resizeend. listW : ' + this.listw + ' !!<br>');
        }
    });
    $("#touchFlow5").touchFlow({
        axis: "x",
        page: $("#touchFlow5 li.on").index()
    });
}

function touch_slide6() {
    $("#touchFlow6").touchFlow({
        initComplete: function (e) {
            $("#throw_nav_debug").prepend('touchFlow init !!<br>');
        },
        stopped: function (e) {
            $("#throw_nav_debug").prepend('touchFlow stopped. posX : ' + e.posX + ' !!<br>');
        },
        resizeend: function (e) {
            $("#throw_nav_debug").prepend('Window resizeend. listW : ' + this.listw + ' !!<br>');
        }
    });
    $("#touchFlow6").touchFlow({
        axis: "x",
        page: $("#touchFlow6 li.on").index()
    });
}

//////////////////////////////////////////////////////////////////////////////////////////
//약관 자세히 보기 통합//
$(document).on('click', '#terms_of_service_view', function () {
    //이용약관 보기
    $('#terms_popup').load('/app_root/jsp/terms/terms_of_service.jsp', function () {
        $("#terms_popup").popup("option", "dismissible", false);
        $("#terms_popup").popup("option", "overlayTheme", "b");
        $("#terms_popup").popup("option", "positionTo", "window");
        $('#terms_popup').popup('open');
    });
});

$(document).on('click', '#personal_info_view', function () {
    //개인정보 처리 및 취급방침 보기
    $('#terms_popup').load('/app_root/jsp/terms/personal_info.jsp', function () {
        $("#terms_popup").popup("option", "dismissible", false);
        $("#terms_popup").popup("option", "overlayTheme", "b");
        $("#terms_popup").popup("option", "positionTo", "window");
        $('#terms_popup').popup('open');
    });
});

$(document).on('click', '#location_based_service_view', function () {
    //위치기반 서비스 이용약관 보기
    $('#terms_popup').load('/app_root/jsp/terms/location_based_service.jsp', function () {
        $("#terms_popup").popup("option", "dismissible", false);
        $("#terms_popup").popup("option", "overlayTheme", "b");
        $("#terms_popup").popup("option", "positionTo", "window");
        $('#terms_popup').popup('open');
    });
});

$(document).on('click', '#perform_request_service_view', function () {
    //공연의뢰 이용약관 보기
    $('#terms_popup').load('/app_root/jsp/terms/perform_request_service.jsp', function () {
        $("#terms_popup").popup("option", "dismissible", false);
        $("#terms_popup").popup("option", "overlayTheme", "b");
        $("#terms_popup").popup("option", "positionTo", "window");
        $('#terms_popup').popup('open');
    });
});

$(document).on('click', '#delivery_view', function () {
    //배송 정책 약관 보기
    $('#terms_popup').load('/app_root/jsp/terms/delivery_service.jsp', function () {
        $("#terms_popup").popup("option", "dismissible", false);
        $("#terms_popup").popup("option", "overlayTheme", "b");
        $("#terms_popup").popup("option", "positionTo", "window");
        $('#terms_popup').popup('open');
    });
});

$(document).on('click', '#qr_requset_service_view', function () {
    //QR 배너 신청 이용약관
    $('#terms_popup').load('/app_root/jsp/terms/qr_request_service.jsp', function () {
        $("#terms_popup").popup("option", "dismissible", false);
        $("#terms_popup").popup("option", "overlayTheme", "b");
        $("#terms_popup").popup("option", "positionTo", "window");
        $('#terms_popup').popup('open');
    });
});

$(document).on('click', '#consignment_view', function () {
    //개인정보의 제3자제공 및 위탁동의
    $('#terms_popup').load('/app_root/jsp/terms/consignment_service.jsp', function () {
        $("#terms_popup").popup("option", "dismissible", false);
        $("#terms_popup").popup("option", "overlayTheme", "b");
        $("#terms_popup").popup("option", "positionTo", "window");
        $('#terms_popup').popup('open');
    });
});

$(document).on('click', '#business_consignment_service_view', function () {
    //고용보험 사무 위탁동의
    $('#terms_popup').load('/app_root/jsp/terms/business_consignment_service.jsp', function () {
        $("#terms_popup").popup("option", "dismissible", false);
        $("#terms_popup").popup("option", "overlayTheme", "b");
        $("#terms_popup").popup("option", "positionTo", "window");
        $('#terms_popup').popup('open');
    });
});

$(document).on('click', '#terms_popup_close', function () {
    //닫기버튼 클릭시
    $('#terms_popup').popup('close');
});
//////////////////////////////////////////////////////////////////////////////////////////

//로그아웃 버튼 클릭시
$(document).on('touchstart', '#start_logout', function () {
    var logout_con = confirm("로그아웃 하시겠습니까?");
    if (logout_con == false) {
        return false;
    }
    user_logout('o');
});

//로그아웃 함수
function user_logout(type) {
    $.ajax({
        type: "GET",
        cache: false,
        url: "/app_root/jsp/logout/logout.jsp",
        data: {
            type: type
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find("ROOT");
            var DATA = $(ROOT).find('DATA');
            $(DATA).each(function (i) {
                var MESSAGE = $(this).find("MESSAGE").text();
                if (MESSAGE == '0') {
                    return;
                }
                location.href = '/app_root/index.jsp';
                $.mobile.changePage(location.href, { transition: 'none' });
            }).promise().done(function () {
                $.mobile.loading('hide', {
                    text: 'foo',
                    textVisible: false,
                    theme: 'z',
                    html: ""
                });
            });
        },
        error: function (xhr, message, errorThrown) { }
    });
}

//로그인 버튼 클릭시
$(document).on("click", "#start_login", function () {
    loadPage('login/login.jsp');
});

//나중에 로그인 클릭시
$(document).on('click', '#later_Loginbtn', function () {
    toHome();
});

//내 정보 클릭시 로그인 체크
function goMyInfo() {
    var login_chk = userLogin_chk();
    if (login_chk == true) {
        loadPage('user/myinfo.jsp');
    } else {
        /*infoTxtBox("로그인을 해주세요.");*/
        loadPage('login/login.jsp');
    }
};

//비밀번호 찾기 클릭시
$(document).on("touchstart", "#idpw_s_btn", function () {
    loadPage('user/idpwsearch.jsp');
});

//홈으로 이동
function toHome() {
    var url = '/app_root/index.jsp';
    location.href = url;

    $.mobile.loading('show', {
        text: '로딩중...',
        textVisible: false,
        theme: 'z',
        html: ""
    });
}

// 이메일 인증을 위한 랜덤 함수 생성
var generateRandom = function (min, max) {
    var ranNum = Math.floor(Math.random() * (max - min + 1)) + min;
    return ranNum;
}

//중복로그인 체크
function duplicate_loginChk() {
    var device_uuid;
    device_uuid = device.uuid;
    $.ajax({
        type: "GET",//url: "JSON/test.json",
        url: '/service/common/duplicate_loginChk.jsp',
        data: {
            uuid: device_uuid
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            DATA.each(function () {
                var RESULT = $(this).find('RESULT').text();

                if (RESULT == 0) {
                    user_logout('du');
                }
                else {
                    return;
                }
            });
        }
    });
}

//왼쪽 버튼 스와이프시
$(document).on('swiperight', '#side_panel_btn', function () {
    $('#header_panel_btn').click();
});
$(document).on('swipeleft', '#side_panel_btn', function () {
    $('#header_panel_btn').click();
});

//메인에 의뢰하기 버튼 클릭시
$(document).on('click', '#index_pfreq_gopfreqbtn', function () {
    go_pfr_search();
});

//메인에 의뢰하기쪽 하트버튼 클릭시
$(document).on('click', '#index_pfreq_goisbtn', function () {
    go_interest_team_list();
});

//사업자정보확인 버튼 클릭시
$(document).on('click', '#licensetitle', function () {
    var showchk = $('#licensebody').css('display');
    if (showchk == 'none') {
        $('#licensebody').slideDown('fast');
        $(this).find('img').attr('src', '/img/common/showing_btn.svg');
        $(this).find('img').css('top', '25px');
    } else {
        $('#licensebody').slideUp('fast');
        $(this).find('img').attr('src', '/img/common/showingup_btn.png');
        $(this).find('img').css('top', '28px');
    }
});

//개별 푸시 보내기
function sendSinglePushMessage() {
    fcm_token = prompt('메시지 보낼 FCM_TOKEN 입력', 'FCM_TOKEN');
    if (fcm_token == '' || fcm_token == null) {
        return;
    }

    $.ajax({
        type: "GET",//url: "JSON/test.json",
        url: '/service/pushService/dangerMessagePush.jsp',
        data: {
            fcm_token: fcm_token
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        complete: function () {
            alert('푸시 전송 완료');
        }
    });
}

//메트로 등록자 푸시
function sendMetroApplyPushMessage() {
    $.ajax({
        type: "GET",//url: "JSON/test.json",
        url: '/service/pushService/metroapplyPush.jsp',
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        complete: function () {
            alert('푸시 전송 완료');
        }
    });
}

//서비스 테스트
function serviceTestFunction() {
    $.ajax({
        type: "GET",//url: "JSON/test.json",
        url: '/service/common/service_test.jsp',
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        complete: function () {
            alert('테스트!');
        }
    });
}

//날짜 형식 변경
function dateToYYYYMMDD(date) {
    function pad(num) {
        num = num + '';
        return num.length < 2 ? '0' + num : num;
    }
    return date.getFullYear() + '-' + pad(date.getMonth() + 1) + '-' + pad(date.getDate());
}

//생년월일 형식 변경
function birthFormat(str) {
    if (str === null || str === '') return '';

    return str.toString().replace(/[^0-9]/g, '').replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
}

//디데이 계산
function getDday(edate) {

    var dday_array = edate.split('-');
    var now_date = new Date();
    var now_array = dateToYYYYMMDD(now_date).split('-');

    var now = new Date(now_array[0], (now_array[1] - 1), now_array[2]);
    var dday = new Date(dday_array[0], (dday_array[1] - 1), dday_array[2]);

    var gap = dday.getTime() - now.getTime();
    var result = Math.floor(gap / (1000 * 60 * 60 * 24));

    return result;
}

//숫자에 세자리마다 콤마(,) 표시
function addComma(str) {
    str = str.toString().replace(/[^0-9]/g, '');
    return str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//콤마제거 함수
function removeComma(str) {  // 콤마제거
    return str.toString().replace(/(,)/g, "");
}

//쿠키 생성
function setCookie(cookieName, value, days) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + days);	//설정 일수만큼 현재시간에 만료값으로 저장

    var cookie_value = escape(value) + ((days == null) ? '' : ';    expires=' + exdate.toUTCString());
    document.cookie = cookieName + '=' + cookie_value;
}

function getAimg() {
    $.ajax({
        type: "GET",//url: "JSON/test.json",
        url: '/service/common/get_aimg.jsp',
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        async: false,
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            if (DATA.length === 0) return;

            $(DATA).each(function () {
                var USER_NO = $(this).find('USER_NO').text();
                var ARTIST_IMG = $(this).find('ARTIST_IMG').text();

                setAimg(USER_NO, ARTIST_IMG);
            });
        }
    });
}

function setAimg(user_no, aimg) {
    var new_img = 'upload/images/artist/artist' + user_no + "/" + aimg;

    var imgSrc = getImagePromise(new_img).then(value => {
        setAimgCallback(value);
    });
}

function setAimgCallback(img) {
    console.log(img);
    $.ajax({
        type: "GET",//url: "JSON/test.json",
        url: '/service/common/set_aimg.jsp',
        async: false,
        data: {
            aimg: img
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        complete: function () {
            toHome();
        }
    });
}

function setAimgCallback2(img) {
    console.log(img);
    $.ajax({
        type: "GET",//url: "JSON/test.json",
        url: '/service/common/set_aimg.jsp',
        async: false,
        data: {
            aimg: img
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        complete: function () {
        }
    });
}

// 공연 종료 체크 - 3일후 자동 공연 종료
function endPerformChk() {
    $.ajax({
        type: "GET",//url: "JSON/test.json",
        url: '/service/busking_time/daily_buskingstatus_update.jsp',
        async: false,
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        complete: function () {
        }
    });
}
//메뉴얼 팝업
function manul_main_popup() {
    var imgwidth = window.innerWidth;
    for (var a = 1; a < 3; a++) {
        var html_manul = '<li>' +
            '<div class="manul_image_div">' +
            '<img id="zoom_picture_img" src="/img/index/manual/store_manual' + a + '.PNG" alt="Los Angeles" style="width:' + imgwidth + 'px; max-width: none; height:300px;">' +
            '</div>' +
            '</li>';

        $('#manual_pfsc_ing_ul').append(html_manul);
        // $('#manual_img_selecter').append('<li class="manual_img_active" id="manual_img_selecter_' + (a) + '">' + (a) + '</li>');

    }
    $.ajax().always(function () {

        var bdc_carousel;

        $(document).ready(function () {

            bdc_carousel = $("#manual_pfsc_ing_ul");
            bdc_carousel.itemslide(
                {
                    left_sided: true,
                    disable_clicktoslide: true
                }
            );

            bdc_carousel.on('changePos', function (_e) {
                var ai = bdc_carousel.getActiveIndex() + 1;
                // $('#manual_img_selecter').find('li').removeClass('manual_img_active');
                // $('#manual_img_selecter_' + ai).addClass('manual_img_active');

            });
        });

    });
    //documentScroll = '0px';

    //var popupPosition = $(this).attr('id');
    $("#manual_popup").show();
    //$('#team_img_popup').css('top', documentScroll);


};

$(document).on('click', '#manual_popup', function () {
    $('#manual_popup').hide();
});
