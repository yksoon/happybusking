<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<%@include file="../importhead.jsp" %>
<body>
<div class="index_wapper">
	<div class="common_header">
		<img class="header_logo" id="header_logo" src="../img/koica_logo.svg">
	</div>
	<div class="common_body">
		<div class="cb_main_image">
			<img src="../img/survey_img.png">
		</div>
		
		<div class="cb_middel_container">
			<div class="dbmc_box" id="now_koica_btn">
				<p>지금 KOICA는?</p><img src="../img/plus.svg">
			</div>
			<div class="dbmc_box" id="koica_poll_btn">
				<p>설문조사참여</p><img src="../img/plus.svg">
			</div>
		</div>
		
		<div class="cb_content_container">
			<div class="box_shadow_container">
				<div class="cbcc_header">
					월드 프렌즈 코리아 설문조사
				</div>
				<div class="cbcc_serv_content">
					<p>1. KOICA 월드프렌즈에 대해 들어본적 있다.</p>
					<div class="cbcc_serv_radio_container">
						<input type="radio" id="wf_y" name="wf" data-role="none">
						<label for="wf_y"><span></span>있다</label>
						
						<input type="radio" id="wf_n" name="wf" data-role="none">
						<label for="wf_n"><span></span>없다</label>
					</div>
				</div>
				<div class="cbcc_serv_content">
					<p>2. 개발도상국의 빈곤과 인권문제에 대해 관심이 있다.</p>
					<div class="cbcc_serv_radio_container">
						<input type="radio" id="gd_y" name="gd" data-role="none">
						<label for="gd_y"><span></span>있다</label>
						
						<input type="radio" id="gd_n" name="gd" data-role="none">
						<label for="gd_n"><span></span>없다</label>
					</div>
				</div>
			</div>
			
			<div class="cbcc_footer_div">
				<p class="cbcc_next_btn">다음</p>
			</div>
		</div>
	</div>
</div>
	
</body>
</html>