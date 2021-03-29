<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="area_select">
	<div class="ui-grid-b gs_header">
		<div class="ui-block-a as_header_left" id="area_select_back">
			<img class="common_header_backbtn" src="/img/header/h_back_icon.svg">
		</div>
		<div class="ui-block-b as_header_center">
			<p class="common_header_text">
				지역선택	
			</p>
		</div>
	</div>
	<div class="as_body" id="as_body">
		<div class="asb_group as_sido">
			<div class="asb_first_container">
				<p class="asb_first_main_title">시/도</p>
				<p class="asb_sub_title">1차 카테고리 선택(중복선택 가능)</p>
				<div class="common_flex_container asb_list" id="si_do">
					
				</div>
			</div>
			<div class="asb_second_container 13">
				<p class="asb_second_main_title">강원</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 3">
				<p class="asb_second_main_title">경기</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 14">
				<p class="asb_second_main_title">경남</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 15">
				<p class="asb_second_main_title">경북</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 8">
				<p class="asb_second_main_title">광주</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 7">
				<p class="asb_second_main_title">대구</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 5">
				<p class="asb_second_main_title">대전</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 2">
				<p class="asb_second_main_title">부산</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 1">
				<p class="asb_second_main_title">서울</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 6">
				<p class="asb_second_main_title">울산</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 4">
				<p class="asb_second_main_title">인천</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 11">
				<p class="asb_second_main_title">전남</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 12">
				<p class="asb_second_main_title">전북</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 16">
				<p class="asb_second_main_title">제주</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 9">
				<p class="asb_second_main_title">충남</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
			<div class="asb_second_container 10">
				<p class="asb_second_main_title">충북</p>
				<p class="asb_sub_title">2차 카테고리(중복선택 가능)</p>
				<div class="common_flex_container asb_list">
					
				</div>
			</div>
		</div>
	</div>
	<div class="common_InsertBtnForm gs_footer" id="as_footer">
		선택 완료
	</div>
</div>


