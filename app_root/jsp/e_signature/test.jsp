<!DOCTYPE html>
<%@page import="db.dbconn" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <meta charset="UTF-8">

        <head>
            <script type="text/javascript" src="/js/jquery/jquery-1.11.3.min.js"></script>
            <script type="text/javascript" src="/js/jquery.jqflipswitch.min.js"></script>
            <script
                src="https://cdn.rawgit.com/eligrey/FileSaver.js/5ed507ef8aa53d8ecfea96d96bc7214cd2476fd2/FileSaver.min.js"></script>
            <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
            <link type="text/css" rel="stylesheet"
                href="/css/heartpay/e_signature/e_sign_contract_form.css?ver=1.0.9" />
        </head>

        <body>
            <div>
                <div id="es_con_save">저장 <span id="ttttttt"></span></div>
            </div>
            <div class="es_con_all" id="es_con_all">

                <!-- 1장 -->
                <div class="es_con_form" id="es_con_form_1">
                    <img id="es_con_img_1" src="/img/contract_form/new_form.gif" />

                    <!-- 사업주 이름 -->
                    <div class="es_con_form_div es_con_form_1_ownerName">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_ownerName" value="" />
                    </div>
                    <!-- 아티스트 이름 -->
                    <div class="es_con_form_div es_con_form_1_artistName">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_artistName" value="" />
                    </div>
                    <!-- 2조 1항 1호 -->
                    <div class="es_con_form_div es_con_form_1_performName">
                        <input data-role="none" type="text" class="es_con_input performName" id="form_1_performName"
                            value="" />
                    </div>
                    <!-- 2조 1항 2호 -->
                    <div class="es_con_form_div es_con_form_1_performStartYear">
                        <input data-role="none" type="text" class="es_con_input performStartYear"
                            id="form_1_performStartYear" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_performStartMonth">
                        <input data-role="none" type="text" class="es_con_input performStartMonth"
                            id="form_1_performStartMonth" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_performStartDay">
                        <input data-role="none" type="text" class="es_con_input performStartDay"
                            id="form_1_performStartDay" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_performEndYear">
                        <input data-role="none" type="text" class="es_con_input performEndYear"
                            id="form_1_performEndYear" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_performEndMonth">
                        <input data-role="none" type="text" class="es_con_input performEndMonth"
                            id="form_1_performEndMonth" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_performEndDay">
                        <input data-role="none" type="text" class="es_con_input performEndDay" id="form_1_performEndDay"
                            value="" />
                    </div>
                    <!-- 2조 1항 3호 -->
                    <div class="es_con_form_div es_con_form_1_perform_no_of_time">
                        <input data-role="none" type="text" class="es_con_input" value="1" />
                    </div>
                    <!-- 2조 1항 4호 -->
                    <div class="es_con_form_div es_con_form_1_performAdress">
                        <input data-role="none" type="text" class="es_con_input performAdress" id="form_1_performAdress"
                            value="" />
                    </div>
                    <!-- 2조 1항 5호 -->
                    <div class="es_con_form_div es_con_form_1_performStartHour">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_performStartHour"
                            value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_performStartMin">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_performStartMin" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_performEndHour">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_performEndHour" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_performEndMin">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_performEndMin" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_perform_Min">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_perform_Min" value="" />
                    </div>
                    <!-- 3조 -->
                    <!-- <div class="es_con_form_div es_con_form_1_contractStartYear">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_contractStartYear"
                            value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_contractStartMonth">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_contractStartMonth"
                            value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_contractStartDay">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_contractStartDay"
                            value="" />
                    </div> -->
                    <!-- <div class="es_con_form_div es_con_form_1_contractEndYear">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_contractEndYear" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_contractEndMonth">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_contractEndMonth"
                            value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_contractEndDay">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_contractEndDay" value="" />
                    </div> -->
                    <!-- 4조 1항 -->
                    <div class="es_con_form_div es_con_form_1_performTime_2">
                        <input data-role="none" type="text" class="es_con_input" value="1" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_personalPrice">
                        <input data-role="none" type="text" class="es_con_input" id="form_1_personalPrice" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_bankName">
                        <input data-role="none" type="text" class="es_con_input form_1_bankName" id="form_1_bankName"
                            value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_bankNumber">
                        <input data-role="none" type="text" class="es_con_input form_1_bankNumber"
                            id="form_1_bankNumber" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_1_bankArtistName">
                        <input data-role="none" type="text" class="es_con_input form_1_bankArtistName"
                            id="form_1_bankArtistName" value="" />
                    </div>


                    <div class="es_con_form_div es_con_form_3_cancelDay">
                        <input data-role="none" type="text" class="es_con_input" value="14" />
                    </div>


                    <!-- 계약 날짜 -->
                    <div class="es_con_form_div es_con_form_4_contractDateYear">
                        <input data-role="none" type="text" class="es_con_input" id="form_4_contractDateYear"
                            value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_4_contractDateMonth">
                        <input data-role="none" type="text" class="es_con_input" id="form_4_contractDateMonth"
                            value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_4_contractDateDay">
                        <input data-role="none" type="text" class="es_con_input" id="form_4_contractDateDay" value="" />
                    </div>
                    <!-- 사업주 정보 -->
                    <div class="es_con_form_div es_con_form_4_ownerName">
                        <input data-role="none" type="text" class="es_con_input form_4_ownerName" id="form_4_ownerName"
                            value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_4_storeName">
                        <input data-role="none" type="text" class="es_con_input form_4_storeName" id="form_4_storeName"
                            value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_4_storeAdress">
                        <div contenteditable="true" id="EDITABLE">
                            <div class="es_con_input form_4_storeAdress" id="form_4_storeAdress" data-role="none"></div>
                        </div>
                    </div>
                    <!-- 아티스트 정보 -->
                    <div class="es_con_form_div es_con_form_4_artistName">
                        <input data-role="none" type="text" class="es_con_input form_4_artistName"
                            id="form_4_artistName" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_4_artistBirth">
                        <input data-role="none" type="text" class="es_con_input" id="form_4_artistBirth" value="" />
                    </div>
                    <div class="es_con_form_div es_con_form_4_artistAdress">
                        <div contenteditable="true" id="EDITABLE">
                            <div class="es_con_input form_4_artistAdress" id="form_4_artistAdress" data-role="none">
                            </div>
                        </div>
                    </div>

                    <div class="es_con_owner_sign_div">
                        <img class="es_con_owner_sign" id="es_con_owner_sign" src="" />
                    </div>

                    <div class="es_con_artist_sign_div">
                        <img class="es_con_artist_sign" id="es_con_artist_sign" src="" />
                    </div>
                </div>

                <div>
                    <img id="test_1" src="" />
                    <img id="test_2" src="" />
                    <img id="test_3" src="" />
                    <img id="test_4" src="" />

                    <img id="test_11" src="" />
                    <img id="test_22" src="" />
                </div>

                <!-- <div style="width: 100%; height: 100%; position: fixed; background: white; top: 0px; left: 0px;">
        </div> -->

                <input data-role="none" type="hidden" id="contract_no" value="" />
            </div>
        </body>
        <script>
            $(document).on('ready', function () {
                var contract_img = [];
                var perform_no = '2009141136039402202104011535';

                $.ajax({
                    type: "GET",
                    cache: false,
                    url: '/service/e_signature/get_e_contract_form.jsp',
                    data: {
                        perform_no: perform_no
                    },
                    async: false,
                    contentType: "application/xml; charset=utf-8",
                    dataType: "xml",
                    timeout: 30000,
                    beforeSend: function () {
                        // $.mobile.loading('show', { text: '계약서 작성중', textVisible: true, theme: 'a', html: "" });
                        // showLoadingBar()
                    },
                    success: function (data) {
                        var ROOT = $(data).find('ROOT');
                        var DATA = $(ROOT).find('DATA');

                        async function qweqwe() {

                            for (var t = 0; t < DATA.length; t++) {
                                var CONTRACT_NO = DATA[t].getElementsByTagName("CONTRACT_NO")[0].innerHTML;
                                var CONTRACT_EMPLOYER = DATA[t].getElementsByTagName("CONTRACT_EMPLOYER")[0].innerHTML;
                                var CONTRACT_ARTIST = DATA[t].getElementsByTagName("CONTRACT_ARTIST")[0].innerHTML;
                                var BUSINESS_WORKNAME = DATA[t].getElementsByTagName("BUSINESS_WORKNAME")[0].innerHTML;
                                var BUSKINGDATE = DATA[t].getElementsByTagName("BUSKINGDATE")[0].innerHTML;
                                var ADDRESS = DATA[t].getElementsByTagName("ADDRESS")[0].innerHTML;
                                var STARTINGTIME = DATA[t].getElementsByTagName("STARTINGTIME")[0].innerHTML;
                                var FINISHINGTIME = DATA[t].getElementsByTagName("FINISHINGTIME")[0].innerHTML;
                                var CONTRACT_PRICE = DATA[t].getElementsByTagName("CONTRACT_PRICE")[0].innerHTML;
                                var ART_BANK_NAME = DATA[t].getElementsByTagName("ART_BANK_NAME")[0].innerHTML;
                                var ART_BANK_NUMBER = DATA[t].getElementsByTagName("ART_BANK_NUMBER")[0].innerHTML;
                                var ART_BANK_USER = DATA[t].getElementsByTagName("ART_BANK_USER")[0].innerHTML;
                                var CONTRACT_DATE = DATA[t].getElementsByTagName("CONTRACT_DATE")[0].innerHTML;
                                var CONTRACT_RESIDENT_REG_NUM = DATA[t].getElementsByTagName("CONTRACT_RESIDENT_REG_NUM")[0].innerHTML;
                                var CONTRACT_ARTIST_ADDR = DATA[t].getElementsByTagName("CONTRACT_ARTIST_ADDR")[0].innerHTML;
                                var EMP_SIGN = DATA[t].getElementsByTagName("EMP_SIGN")[0].innerHTML;
                                var ARTIST_SIGN = DATA[t].getElementsByTagName("ARTIST_SIGN")[0].innerHTML;
                                var PERFORM_MIN = DATA[t].getElementsByTagName("PERFORM_MIN")[0].innerHTML;

                                $('#contract_no').val(CONTRACT_NO);
                                ////////////////////////form 1
                                $('#form_1_ownerName').val(CONTRACT_EMPLOYER);
                                $('#form_1_artistName').val(CONTRACT_ARTIST);
                                $('#form_1_performName').val(BUSINESS_WORKNAME + " 공연");

                                var busking_date = BUSKINGDATE.split('-');
                                var busking_date_year = busking_date[0];
                                busking_date_year = busking_date_year.substr(2, 2);
                                var busking_date_month = busking_date[1];
                                var busking_date_day = busking_date[2];
                                $('#form_1_performStartYear').val(busking_date_year);
                                $('#form_1_performStartMonth').val(busking_date_month);
                                $('#form_1_performStartDay').val(busking_date_day);
                                $('#form_1_performEndYear').val(busking_date_year);
                                $('#form_1_performEndMonth').val(busking_date_month);
                                $('#form_1_performEndDay').val(busking_date_day);

                                $('#form_1_performAdress').val(ADDRESS);

                                var perform_starting_time = STARTINGTIME.split(':');
                                var perform_starting_time_hour = perform_starting_time[0];
                                var perform_starting_time_min = perform_starting_time[1];
                                $('#form_1_performStartHour').val(perform_starting_time_hour);
                                $('#form_1_performStartMin').val(perform_starting_time_min);

                                var perform_finishing_time = FINISHINGTIME.split(':');
                                var perform_finishing_time_hour = perform_finishing_time[0];
                                var perform_finishing_time_min = perform_finishing_time[1];
                                $('#form_1_performEndHour').val(perform_finishing_time_hour);
                                $('#form_1_performEndMin').val(perform_finishing_time_min);

                                $('#form_1_perform_Min').val(PERFORM_MIN);

                                var shour = new Date(perform_starting_time_hour);
                                var smin = new Date(perform_starting_time_min);
                                var ehour = new Date(perform_finishing_time_hour);
                                var emin = new Date(perform_finishing_time_min);



                                $('#form_1_contractStartYear').val(busking_date_year);
                                $('#form_1_contractStartMonth').val(busking_date_month);
                                $('#form_1_contractStartDay').val(busking_date_day);
                                $('#form_1_contractEndYear').val(busking_date_year);
                                $('#form_1_contractEndMonth').val(busking_date_month);
                                $('#form_1_contractEndDay').val(busking_date_day);

                                var contract_price = CONTRACT_PRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 
                                $('#form_1_personalPrice').val(contract_price);

                                $('#form_1_bankName').val(ART_BANK_NAME);
                                $('#form_1_bankNumber').val(ART_BANK_NUMBER);
                                $('#form_1_bankArtistName').val(ART_BANK_USER);
                                ////////////////////////form 1 END

                                ////////////////////////form 4
                                var contract_date = CONTRACT_DATE.split('-');
                                var contract_date_year = contract_date[0];
                                var contract_date_month = contract_date[1];
                                var contract_date_day = contract_date[2];
                                $('#form_4_contractDateYear').val(contract_date_year);
                                $('#form_4_contractDateMonth').val(contract_date_month);
                                $('#form_4_contractDateDay').val(contract_date_day);

                                $('#form_4_ownerName').val(CONTRACT_EMPLOYER);
                                $('#form_4_storeName').val(BUSINESS_WORKNAME);
                                $('#form_4_storeAdress').text(ADDRESS);

                                $('#form_4_artistName').val(CONTRACT_ARTIST);

                                var artist_birth = CONTRACT_RESIDENT_REG_NUM.split('-');
                                artist_birth = artist_birth[0]
                                var artist_birth_sec = CONTRACT_RESIDENT_REG_NUM.split('-');
                                artist_birth_sec = artist_birth_sec[1].substr(0, 1)

                                //console.log(artist_birth_sec, typeof (artist_birth_sec));
                                var artist_birth_year = "";
                                if (artist_birth_sec === '1' || artist_birth_sec === '2') {
                                    artist_birth_year = '19' + artist_birth.substr(0, 2);
                                    //console.log("1900년대생");
                                }
                                else if (artist_birth_sec === '3' || artist_birth_sec === '4') {
                                    artist_birth_year = '20' + artist_birth.substr(0, 2);
                                    //console.log("2000년대생");
                                }
                                //console.log(artist_birth_year);
                                var artist_birth_month = artist_birth.substr(2, 2);
                                if (artist_birth_month.substr(0, 1) == '0') {
                                    artist_birth_month = artist_birth_month.substr(1, 1);
                                }
                                var artist_birth_day = artist_birth.substr(4, 2);
                                if (artist_birth_day.substr(0, 1) == '0') {
                                    artist_birth_day = artist_birth_day.substr(1, 1);
                                }
                                var artist_birth_2 = artist_birth_year + "년 " + artist_birth_month + "월 " + artist_birth_day + "일";
                                $('#form_4_artistBirth').val(artist_birth_2);

                                $('#form_4_artistAdress').text(CONTRACT_ARTIST_ADDR);

                                $('#es_con_owner_sign').attr('src', EMP_SIGN);
                                $('#es_con_artist_sign').attr('src', ARTIST_SIGN);
                                //console.log(CONTRACT_NO2);
                                //console.log(CONTRACT_EMPLOYER2);
                                //console.log(CONTRACT_ARTIST2);
                                //console.log(t);
                                // await es_con_screenshot_canvas();

                                // console.log($('#test_1').attr('src'));
                            }

                            // hideLoadingBar();
                            // location.replace("e_sign_complete_owner.jsp");

                        }

                        qweqwe();

                    },
                    complete: function () {
                        // $.mobile.loading('hide', { text: '계약서 작성중', textVisible: true, theme: 'a', html: "" });
                        // location.href = "e_sign_complete_owner.jsp";
                    }
                });
            });

            // 테스트 DB에서 잘 뽑아오는지......
            $(document).on('click', '#es_con_save', function () {
                // PrintDiv($('#es_con_form_1'));
                // for (i = 1; i <= 4; i++) {
                //     PrintDiv($('#es_con_form_' + i), i);
                // }
                $.ajax({
                    type: "GET",
                    cache: false,
                    url: '/service/e_signature/get_e_contract_form_final.jsp',
                    data: {
                        // perform_no: perform_no,
                        // user_no: user_no
                    },
                    contentType: "application/xml; charset=utf-8",
                    dataType: "xml",
                    timeout: 30000,
                    success: function (data) {
                        var ROOT = $(data).find('ROOT');
                        var DATA = $(ROOT).find('DATA');

                        $(DATA).each(function (i) {
                            var CONTRACT_1 = $(this).find("CONTRACT_1").text();
                            var CONTRACT_2 = $(this).find("CONTRACT_2").text();
                            var CONTRACT_3 = $(this).find("CONTRACT_3").text();
                            var CONTRACT_4 = $(this).find("CONTRACT_4").text();

                            $('#test_11').attr('src', CONTRACT_1);
                            $('#test_22').attr('src', CONTRACT_4);

                        })
                    }

                })
            });


        </script>


        </html>