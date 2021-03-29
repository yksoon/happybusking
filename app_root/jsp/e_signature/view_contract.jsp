<!DOCTYPE html>
<%@page import="db.dbconn" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <meta charset="UTF-8">
        <%@include file="/importhaed.jsp" %>
                <%-- page 부분 --%>
                    <div data-role="page" id="view_contract">
                        <!-- header 부분 -->
                        <%@include file="/app_root/jsp/header/header.jsp" %>
                            <%@include file="/app_root/jsp/panel/panel.jsp" %>
                                <!-- content 부분 -->
                                <%-- <div id="view_contract_content" data-role="content"
                                    style="text-align:center; height: 100% !important;"> --%>

                                    <div class="vc_title">
                                    <div class="vc_refresh_text_div">
										<!-- <a href="http://116.126.142.192:8094/app_root/jsp/e_signature/123123123123.pdf">4test</a> -->
                                        <p class="vc_refresh_text">이미지가 제대로 출력되지 않은경우</p>
                                        <p class="vc_refresh_text">우측 새로고침 버튼을 눌러주세요</p>
                                        </div>
                                        <img src="/img/e_signature/refresh.svg" style="width: 24px; height: 24px;"
                                            id="vc_refresh" />
                                    </div>

                                    <div class="vc_img_container" id="vc_pdf_form">
                                        <!-- <img class="vc_img" src="/img/contract_form/new_form-1.png" />
                                        <img class="vc_img" src="/img/contract_form/new_form-1.png" /> -->
                                    </div>

                                    <input type="hidden" id="user_no" value="<%=USER_NO %>">
                                <%-- </div> --%>
								
                                <footer data-role="footer" data-position="fixed" data-tap-toggle="false" id="footer">
                                    <div class="common_InsertBtnForm vc_footer" id="vc_footer">
                                        계약서 PDF 다운로드
                                    </div>
                                </footer>

                    </div>