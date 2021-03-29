// 승인 대기
function btad_stand_by(team_no, perform_no) {
    var user_no_arr = [];
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/busking_time_contract/busking_time_apply_detail.jsp',
        data: {
            team_no: team_no,
            perform_no: perform_no
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
                var CODE_GENRE = $(this).find("CODE_GENRE").text();
                var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
                var CODE_AREA = $(this).find("CODE_AREA").text();
                var TINTRO_VIDEO = $(this).find("TINTRO_VIDEO").text();
                var TEAM_INTRO = $(this).find("TEAM_INTRO").text();
                var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
                var STARTINGTIME = $(this).find("STARTINGTIME").text();
                var FINISHINGTIME = $(this).find("FINISHINGTIME").text();
                var OFFERPRICE = $(this).find("OFFERPRICE").text();
                var TINTRO_VIDEO_CONTENT = changeLineBreak($(this).find("TVIDEO_CONTENT").text());
                var USER_NO = $(this).find("USER_NO").text();
                var TEAM_NO = $(this).find("TEAM_NO").text();
                var BUSINESS_REPRESENTIVE = $(this).find("BUSINESS_REPRESENTIVE").text();

                sessionStorage.setItem('ab_complete_teamName', TEAM_NAME);
                sessionStorage.setItem('ab_complete_buskingDate', BUSKINGDATE);
                sessionStorage.setItem('ab_complete_buskingTime', STARTINGTIME + ' - ' + FINISHINGTIME);


                var busking_day_arr = BUSKINGDATE.split('-');

                // console.log(busking_day);

                // console.log($('.btcl_day p').val());

                user_no_arr.push(USER_NO);


                var sessTeamName = sessionStorage.getItem('sessTeamName');
                console.log('ss' + sessTeamName);

                OFFERPRICE = OFFERPRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 

                var artist_arr = [];

                if (sessTeamName != TEAM_NAME) {
                    sessionStorage.setItem('sessTeamName', TEAM_NAME);
                    var btad_team_name_title =
                        '<p>' + TEAM_NAME + '</p>';

                    var btad_artist_info =
                        '<div class="btad_artist_info_click" onclick="go_team_infoPage(' + TEAM_NO + ');">' +
                        '<p>아티스트 정보 ></p>' +
                        '</div>';

                    var btad_basic_info_table =
                        '<table>' +
                        '<tr>' +
                        '<th>팀/솔로명</th>' +
                        '<td>' + TEAM_NAME + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>장르</th>' +
                        '<td>' + CODE_GENRE + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>멤버</th>' +
                        '<td class="btad_artist_name"></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>활동지역</th>' +
                        '<td>' + CODE_AREA + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>영상</th>' +
                        '<td><p class="btad_intro_video" onclick="show_teamInfoVideo(\'' + TINTRO_VIDEO + '\', \'' + TINTRO_VIDEO_CONTENT + '\');">영상 보기</p></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>소개</th>' +
                        '<td>' + TEAM_INTRO + '</td>' +
                        '</tr>' +
                        '</table>';

                    var btad_apply_info_table =
                        '<table>' +
                        '<tr>' +
                        '<th>신청 날짜</th>' +
                        '<td>' + busking_day_arr[0] + '년 ' + busking_day_arr[1] + '월 ' + busking_day_arr[2] + '일' + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>신청 시간</th>' +
                        '<td>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>공연비</th>' +
                        '<td>' + OFFERPRICE + '원</td>' +
                        '</tr>' +
                        '</table>';
                    artist_arr.push(ARTIST_NAME);
                } else {
                    var btad_team_name_title = '';
                    var btad_basic_info_table = '';
                    var btad_apply_info_table = '';

                    artist_arr.push(', ' + ARTIST_NAME);
                }
                $('.btad_team_name_title').append(btad_team_name_title);
                $('.btad_artist_info').append(btad_artist_info);
                $('.btad_basic_info_table').append(btad_basic_info_table);
                $('.btad_apply_info_table').append(btad_apply_info_table);
                $('.btad_artist_name').append(artist_arr);

                sessionStorage.setItem('btadPerformSess', PERFORM_NO);
                // sessionStorage.setItem('btad_artist_arr', artist_arr);
                sessionStorage.setItem('btad_user_no_arr', user_no_arr);
                // console.log(user_no_arr);
                sessionStorage.setItem('btad_team_name', TEAM_NAME);
                sessionStorage.setItem('btad_team_no', TEAM_NO);
                sessionStorage.setItem('btad_business_representive', BUSINESS_REPRESENTIVE);
                sessionStorage.setItem('btad_buskingdate', BUSKINGDATE);

            }).promise().done(function () {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
            });
        },//end success
        error: function (xhr, message, errorThrown) {
            //hideLoading();
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
        } // end error
    });
    sessionStorage.removeItem('sessTeamName');

    var btad_footer =
        '<div class="btad_footer_reject" id="btad_footer_reject" onclick="go_complete_reject_busking()">' +
        '공연거절' +
        '</div>' +
        '<div class="btad_footer_accept" id="btad_footer_accept" onclick="go_complete_confirm_busking()">' +
        '공연승인' +
        '</div>';
    $('.btad_footer').append(btad_footer);
}

//// 거절된 공연
function btad_reject(team_no, perform_no) {
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/busking_time_contract/busking_time_apply_detail.jsp',
        data: {
            team_no: team_no,
            perform_no: perform_no
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
                var CODE_GENRE = $(this).find("CODE_GENRE").text();
                var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
                var CODE_AREA = $(this).find("CODE_AREA").text();
                var TINTRO_VIDEO = $(this).find("TINTRO_VIDEO").text();
                var TEAM_INTRO = $(this).find("TEAM_INTRO").text();
                var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
                var STARTINGTIME = $(this).find("STARTINGTIME").text();
                var FINISHINGTIME = $(this).find("FINISHINGTIME").text();
                var OFFERPRICE = $(this).find("OFFERPRICE").text();
                var TINTRO_VIDEO_CONTENT = changeLineBreak($(this).find("TVIDEO_CONTENT").text());
                var TEAM_NO = $(this).find("TEAM_NO").text();

                var busking_day_arr = BUSKINGDATE.split('-');

                // console.log(busking_day);

                // console.log($('.btcl_day p').val());


                var sessTeamName = sessionStorage.getItem('sessTeamName');
                // console.log('ss' + sessTeamName);

                var artist_arr = [];

                OFFERPRICE = OFFERPRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 

                if (sessTeamName != TEAM_NAME) {
                    sessionStorage.setItem('sessTeamName', TEAM_NAME);
                    var btad_team_name_title =
                        '<p>' + TEAM_NAME + '</p>';

                    var btad_artist_info =
                        '<div class="btad_artist_info_click" onclick="go_team_infoPage(' + TEAM_NO + ');">' +
                        '<p>아티스트 정보 ></p>' +
                        '</div>';

                    var btad_basic_info_table =
                        '<table>' +
                        '<tr>' +
                        '<th>팀/솔로명</th>' +
                        '<td>' + TEAM_NAME + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>장르</th>' +
                        '<td>' + CODE_GENRE + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>멤버</th>' +
                        '<td class="btad_artist_name"></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>활동지역</th>' +
                        '<td>' + CODE_AREA + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>영상</th>' +
                        '<td><p class="btad_intro_video" onclick="show_teamInfoVideo(\'' + TINTRO_VIDEO + '\', \'' + TINTRO_VIDEO_CONTENT + '\');">영상 보기</p></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>소개</th>' +
                        '<td>' + TEAM_INTRO + '</td>' +
                        '</tr>' +
                        '</table>';

                    var btad_apply_info_table =
                        '<table>' +
                        '<tr>' +
                        '<th>신청 날짜</th>' +
                        '<td>' + busking_day_arr[0] + '년 ' + busking_day_arr[1] + '월 ' + busking_day_arr[2] + '일' + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>신청 시간</th>' +
                        '<td>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>공연비</th>' +
                        '<td>' + OFFERPRICE + '원</td>' +
                        '</tr>' +
                        '</table>';
                    artist_arr.push(ARTIST_NAME);
                } else {
                    var btad_team_name_title = '';
                    var btad_basic_info_table = '';
                    var btad_apply_info_table = '';

                    artist_arr.push(', ' + ARTIST_NAME);
                }
                $('.btad_team_name_title').append(btad_team_name_title);
                $('.btad_artist_info').append(btad_artist_info);
                $('.btad_basic_info_table').append(btad_basic_info_table);
                $('.btad_apply_info_table').append(btad_apply_info_table);
                $('.btad_artist_name').append(artist_arr);

                sessionStorage.setItem('btadPerformSess', PERFORM_NO);

            }).promise().done(function () {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
            });
        },//end success
        error: function (xhr, message, errorThrown) {
            //hideLoading();
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
        } // end error
    });
    sessionStorage.removeItem('sessTeamName');

    var btad_footer =
        '<div class="btad_footer_notice">' +
        '통보 완료' +
        '</div>';
    $('.btad_footer').append(btad_footer);
}


//// 확정된 공연
function btad_confirm(team_no, perform_no) {
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/busking_time_contract/busking_time_apply_detail.jsp',
        data: {
            team_no: team_no,
            perform_no: perform_no
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');
            var DATA2 = $(ROOT).find('DATA2');

            var btad_bank_info_container;
            $(DATA).each(function (i) {
                var PERFORM_NO = $(this).find("PERFORM_NO").text();
                var TEAM_NAME = $(this).find("TEAM_NAME").text();
                var CODE_GENRE = $(this).find("CODE_GENRE").text();
                var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
                var CODE_AREA = $(this).find("CODE_AREA").text();
                var TINTRO_VIDEO = $(this).find("TINTRO_VIDEO").text();
                var TEAM_INTRO = $(this).find("TEAM_INTRO").text();
                var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
                var STARTINGTIME = $(this).find("STARTINGTIME").text();
                var FINISHINGTIME = $(this).find("FINISHINGTIME").text();
                var OFFERPRICE = $(this).find("OFFERPRICE").text();
                var TINTRO_VIDEO_CONTENT = changeLineBreak($(this).find("TVIDEO_CONTENT").text());
                var TEAM_NO = $(this).find("TEAM_NO").text();
                var BUSKINGSTATUS = $(this).find("BUSKINGSTATUS").text();

                var busking_day_arr = BUSKINGDATE.split('-');

                // console.log(busking_day);

                // console.log($('.btcl_day p').val());


                var sessTeamName = sessionStorage.getItem('sessTeamName');
                console.log('ss' + sessTeamName);

                var artist_arr = [];
                var deduction_price = parseInt(OFFERPRICE) - (parseInt(OFFERPRICE) * 0.008)
                deduction_price = String(deduction_price);

                OFFERPRICE = OFFERPRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 

                if (sessTeamName != TEAM_NAME) {
                    sessionStorage.setItem('sessTeamName', TEAM_NAME);
                    var btad_team_name_title =
                        '<p>' + TEAM_NAME + '</p>';

                    var btad_artist_info =
                        '<div class="btad_artist_info_click" onclick="go_team_infoPage(' + TEAM_NO + ');">' +
                        '<p>아티스트 정보 ></p>' +
                        '</div>';

                    var btad_basic_info_table =
                        '<table>' +
                        '<tr>' +
                        '<th>팀/솔로명</th>' +
                        '<td>' + TEAM_NAME + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>장르</th>' +
                        '<td>' + CODE_GENRE + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>멤버</th>' +
                        '<td class="btad_artist_name"></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>활동지역</th>' +
                        '<td>' + CODE_AREA + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>영상</th>' +
                        '<td><p class="btad_intro_video" onclick="show_teamInfoVideo(\'' + TINTRO_VIDEO + '\', \'' + TINTRO_VIDEO_CONTENT + '\');">영상 보기</p></td>' +
                        '</tr>' +
                        '</table>';

                    var btad_apply_info_table =
                        '<table>' +
                        '<tr>' +
                        '<th>신청 날짜</th>' +
                        '<td>' + busking_day_arr[0] + '년 ' + busking_day_arr[1] + '월 ' + busking_day_arr[2] + '일' + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>신청 시간</th>' +
                        '<td>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>공연비</th>' +
                        '<td>' + OFFERPRICE + '원</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>사업주<br>계약상태</th>' +
                        '<td>서명 대기</td>' +
                        '</tr>' +
                        '</table>';
                    artist_arr.push(ARTIST_NAME);
                } else {
                    var btad_team_name_title = '';
                    var btad_basic_info_table = '';
                    var btad_apply_info_table = '';

                    artist_arr.push(', ' + ARTIST_NAME);
                }


                deduction_price = deduction_price.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 

                $(DATA2).each(function (i) {
                    var ART_BANK_NAME = $(this).find("ART_BANK_NAME").text();
                    var ART_BANK_NUMBER = $(this).find("ART_BANK_NUMBER").text();
                    var ART_BANK_USER = $(this).find("ART_BANK_USER").text();

                    if (BUSKINGSTATUS != '5') {
                        btad_bank_info_container =
                            '<div class="btad_bank_info_container_2">' +
                            '<div class="btad_info_title btad_perform_info_title">' +
                            '<p>입금 계좌 정보</p>' +
                            '</div>' +
                            '<div class = "btad_info_table btad_bank_info_table">' +
                            '<p class="btad_bank_info_not_p">공연 종료(최대 3일) 후 입금 계좌 정보가 생성됩니다.</p>' +
                            '</div>' +
                            '</div>';
                    } else {
                        if (!ART_BANK_NAME) {
                            btad_bank_info_container =
                                '<div class="btad_bank_info_container_2">' +
                                '<div class="btad_info_title btad_perform_info_title">' +
                                '<p>입금 계좌 정보</p>' +
                                '</div>' +
                                '<div class = "btad_info_table btad_bank_info_table">' +
                                '<p class="btad_bank_info_not_p">아티스트가 아무도 서명하지 않았습니다.</p>' +
                                '<p class="btad_bank_info_not_p">아티스트에게 서명 요청을 하세요.</p>' +
                                '</div>' +
                                '</div>';
                        } else {
                            btad_bank_info_container =
                                '<div class="btad_bank_info_container_2">' +
                                '<div class="btad_info_title btad_perform_info_title">' +
                                '<p>입금 계좌 정보</p>' +
                                '</div>' +
                                '<div class = "btad_info_table btad_bank_info_table">' +
                                '<table>' +
                                '<tr>' +
                                '<th>입금계좌</th>' +
                                '<td>' + ART_BANK_NUMBER + ' (' + ART_BANK_NAME + ')</td>' +
                                '</tr>' +
                                '<tr>' +
                                '<th>예금주</th>' +
                                '<td>' + ART_BANK_USER + '</td>' +
                                '</tr>' +
                                '<tr>' +
                                '<th>공연비</th>' +
                                '<td>' + deduction_price + '원 (0.8% 공제된 금액)</td>' +
                                '</tr>' +
                                '</table>' +
                                '</div>' +
                                '</div>';
                        }

                    }
                });


                $('.btad_team_name_title').append(btad_team_name_title);
                $('.btad_artist_info').append(btad_artist_info);
                $('.btad_basic_info_table').append(btad_basic_info_table);
                $('.btad_apply_info_table').append(btad_apply_info_table);
                $('.btad_artist_name').append(artist_arr);


                sessionStorage.setItem('btadPerformSess', PERFORM_NO);

            }).promise().done(function () {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                $('.btad_bank_info_container').append(btad_bank_info_container);
            });
        },//end success
        error: function (xhr, message, errorThrown) {
            //hideLoading();
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
        } // end error
    });
    sessionStorage.removeItem('sessTeamName');

    btad_get_e_contract(perform_no);

    // var btad_footer =
    //     '<div class="btad_footer_notice">' +
    //     '통보 완료' +
    //     '</div>';
    // $('.btad_footer').append(btad_footer);
}

// 계약 상황 가져오기 - 사업주가
function btad_get_e_contract(perform_no) {
    sessionStorage.setItem('es_con_perform_no', perform_no);
    var contract_chk = [];
    var btad_contract_status_title =
        '<div class="btad_info_title btad_contract_status_title">' +
        '<p>계약 상태</p>' +
        '</div>' +
        '<div class="btad_contract_team_name_container">' +
        '</div>' +
        '<div class="btad_info_table btad_contract_table">' +
        '<table class="btad_contract_table_2">' +
        '</table> ' +
        '<div class="btad_total_price_container">' +
        '</div>' +
        '</div>';
    $('.btad_contract_status_container').append(btad_contract_status_title);
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/e_contract/get_e_contract_detailpage.jsp',
        data: {
            perform_no: perform_no
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function (i) {
                var TEAM_NAME = $(this).find("TEAM_NAME").text();
                var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
                var CONTRACT_PRICE = $(this).find("CONTRACT_PRICE").text();
                var CONTRACT_STATUS = $(this).find("CONTRACT_STATUS").text();
                var OFFERPRICE = $(this).find("OFFERPRICE").text();
                var USER_NO = $(this).find("USER_NO").text();
                var BUSKINGSTATUS = $(this).find("BUSKINGSTATUS").text();

                contract_chk.push(CONTRACT_STATUS);
                contract_chk = Array.from(new Set(contract_chk)); //중복 제거
                console.log(contract_chk);

                if (contract_chk != '3') {
                    var btad_contract_status_label = '<div class="btad_contract_status_label">계약진행</div>'
                } else {
                    var btad_contract_status_label = '<div class="btad_contract_status_label" style="border: 1px solid #26B5F5; color: #26B5F5;">계약완료</div>'
                }

                $('.btad_contract_team_name_container').empty();

                var btad_contract_team_name_container =
                    '<div style="display: flex;">' +
                    '<p class="btad_contract_team_name">' + TEAM_NAME + '</p>' +
                    btad_contract_status_label +
                    '</div>' +
                    '<p class="btad_contract_cancel_contract_p" onclick="go_contract_cancel_pop()">계약 취소</p>';

                $('.btad_contract_team_name_container').append(btad_contract_team_name_container);

                if (BUSKINGSTATUS === '5') {
                    $('.btad_contract_cancel_contract_p').css('color', '#DBDBDB');
                    $('.btad_contract_cancel_contract_p').css('text-decoration', 'none');
                    $('.btad_contract_cancel_contract_p').removeAttr('onclick');
                }

                //////////////////////

                if (CONTRACT_STATUS == '1') {
                    var stat_chk =
                        '<div class="btad_btn_container" style="margin-bottom: 0;">' +
                        '<span class = "btad_contract_check_span sign_notcom_span" onclick="btad_contract_check(\'' + USER_NO + '\', \'' + perform_no + '\')">서명 요청</span>' +
                        '</div>';
                } else if (CONTRACT_STATUS == '2' || CONTRACT_STATUS == '3') {
                    var stat_chk =
                        '<div class="btad_btn_container" style="margin-bottom: 0;">' +
                        '<span class = "btad_contract_check_span sign_com_span">서명 완료</span>' +
                        '</div>';
                }

                var contract_price_td;
                if (!CONTRACT_PRICE) {
                    contract_price_td = '';
                } else {
                    CONTRACT_PRICE = CONTRACT_PRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 
                    contract_price_td = CONTRACT_PRICE + ' 원'
                }
                var btad_contract_table_2 =
                    '<tr>' +
                    '<th>' + ARTIST_NAME + '</th>' +
                    '<td>' + contract_price_td + '</td>' +
                    '<td style="width: 85px;">' +
                    stat_chk +
                    '</td>' +
                    '</tr>';
                $('.btad_contract_table_2').append(btad_contract_table_2);

                /////////////////////////
                OFFERPRICE = OFFERPRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 
                $('.btad_total_price_container').empty()
                var btad_total_price_container =
                    '<div class="btad_total_price_title">총 공연비</div>' +
                    '<div class="btad_total_price">' + OFFERPRICE + ' 원</div>';

                $('.btad_total_price_container').append(btad_total_price_container);

            }).promise().done(function () {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });

                contract_chk = Array.from(new Set(contract_chk));
                // console.log(contract_chk);
                if ((contract_chk.length == 1 && contract_chk[0] == "3")) {
                    // console.log("서명 다했대");
                    var btad_footer =
                        '<div class="btad_footer_e_contract_view_contract" onclick="go_view_contract()" style="border-top: 1px solid #E4E4EA;">' +
                        '계약서 보기' +
                        '</div>';
                    $('.btad_footer').append(btad_footer);
                } else {
                    if (contract_chk.length == 1 && contract_chk[0] == "2") {
                        // console.log("서명 다했대");
                        var btad_footer =
                            '<div class="btad_footer_e_contract" onclick="go_esign_owner()">' +
                            '전자 계약 서명하기' +
                            '</div>';
                        $('.btad_footer').append(btad_footer);
                    } else {
                        // console.log("아직 못했대");
                        var btad_footer =
                            '<div class="btad_footer_e_contract" onclick="go_esign_owner()">' +
                            '전자 계약 서명하기' +
                            '</div>';
                        $('.btad_footer').append(btad_footer);
                    }
                }
                sessionStorage.setItem('es_perform_no', perform_no);
            });
        },//end success
        error: function (xhr, message, errorThrown) {
            //hideLoading();
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
        } // end error
    });
}


////// 공연 승인버튼 눌렀을때
function go_complete_confirm_busking() {
    var user_no_arr = sessionStorage.getItem('btad_user_no_arr');

    var perform_no = sessionStorage.getItem('btadPerformSess');
    var team_name = sessionStorage.getItem('btad_team_name');
    var team_no = sessionStorage.getItem('btad_team_no');
    var business_representive = sessionStorage.getItem('btad_business_representive');
    var buskingdate = sessionStorage.getItem('btad_buskingdate');

    // console.log(contract_no);
    console.log(perform_no);
    // console.log(user_no);
    console.log(team_no);
    console.log(team_name);
    console.log(business_representive);
    console.log(buskingdate);
    console.log(user_no_arr);




    $.ajax({
        type: 'GET',
        cache: false,
        url: '/service/busking_time_contract/set_busking_time_confirm.jsp',
        data: {
            perform_no: perform_no,
            user_no_arr: user_no_arr,
            team_no: team_no,
            team_name: team_name,
            business_representive: business_representive,
            buskingdate: buskingdate
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


        },
        error: function (xhr, status, error) {
            console.log(xhr);
            // console.log(message);
            // console.log(errorThrown);
        }
    }).promise().done(function () {

        // 아티스트에게에게 승인 푸쉬
        $.ajax({
            type: "POST",//url: "JSON/test.json",
            cache: false,
            url: '/service/push_perform_contract/art_accept_perform.jsp',
            //data : data,
            data: {
                perform_no: perform_no,
                team_no: team_no
            },
            dataType: "xml",
            timeout: 30000,
            success: function (data) {
                // console.log("여기까지 옴");
            }
        })

        loadPage('busking_time_contract/complete_accept_busking.jsp')
    });
}

////// 공연 거절 버튼 눌렀을때
function go_complete_reject_busking() {
    var team_no = sessionStorage.getItem('TNO');
    var btadPerform = sessionStorage.getItem('btadPerformSess');

    console.log(team_no);
    console.log(btadPerform);

    $.ajax({
        type: "POST",//url: "JSON/test.json",
        cache: false,
        url: '/service/busking_time_contract/busking_time_reject.jsp',
        //data : data,
        data: {
            team_no: team_no,
            btadPerform: btadPerform
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
                var RESULT = $(DATA).find('RESULT').text();
                var MESSAGE = $(DATA).find('MESSAGE').text();

                if (RESULT == 'TRUE' || RESULT == 'true') {
                    // sessionStorage.setItem('pfrChk', 'Y');
                    // sessionStorage.setItem('btrChk', 'Y');
                    // perform_reg_push_send(team_no, perform_sDate);

                    // alert(MESSAGE);

                    sessionStorage.removeItem('btadPerformSess');

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
            alert('잠시후 다시 시도해주세요.');
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            // showLoading('hide', '등록중입니다');
        }
    }).promise().done(function () {

        // 아티스트에게에게 거절 푸쉬
        $.ajax({
            type: "POST",//url: "JSON/test.json",
            cache: false,
            url: '/service/push_perform_contract/art_reject_perform.jsp',
            //data : data,
            data: {
                perform_no: btadPerform,
                team_no: team_no
            },
            dataType: "xml",
            timeout: 30000,
            success: function (data) {
                // console.log("여기까지 옴");
            }
        })

        loadPage('busking_time_contract/complete_reject_busking.jsp');
    });
}


/////////////// 아티스트 - 신청한 공연
function btad_stand_by_art(user_no, perform_no) {
    var user_no_arr = [];
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/busking_time_contract/busking_time_apply_detail_artist.jsp',
        data: {
            user_no: user_no,
            perform_no: perform_no
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
                var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
                var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
                var STARTINGTIME = $(this).find("STARTINGTIME").text();
                var FINISHINGTIME = $(this).find("FINISHINGTIME").text();
                var USER_NO = $(this).find("USER_NO").text();
                var TEAM_NO = $(this).find("TEAM_NO").text();
                var BUSINESS_WORKNAME = $(this).find("BUSINESS_WORKNAME").text();

                var busking_day_arr = BUSKINGDATE.split('-');

                user_no_arr.push(USER_NO);

                var sessTeamName = sessionStorage.getItem('sessTeamName');
                // console.log('ss' + sessTeamName);
                var btcl_perform_no = sessionStorage.getItem('btcl_perform_no');

                var artist_arr = [];

                if (sessTeamName != TEAM_NAME) {
                    sessionStorage.setItem('sessTeamName', TEAM_NAME);
                    $('.btad_basic_info_title p').text('신청 정보');
                    $('.btad_apply_info_title').empty();

                    var btad_team_name_title =
                        '<p>' + BUSINESS_WORKNAME + '</p>';

                    var btad_basic_info_table =
                        '<table>' +
                        '<tr>' +
                        '<th>신청 날짜</th>' +
                        '<td>' + busking_day_arr[0] + '년 ' + busking_day_arr[1] + '월 ' + busking_day_arr[2] + '일' + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>신청 시간</th>' +
                        '<td>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>팀/솔로명</th>' +
                        '<td>' + TEAM_NAME + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>멤버</th>' +
                        '<td class="btad_artist_name"></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>사업주<br>계약상태</th>' +
                        '<td>서명 대기</td>' +
                        '</tr>' +
                        '</table>';

                    artist_arr.push(ARTIST_NAME);
                } else {
                    var btad_team_name_title = '';
                    var btad_basic_info_table = '';

                    artist_arr.push(', ' + ARTIST_NAME);
                }
                $('.btad_team_name_title').append(btad_team_name_title);
                $('.btad_basic_info_table').append(btad_basic_info_table);
                $('.btad_artist_name').append(artist_arr);

                sessionStorage.setItem('btadPerformSess', PERFORM_NO);
                // sessionStorage.setItem('btad_artist_arr', artist_arr);
                sessionStorage.setItem('btad_user_no_arr', user_no_arr);
                // console.log(user_no_arr);
                sessionStorage.setItem('btad_team_name', TEAM_NAME);
                sessionStorage.setItem('btad_team_no', TEAM_NO);
                sessionStorage.setItem('btad_buskingdate', BUSKINGDATE);
            });
        }
    });
    var btad_footer =
        '<div class="btad_footer_cancel_artist" onclick="artist_cancel_go()">' +
        '신청취소' +
        '</div>';
    $('.btad_footer').append(btad_footer);
}

/////////////// 아티스트 - 승인된 공연
function btad_confirm_art(user_no, perform_no) {
    var user_no_arr = [];
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/busking_time_contract/busking_time_apply_detail_artist.jsp',
        data: {
            user_no: user_no,
            perform_no: perform_no
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            var btad_perform_info_container;

            $(DATA).each(function (i) {
                var PERFORM_NO = $(this).find("PERFORM_NO").text();
                var TEAM_NAME = $(this).find("TEAM_NAME").text();
                var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
                var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
                var STARTINGTIME = $(this).find("STARTINGTIME").text();
                var FINISHINGTIME = $(this).find("FINISHINGTIME").text();
                var USER_NO = $(this).find("USER_NO").text();
                var TEAM_NO = $(this).find("TEAM_NO").text();
                var BUSINESS_WORKNAME = $(this).find("BUSINESS_WORKNAME").text();
                var CONTRACT_STATUS = $(this).find("CONTRACT_STATUS").text();
                var BUSKINGSTATUS = $(this).find("BUSKINGSTATUS").text();
                var END_PERFORM_ART = $(this).find("END_PERFORM_ART").text();
                var END_PERFORM_DATE = $(this).find("END_PERFORM_DATE").text();
                var END_PERFORM_USER_NO = $(this).find("END_PERFORM_USER_NO").text();


                var busking_day_arr = BUSKINGDATE.split('-');

                user_no_arr.push(USER_NO);

                var sessTeamName = sessionStorage.getItem('sessTeamName');
                // console.log('ss' + sessTeamName);
                var btcl_perform_no = sessionStorage.getItem('btcl_perform_no');

                var artist_arr = [];

                var contract_stat;
                if (CONTRACT_STATUS == '1' || CONTRACT_STATUS == '2') {
                    contract_stat = "서명 대기"
                }
                else if (CONTRACT_STATUS == '3') {
                    contract_stat = "서명 완료"
                }

                if (sessTeamName != TEAM_NAME) {
                    sessionStorage.setItem('sessTeamName', TEAM_NAME);
                    $('.btad_basic_info_title p').text('신청 정보');
                    $('.btad_apply_info_title').empty();

                    var btad_team_name_title =
                        '<p>' + BUSINESS_WORKNAME + '</p>';

                    var btad_basic_info_table =
                        '<table>' +
                        '<tr>' +
                        '<th>신청 날짜</th>' +
                        '<td>' + busking_day_arr[0] + '년 ' + busking_day_arr[1] + '월 ' + busking_day_arr[2] + '일' + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>신청 시간</th>' +
                        '<td>' + STARTINGTIME + ' - ' + FINISHINGTIME + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>팀/솔로명</th>' +
                        '<td>' + TEAM_NAME + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>멤버</th>' +
                        '<td class="btad_artist_name"></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<th>사업주<br>계약상태</th>' +
                        '<td>' + contract_stat + '</td>' +
                        '</tr>' +
                        '</table>';

                    artist_arr.push(ARTIST_NAME);
                } else {
                    var btad_team_name_title = '';
                    var btad_basic_info_table = '';

                    artist_arr.push(', ' + ARTIST_NAME);
                }

                var now = new Date();

                var today = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1);
                // console.log(today);
                // console.log(typeof (today));

                var buskingdate = BUSKINGDATE;
                buskingdate = new Date(buskingdate);


                var distance = buskingdate - today;
                var d = Math.floor((distance / (1000 * 60 * 60 * 24)) + 1);


                // console.log(buskingdate)

                // console.log(today >= buskingdate);



                // var btad_perform_info_container;
                if (BUSKINGSTATUS == '1') {
                    if (today >= buskingdate) {
                        // console.log(today)
                        // console.log(buskingdate)
                        btad_perform_info_container =
                            '<div class="btad_info_title btad_perform_info_title">' +
                            '<p>공연 정보</p>' +
                            '<p class="content" style="font: normal normal normal 12px/24px SpoqaHanSans; letter-spacing: -0.5px; color: #999999; margin-left: 6px;">공연 종료</p>' +
                            '</div>' +
                            '<div class="btad_perform_info_notice">' +
                            '<p>공연을 잘 마치셨다면 공연종료를 클릭해주세요.</p>' +
                            '<p>사업주에게 공연비 지급 요청 메세지가 전달됩니다.</p>' +
                            '</div>' +
                            '<div class="btad_perform_info_notice_2">' +
                            '<p>팀원중 한명이라도 종료버튼을 누르면 팀원 모두 자동 종료 처리됩니다.</p>' +
                            '</div>' +
                            '<div class="btad_perform_info_endPerform_btn" style="border: 1px solid #8354C8; color: #8354C8;" onclick="btad_endPerform()">' +
                            '공연종료' +
                            '</div>';
                    } else if (today < buskingdate) {
                        console.log(today)
                        console.log(buskingdate)
                        btad_perform_info_container =
                            '<div class="btad_info_title btad_perform_info_title">' +
                            '<p>공연 정보</p>' +
                            '<p class="content" style="font: normal normal normal 12px/24px SpoqaHanSans; letter-spacing: -0.5px; color: #999999; margin-left: 6px;">공연 ' + d + '일전</p>' +
                            '</div>' +
                            '<div class="btad_perform_info_notice">' +
                            '<p>공연을 잘 마치셨다면 공연종료를 클릭해주세요.</p>' +
                            '<p>사업주에게 공연비 지급 요청 메세지가 전달됩니다.</p>' +
                            '</div>' +
                            '<div class="btad_perform_info_notice_2">' +
                            '<p>팀원중 한명이라도 종료버튼을 누르면 팀원 모두 자동 종료 처리됩니다.</p>' +
                            '</div>' +
                            '<div class="btad_perform_info_endPerform_btn">' +
                            '공연종료' +
                            '</div>';
                    }
                }
                else if (BUSKINGSTATUS == '5') {
                    if (END_PERFORM_USER_NO == '자동') {
                        btad_perform_info_container =
                            '<div class="btad_info_title btad_perform_info_title">' +
                            '<p>공연 정보</p>' +
                            '<p class="content" style="font: normal normal normal 12px/24px SpoqaHanSans; letter-spacing: -0.5px; color: #999999; margin-left: 6px;">공연 종료</p>' +
                            '</div>' +
                            '<div class="btad_perform_info_notice">' +
                            '<p>공연이 정상적으로 종료되었습니다.</p>' +
                            '<p>사업주에게 공연비 지급 요청 메세지가 전달됩니다.</p>' +
                            '</div>' +
                            '<div class="btad_perform_info_notice_2">' +
                            '<p>팀원중 한명이라도 종료버튼을 누르면 팀원 모두 자동 종료 처리됩니다.</p>' +
                            '</div>' +
                            '<div class="btad_perform_info_endPerform_btn">' +
                            '공연종료' +
                            '</div>' +
                            '<div class="btad_endPerform_who">' +
                            '<p>공연후 3일이 경과되어 자동으로 종료 처리 되었습니다.</p>' +
                            '</div>';
                    } else {
                        btad_perform_info_container =
                            '<div class="btad_info_title btad_perform_info_title">' +
                            '<p>공연 정보</p>' +
                            '<p class="content" style="font: normal normal normal 12px/24px SpoqaHanSans; letter-spacing: -0.5px; color: #999999; margin-left: 6px;">공연 종료</p>' +
                            '</div>' +
                            '<div class="btad_perform_info_notice">' +
                            '<p>공연이 정상적으로 종료되었습니다.</p>' +
                            '<p>사업주에게 공연비 지급 요청 메세지가 전달됩니다.</p>' +
                            '</div>' +
                            '<div class="btad_perform_info_notice_2">' +
                            '<p>팀원중 한명이라도 종료버튼을 누르면 팀원 모두 자동 종료 처리됩니다.</p>' +
                            '</div>' +
                            '<div class="btad_perform_info_endPerform_btn">' +
                            '공연종료' +
                            '</div>' +
                            '<div class="btad_endPerform_who">' +
                            '<p>' + END_PERFORM_DATE + ' ' + END_PERFORM_ART + '님이 공연종료 확인하셨습니다</p>' +
                            '</div>';
                    }

                }

                // $('.btad_perform_info_container').append(btad_perform_info_container);


                $('.btad_team_name_title').append(btad_team_name_title);
                $('.btad_basic_info_table').append(btad_basic_info_table);
                $('.btad_artist_name').append(artist_arr);

                sessionStorage.setItem('btadPerformSess', PERFORM_NO);
                // sessionStorage.setItem('btad_artist_arr', artist_arr);
                sessionStorage.setItem('btad_user_no_arr', user_no_arr);
                // console.log(user_no_arr);
                sessionStorage.setItem('btad_team_name', TEAM_NAME);
                sessionStorage.setItem('btad_team_no', TEAM_NO);
                sessionStorage.setItem('btad_buskingdate', BUSKINGDATE);
            });

            $('.btad_perform_info_container').append(btad_perform_info_container);
        }
    });
    btad_get_e_contract_artist(user_no, perform_no);
}

////////////// 계약상태 가져오기 - 아티스트
function btad_get_e_contract_artist(user_no, perform_no) {
    // sessionStorage.removeItem('btad_personal_price');
    sessionStorage.setItem('es_con_perform_no', perform_no);
    var contract_chk = [];
    var btad_contract_status_title =
        '<div class="btad_info_title btad_contract_status_title">' +
        '<p>계약 상태</p>' +
        '</div>' +
        '<div class="btad_contract_team_name_container">' +
        '</div>' +
        '<div class="btad_info_table btad_contract_table">' +
        '<table class="btad_contract_table_2">' +
        '</table> ' +
        '<div class="btad_total_price_container">' +
        '</div>' +
        '<div class="btad_remain_price_con">' +
        '</div>' +
        '</div>';
    $('.btad_contract_status_container').append(btad_contract_status_title);

    var offprice;
    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/busking_time_contract/busking_time_apply_detail_artist.jsp',
        data: {
            user_no: user_no,
            perform_no: perform_no
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function (i) {
                var TEAM_NAME = $(this).find("TEAM_NAME").text();
                var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
                var CONTRACT_STATUS = $(this).find("CONTRACT_STATUS").text();
                var OFFERPRICE = $(this).find("OFFERPRICE").text();
                var PERSONAL_PRICE = $(this).find("PERSONAL_PRICE").text();
                var USER_NO = $(this).find("USER_NO").text();
                var BUSKINGSTATUS = $(this).find("BUSKINGSTATUS").text();
                var CONTRACT_PRICE = $(this).find("CONTRACT_PRICE").text();

                contract_chk.push(CONTRACT_STATUS);
                contract_chk = Array.from(new Set(contract_chk)); //중복 제거
                console.log(contract_chk);

                if (contract_chk != '3') {
                    var btad_contract_status_label = '<div class="btad_contract_status_label">계약진행</div>'
                } else {
                    var btad_contract_status_label = '<div class="btad_contract_status_label" style="border: 1px solid #26B5F5; color: #26B5F5;">계약완료</div>'
                }

                $('.btad_contract_team_name_container').empty();

                var btad_contract_team_name_container =
                    '<div style="display: flex;">' +
                    '<p class="btad_contract_team_name">' + TEAM_NAME + '</p>' +
                    btad_contract_status_label +
                    '</div>' +
                    '<p class="btad_contract_cancel_contract_p" onclick="go_contract_cancel_pop()">계약 취소</p>';

                $('.btad_contract_team_name_container').append(btad_contract_team_name_container);

                if (BUSKINGSTATUS === '5') {
                    $('.btad_contract_cancel_contract_p').css('color', '#DBDBDB');
                    $('.btad_contract_cancel_contract_p').css('text-decoration', 'none');
                    $('.btad_contract_cancel_contract_p').removeAttr('onclick');
                }

                //////////////////////


                if (CONTRACT_STATUS == '2') {
                    var stat_chk =
                        '<div class="btad_stat_container" style="margin-bottom: 0;">' +
                        '<span class = "btad_contract_check_span" style="color: #8354C8;">서명 완료</span>' +
                        '</div>';
                }
                else if (CONTRACT_STATUS == '1') {
                    var stat_chk =
                        '<div class="btad_stat_container" style="margin-bottom: 0;">' +
                        '<span class = "btad_contract_check_span" style="text-decoration: underline; color: #F76C4A;" id="btad_contract_check_' + USER_NO + '" onclick="btad_contract_check(\'' + USER_NO + '\', \'' + perform_no + '\')">서명 요청</span>' +
                        '</div>';
                }
                else if (CONTRACT_STATUS == '3') {
                    var stat_chk =
                        '<div class="btad_stat_container" style="margin-bottom: 0;">' +
                        '<span class = "btad_contract_check_span" style="text-decoration: underline; color: #F76C4A;">서명 완료</span>' +
                        '</div>';
                }

                var artist_name =
                    '<div class="btad_btn_container" style="margin-bottom: 0; float: none;">' +
                    '<input type="checkbox" class="btad_contract_check" name="btad_contract_check" id="btad_contract_check_' + USER_NO + '" data-role="none">' +
                    '<label class="btad_contract_check_label" for="btad_contract_check_' + USER_NO + '"></label>' +
                    '<span class = "btad_contract_check_span btad_art_name">' + ARTIST_NAME + '</span>' +
                    '</div>';



                var personal_price_input;
                if (!CONTRACT_PRICE) {
                    PERSONAL_PRICE = PERSONAL_PRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 
                    personal_price_input =
                        '<input class="btad_personal_price_input" id="btad_personal_price_input_' + USER_NO + '" type="text" value="' + PERSONAL_PRICE + '" placeholder="금액입력" data-role="none" />';
                } else {
                    CONTRACT_PRICE = CONTRACT_PRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가
                    personal_price_input =
                        '<input class="btad_personal_price_input" id="btad_personal_price_input_' + USER_NO + '" type="text" value="' + CONTRACT_PRICE + '" placeholder="금액입력" data-role="none" />';
                }

                ////////////

                var btad_contract_table_2 =
                    '<tr>' +
                    '<th style="padding-left: 0;">' + artist_name + '</th>' +
                    '<td>' + personal_price_input + ' 원</td>' +
                    '<td style="width: 72px; padding-right: 0;" id="contract_' + USER_NO + '">' +
                    stat_chk +
                    '</td>' +
                    '</tr>';
                $('.btad_contract_table_2').append(btad_contract_table_2);

                /////////////////////////
                sessionStorage.setItem("btad_offerprice", OFFERPRICE);
                OFFERPRICE = OFFERPRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 
                offprice = OFFERPRICE;
                $('.btad_total_price_container').empty()
                var btad_total_price_container =
                    '<div class="btad_total_price_title">총 공연비</div>' +
                    '<div class="btad_total_price">' + OFFERPRICE + ' 원</div>';

                $('.btad_total_price_container').append(btad_total_price_container);

                // var btad_remain_price_con =
                //     '<div class="btad_total_price_title">잔여 공연비</div>' +
                //     '<div class="btad_total_price btad_remain_price">30,000 원</div>';

                // $('.btad_remain_price_con').append(btad_remain_price_con);

                sessionStorage.setItem('btad_offerprice', OFFERPRICE);
            }).promise().done(function () {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });

                $("input[name=btad_contract_check]").prop("checked", true);

                if (isNaN(offprice)) {
                    offprice = offprice.replace(/[^\d]+/g, '');   //콤마제거
                    offprice = parseInt(offprice);
                }
                // console.log(offprice);
                // console.log(typeof (offprice));
                var input_price_arr = [];
                $('.btad_personal_price_input').each(function () {
                    var input_price = $(this).val().replace(/[^\d]+/g, '');     //콤마제거
                    if (input_price == '') {
                        input_price = 0;
                    }
                    input_price = parseInt(input_price);
                    input_price_arr.push(input_price);
                });
                var input_total_price = 0;
                for (i = 0; i < input_price_arr.length; i++) {
                    var i_price = input_price_arr[i];
                    input_total_price = input_total_price + i_price;
                }
                // console.log(input_total_price);
                var final_price = offprice - input_total_price;
                final_price = String(final_price).replace(/\B(?=(\d{3})+(?!\d))/g, ",");    // 콤마 다시 추가

                var btad_remain_price_con =
                    '<div class="btad_total_price_title">잔여 공연비</div>' +
                    '<div class="btad_total_price btad_remain_price">' + final_price + ' 원</div>';

                $('.btad_remain_price_con').append(btad_remain_price_con);

                // console.log(btad_personal_price);

                var user_no_2 = $('#user_no').val();
                contract_chk = Array.from(new Set(contract_chk));
                // console.log(contract_chk);
                if ((contract_chk.length == 1 && contract_chk[0] == "3")) {
                    $('.btad_contract_check').remove();
                    $('.btad_contract_check_label').remove();
                    $('.btad_art_name').css('width', '73px');
                    $('.btad_personal_price_input').css('border', '0px');
                    $('.btad_personal_price_input').prop('readonly', true);
                    $('.btad_remain_price_con').remove();
                    // console.log("서명 다했대");
                    var btad_footer =
                        '<div class="btad_footer_e_contract_view_contract" onclick="go_view_contract()" style="border-top: 1px solid #E4E4EA;">' +
                        '계약서 보기' +
                        '</div>';
                    $('.btad_footer').append(btad_footer);
                } else {
                    // console.log("아직 못했대");
                    if ($('#contract_' + user_no_2).find('.btad_contract_check_span').text() == '서명 완료') {
                        var btad_footer =
                            '<div class="btad_footer_e_contract_complete_contract">' +
                            '서명 완료' +
                            '</div>';
                        $('.btad_footer').append(btad_footer);
                    } else {
                        var btad_footer =
                            '<div class="btad_footer_e_contract" onclick="go_esign_artist()">' +
                            '전자 계약 서명하기' +
                            '</div>';
                        $('.btad_footer').append(btad_footer);
                    }
                }
            });
        },//end success
        error: function (xhr, message, errorThrown) {
            //hideLoading();
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
        } // end error
    });

    // var user_no_hidden = $('#user_no').val();
    // var btad_personal_price = $('#btad_personal_price_input_' + user_no_hidden).val();

    // console.log(btad_personal_price);

    // var btad_footer =
    //     '<div class="btad_footer_e_contract" onclick="go_esign_artist()">' +
    //     '전자 계약 서명하기' +
    //     '</div>';
    // $('.btad_footer').append(btad_footer);
}

// 공연 종료 버튼
function btad_endPerform() {
    var perform_no = sessionStorage.getItem('es_con_perform_no');

    var user_no = $('#user_no').val();

    var now = new Date();
    var year = now.getFullYear();
    var month = now.getMonth() + 1;
    month = String(month);
    if (month.length == 1) {
        month = '0' + month;
    }
    var date = now.getDate();
    date = String(date);
    if (date.length == 1) {
        date = '0' + date;
    }
    var end_perform_date = year + '-' + month + '-' + date;

    // console.log(perform_no);
    // console.log(user_no);
    // console.log(end_perform_date);

    $.ajax({
        type: "POST",//url: "JSON/test.json",
        cache: false,
        url: '/service/busking_time_contract/set_end_perform.jsp',
        data: {
            perform_no: perform_no,
            user_no: user_no,
            end_perform_date, end_perform_date
        },
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function (i) {
                var END_PERFORM_USER_NO = $(this).find("END_PERFORM_USER_NO").text();
                var END_PERFORM_DATE = $(this).find("END_PERFORM_DATE").text();
                var ARTIST_NAME = $(this).find("ARTIST_NAME").text();

                $('.btad_perform_info_container').empty();

                var btad_perform_info_container =
                    '<div class="btad_info_title btad_perform_info_title">' +
                    '<p>공연 정보</p>' +
                    '<p class="content" style="font: normal normal normal 12px/24px SpoqaHanSans; letter-spacing: -0.5px; color: #999999; margin-left: 6px;">공연 종료</p>' +
                    '</div>' +
                    '<div class="btad_perform_info_notice">' +
                    '<p>공연이 정상적으로 종료되었습니다.</p>' +
                    '<p>사업주에게 공연비 지급 요청 메세지가 전달됩니다.</p>' +
                    '</div>' +
                    '<div class="btad_perform_info_notice_2">' +
                    '<p>팀원중 한명이라도 종료버튼을 누르면 팀원 모두 자동 종료 처리됩니다.</p>' +
                    '</div>' +
                    '<div class="btad_perform_info_endPerform_btn">' +
                    '공연종료' +
                    '</div>' +
                    '<div class="btad_endPerform_who">' +
                    '<p>' + END_PERFORM_DATE + ' ' + ARTIST_NAME + '님이 공연종료 확인하셨습니다</p>' +
                    '</div>';

                $('.btad_perform_info_container').append(btad_perform_info_container);

            })
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
            $.ajax({
                type: "POST",//url: "JSON/test.json",
                cache: false,
                url: '/service/push_perform_contract/owner_end_perform.jsp',
                //data : data,
                data: {
                    perform_no: perform_no
                },
                dataType: "xml",
                timeout: 30000,
                success: function (data) {
                    // console.log("여기까지 옴");
                }
            })
            // showLoading('hide', '등록중입니다');
        }
    });
}

// 아티스트에게 서명요청 푸쉬
function btad_contract_check(user_no, perform_no) {
    var result = confirm('해당 아티스트에게 서명요청을 하시겠습니까?');

    if (result) {
        console.log("확인")
        $.ajax({
            type: "POST",//url: "JSON/test.json",
            cache: false,
            url: '/service/push_perform_contract/art_request_contract.jsp',
            //data : data,
            data: {
                perform_no: perform_no,
                user_no: user_no
            },
            dataType: "xml",
            timeout: 30000,
            success: function (data) {
                // console.log("여기까지 옴");
            }
        });
    } else {
        console.log("취소")
    }
}


function go_contract_cancel_pop() {
    $('#contract_cancel_popup').load('/app_root/jsp/custom_select_box/contract_cancel_popup.jsp', function () {
        $("html, body").css({ "overflow": "hidden", "height": "100%" });

        $('#contract_cancel_popup').show();

        $('#header').hide();
        $('#footer').hide();
    });
}

// 계약취소 팝업 닫기
function close_ccp_popup() {
    $("html, body").css({ "overflow": "auto", "height": "auto" });
    $('#contract_cancel_popup').unbind('touchmove');

    $('#contract_cancel_popup').hide();

    $('#header').show();
    $('#footer').show();
}

