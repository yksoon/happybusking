<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="genre_select">
	<div class="ui-grid-b gs_header">
		<div class="ui-block-a gs_header_left" id="genre_select_back">
			<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
		</div>
		<div class="ui-block-b gs_header_center">
			<p class="common_header_text">
				장르선택	
			</p>
		</div>
		<div class="common_flex_container gs_main_genre_container">
			<div class="gs_mg_title gs_mg_on" id="gs_mg_music"><p>음악</p></div>
			<div class="gs_mg_title" id="gs_mg_dance"><p>댄스</p></div>
			<div class="gs_mg_title" id="gs_mg_performance"><p>퍼포먼스</p></div>
			<div class="gs_mg_title" id="gs_mg_tradition"><p>전통</p></div>
		</div>
	</div>
	<div class="gs_body" id="gs_body">
		<div class="gsb_group gs_mg_music">
			<div class="gsb_first_container">
				<p class="gsb_first_main_title">공연 형태</p>
				<p class="gsb_sub_title">1차 카테고리 선택(중복선택 가능)</p>
				<div class="common_flex_container gsb_list" id="music_type">
				
				</div>
			</div>
			<div class="gsb_second_container" id="gsb_main_vocal">
				<p class="gsb_second_main_title">장르</p>
				<p class="gsb_sub_title">보컬 2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container gsb_list" id="music_vocal">
				
				</div>
			</div>
			<div class="gsb_second_container" id="gsb_main_instrument">
				<p class="gsb_second_main_title">악기</p>
				<p class="gsb_sub_title">연주 2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container gsb_list" id="music_instrument">
				
				</div>
			</div>
		</div>
		<div class="gsb_group gs_mg_dance">
			<div class="gsb_first_container">
				<p class="gsb_first_main_title">댄스</p>
				<p class="gsb_sub_title">1차 카테고리 선택(중복선택 가능)</p>
				<div class="common_flex_container gsb_list" id="dance_genre">
				
				</div>
			</div>
		</div>
		<div class="gsb_group gs_mg_performance">
			<div class="gsb_first_container">
				<p class="gsb_first_main_title">퍼포먼스</p>
				<p class="gsb_sub_title">1차 카테고리 선택(중복선택 가능)</p>
				<div class="common_flex_container gsb_list" id="performance_genre">
					
				</div>
			</div>
		</div>
		<div class="gsb_group gs_mg_tradition">
			<div class="gsb_first_container">
				<p class="gsb_first_main_title">노래</p>
				<p class="gsb_sub_title">1차 카테고리 선택(중복선택 가능)</p>
				<div class="common_flex_container gsb_list" id="tradition_music">
				</div>
			</div>
			<div class="gsb_first_container">
				<p class="gsb_first_main_title">연주</p>
				<p class="gsb_sub_title">1차 카테고리 선택(중복선택 가능)</p>
				<div class="common_flex_container gsb_list" id="tradition_play">
				</div>
			</div>
			<div class="gsb_first_container">
				<p class="gsb_first_main_title">춤</p>
				<p class="gsb_sub_title">1차 카테고리 선택(중복선택 가능)</p>
				<div class="common_flex_container gsb_list" id="tradition_dance">
				</div>
			</div>
		</div>
	</div>
	<div class="common_InsertBtnForm gs_footer" id="gs_footer">
		선택 완료
	</div>
</div>


