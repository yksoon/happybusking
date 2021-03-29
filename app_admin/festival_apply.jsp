<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<div class="koica_apply_container" id="koica_apply_container">
	<div class="kac_popup_background"></div>
	<div class="kac_popup">
		<p class="kacp_title">신청 공연</p>
		<p class="kacp_content" id="kacp_area"></p>
		<p class="kacp_title">이름</p>
		<p class="kacp_content" id="kacp_name"></p>
		<p class="kacp_title">생일</p>
		<p class="kacp_content" id="kacp_birth"></p>
		<p class="kacp_title">주소</p>
		<p class="kacp_content" id="kacp_addr"></p>
		<p class="kacp_title">이메일</p>
		<p class="kacp_content" id="kacp_email"></p>
		<p class="kacp_title">전화번호</p>
		<p class="kacp_content" id="kacp_tel"></p>
		<p class="kacp_title">팀이름</p>
		<p class="kacp_content" id="kacp_tname"></p>
		<p class="kacp_title">장르</p>
		<p class="kacp_content" id="kacp_genre"></p>
		<p class="kacp_title">팀구성</p>
		<p class="kacp_content" id="kacp_type"></p>
		<p class="kacp_title">팀 정보</p>
		<p class="kacp_content" id="kacp_info"></p>
		<p class="kacp_title">영상 URL</p>
		<p class="kacp_content" id="kacp_url"></p>
		<p class="kacp_title">신청일</p>
		<p class="kacp_content" id="kacp_date"></p>
	</div>
	<div class="kac_festival_change_popup">
		<table id="kac_fcp">
		</table>
	</div>
	<div class="kac_festival_insert_popup">
		<table id="kac_fip">
			<tr>
				<th>모집 공연 카테고리</th>
				<td><input type="text" id="frgubun" placeholder="ex) 코이카(서울)"></td>
			</tr>
			<tr>
				<th>모집 공연 이름</th>
				<td><input type="text" id="frname" placeholder="ex) 코이카(서울) 10월30일"></td>
			</tr>
		</table>
		<p class="kac_fip_btn" id="kac_fip_apply_btn">등록</p>
	</div>
	<div class="kac_btn_container">
		<p class="kac_btn" id="kac_change_btn">모집 공연 변경</p>
		<p class="kac_btn" id="kac_insert_btn">모집 공연 등록</p>
		<select id="kac_filter"></select>
	</div>
	<table class="kac_table">
	 	
	</table>
</div>