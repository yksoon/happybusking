<!DOCTYPE html>
<%@page import="db.dbconn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>

<script>
// $(document).on('click', '#e_sign_save', function() {
//     PrintDiv($('#e_sign_form_4'));
// })

// function PrintDiv(div) {
//     var target = div[0];


//     html2canvas(target).then(function (canvas) { 
//         var myImage = canvas.toDataURL('image/png');
//         //console.log(div);
//         // console.log(myImage);
//         downloadURI(myImage, "저장이미지이름.png");
//     });
// }

// function downloadURI(uri, name) {
//     var link = document.createElement("a")
//     link.download = name;
//     link.href = uri;
//     document.body.appendChild(link);
//     link.click();
// }
</script>

<div id="e_sign_contract_2">
    <div class="es_con_form" id="es_con_form_1">
        <img class="e_sign_form" id="e_sign_form_1" src="">

        <%-- 사업주 이름 --%>
        <div class="es_con_owner_name_container">
            <input type="text" class="es_con_input es_con_owner_name" data-role="none" value="용광순" />
        </div>
        <%-- 아티스트 이름 --%>
        <div class="es_con_artist_name_container">
            <input type="text" class="es_con_input es_con_artist_name" data-role="none" value="아이유" />
        </div>

        <%-- 2조 1항 1호 --%>
        <div class="es_con_perform_name_container">
            <input type="text" class="es_con_input es_con_perform_name" data-role="none" value="용광순 라이브카페 공연" />
        </div>
        <%-- 2조 1항 2호 --%>
        <div class="es_con_perform_date_year_container">
            <input type="text" class="es_con_input es_con_perform_date_year" data-role="none" value="2021" />
        </div>
        <div class="es_con_perform_date_month_container">
            <input type="text" class="es_con_input es_con_perform_date_month" data-role="none" value="02" />
        </div>
        <div class="es_con_perform_date_day_container">
            <input type="text" class="es_con_input es_con_perform_date_day" data-role="none" value="22" />
        </div>
        <div class="es_con_perform_date_year_container es_con_end_year">
            <input type="text" class="es_con_input es_con_perform_date_year" data-role="none" value="2021" />
        </div>
        <div class="es_con_perform_date_month_container es_con_end_month">
            <input type="text" class="es_con_input es_con_perform_date_month" data-role="none" value="02" />
        </div>
        <div class="es_con_perform_date_day_container es_con_end_day">
            <input type="text" class="es_con_input es_con_perform_date_day" data-role="none" value="22" />
        </div>
        <%-- 2조 1항 3호 --%>
        <div class="es_con_perform_noft_container">
            <input type="text" class="es_con_input es_con_perform_noft" data-role="none" value="1 회" />
        </div>
        <%-- 2조 1항 4호 --%>
        <div class="es_con_perform_place_container">
            <input type="text" class="es_con_input es_con_perform_place" data-role="none" value="경기도 고양시 일산동구 정발산로196번길 8-4" />
        </div>
        <%-- 2조 1항 5호 --%>
        <div class="es_con_perform_time_sHour_container">
            <input type="text" class="es_con_input es_con_perform_time_sHour" data-role="none" value="19" />
        </div>
        <div class="es_con_perform_time_sMin_container">
            <input type="text" class="es_con_input es_con_perform_time_sMin" data-role="none" value="00" />
        </div>
        <div class="es_con_perform_time_sHour_container es_con_time_eHour">
            <input type="text" class="es_con_input es_con_perform_time_eHour" data-role="none" value="20" />
        </div>
        <div class="es_con_perform_time_sMin_container es_con_time_eMin">
            <input type="text" class="es_con_input es_con_perform_time_eMin" data-role="none" value="00" />
        </div>

        <%-- 3조 --%>
        <div class="es_con_perform_date_year_container es_3rd_sYear">
            <input type="text" class="es_con_input es_con_perform_date_year" data-role="none" value="2021" />
        </div>
        <div class="es_con_perform_date_month_container es_3rd_sMonth">
            <input type="text" class="es_con_input es_con_perform_date_month" data-role="none" value="02" />
        </div>
        <div class="es_con_perform_date_day_container es_3rd_sDay">
            <input type="text" class="es_con_input es_con_perform_date_day" data-role="none" value="22" />
        </div>
        <div class="es_con_perform_date_year_container es_con_end_year es_3rd_eYear">
            <input type="text" class="es_con_input es_con_perform_date_year" data-role="none" value="2021" />
        </div>
        <div class="es_con_perform_date_month_container es_con_end_month es_3rd_eMonth">
            <input type="text" class="es_con_input es_con_perform_date_month" data-role="none" value="02" />
        </div>
        <div class="es_con_perform_date_day_container es_con_end_day es_3rd_eDay">
            <input type="text" class="es_con_input es_con_perform_date_day" data-role="none" value="22" />
        </div>

        <%-- 4조 1항 --%>
        <div class="es_con_perform_noft_container es_con_perform_noft_container_2">
            <input type="text" class="es_con_input es_con_perform_noft" data-role="none" value="1" />
        </div>
        <div class="es_con_perform_pay_container">
            <input type="text" class="es_con_input es_con_perform_pay" data-role="none" value="200,000" />
        </div>
        <%-- 4조 2항 1호 --%>
        <div class="es_con_perform_bankname_container">
            <input type="text" class="es_con_input es_con_perform_bankname" data-role="none" value="카카오뱅크" />
        </div>
        <%-- 4조 2항 2호 --%>
        <div class="es_con_perform_bankNumber_container">
            <input type="text" class="es_con_input es_con_perform_bankNumber" data-role="none" value="110362726850" />
        </div>
        <%-- 4조 2항 3호 --%>
        <div class="es_con_perform_depositor_container">
            <input type="text" class="es_con_input es_con_perform_depositor" data-role="none" value="아이유" />
        </div>
    </div>

    <div class="es_con_form" id="es_con_form_2">
        <img class="e_sign_form" id="e_sign_form_2" src="">
    </div>

    <div class="es_con_form" id="es_con_form_3">
        <img class="e_sign_form" id="e_sign_form_3" src="">
        <%-- 10조 1항 --%>
        <div class="es_con_cancel_day_container">
            <input type="text" class="es_con_input es_con_cancel_day" data-role="none" value="14" />
        </div>
    </div>

    <div class="es_con_form" id="es_con_form_4">
        <img class="e_sign_form" id="e_sign_form_4" src="">
        <%-- 계약 날짜 --%>
        <div class="es_con_year_container">
            <input type="text" class="es_con_input es_con_year" data-role="none" value="2021" />
        </div>
        <div class="es_con_month_container">
            <input type="text" class="es_con_input es_con_month" data-role="none" value="02" />
        </div>
        <div class="es_con_day_container">
            <input type="text" class="es_con_input es_con_day" data-role="none" value="22" />
        </div>

        <%-- 대표자명 --%>
        <div class="es_con_owner_name_2_container">
            <input type="text" class="es_con_input es_con_owner_name_2" data-role="none" value="용광순" />
        </div>
        <%-- 단체명 --%>
        <div class="es_con_owner_company_2_container">
            <input type="text" class="es_con_input es_con_owner_company_2" data-role="none" value="용광순 라이브카페" />
        </div>
        <%-- 주소 --%>
        <div class="es_con_owner_adress_2_container">
            <textarea class="es_con_input es_con_owner_adress_2" data-role="none" value="">경기도 고양시 일산동구 정발산로196번길 8-4</textarea>
        </div>

        <%-- 아티스트 성명 --%>
        <div class="es_con_artist_name_2_container">
            <input type="text" class="es_con_input es_con_artist_name_2" data-role="none" value="아이유" />
        </div>
        <%-- 생년월일 --%>
        <div class="es_con_artist_birth_2_container">
            <input type="text" class="es_con_input es_con_artist_birth_2" data-role="none" value="1990년 11월 08일" />
        </div>
        <%-- 아티스트 주소 --%>
        <div class="es_con_artist_adress_2_container">
            <textarea class="es_con_input es_con_artist_adress_2" data-role="none" value="">경기도 고양시 일산동구 정발산로196번길 8-4</textarea>
        </div>
    </div>

    <button id="e_sign_save">저장하기</button>

    <div>
        <img id="test_img" src="">
    </div>
    </div>
