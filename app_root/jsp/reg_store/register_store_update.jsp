<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">

<%-- css/js including --%>
<%@include file="/importhaed.jsp" %>
<%@include file="/importhead3.jsp" %>

<%-- page 부분 --%>
<div data-role="page" id="busking_store_update" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%-- panel 부분 --%>
    <%@include file="/app_root/jsp/panel/panel.jsp" %>
    <%@include file="/app_root/jsp/common/resize_image.jsp" %>
    <div class="custom_select_popup" id="genre_select_popup" style="display: none;"></div>
    <div id="busking_store_reg_content" data-role="content" >
	<input type="hidden" id="user_no" value="<%=USER_NO%>"/>
    <input type="hidden" id="perform_no" />
    <input type="hidden" id="artist_matching" />
		<p class="rb_semiTitle_A">상업 공간 소개</p><div class="busking_store_button_A" id="busking_store_a_button" name="plus"></div>
        <div class="busking_store_a" style="display: none;">
            <div class="common_form_main_title">
                상호명
            </div>
            <div class="common_form_input_div">
                <input type="text" id="business_workname" placeholder="상호명 입력" maxlength='20'>
            </div>
            <div class="common_form_main_title">
                대표자명
            </div>
            <div class="common_form_input_div">
                <input type="text" id="business_representive" placeholder="대표자명 입력" maxlength='10'>
            </div>
            <div class="common_form_main_title">
                사업자번호
            </div>
            <div class="common_form_input_div">
                <input type="text" id="business_no" placeholder="사업자 번호 입력" maxlength='12'>
            </div>
            <div class="common_form_main_title">
                주소
            </div>
            <div class="common_form_input_div common_flex_container">
                <div class="common_form_input_div_left">
                    <input type="hidden" id="postcode">
                    <input type="text" id="address" placeholder="우편번호" maxlength='30'>
                </div>
                <div class="common_form_input_div_right" id="brc_addrsearch_btn" onclick="open_execDaumPostcode('addr_layer');">
                    <p>주소검색</p>
                </div>
                <input type="hidden" id="latlng">
            </div>
            <div class="common_form_input_div">
                <input type="text" id="address_detail" placeholder="상세주소를 입력해주세요" maxlength='20'> 
            </div>
            <div class="common_form_main_title">
                연락처
            </div>
            <div class="common_form_input_div">
                <input type="text" id="business_phone" placeholder="연락처 입력" maxlength='13'>
            </div>

            <%-- 버스킹존 등록(buskingzone_reg.jsp)에서 이미지 4개
            등록하는 소스 활용해서 10개로 변경해 추가할 것(공간사진/무대사진/메뉴판) --%>
            <div class="common_form_main_title">
                공간사진(첫번째 사진은 대표사진으로 설정됩니다)
            </div>
            <div class="ui-grid-a common_form_input_div brc_main_image_container" style="display: flex;">
                <div class="st_ui_img_a" id="brc_space_image_btn_div">
                    <div class="boxing_img_upload">
                        <img src="/img/reg_store/img_upload.svg" />
                        (<span id="upload_img_amount_sp">0</span>/10)
                    </div>
                    <%-- <img src="/img/common/plus_btn.png"> --%>
                </div>
                <div class="st_ui_img_b" id="bdc_pfsc_ing_body">
                    <ul id="bdc_pfsc_ing_ul">
                        <li>
                            <div id="img_cancel" name="sp_1" style="display: none">
                            </div>
                            <div class="bdc_image_div">
                                <img id="bi-main_sp1" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  height:84px; opacity: 1; display:none">
                            </div>
                        </li>
                        <li>
                            <div id="img_cancel" name="sp_2" style="display: none">
                            </div>
                            <div class="bdc_image_div">
                                <img id="bi-main_sp2" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  height:84px; opacity: 1; display:none">
                            </div>
                        </li>
                        <li>
                            <div id="img_cancel" name="sp_3" style="display: none">
                            </div>
                            <div class="bdc_image_div">
                                <img id="bi-main_sp3" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px; height:84px; opacity: 1; display:none">
                            </div>
                        </li>
                        <li>
                            <div id="img_cancel" name="sp_4" style="display: none">
                            </div>
                            <div class="bdc_image_div">
                                <img id="bi-main_sp4" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px; height:84px; opacity: 1; display:none">
                            </div>
                        </li>
                        <li>
                            <div id="img_cancel" name="sp_5" style="display: none">
                            </div>
                            <div class="bdc_image_div">
                                <img id="bi-main_sp5" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  height:84px; opacity: 1; display:none">
                            </div>
                        </li>
                        <li>
                            <div id="img_cancel" name="sp_6" style="display: none">
                            </div>
                            <div class="bdc_image_div">
                                <img id="bi-main_sp6" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px; height:84px; opacity: 1; display:none">
                            </div>
                        </li>
                        <li>
                            <div id="img_cancel" name="sp_7" style="display: none">
                            </div>
                            <div class="bdc_image_div">
                                <img id="bi-main_sp7" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  height:84px; opacity: 1; display:none">
                            </div>
                        </li>
                        <li>
                            <div id="img_cancel" name="sp_8" style="display: none">
                            </div>
                            <div class="bdc_image_div">
                                <img id="bi-main_sp8" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  height:84px; opacity: 1; display:none">
                            </div>
                        </li>
                        <li>
                            <div id="img_cancel" name="sp_9" style="display: none">
                            </div>
                            <div class="bdc_image_div">
                                <img id="bi-main_sp9" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  height:84px; opacity: 1; display:none">
                            </div>
                        </li>
                        <li>
                            <div id="img_cancel" name="sp_10" style="display: none">
                            </div>
                            <div class="bdc_image_div">
                                <img id="bi-main_sp10" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px; height:84px; opacity: 1; display:none">
                            </div>
                        </li>
                    </ul>
                </div>
                <input type="file" id="space_picture" style="display: none" accept="image/*" data-role="none">
                <input type="hidden" id="fname_sp1" />
                <input type="hidden" id="fname_sp2" />
                <input type="hidden" id="fname_sp3" />
                <input type="hidden" id="fname_sp4" />
                <input type="hidden" id="fname_sp5" />
                <input type="hidden" id="fname_sp6" />
                <input type="hidden" id="fname_sp7" />
                <input type="hidden" id="fname_sp8" />
                <input type="hidden" id="fname_sp9" />
                <input type="hidden" id="fname_sp10" />
            </div>

            <%-- 버스킹존 등록(buskingzone_reg.jsp)에서 이미지 4개
            등록하는 소스 활용해서 10개로 변경해 추가할 것(공간사진/무대사진/메뉴판) --%>
            <div class="common_form_main_title">
                무대사진
            </div>
            <div class="ui-grid-a common_form_input_div brc_main_image_container" style="display: flex;">
                <div class="st_ui_img_a" id="brc_stage_image_btn_div">
                    <div class="boxing_img_upload">
                        <img src="/img/reg_store/img_upload.svg" />
                        (<span id="upload_img_amount_st">0</span>/10)
                    </div>
                    <%-- <img src="/img/common/plus_btn.png"> --%>
                </div>
                <div class="st_ui_img_b" id="bdc_pfsc_ing_body">
                <ul id="bdc_pfsc_ing_ul_st">
                    <li>
                        <div id="img_cancel" name="st_1" style="display: none">
                        </div>
                        <div class="bdc_image_div">
                            <img id="bi-main_st1"  src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  height:84px; opacity: 1; display:none">
                        </div>
                    </li>
                    <li>
                        <div id="img_cancel" name="st_2" style="display: none">
                        </div>
                        <div class="bdc_image_div">
                            <img id="bi-main_st2" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px; height:84px; opacity: 1; display:none">
                        </div>
                    </li>
                    <li>
                        <div id="img_cancel" name="st_3" style="display: none" >
                        </div>
                        <div class="bdc_image_div">
                            <img id="bi-main_st3" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  height:84px; opacity: 1; display:none">
                        </div>
                    </li>
                    <li>
                        <div id="img_cancel" name="st_4" style="display: none">
                        </div>
                        <div class="bdc_image_div">
                            <img id="bi-main_st4" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  height:84px; opacity: 1; display:none">
                        </div>
                    </li>
                    <li>
                        <div id="img_cancel" name="st_5" style="display: none">
                        </div>
                        <div class="bdc_image_div">
                            <img id="bi-main_st5" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  height:84px; opacity: 1; display:none">
                        </div>
                    </li>
                    <li>
                        <div id="img_cancel" name="st_6" style="display: none">
                        </div>
                        <div class="bdc_image_div">
                            <img id="bi-main_st6" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  height:84px; opacity: 1; display:none">
                        </div>
                    </li>
                    <li>
                        <div id="img_cancel" name="st_7" style="display: none">
                        </div>
                        <div class="bdc_image_div">
                            <img id="bi-main_st7" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  none; height:84px; opacity: 1; display:none">
                        </div>
                    </li>
                    <li>
                        <div id="img_cancel" name="st_8" style="display: none">
                        </div>
                        <div class="bdc_image_div">
                            <img id="bi-main_st8" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  none; height:84px; opacity: 1; display:none">
                        </div>
                    </li>
                    <li>
                        <div id="img_cancel" name="st_9" style="display: none">
                        </div>
                        <div class="bdc_image_div">
                            <img id="bi-main_st9" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  none; height:84px; opacity: 1; display:none">
                        </div>
                    </li>
                    <li>
                        <div id="img_cancel" name="st_10" style="display: none">
                        </div>
                        <div class="bdc_image_div">
                            <img id="bi-main_st10" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px;  none; height:84px; opacity: 1; display:none">
                        </div>
                    </li>
                </ul>
                </div>
                <input type="file" id="stage_picture" style="display: none" accept="image/*" data-role="none">
                <input type="hidden" id="fname_st1" />
                <input type="hidden" id="fname_st2" />
                <input type="hidden" id="fname_st3" />
                <input type="hidden" id="fname_st4" />
                <input type="hidden" id="fname_st5" />
                <input type="hidden" id="fname_st6" />
                <input type="hidden" id="fname_st7" />
                <input type="hidden" id="fname_st8" />
                <input type="hidden" id="fname_st9" />
                <input type="hidden" id="fname_st10" />
            </div>
                
            <div class="common_form_main_title">
                공간소개
            </div>
            <div class="common_form_input_div">
                <textarea id="zone_info" placeholder="공간을 소개해주세요" maxlength='200'></textarea>
            </div>
            <div class="common_form_main_title">
                영업시간
            </div>
            <div class="common_form_input_div">
                <%-- <input type="text" id="operationhour" placeholder="영업 시간을 입력해주세요(ex)오전 10:00-오후11:00)"> --%>
                <select class="operationhour" id="open_hour" data-role="none">
                    <option value="00">00시</option>
                    <option value="01">01시</option>
                    <option value="02">02시</option>
                    <option value="03">02시</option>
                    <option value="04">04시</option>
                    <option value="05">05시</option>
                    <option value="06">06시</option>
                    <option value="07">07시</option>
                    <option value="08">08시</option>
                    <option value="09">09시</option>
                    <option value="10">10시</option>
                    <option value="11">11시</option>
                    <option value="12">12시</option>
                    <option value="13" selected="selected">13시</option>
                    <option value="14">14시</option>
                    <option value="15">15시</option>
                    <option value="16">16시</option>
                    <option value="17">17시</option>
                    <option value="18">18시</option>
                    <option value="19">19시</option>
                    <option value="20">20시</option>
                    <option value="21">21시</option>
                    <option value="22">22시</option>
                    <option value="23">23시</option>
                    <option value="24">24시</option>
                </select>
                <select class="operationhour" id="open_minute" data-role="none">
                    <option value="00" selected="selected">00분</option>
                    <option value="10">10분</option>
                    <option value="20">20분</option>
                    <option value="30">30분</option>
                    <option value="40">40분</option>
                    <option value="50">50분</option>
                </select>
                <div class="operationhour_text">~</div>
                <select class="operationhour" id="close_hour" data-role="none">
                    <option value="00">00시</option>
                    <option value="01">01시</option>
                    <option value="02" selected="selected">02시</option>
                    <option value="03">02시</option>
                    <option value="04">04시</option>
                    <option value="05">05시</option>
                    <option value="06">06시</option>
                    <option value="07">07시</option>
                    <option value="08">08시</option>
                    <option value="09">09시</option>
                    <option value="10">10시</option>
                    <option value="11">11시</option>
                    <option value="12">12시</option>
                    <option value="13">13시</option>
                    <option value="14">14시</option>
                    <option value="15">15시</option>
                    <option value="16">16시</option>
                    <option value="17">17시</option>
                    <option value="18">18시</option>
                    <option value="19">19시</option>
                    <option value="20">20시</option>
                    <option value="21">21시</option>
                    <option value="22">22시</option>
                    <option value="23">23시</option>
                    <option value="24">24시</option>
                </select>
                <select class="operationhour_end" id="close_minute" data-role="none">
                    <option value="00" selected="selected">00분</option>
                    <option value="10">10분</option>
                    <option value="20">20분</option>
                    <option value="30">30분</option>
                    <option value="40">40분</option>
                    <option value="50">50분</option>
                </select>
            </div>
            <div class="common_form_main_title">
                홍보 해시태그
            </div>
            <div class="common_form_input_div common_flex_container" style="position: relative;">
                <div class="common_form_input_div_left">
                    <input type="hidden" id="postcode">
                    <span class="hashtag_text">#</span><input type="text" id="hashtag" placeholder="홍보 해시태그를 추가해주세요" maxlength="10">
                </div>
                <%-- 해시태그 추가 버튼 --%>
                <div class="common_form_input_div_right" id="brc_addrsearch_btn" onclick="add_hashtag()">
                    <p>추가</p>
                </div>
            </div>
            <%-- 해시태그 생성 영역 --%>
            <div id="area_hashtag"></div>

            <%-- 버스킹존 등록(buskingzone_reg.jsp)에서 이미지 4개
            등록하는 소스 활용해서 10개로 변경해 추가할 것(공간사진/무대사진/메뉴판) --%>
            <div class="common_form_main_title">
                메뉴판 등록
            </div>
            <div class="ui-grid-a common_form_input_div brc_main_image_container" style="display: flex;">
                <div class="st_ui_img_a" id="brc_menu_image_btn_div">
                    <div class="boxing_img_upload">
                        <img src="/img/reg_store/img_upload.svg" />
                        (<span id="upload_img_amount_me">0</span>/1)
                    </div>
                    <%-- <img src="/img/common/plus_btn.png"> --%>
                </div>
                <div class="st_ui_img_b" id="bdc_pfsc_ing_body">
                    <ul id="bdc_pfsc_ing_ul_me">
                        <li>
                            <div id="img_cancel" name="me_1" style="display: none">
                            </div>
                            <div class="bdc_image_div">
                                <img id="bi-main_me1" src="/img/test/noimage.gif" alt="1번 사진은 대표사진입니다" style="width:84px; height:84px; opacity: 1; visibility: hidden;">
                            </div>
                        </li>
                    </ul>
                </div>
                <input type="file" id="menu" style="display: none" accept="image/*" data-role="none">
                <input type="hidden" id="fname_me1" />
            </div>
        </div>
		<p class="rb_semiTitle_B">버스킹 공간 정보</p><div class="busking_store_button_B" id="busking_store_b_button" name="plus"></div>
        <div class="busking_store_b" style="display: none;">
            <div class="common_form_main_title">
                지원장비
            </div>
            <div class="common_form_input_div">
                <textarea id="equipment" placeholder="가지고 계신 음향장비를 입력해주세요" maxlength='200'></textarea>
            </div>
            <div class="common_form_main_title">
                주차
            </div>
            <div class="wide_space_container">
                <div class="common_terms_container_alpha">
                    <div class="common_terms_check common_flex_container">
                            <input type="radio" name="parking_chk" id="parking_chk1" data-role="none" checked="checked">
                            <label for="parking_chk1"><span></span><div class="text_label_value">가능</div></label>
                    </div>
                </div>

                <div class="common_terms_container_alpha">
                    <div class="common_terms_check common_flex_container">
                            <input type="radio" name="parking_chk" id="parking_chk2" data-role="none">
                            <label for="parking_chk2"><span></span><div class="text_label_value">불가능</div></label>
                    </div>
                </div>
            </div>
            <div class="common_form_main_title">
                팁박스
            </div>
            <div class="wide_space_container">
                <div class="common_terms_container_alpha">
                    <div class="common_terms_check common_flex_container">
                            <input type="checkbox" name="tipbox_chk" id="tipbox_chk1" data-role="none" checked="checked">
                            <label for="tipbox_chk1"><span></span><div class="text_label_value">공연팁박스</div></label>
                    </div>
                </div>
                <div class="common_terms_container_alpha">
                    <div class="common_terms_check common_flex_container">
                            <input type="checkbox" name="tipbox_chk" id="tipbox_chk2" data-role="none">
                            <label for="tipbox_chk2"><span></span><div class="text_label_value">모바일팁박스</div></label>
                    </div>
                </div>
            </div>    
            <div class="common_form_main_title">
                장르
            </div>
            <div class="common_form_input_div">
                <%-- <input type="text" id="buskingzone_detailaddr" placeholder="장르를 입력해주세요"> --%>
                <input type="text" id="text_genre" placeholder="장르를 입력해주세요" readonly="readonly" onclick="viewGenreSelectBox();" style="opacity: 1;">
                <input type="hidden" id="select_genre">
                <input type="hidden" id="main_genre">
                <input type="hidden" id="add_genre">
            </div>
            <div class="common_form_main_title">영상촬영</div>
            <div class="wide_space_container">
                <div class="common_terms_container_alpha">
                    <div class="common_terms_check common_flex_container">
                            <input type="radio" name="video_chk" id="video_chk1" data-role="none" checked="checked">
                            <label for="video_chk1"><span></span><div class="text_label_value">가능</div></label>
                    </div>
                </div>
                <div class="common_terms_container_alpha">
                    <div class="common_terms_check common_flex_container">
                            <input type="radio" name="video_chk" id="video_chk2" data-role="none">
                            <label for="video_chk2"><span></span><div class="text_label_value">불가능</div></label>
                    </div>
                </div>
            </div>
		</div>
        <p class="rb_semiTitle_B">공연 모집 정보</p><div class="busking_store_button_C" id="busking_store_c_button" name="minus"></div>
        <div class="busking_store_c" >
            <div class="common_form_main_title">
                공연날짜
            </div>
            <div class="common_form_input_div">
                <input type="text" class="text_input date" id="re_perfom_date" value="" placeholder="날짜를 선택하세요" readonly />
            </div>
            <div class="common_form_main_title">
                공연시간
            </div>
           <div class="common_form_input_div">
               <div class="operationhour"><input type="text" class="time_input_text" id="start_time_input_hour" value="" inputmode="numeric" readonly data-role="none"/><span class="start_input_text">시</span></div>
               <div class="operationhour"><input type="text" class="time_input_text" id="start_time_input_min" value="" inputmode="numeric" readonly data-role="none"/><span class="start_input_text">분</span></div>
               <div class="operationhour_text">~</div>
               <div class="operationhour"><input type="text" class="time_input_text" id="end_time_input_hour" value="" inputmode="numeric" readonly data-role="none"/><span class="start_input_text">시</span></div>
               <div class="operationhour_end"><input type="text" class="time_input_text" id="end_time_input_min" value="" inputmode="numeric" readonly data-role="none"/><span class="start_input_text">분</span></div>
            </div>
            <div class="re_date perform_fee">
                <div class="common_form_main_title">
                 공연비
                </div>
                <div class="common_form_input_div_end">
                    <div class="money_input_text_div">
                        <input type="text" class="store_money_input_text" placeholder="공연비를 입력하세요" id="store_money_input_price" inputmode="numeric_a" data-role="none" />
                        <%-- <div class="money_input_text_won">원</div> --%>
                        <div class="money_input_text_cancel">
                        </div>
                    </div>    
                    <%-- <table class="perform_fee_table">
                        <tr>
                            <th class="money_title">금액</th>
                            <td class="money_input">
                                <input type="text" class="money_input_text" placeholder="공연비를 입력하세요" id="money_input_price" inputmode="numeric" />
                            </td>
                            <td class="money_won">원</td>
                        </tr>
                    </table> --%>
                </div>
            </div>
        </div>
        <input type="hidden" id="re_perfom_date_se" />
        <%-- <input type="hidden" id="re_perfom_date_se" />
        <input type="hidden" id="start_time_input_hour_se" />
        <input type="hidden" id="start_time_input_min_se" />
        <input type="hidden" id="end_time_input_hour_se" />
        <input type="hidden" id="end_time_input_min_se" />
         <input type="hidden" id="money_input_price_se" /> --%>
        <div class="button_registrations">
            <%-- <div class="button_registration_a">삭제 하기</div>
            <div class="button_registration_b">수정 완료</div> --%>
        </div>

		<!-- 주소찾기 팝업 레이어 -->
        <div id="addr_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
			<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode('addr_layer')" alt="닫기 버튼">
		</div>
        <!-- 약관 자세히보기 팝업 통합 -->
	    <div data-role="popup" class="common_trems_popup_container" id="terms_popup">
    </div>
</div>
</div>