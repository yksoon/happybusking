<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE>
<script type="text/javascript" src="/js/jquery/jquery-1.11.3.min.js" ></script>
<script type="text/javascript" src="/js/admin/artist_info.js" ></script>

<div class="artist_info_container" id="artist_info_container">

	<input type="text" id="aic_search" placeholder="팀명 검색">
	
	<table class="aic_table">
	  <tr>
	  	<th>카운트</th>
	    <th>아이디</th>
		<th class="aic_nickname_table">닉네임</th>
		<th>아티스트명</th>
		<th class="aic_tcreate_chk_table" style="min-width: 130px;">팀생성여부(클릭시 정렬)</th>
		<th class="aic_phone_table">연락처</th>
		<th class="">아티스트 소개</th>
	  </tr>
	</table>
	
	<div class="aic_popup">
		<input type="hidden" id="uno">
		<input type="hidden" id="aname">
		
		<div class="aic_title"><p id="artist_name"></p>님이 속한 팀</div>
		
		<table id="aic_table">
			
		</table>
		
		<span id="aic_popup_close">닫기</span>
	</div>
</div>

