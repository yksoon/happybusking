<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="manual_artist">	
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<div id = "manual_artist_content" data-role="content">
        <%-- <div class="ma_header_panel"> --%>
        <%-- <div class="ma_header"> --%>
            <ul class="ma_header">
                <li><div class="ma_header_t_on" id="ma_num1"><span class="ma_header_t_t_on">공연신청</span></div></li>
                <li><div class="ma_header_t_base" id="ma_num2"><span class="ma_header_t_t_base">공연신청 취소</span></div></li>
                <li><div class="ma_header_t_base" id="ma_num3"><span class="ma_header_t_t_base">전자계약</span></div></li>
                <li style="padding-right: 15px;"><div class="ma_header_t_base" id="ma_num4"><span class="ma_header_t_t_base">전자계약 PDF 다운로드</span></div></li>
            </ul> 
            <%-- <div class="ma_header_t_on" id="ma_num1"><span class="ma_header_t_t_on">공연신청</span></div>
            <div class="ma_header_t_base" id="ma_num2"><span class="ma_header_t_t_base">공연신청 취소</span></div>
            <div class="ma_header_t_base" id="ma_num3"><span class="ma_header_t_t_base">전자계약</span></div>
            <div class="ma_header_t_base" id="ma_num4"><span class="ma_header_t_t_base">전자계약 PDF 다운로드</span></div> --%>
        <%-- </div> --%>
        <%-- </div> --%>
        <div class="ma_content" id="ma_c_num1" style="display: block;">
            <div class="ma_content_box">
                <div class="ma_content_box_num">1</div>
                <div class="ma_content_box_title_a">공연 일정에서 ‘모집중인 공연’ 클릭</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c1_a.png"></div>
            </div>
            <div class="ma_content_box">
                <div class="ma_content_box_num">2</div>
                <div class="ma_content_box_title_a">공연 상세 페이지 내 ‘공연 신청’ 클릭</div>
                <div class="ma_content_box_title_b">OR 공연 상세페이지 내 일정탭에서 신청 가능한 공연 클릭</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c1_b.png"></div>
            </div>
            <div class="ma_content_box">
                <div class="ma_content_box_num">3</div>
                <div class="ma_content_box_title_a">공연 정보 및 공연비 입력 후 공연 신청</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c1_c.png"></div>
            </div>
            <div class="ma_content_box">
                <div class="ma_content_box_num">4</div>
                <div class="ma_content_box_title_a">버스킹 공간 정보 자세히 보기</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c1_d.png"></div>
            </div>
            <div class="ma_content_box" style="margin-bottom: 69px;">
                 <div class="ma_content_box_num">5</div>
                <div class="ma_content_box_title_a">공연 신청 완료</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c1_e.png"></div>
            </div>
        </div>
        <div class="ma_content" id="ma_c_num2" style="display: none;">
            <div class="ma_content_box">
                <div class="ma_content_box_num">1</div>
                <div class="ma_content_box_title_a">신청한 공연의 상세페이지에서 신청취소</div>
                <div class="ma_content_box_title_b">OR 공연신청/계약이력 페이지에서 신청취소</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c2_a.png"></div>
            </div>
            <div class="ma_content_box">
                <div class="ma_content_box_num">2</div>
                <div class="ma_content_box_title_a">공연 신청 취소하기</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c2_b.png"></div>
            </div>
            <div class="ma_content_box" style="margin-bottom: 69px;">
                <div class="ma_content_box_num">3</div>
                <div class="ma_content_box_title_a">신청 취소 완료</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c2_c.png"></div>
            </div>
        </div>
        <div class="ma_content" id="ma_c_num3" style="display: none;">
            <div class="ma_content_box">
                <div class="ma_content_box_num">1</div>
                <div class="ma_content_box_title_a">공연신청/계약이력의 계약 대기중 일정 클릭</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c3_a.png"></div>
            </div>
            <div class="ma_content_box">
                <div class="ma_content_box_num">2</div>
                <div class="ma_content_box_title_a">전자 계약 서명</div>
                <div class="ma_content_box_title_b">서명 전 금액 변경 가능, 잔여공연비가 0원이어야 서명 가능</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c3_b.png"></div>
            </div>
            <div class="ma_content_box" style="margin-bottom: 69px;">
                <div class="ma_content_box_num">3</div>
                <div class="ma_content_box_title_a">계약서 작성 및 서명</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c3_c.png"></div>
            </div>
        </div>
        <div class="ma_content" id="ma_c_num4" style="display: none;">
            <div class="ma_content_box">
                <div class="ma_content_box_num">1</div>
                <div class="ma_content_box_title_a">공연신청/계약이력의 계약완료 일정 클릭</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c4_a.png"></div>
            </div>
            <div class="ma_content_box">
                <div class="ma_content_box_num">2</div>
                <div class="ma_content_box_title_a">‘계약서 보기’ 클릭</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c4_b.png"></div>
            </div>
            <div class="ma_content_box" style="margin-bottom: 69px;">
                <div class="ma_content_box_num">3</div>
                <div class="ma_content_box_title_a">전자계약서 확인 및 PDF 다운로드 클릭</div>
                <div class="ma_content_box_img"><img class="ma_content_img" src="/img/manual_artist/manual_artist_c4_c.png"></div>
            </div>
        </div>
    </div>
</div>