var a_ranking_menu = '';
var a_ranking_middle = '';
var a_ranking_content_2 = '';
var a_ranking_slidebar = '';

var a_ranking_sc_temp = '';

// 세션 초기화
$(document).ready(function () {
    sessionStorage.removeItem('member_count');
});
// 팝업창 닫을시 세션 초기화
$(document).on('click', '#btet_back', function () {
    sessionStorage.removeItem('selected_team_no');
    sessionStorage.removeItem('selecte_team_name');

    $("html, body").css({ "overflow": "auto", "height": "auto" });
    $('#busking_time_each_popup').unbind('touchmove');

    $('#busking_time_each_popup').hide();

    $('#header').show();
    $('#footer').show();
});

//검색 부분 X표시 눌렀을 때 텍스트 초기화 및 버튼 없애기
$(document).on('click', '#btet_cancle', function () {
    sessionStorage.removeItem('a_ranking_count');
    sessionStorage.removeItem('aEndCount');
    sessionStorage.removeItem('arankScroll');

    $('#btet_search_date').val('');
    $('#btet_search_date').focus();
    a_ranking_sc_temp = '';

    var arankPageNum = sessionStorage.getItem('arankPageNum');
    if (arankPageNum == null || arankPageNum == '1') {
        $('#Go_AllRanking').trigger('click');
    } else if (arankPageNum == '2') {
        $('#Go_AreaRanking').trigger('click');
    } else {
        $('#Go_GenreRanking').trigger('click');
    }
});

$(document).on('keyup', '#btet_search_date', function (e) {

    // var user_no = $('#user_no').val();

    if (e.keyCode == 13) {
        var team_search = $(this).val();
        if (team_search == null || team_search == '') {
            alert("검색어를 입력해주세요");
            return false;
        }
        //검색 후 ENTER 누를시
        a_ranking_sc_temp = team_search;
        $('#btet_search_date').blur();
        sessionStorage.removeItem('a_ranking_count');
        sessionStorage.removeItem('arankScroll');
        sessionStorage.removeItem('aEndCount');
        // console.log(a_ranking_sc_temp);
        get_artist_ranking_2();
    }
});




// 공연팀 선택 팝업 확인 클릭
$(document).on('click', '#btet_footer', function () {
    var selected_team_no = sessionStorage.getItem('selected_team_no');
    var selected_team_name = sessionStorage.getItem('selected_team_name');
    $('#re_team_1').prop("checked", true);
    $('#re_team_2').prop("checked", false);

    $('#re_team_input_text').val(selected_team_name);


    $("html, body").css({ "overflow": "auto", "height": "auto" });
    $('#busking_time_each_popup').unbind('touchmove');

    $('#busking_time_each_popup').hide();

    $('#header').show();
    $('#footer').show();
});
