<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="manual_owner">	
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<ul class="tabs">
			<li class="tab-link current" data-tab="tab-1" style="margin-left: 15px;">상업공간 등록</li>
			<li class="tab-link" data-tab="tab-2">공연모집 등록</li>
			<li class="tab-link" data-tab="tab-3">공연모집 수정</li>
			<li class="tab-link" data-tab="tab-4">공연승인 및 거절</li>
			<li class="tab-link" data-tab="tab-5">전자계약</li>
			<li class="tab-link" data-tab="tab-6">전자계약PDF 다운</li>
			<div style="width: 15px; display: inline-block; padding: 0 7px;"></div>
		</ul>
	<div id = "manual_owner_content" data-role="content" style="padding-top: 55px;">

		<!-- 상업공간 등록 -->
		<div id="tab-1" class="tab-content current">

			<div class="mo_word_container">
				<div class="mo_number">1</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>메인 페이지 ‘공연일정 이미지’ 클릭</p>
					</div>
					<div class="mo_subtitle">
						<p>OR 오른쪽에 있는 메뉴 아이콘 누른 후 ‘매장공연’ 클릭</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/1-1.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">2</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>‘공연 등록’ 버튼 클릭</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/1-2.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">3</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>상업 공간 및 버스킹 공간 등록</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/1-3.png" />
			</div>

			<div style="display: inline-block; height: 60px;">
			</div>
		</div>

		<!-- 공연모집 등록 -->
		<div id="tab-2" class="tab-content">

			<div class="mo_word_container">
				<div class="mo_number">1</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>상업공간 등록 후 ‘공연 등록’ 클릭</p>
					</div>
					<div class="mo_subtitle">
						<p>OR 오른쪽에 있는 메뉴 아이콘 누른 후 ‘공연 등록’ 클릭</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/2-1.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">2</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>공연일시 설정</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/2-2.png" />
			</div>
			
			<div class="mo_word_container">
				<div class="mo_number">3</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>날짜 선택</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/2-3.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">4</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>공연비 설정</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/2-4.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">5</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>공연팀 선택</p>
					</div>
					<div class="mo_subtitle">
						<p>지정팀 있는 경우만 해당, 없는 경우 바로 공연 등록</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/2-5.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">6</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>공연 등록 완료</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/2-6.png" />
			</div>

			<div style="display: inline-block; height: 60px;">
			</div>
		</div>

		<!-- 공연모집 수정 -->
		<div id="tab-3" class="tab-content">

			<div class="mo_word_container">
				<div class="mo_number">1</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>등록한 공연일정 페이지 ‘공연 수정하기’ 클릭</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/3-1.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">2</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>모집중인 공연 및 마감 공연 수정 가능</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/3-2.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">3</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>상업공간 및 버스킹 공간 수정 가능</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/3-3.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">4</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>수정 완료</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/3-4.png" />
			</div>

			<div style="display: inline-block; height: 60px;">
			</div>

		</div>


		<div id="tab-4" class="tab-content">

			<div class="mo_word_container">
				<div class="mo_number">1</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>공연신청/계약이력 ‘승인대기’공연 클릭</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/4-1.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">2</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>상세정보 확인 후 ‘공연승인 및 거절’ 클릭</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/4-2.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">3</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>승인 및 거절 완료</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/4-3.png" />
			</div>

			<div style="display: inline-block; height: 60px;">
			</div>

		</div>


		<div id="tab-5" class="tab-content">

			<div class="mo_word_container">
				<div class="mo_number">1</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>‘전자계약 대기’중인 공연 클릭</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/5-1.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">2</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>‘서명 요청’ 버튼 클릭하여 서명 요청</p>
					</div>
					<div class="mo_subtitle">
						<p>아티스트가 서명하지 않으면 전자계약 서명이 불가합니다</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/5-2.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">3</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>아티스트에게 알림 전송</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/5-3.png" />
			</div>

			<div style="display: inline-block; height: 60px;">
			</div>

		</div>


		<div id="tab-6" class="tab-content">

			<div class="mo_word_container">
				<div class="mo_number">1</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>전자계약이 완료된 공연 클릭</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/6-1.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">2</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>계약서 보기 클릭</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/6-2.png" />
			</div>

			<div class="mo_word_container">
				<div class="mo_number">3</div>
				<div class="mo_notice">
					<div class="mo_title">
						<p>전자계약서 확인 및 PDF 다운로드 클릭</p>
					</div>
				</div>
			</div>
			<div class="mo_img_div">
				<img class="mo_img" src="/img/app_manual/manual_owner/6-3.png" />
			</div>

			<div style="display: inline-block; height: 60px;">
			</div>

		</div>
    </div>
</div>