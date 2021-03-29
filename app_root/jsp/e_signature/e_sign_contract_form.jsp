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
            <script src="/js/jspdf.min.js"></script>

            <script type="text/javascript" src="/js/heartpay/e_signature/e_sign_contract_form.js?ver=1.1.3"></script>

            <link type="text/css" rel="stylesheet"
                href="/css/heartpay/e_signature/e_sign_contract_form.css?ver=1.0.9" />
        </head>

        <body style="display: inline-block;">
            <div>
                <div id="es_con_save">저장 <span id="ttttttt"></span></div>
            </div>
            <div class="es_con_all" id="es_con_all">

                <!-- 1장 -->
                <div class="es_con_form" id="es_con_form_1">
                    <img id="es_con_img_1" src="/img/contract_form/new_form-1.png" />

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

                <div style="width: 100%; height: 100%; position: fixed; background: white; top: 0px; left: 0px;">
                </div>

                <input data-role="none" type="hidden" id="contract_no" value="" />
            </div>
        </body>