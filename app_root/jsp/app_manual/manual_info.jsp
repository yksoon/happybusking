<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="manual_info">	
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>

	<div id = "manual_info_content" data-role="content">

        <div class="mi_owner_container">
            <div class="mi_owner_content">
                <div class="mi_subtitle">
                    <p>서비스 소개</p>
                </div>
                <div class="mi_title">
                    <p>사업주 이용방법</p>
                </div>
                <div class="mi_button" id="mi_go_owner_btn">
                    자세히 보기 →
                </div>
            </div>
        </div>

        <div class="mi_midline"></div>

        <div class="mi_artist_container">
            <div class="mi_artist_content">
                <div class="mi_subtitle">
                    <p>서비스 소개</p>
                </div>
                <div class="mi_title">
                    <p>아티스트 이용방법</p>
                </div>
                <div class="mi_button" id="mi_go_artist_btn">
                    자세히 보기 →
                </div>
            </div>
        </div>

    </div>
</div>