$(document).ready(function () {
    document.addEventListener("backbutton", onBackKeyDown, false);
});

$(document).on('mobileinit', function () {
    $.mobile.page.prototype.options.addBackBtn = true;
    $.mobile.page.prototype.options.domCache = true;
    var attachFastClick = Origami.fastclick;
    attachFastClick(document.body);
});
$(document).on('pagecreate', function () {
    $('.cycle-slideshow').cycle('stop');
    document.addEventListener("backbutton", onBackKeyDown, false);
});
$(document).on('ajaxComplete', function () { });
$(document).on("pagehide", "div[data-role=page]", function (event) {
    $(event.target).remove();
});
$(document).on('pageshow', function () {
    setTimeout(function () {
        SetHeightOfDiv();
    }, 100);
    $('html, body').scrollTop(0);
    document.addEventListener("backbutton", onBackKeyDown, false);
});


var lastScroll = 0;
$(document).on('scroll', function (e) {
    var activePage = $.mobile.pageContainer.pagecontainer("getActivePage"),

        /* window's scrollTop() */
        scrolled = $(window).scrollTop(),

        /* viewport */
        screenHeight = $.mobile.getScreenHeight(),

        /* content div height within active page */
        contentHeight = $(".ui-content", activePage).outerHeight(),

        /* header's height within active page (remove -1 for unfixed) */
        header = $(".ui-header", activePage).outerHeight() - 1,

        /* footer's height within active page (remove -1 for unfixed) */
        footer = $(".ui-footer", activePage).outerHeight() - 1,

        /* total height to scroll */
        scrollEnd = contentHeight - screenHeight + header + footer;

    var thisPage = $('.ui-page').attr('id');

    if (thisPage == 'artist_ranking') {
        if (scrolled <= lastScroll || lastScroll <= 0) $('#ar-container').slideDown('fast'); //$('#ar-container').show();
        else $('#ar-container').slideUp('fast'); //$('#ar-container').hide();
    } else if (thisPage == 'pbi_list') {
        if (scrolled <= lastScroll || lastScroll <= 0) $('#pbi_middle').slideDown('fast'); //$('#ar-container').show();
        else $('#pbi_middle').slideUp('fast'); //$('#ar-container').hide();
    } else if (thisPage == 'team_board') {
        if (scrolled <= lastScroll || lastScroll <= 0) $('#tb-box').slideDown('fast'); //$('#ar-container').show();
        else $('#tb-box').slideUp('fast'); //$('#ar-container').hide();
    } else if (thisPage == 'perform_sc') {
        if (scrolled <= lastScroll || lastScroll <= 0) $('#perform_sc_middle').slideDown('fast'); //$('#ar-container').show();
        else $('#perform_sc_middle').slideUp('fast'); //$('#ar-container').hide();
    }
    lastScroll = scrolled;
});


$(document).on('scrollstop', function (e) {
    var activePage = $.mobile.pageContainer.pagecontainer("getActivePage"),

        /* window's scrollTop() */
        scrolled = $(window).scrollTop(),

        /* viewport */
        screenHeight = $.mobile.getScreenHeight(),

        /* content div height within active page */
        contentHeight = $(".ui-content", activePage).outerHeight(),

        /* header's height within active page (remove -1 for unfixed) */
        header = $(".ui-header", activePage).outerHeight() - 1,

        /* footer's height within active page (remove -1 for unfixed) */
        footer = $(".ui-footer", activePage).outerHeight() - 1,

        /* total height to scroll */
        scrollEnd = contentHeight - screenHeight + header + footer;

    var thisPage = $('.ui-page').attr('id');

    if (scrolled >= scrollEnd) {
        if (thisPage == 'artist_ranking') {
            get_artist_reRanking();
        } else if (thisPage == 'perform_sc') {
            scheduleMoreView();
        } else if (thisPage == 'share_busking_list') {
            getMoreBuskingzoneList();
        } else if (thisPage == 'pbi_list') {
            const mchk = sessionStorage.getItem('pbiMenu');
            if (mchk === 'condition') {
                getMorePbiConditionList();
            } else {
                getMorePbiList();
            }
        } else if (thisPage == 'team_board') {
            more_team_baord_load();
        } else if (thisPage == 'tipbox_list_page') {
            getMoreTipboxList();
        } else if (thisPage == 'store_list') {
            getMore_store_list();
        }
    }
});

var backKeyPressedTime = 0;

function onBackKeyDown() {
    var genrePopupChk = $('#genre_select_popup').css('display');
    if (genrePopupChk == 'block') {
        $('#genre_select_back').click();
        return;
    }
    backKeyPressedTime = parseFloat(backKeyPressedTime);
    var main_url = "https://www.happybusking.com/app_root/";
    var main_index_url = "https://www.happybusking.com/app_root/index.jsp";
    var teamCreate_url = "https://www.happybusking.com/app_root/jsp/team/team_create.jsp";
    var artistBecome_url = "https://www.happybusking.com/app_root/jsp/artist_become/artist_become.jsp";
    var artistPerformRequestList_url = "http://www.happybusking.com/app_root/jsp/perform_request/artist_perform_requestList.jsp";
    var support_complete_url = "https://www.happybusking.com/app_root/jsp/support/support_complete.jsp";
    var support_list_url = "https://www.happybusking.com/app_root/jsp/support/support_list.jsp";
    var share_item_list_url = "https://www.happybusking.com/app_root/jsp/share_item/share_item_list.jsp";
    var buskingzone_list_url = "https://www.happybusking.com/app_root/jsp/buskingzone/buskingzone_list.jsp";
    var team_info_url = "https://www.happybusking.com/app_root/jsp/team/team_info.jsp";
    var qr_request_url = "https://www.happybusking.com/app_root/jsp/supply_item/qrcode_request_complete.jsp";
    var rating_list_url = "https://www.happybusking.com/app_root/jsp/rating_list/rating_list.jsp";
    var busking_oath_url = "https://www.happybusking.com/app_root/jsp/busking_oath/busking_oath.jsp";
    var team_board_url = "https://www.happybusking.com/app_root/jsp/team_board/team_board.jsp";
    var team_board_detail_url = "https://www.happybusking.com/app_root/jsp/team_board/team_board_view.jsp";
    var perform_request_url = "https://www.happybusking.com/app_root/jsp/perform_request/perform_request_search.jsp";
    var kiwoompay_complete_url = "https://www.happybusking.com/app_root/jsp/kiwoompay/kiwoompay_complete.jsp";
    var naver_check_terms_url = "https://www.happybusking.com/app_root/jsp/login/navercheckterms.jsp";
    var facebook_check_terms_url = "https://www.happybusking.com/app_root/jsp/login/checkterms.jsp";
    var pbi_condition_url = "https://www.happybusking.com/app_root/jsp/public_busking_info/pbi_condition.jsp";
    var currentPage_url = window.location.href;	//현재 페이지

    //alert(currentPage_url);

    if (currentPage_url == main_url || currentPage_url == main_index_url) {
        if (new Date().getTime() > backKeyPressedTime + 2000) {
            backKeyPressedTime = new Date().getTime();
            $.mobile.toast({
                message: '\"뒤로\" 버튼을 한번 더 누르시면 종료됩니다.'
            });
            return;
        }
        if (new Date().getTime() <= backKeyPressedTime + 2000) {
            navigator.app.exitApp();
        }
    } else if (currentPage_url == teamCreate_url || currentPage_url == support_complete_url || currentPage_url == qr_request_url || currentPage_url == perform_request_url || currentPage_url == kiwoompay_complete_url || currentPage_url == naver_check_terms_url || currentPage_url == facebook_check_terms_url) {
        toHome();
    } else if (currentPage_url == support_list_url) {
        support_list_back();
    } else if (currentPage_url == share_item_list_url) {
        siBackBtn();
    } else if (currentPage_url == buskingzone_list_url) {
        bzBackBtn();
    } else if (currentPage_url == team_info_url) {
        teamInfoBackBtn();
    } else if (currentPage_url == rating_list_url) {
        go_perform_reg_back();
    } else if (currentPage_url == busking_oath_url) {
        goBuskingOathBack();
    } else if (currentPage_url == team_board_url) {
        teamBoardBackBtn();
    } else if (currentPage_url == team_board_detail_url) {
        teamBoardDetailBackBtn();
    } else if (currentPage_url == artistBecome_url) {
        backArtistBecome();
    } else if (currentPage_url == pbi_condition_url) {
        var conf = confirm('설정을 그만두시겠습니까?');
        if (!conf) return;
        else navigator.app.backHistory();
    } else {
        navigator.app.backHistory();
    }
}
$(document).on('touchstart', 'img', function () {
    $(this).css({
        "opacity": "0.5"
    });
});
$(document).on('touchend', 'img', function () {
    $(this).css({
        "opacity": "1"
    });
});
$(document).on('touchstart', '[onclick]', function () {
    $(this).css({
        "opacity": "0.5"
    });
});
$(document).on('touchend', '[onclick]', function () {
    $(this).css({
        "opacity": "1"
    });
});
$(document).on('pagecreate', function () {
    $(".ui-input-text").removeClass("ui-shadow-inset");
    $(".ui-input-search").removeClass("ui-shadow-inset");
});
$(document).on('click', 'input', function () {
    $('.ui-header').css({
        'top': '0px',
        'border': '0px'
    });
});
$(document).on('click', 'select', function () {
    $('.ui-header').css({
        'top': '0px',
        'border': '0px'
    });
});
$(document).on('panelbeforeopen', '#panel', function () {
    $('.ui-panel-wrapper').css('position', 'fixed');
    $('.header_menu_container').css('top', '0px');
    $('#perform_sc_middle').css('top', '45px');
});
$(document).on('panelbeforeclose', '#panel', function () {
    $('.ui-panel-wrapper').css('position', 'relative');
    $('.header_menu_container').css('top', '45px');
    $('#perform_sc_middle').css('top', '86px');
});
$(document).on('click', '.ui-panel-page-content-open', function () {
    $("#panel").panel("close")
});

$(document).on('click', 'url', function () {
    const url = $(this).text();
    window.open = cordova.InAppBrowser.open;
    window.open(url, '_blank');
});


function SetHeightOfDiv() {
    var page = $('.ui-page').attr('id');
    if (page == "team_video_dialog") {
        return;
    } else {
        var screen = $.mobile.getScreenHeight();
        var header = $(".ui-header").hasClass("ui-header-fixed") ? $(".ui-header").outerHeight() - 1 : $(".ui-header").outerHeight();
        var footer = $(".ui-footer").hasClass("ui-footer-fixed") ? $(".ui-footer").outerHeight() - 1 : $(".ui-footer").outerHeight();
        var contentCurrent = $(".ui-content").outerHeight() - $(".ui-content").height();
        var content = screen - (header + footer + contentCurrent);
        $(".ui-content").height(content);
    }
}

function getUrlParams(url) {
    var params = {};
    url.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (str, key, value) {
        params[key] = value;
    });
    return params;
}

$(document).on('keyup', '#tm_member_phone', function (event) {
    if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
        var inputVal = $(this).val();
        $(this).val(inputVal.replace(/[^0-9]/gi, ''));
    }
});
$(document).on('keyup', '.onlyNumberStart', function (event) {
    if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
        var inputVal = $(this).val();
        $(this).val(inputVal.replace(/[^0-9]/gi, ''));
    }
});
$(document).on('keyup', '.onlyNumberPhone', function (event) {
    if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
        var inputVal = $(this).val();
        $(this).val(inputVal.replace(/[^0-9.-]/gi, ''));
    }
});


function pad(n, width) {
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

function getCookie(name) {
    name = new RegExp(name + '=([^;]*)');
    return name.test(document.cookie) ? unescape(RegExp.$1) : '';
}

function setCookie(name, value, exp) {
    var date = new Date();
    date.setTime(date.getTime() + exp * 24 * 60 * 60 * 1000);
    document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
}

function artist_chk() {
    var atc = getCookie('artist_chk');
    if (atc == 'Y') {
        return true;
    } else {
        return false;
    }
}

function owner_chk() {
    var atc = getCookie('owner_chk');
    if (atc == 'Y') {
        return true;
    } else {
        return false;
    }
}

// function store_chk() {
//     var atc = getCookie('store_chk');
//     if (atc == 'Y') {
//         return true;
//     } else {
//         return false;
//     }
// }

function userLogin_chk() {
    var ulc = getCookie('user_no');
    if (ulc == null || ulc == "null" || ulc == "") {
        return false;
    } else {
        return true;
    }
}
$(document).on('keydown', '#artist_phone', function () {
    var key = event.charCode || event.keyCode || 0;
    $text = $(this);
    if (key !== 8 && key !== 9) {
        if ($text.val().length === 3) {
            $text.val($text.val() + '-');
        }
        if ($text.val().length === 8) {
            $text.val($text.val() + '-');
        }
    }
    return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
});
$(document).on('keydown', '#business_phone', function () {
    var key = event.charCode || event.keyCode || 0;
    $text = $(this);
    if (key !== 8 && key !== 9) {
        if ($text.val().length === 3) {
            $text.val($text.val() + '-');
        }
        if ($text.val().length === 8) {
            $text.val($text.val() + '-');
        }
    }
    return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
});
$(document).on('keydown', '#business_no', function () {
    var key = event.charCode || event.keyCode || 0;
    $text = $(this);
    if (key !== 8 && key !== 9) {
        if ($text.val().length === 3) {
            $text.val($text.val() + '-');
        }
        if ($text.val().length === 6) {
            $text.val($text.val() + '-');
        }
    }
    return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
});
$(document).on('keydown', '.operationhour', function () {
    var key = event.charCode || event.keyCode || 0;
    $text = $(this);
    return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
});
$(document).on('keydown', '.operationhour_end', function () {
    var key = event.charCode || event.keyCode || 0;
    $text = $(this);
    return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
});
$(document).on('keyup', '#open_hour', function () {
    var hour = $(this).val();
    if (Number(hour) > 24) {
        alert('잘못된 시간 입니다.');
        $(this).val('')
    }
});
$(document).on('keyup', '#open_minute', function () {
    var hour = $(this).val();
    if (Number(hour) > 59) {
        alert('잘못된 분 입니다.');
        $(this).val('')
    }
});
$(document).on('keyup', '#close_hour', function () {
    var hour = $(this).val();
    if (Number(hour) > 24) {
        alert('잘못된 시간 입니다.');
        $(this).val('')
    }
});
$(document).on('keyup', '#close_minute', function () {
    var hour = $(this).val();
    if (Number(hour) > 59) {
        alert('잘못된 분 입니다.');
        $(this).val('')
    }
});
$(document).on('keydown', '.phoneAuto', function () {
    var key = event.charCode || event.keyCode || 0;
    $text = $(this);
    if (key !== 8 && key !== 9) {
        if ($text.val().length === 3) {
            $text.val($text.val() + '-');
        }
        if ($text.val().length === 8) {
            $text.val($text.val() + '-');
        }
    }
    return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
});
$(function () {
    $('#dialog').dialog({
        autoOpen: false,
        resizable: false,
        buttons: [{
            text: "예",
            click: function () {
                $(this).dialog("close");
            }
        }, {
            text: "아니오",
            click: function () {
                $(this).dialog("close");
                return;
            }
        }]
    });
});

function time_gap(startTime, endTime) {
    var startDate = new Date(parseInt(startTime.substring(0, 4), 10), parseInt(startTime.substring(4, 6), 10) - 1, parseInt(startTime.substring(6, 8), 10), parseInt(startTime.substring(8, 10), 10), parseInt(startTime.substring(10, 12), 10));
    var endDate = new Date(parseInt(endTime.substring(0, 4), 10), parseInt(endTime.substring(4, 6), 10) - 1, parseInt(endTime.substring(6, 8), 10), parseInt(endTime.substring(8, 10), 10), parseInt(endTime.substring(10, 12), 10));
    var dateGap = endDate.getTime() - startDate.getTime();
    var timeGap = new Date(0, 0, 0, 0, 0, 0, endDate - startDate);
    var diffDay = Math.floor(dateGap / (1000 * 60 * 60 * 24));
    var diffHour = timeGap.getHours();
    var diffMin = timeGap.getMinutes();
    var diffDay_sec = diffDay * 60 * 60 * 24;
    var diffHour_sec = diffHour * 60 * 60;
    var diffMin_sec = diffMin * 60;
    var diffAllsec = diffDay_sec + diffHour_sec + diffMin_sec;
    var hour = diffAllsec / 3600;
    var hour_lenght = hour.toString();
    hour_lenght = hour_lenght.length;
    if (hour_lenght > 4) {
        hour = hour.toFixed(2);
    }
    return hour;
}

function time_overlap(dateValue, inSdate, inEdate) {
    var result = false;
    var jbSplit = dateValue.split(' ');
    var daySplit = jbSplit[0].split('-');
    var day = daySplit[0] + daySplit[1] + daySplit[2];
    var timeSplit = jbSplit[1].split('~');
    var Stime = timeSplit[0].replace(/:/gi, "");
    var Etime = timeSplit[1].replace(/:/gi, "");
    var sDate = day + Stime;
    var eDate = day + Etime;
    var startDate = new Date(parseInt(sDate.substring(0, 4), 10), parseInt(sDate.substring(4, 6), 10) - 1, parseInt(sDate.substring(6, 8), 10), parseInt(sDate.substring(8, 10), 10), parseInt(sDate.substring(10, 12), 10));
    var endDate = new Date(parseInt(eDate.substring(0, 4), 10), parseInt(eDate.substring(4, 6), 10) - 1, parseInt(eDate.substring(6, 8), 10), parseInt(eDate.substring(8, 10), 10), parseInt(eDate.substring(10, 12), 10));
    var InstartDate = new Date(parseInt(inSdate.substring(0, 4), 10), parseInt(inSdate.substring(4, 6), 10) - 1, parseInt(inSdate.substring(6, 8), 10), parseInt(inSdate.substring(8, 10), 10), parseInt(inSdate.substring(10, 12), 10));
    var InendDate = new Date(parseInt(inEdate.substring(0, 4), 10), parseInt(inEdate.substring(4, 6), 10) - 1, parseInt(inEdate.substring(6, 8), 10), parseInt(inEdate.substring(8, 10), 10), parseInt(inEdate.substring(10, 12), 10));
    if ((InstartDate.getTime() < endDate.getTime()) && (InendDate.getTime() > startDate.getTime())) {
        result = true;
    }
    return result;
}

function numberWithCommas(x) {
    return x.toString().replace(/[^0-9]/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function removeComma(n) {
    if (typeof n == "undefined" || n == null || n == "") {
        return "";
    }
    var txtNumber = '' + n;
    return txtNumber.replace(/(,)/g, "");
}

function mobile_pc_chk() {
    var filter = "win16|win32|win64|macintel|mac|";
    var result = true;
    if (navigator.platform) {
        if (filter.indexOf(navigator.platform.toLowerCase()) < 0) {
            result = true;
        } else {
            result = false;
        }
    }
    return result;
}

function getDayOfTheWeek(date) {
    var week = new Array('일', '월', '화', '수', '목', '금', '토');
    var today = new Date(date).getDay();
    var todayLabel = week[today];
    return todayLabel;
}

//날짜 형식 변경
function dateFormatChange2(str) {
    if (!str) return '';
    let format = '';

    str = str.replace(/\s/gi, '');

    try {
        if (str.length == 8) {
            format = str.replace(/(\d{4})(\d{2})(\d{2})/, '$1년 $2월 $3일');
        }
    } catch (e) {
        console.log(e);
        format = str;
    }
    return format;
}

//날짜 형식 변경
function dateFormatChange(str) {
    if (!str) return '';
    let format = '';

    str = str.replace(/\s/gi, '');

    try {
        if (str.length == 8) {
            format = str.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3');
        }
    } catch (e) {
        console.log(e);
        format = str;
    }
    return format;
}

//디데이 구하기
function ddayExon(s) {
    let sdate = dateFormatChange(s);
    sdate = sdate.split('.');

    let month = parseInt(sdate[1]) - 1;

    let dday = new Date(sdate[0], month, sdate[2]);
    let now = new Date();

    let gap = now.getTime() - dday.getTime();
    let result = Math.floor(gap / (1000 * 60 * 60 * 24)) * -1;

    return result;
}

//오전 오후 구분
function divistionMorningAfternoon(t) {
    let time = parseInt(t.split(':')[0]);

    if (time > 12) {
        time -= 12;
        return '오후 ' + setPad(String(time), 2) + ':' + t.split(':')[1];
    } else {
        return '오전 ' + t;
    }
}


//페이지 이동 통합
function loadPage(str) {
    var url = '/app_root/jsp/' + str;
    $.mobile.loading('hide', { text: 'loading', textVisible: false, theme: 'z', html: "" });
    $.mobile.changePage(url, { transition: 'none' });
}


//길찾기
function load_search(place, x, y) {
    //var url = 'http://map.daum.net/link/to/' + place + ',' + y +','+ x + '&new';
    //window.open = cordova.InAppBrowser.open;
    place = place.replace(/ /g, '');
    var url = 'https://map.kakao.com/link/to/' + place + ',' + y + ',' + x;
    //window.open(url, '_blank', 'location=yes,usewkwebview=yes');
    //var ref = cordova.InAppBrowser.open(encodeURI(url), '_blank', 'location=yes');
    var ref = cordova.InAppBrowser.open(url, '_system', 'location=yes,usewkwebview=yes');
    ref;
}


//DB INSERT를 위해 특수문자 치환
function changeQuotes(str) {
    str = str.replace(/;/gi, "");
    str = str.replace(/&/gi, "&amp;");
    str = str.replace(/\'/gi, "&apos;");
    str = str.replace(/\"/gi, "&quot;");
    str = str.replace(/</gi, "&lt;");
    str = str.replace(/>/gi, "&gt;");
    return str;
}

//DB SELECT시 줄바꿈
function changeLineBreak(str) {
    str = str.replace(/(?:\r\n|\r|\n)/g, '<br/>');
    return str;
}

//공백 제거(체크용)
function blankChk(str) {
    if (str == null || str === '') return '';

    str = str.replace(/ /gi, '');
    return str;
}


//자릿수 채우기
function setPad(n, width) {
    //n : 숫자, width : 글자수
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

//특정 날짜 요일구하기
function getDayOfTheWeek(str) {
    var week = ['일', '월', '화', '수', '목', '금', '토'];
    var dayOfWeek = week[new Date(str).getDay()];
    return dayOfWeek;
}

//메트로 아티스트 체크
function metroArtistChk() {
    var res = false;

    $.ajax({
        type: "GET",
        cache: false,
        async: false,
        url: '/service/common/metro_artist_chk.jsp',
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
                var BELONG = $(this).find('BELONG').text();

                if (BELONG === '') {
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

function showLoading(sh, str) {
    $.mobile.loading(sh, { text: str, textVisible: true, theme: 'b', html: "" });
}

function createRandomNum() {
    const date = new Date();
    const y = String(date.getFullYear()).slice(2, 4);
    const m = pad(date.getMonth() + 1, 2);
    const d = pad(date.getDate(), 2);
    const h = pad(date.getHours(), 2);
    const mi = pad(date.getMinutes(), 2);
    const s = pad(date.getSeconds(), 2);

    const r = String(Math.floor(Math.random() * 9998) + 1);

    const res = y + m + d + h + mi + s + r;

    return res;
}

function changeFileName(str) {
    let arr1 = str.split('.');
    let exe = arr1[arr1.length - 1];

    const fname = arr1[0] + '_400x400.' + exe;
    return fname;
}

function goRegRecruit() {
    //window.open = cordova.InAppBrowser.open;
    var url = 'https://happybusking.com/recruit?plocation=app';
    window.open(url, '_system', 'location=yes');

    /*console.log('1');
    var url = 'https://happybusking.com/recruit?plocation=app';
    console.log(url);
    $('#recruit-popup').load(url);*/
}


//이미지 리사이징
var cropper;

const readURL = (input, w, h) => {
    cropper = '';
    $('#resize-image-container').show();
    showImageLoading('사진을 불러오는중입니다.<br>잠시만 기다려주세요.<br>파일의 크기가 크면 오래 걸릴 수 있습니다.');
    if (input.files && input.files[0]) {
        let reader = new FileReader();

        reader.onload = function (e) {
            $('#ric-img').attr('src', e.target.result);

            const image = document.getElementById('ric-img');

            if (cropper === undefined || cropper === 'undefined' || cropper === '') {
                cropper = new Cropper(image, {
                    autoCrop: true,  //true 로 설정
                    aspectRatio: w / h,
                    ready() {
                        $('#loading-container').hide();
                    },
                    crop(event) {
                        /*console.log(event.detail.x);
                        console.log(event.detail.y);
                        console.log(event.detail.width);
                        console.log(event.detail.height);
                        console.log(event.detail.rotate);
                        console.log(event.detail.scaleX);
                        console.log(event.detail.scaleY);*/
                    },
                });
            }
            cropper.replace(e.target.result);

        }
        reader.readAsDataURL(input.files[0]);
    }
}

const resizeSave = (path) => {
    // Upload cropped image to server if the browser supports `HTMLCanvasElement.toBlob`.
    // The default value for the second parameter of `toBlob` is 'image/png', change it if necessary.
    showImageLoading('사진을 저장중입니다.<br>잠시만 기다려주세요.');
    cropper.getCroppedCanvas().toBlob((blob) => {
        const filename = createRandomNum() + '.jpeg';

        // Pass the image file name as the third parameter if necessary.
        uploadResizeFile(blob, path, filename, function (f) {

            var new_img = '/upload/' + path + '/' + f;

            // test로 쓰고 지울 예정
            console.log(path);
            console.log(filename);
            console.log(new_img);

            var imgSrc = getImagePromise(new_img).then(value => {
                $('#img_preview').attr('src', value);
                $('#img_name').val(filename);
                $('#resize-image-container').hide();
                cropper = '';
            });
        });


        //$('#uploading').show();
        // Use `jQuery.ajax` method for example
        /*$.ajax('./image_save.jsp', {
          method: 'POST',
          data: formData,
          processData: false,
          contentType: false,
          success: function() {
          },
          error: function() {
              console.log('Upload error');
          },
          complete: function(){
              setTimeout(function(){
                  $('#uploading').hide();
                  $('#result').attr('src', '/upload/'+filename);
              }, 3000);
          }
        });*/
    }, 'image/jpeg');
}
const store_resizeSave = (path) => {
    // Upload cropped image to server if the browser supports `HTMLCanvasElement.toBlob`.
    // The default value for the second parameter of `toBlob` is 'image/png', change it if necessary.
    showImageLoading('사진을 저장중입니다.<br>잠시만 기다려주세요.');
    cropper.getCroppedCanvas().toBlob((blob) => {
        const filename = createRandomNum() + '.jpeg';

        // Pass the image file name as the third parameter if necessary.
        uploadResizeFile(blob, path, filename, function (f) {

            var new_img = '/upload/' + path + '/' + f;

            // test로 쓰고 지울 예정
            console.log(path);
            console.log(filename);
            console.log(new_img);

            var imgSrc = getImagePromise(new_img).then(value => {
                if (f_url_ck == 'sp') {

                    $('#bi-main_sp' + sp_num).attr('src', value);
                    $('#fname_sp' + sp_num).val(filename);
                    if (sp_num == '1') {
                        $('#bi-main_sp' + sp_num).css("visibility", "visible");
                    }
                    else {
                        $('#bi-main_sp' + sp_num).show();
                    }
                    $('div[name=sp_' + sp_num + ']').show();
                }
                else if (f_url_ck == 'st') {

                    $('#bi-main_st' + st_num).attr('src', value);
                    $('#fname_st' + st_num).val(filename);
                    if (st_num == '1') {
                        $('#bi-main_st' + st_num).css("visibility", "visible");
                    }
                    else {
                        $('#bi-main_st' + st_num).show();
                    }
                    $('div[name=st_' + st_num + ']').show();
                }
                else if (f_url_ck == 'me') {

                    $('#bi-main_me' + me_num).attr('src', value);
                    $('#fname_me' + me_num).val(filename);
                    if (me_num == '1') {
                        $('#bi-main_me' + me_num).css("visibility", "visible");
                    }
                    else {
                        $('#bi-main_me' + me_num).show();
                    }
                    $('div[name=me_' + me_num + ']').show();
                }
                $('#resize-image-container').hide();
                cropper = '';
            });
        });


        //$('#uploading').show();
        // Use `jQuery.ajax` method for example
        /*$.ajax('./image_save.jsp', {
          method: 'POST',
          data: formData,
          processData: false,
          contentType: false,
          success: function() {
          },
          error: function() {
              console.log('Upload error');
          },
          complete: function(){
              setTimeout(function(){
                  $('#uploading').hide();
                  $('#result').attr('src', '/upload/'+filename);
              }, 3000);
          }
        });*/
    }, 'image/jpeg');
}

const showImageLoading = (msg) => {
    $('#loading-message').html(msg);
    $('#loading-container').show();
}

$(document).on('click', '#ric-cancel', function () {
    const nowpage = $('div[data-role=page]').attr('id');
    if (nowpage === 'busking_store_reg' || nowpage === 'busking_store_update' || nowpage === 'main_store_update') {
        if (f_url_ck == 'sp') {
            f_sp_cont = f_sp_cont - 1;
            $('#upload_img_amount_sp').text(f_sp_cont);
        }
        if (f_url_ck == 'st') {
            f_st_cont = f_st_cont - 1;
            $('#upload_img_amount_st').text(f_st_cont);
        }
        if (f_url_ck == 'me') {
            f_me_cont = f_me_cont - 1;
            $('#upload_img_amount_me').text(f_me_cont);
        }
    }
    $('#resize-image-container').hide();
    cropper = '';
})

// $(document).on('click', '#ric-save', function () {
//     const nowpage = $('div[data-role=page]').attr('id');

//     let no = '';
//     let path = '';

//     if (nowpage === 'artist_become' || nowpage === 'artist_update') {
//         no = $('#user_no').val();
//         path = 'images/artist/artist' + no;
//     } else if (nowpage === 'team_create' || nowpage === 'team_create_update') {
//         no = $('#team_no').val();
//         path = 'images/team/team' + no;
//     } else if (nowpage === 'perform_reg') { 
//         no = $('#pr_team').val();
//         path = 'images/team/team' + no;
//     } else {
//         alert('잘못된 접근입니다.\n다시 시도해주세요.');
//         return;
//     }


//     resizeSave(path);
// });

// firebase 경로 검사
$(document).on('click', '#ric-save', function () {
    const nowpage = $('div[data-role=page]').attr('id');
    let no = '';
    let path = '';

    if (nowpage === 'artist_become' || nowpage === 'artist_update') {
        no = $('#user_no').val();
        path = 'images/artist/artist' + no;
        resizeSave(path);
    } else if (nowpage === 'team_create' || nowpage === 'team_create_update') {
        no = $('#team_no').val();
        path = 'images/team/team' + no;
        resizeSave(path);
    } else if (nowpage === 'perform_reg') {
        no = $('#pr_team').val();
        path = 'images/team/team' + no;
        resizeSave(path);
    }
    else if (nowpage === 'test_artist_become') {  // 테스트중입니다
        path = 'test';
        resizeSave(path);
    }
    else if (nowpage === 'busking_store_reg' || nowpage === 'busking_store_update' || nowpage === 'main_store_update') {  // 테스트중입니다
        no = $('#user_no').val();
        if (f_url_ck == 'sp') {
            path = 'store/space/space' + no;
        }
        else if (f_url_ck == 'st') {
            path = 'store/stage/stage' + no;
        }
        else if (f_url_ck == 'me') {
            path = 'store/menu/menu' + no;
        }
        store_resizeSave(path);
    }
    else {

        alert('잘못된 접근입니다.\n다시 시도해주세요.');
        return;
    }

    // const nowpage2= $('div[data-role=page]').attr('class');

    // if(nowpage2 === 'uploading_become'){
    //     path = "test";
    // }


});


