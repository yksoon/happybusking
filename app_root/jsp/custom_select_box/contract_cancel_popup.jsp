<!DOCTYPE html>
<%@page import="db.dbconn" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <div id="contract_cancel_pop">
            <div class="ccp_body" id="ccp_body">
                <div class="ccp_body_content">
                    <div class="ccp_close">
                        <img class="ccp_close_btn" src="/img/custom_select_box/close_popup.svg"
                            onclick="close_ccp_popup()" />
                    </div>
                    <div class="ccp_title">
                        <p>계약 취소 요청을</p>
                        <p>하시겠습니까?</p>
                    </div>
                    <div class="ccp_message">
                        <p>계약취소가 필요한 경우</p>
                        <p>연락처 또는 이메일로 연락주세요</p>
                    </div>
                    <div class="ccp_contact_table_container">
                        <table class="ccp_contact_table">
                            <tr>
                                <th style="padding-top: 16px; padding-bottom: 8px;">연락처</th>
                                <td style="padding-top: 16px; padding-bottom: 8px;">02-780-2328</td>
                            </tr>
                            <tr>
                                <th style="padding-bottom: 16px; padding-top: 8px;">이메일</th>
                                <td style="padding-bottom: 16px; padding-top: 8px;">contact@happybusking.com</td>
                            </tr>
                        </table>
                    </div>
                    <div class="ccp_notice">
                        <p>단, 계약취소는 공연일로부터 7일이전 가능하며</p>
                        <p>특별한 사유발생시 당사자가 인정하거나</p>
                        <p>사전에 협의된 경우 취소처리 가능</p>
                    </div>
                    <div class="ccp_confirm_btn_container">
                        <div class="ccp_confirm_btn" id="ccp_confirm_btn" onclick="close_ccp_popup()">
                            확인
                        </div>
                    </div>
                </div>
            </div>
        </div>