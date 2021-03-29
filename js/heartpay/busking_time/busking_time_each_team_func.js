var ranking_count;

var member_count;
var selected_team_no;
var selected_team_name;

function get_artist_ranking_2() {
    ranking_count = 0;

    var a_ranking_count = sessionStorage.getItem('a_ranking_count');
    var endCount = sessionStorage.getItem('aEndCount');

    if (a_ranking_count == null) {
        a_ranking_count = 0;
        sessionStorage.setItem('a_ranking_count', a_ranking_count);
    }

    if (endCount == null) {
        endCount = 20;
        sessionStorage.setItem('aEndCount', endCount);
    }

    var arankArea = sessionStorage.getItem('arankArea');
    var arankGenre = sessionStorage.getItem('arankGenre');

    if (arankArea == null) {
        arankArea = '';
    }
    if (arankGenre == null) {
        arankGenre = '';
    }

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

                $('#Go_AllRanking').find('span').html('전체 (' + ALL_CNT + ')');
            });

        }
    });


    var sort = sessionStorage.getItem('ars_sort');

    $.ajax({
        type: "GET",
        cache: false,
        async: false,
        url: '/service/artist_ranking/artist_ranking.jsp',
        data: {
            code_area: arankArea,
            code_genre: arankGenre,
            team_search: a_ranking_sc_temp,
            a_count: 0,
            endCount: endCount,
            sort: sort
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');


            $('#a_ranking_content_2').empty();
            console.log(a_ranking_sc_temp);

            if (DATA.length == 0) {
                $('#a_ranking_content_2').html('<p id="main_cont"></p>');
                $("#main_cont").text("검색 결과가 없습니다.");
                $("#main_cont").attr("onclick", "");
                $("#main_cont").removeClass("moreViewBtn");
                $("#main_cont").addClass("noViewBtn");
                $("#main_cont").css('display', 'inline-block');
                return;
            } else if ((DATA.length % 20) == 0) {
                // $('#a_ranking_content_2').html('<p id="main_cont"></p>');
                // $("#main_cont").text("더보기 >");
                // $("#main_cont").attr("onclick", "get_artist_reRanking()");
                // $("#main_cont").removeClass("noViewBtn");
                // $("#main_cont").addClass("moreViewBtn");
                // $("#main_cont").css('display', 'inline-block');
            } else {
                $("#main_cont").hide();
            }

            var search_title =
                '<div class="btet_search_result_title" id="btet_search_result_title">' +
                '검색결과' +
                '</div>'
            $('#a_ranking_content_2').append(search_title);

            // sessionStorage.removeItem('member_count');

            $(DATA).each(function (i) {
                var TEAM_NO = $(this).find('TEAM_NO').text();
                var TEAM_NAME = $(this).find('TEAM_NAME').text();
                var RATY_STAR = $(this).find('RATY_STAR').text();
                var CODE_GENRE = $(this).find('CODE_GENRE').text();
                var I_CNT = $(this).find('I_CNT').text();
                var TINTRO_IMG = $(this).find('TINTRO_IMG').text();
                var PF_DATE = $(this).find('PF_DATE').text();
                var BELONG = $(this).find('BELONG').text();
                var t_img = '/upload/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                //RATY_STAR와 I_CNT의  NULL 값은 0으로 나옴

                ranking_count++;

                var belong_content;

                if (BELONG == '') {
                    belong_content = '<p class="ait_text ait_perform" id="a_rank_t_a_ranking_' + ranking_count + '"></p>';
                } else {
                    belong_content = '<p class="ait_text ait_belong">' + BELONG + '</p>' +
                        '<p class="ait_middle">&nbsp;|&nbsp;</p>' +
                        '<p class="ait_text ait_perform" id="a_rank_t_a_ranking_' + ranking_count + '"></p>';
                }

                btet_chk_id = "#re_team_select_" + TEAM_NO;
                // member_container_id = "#btet_member_container_" + TEAM_NO
                // btet_team_chk_class = ".btet_member_" + TEAM_NO;
                selected_team_name = TEAM_NAME;
                selected_team_no = TEAM_NO;

                var a_ranking_content_2 =
                    '<div class="artist_list_container">' +
                    // '<div class="alc_ranknum" id="ar_rank_' + ranking_count + '">' + ranking_count + '</div>' +
                    '<div class="alc_thumbnail">' +
                    '<img id="aimg' + TEAM_NO + '">' +
                    '</div>' +
                    '<div class="alc_info_text">' +
                    '<p class="ait_teamname">' + TEAM_NAME + '</p>' +
                    // '<p class="ait_text ait_genre">' + CODE_GENRE + '</p>' +
                    // belong_content +
                    '</div>' +
                    '<div class="common_terms_check common_flex_container" style="padding: 20px 15px 0px 15px !important;" onclick="btetShowMember(\'' + btet_chk_id + '\', \'' + selected_team_name + '\', \'' + selected_team_no + '\');">' +
                    // '<div class="common_terms_check common_flex_container" style="padding: 20px 15px 0px 15px !important;" onclick="btetShowMember(\'' + btet_team_chk_class + '\', \'' + btet_chk_id + '\', \'' + member_container_id + '\');">' +
                    // '<div class="common_terms_check common_flex_container" style="padding: 20px 15px 0px 15px !important;">' +
                    '<input type="radio" name="re_team" id="re_team_select_' + TEAM_NO + '" data-role="none" value="1">' +
                    '<label for="re_team_select_' + TEAM_NO + '"></label>' +
                    '</div>' +
                    '</div>';
                // '<div class="btet_member_container" id="btet_member_container_' + TEAM_NO + '" style="display: none;">' +
                // '</div>';


                $('#a_ranking_content_2').append(a_ranking_content_2);

                ///////////////////// 2021.01.08 팀명만 선택되도록 변경 ///////////////////////

                // var tno = TEAM_NO;
                // $.ajax({
                //     type: "GET",//url: "JSON/test.json",
                //     cache: false,
                //     url: "/service/team/team_info.jsp",
                //     data: {
                //         team_no: tno,
                //         user_no: user_no
                //     },
                //     contentType: "application/xml; charset=utf-8",
                //     dataType: "xml",
                //     timeout: 30000,
                //     success: function (data) {
                //         var ROOT = $(data).find('ROOT');
                //         var DATA2 = $(ROOT).find('DATA2');
                //         $(DATA2).each(function (i) {
                //             i = i + 1;
                //             var USER_NO = $(this).find("USER_NO").text();
                //             var TEAM_NO = $(this).find("TEAM_NO").text();
                //             var PART = $(this).find("PART").text();
                //             var ARTIST_IMG = $(this).find("ARTIST_IMG").text();
                //             var ARTIST_NAME = $(this).find("ARTIST_NAME").text();

                //             //var a_img = '/upload/artist/artist'+ USER_NO +'/'+ARTIST_IMG;
                //             // var new_img = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;
                //             // var imgSrc = getImagePromise(new_img).then(value => {
                //             //     $('#aimg' + i).attr('src', value);
                //             // });

                //             // var part_content = PART + ' | ' + TEAM_NAME


                //             var content = '';

                //             content =
                //                 '<div class="btet_member_tab">' +
                //                 '<div class="btet_left_container">' +
                //                 '<div class="alc_thumbnail btet_member_thumbnail">' +
                //                 '<img id="aimg' + i + '">' +
                //                 '</div>' +
                //                 '<div class="alc_info_text btet_member_text">' +
                //                 '<p class="ait_teamname btet_member_name">' + ARTIST_NAME + '</p>' +
                //                 '</div>' +
                //                 '</div>' +
                //                 '<div class="btet_right_container">' +
                //                 '<div class="alc_info_text btet_member_text btet_member_fee_text">' +
                //                 '<p class="btet_member_fee"></p>' +
                //                 '</div>' +
                //                 '<div class="common_terms_check common_flex_container btet_member_chk">' +
                //                 '<input type="checkbox" name="re_team" class="btet_member_' + TEAM_NO + '" id="btet_member_' + USER_NO + '" data-role="none" value="1">' +
                //                 '<label for="btet_member_' + USER_NO + '"></label>' +
                //                 '</div>' +
                //                 '</div>' +
                //                 '</div>';



                //             var new_img = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;
                //             var imgSrc = getImagePromise(new_img).then(value => {
                //                 $('#aimg' + i).attr('src', value);
                //             });

                //             $("#btet_member_container_" + TEAM_NO).append(content);
                //             // console.log(new_img);
                //             // console.log(TEAM_NO);
                //         });
                //     },
                //     error: function (xhr, message, errorThrown) {
                //         //hideLoading();
                //         infoTxtBox(xhr);
                //         infoTxtBox(message);
                //         infoTxtBox(errorThrown);
                //     } // end error 
                // });


                var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                var imgSrc = getImagePromise(new_img).then(value => {
                    $('#aimg' + TEAM_NO).attr('src', value);
                });

            });

        }, error: function (xhr, message, errorThrown) {
        },
        complete: function () {
            $('#artist_ranking').css('padding-top', '185px');
            var scroll = sessionStorage.getItem('arankScroll');
            if (scroll == null) {
                scroll = 0;
            }
            $('html,body').animate({ scrollTop: scroll }, 'fast');
        }
    });
}

function btetShowMember(btet_chk_id, selected_team_name, selected_team_no) {
    // console.log(btet_chk_id);
    if ($(btet_chk_id).is(":checked") == true) {
        // console.log(selected_team_no);
        // console.log(selected_team_name);

        sessionStorage.setItem('selected_team_no', selected_team_no);
        sessionStorage.setItem('selected_team_name', selected_team_name);
        console.log("세션 저장 : " + selected_team_no + ", " + selected_team_name);
        return false;
    } else {
        sessionStorage.removeItem('selected_team_no');
        sessionStorage.removeItem('selected_team_name');
        selected_team_no = sessionStorage.getItem('selected_team_no');
        selected_team_name = sessionStorage.getItem('selected_team_name');
        console.log("세션 삭제 : " + selected_team_no + ", " + selected_team_name);
        return false;
    }
}

///////////////////// 2021.01.08 팀명만 선택되도록 변경 ///////////////////////

// function btetShowMember(btet_team_chk_class, btet_chk_id, member_container_id) {
//     // console.log(btet_chk_id);
//     if ($(btet_chk_id).is(":checked") == true) {
//         $(member_container_id).css('display', 'block');
//         $(btet_team_chk_class).prop("checked", true);
//         // console.log($(btet_team_chk_class).is(":checked"));

//         // console.log(btet_team_chk_class);
//         btet_team_chk_class_2 = btet_team_chk_class.split('.');
//         btet_team_chk_class_2 = btet_team_chk_class_2[1];
//         // console.log(btet_team_chk_class_2);

//         member_count = sessionStorage.getItem('member_count');
//         if (member_count == null || member_count == '') {
//             member_count = new Array();
//         } else {
//             member_count = member_count.split(',');
//         }
//         member_count = $('input:checkbox[class="' + btet_team_chk_class_2 + '"]:checked').length;
//         // console.log(member_count);

//         sessionStorage.setItem('member_count', member_count);
//         member_count = sessionStorage.getItem('member_count');
//         var team_total_price = sessionStorage.getItem('team_total_price')

//         var personal_price = team_total_price / member_count;
//         // console.log(personal_price);
//         console.log(typeof (personal_price));

//         personal_price = personal_price.toString();
//         var personal_price_comma = personal_price.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 	
//         $('.btet_member_fee').append(personal_price_comma + ' 원');

//         // console.log(testtt);
//         // console.log(test2);
//         // console.log(personal_price);

//         return false;
//     } else {
//         $(member_container_id).css('display', 'none');
//         $(btet_team_chk_class).prop("checked", false);
//         // console.log($(btet_team_chk_class).is(":checked"));

//         $('.btet_member_fee').empty();
//         return false;
//     }
// }
