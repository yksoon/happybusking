<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <script type="text/javascript" src="/js/jquery/jquery-1.11.3.min.js" ></script> -->
<style type="text/css">
#evaluition_popup{
    background-color: rgba(0,0,0,0.5);
    position: fixed;
    z-index: 9999;
    width: 100vw;
    height: 100vh;
    top: 0;
    left: 0;
}
.ep_wapper {
	position: relative;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 90vw;
	background-color: #ffffff;
}

.ep_top_wapper {
	padding: 40px 10px;
	border-bottom: 14px solid #f5f5f5;
}

.ep_small {
	font-size: 14px;
	letter-spacing: -1px;
	color: #999999;
	font-weight: 600;
}

.ep_big {
	font-size: 25px;
	letter-spacing: -1.8px;
	font-weight: 600;
	margin-bottom: 35px;
}

.ep_question {
	font-size: 15px;
	letter-spacing: -0.7px;
	color: #333333;
	margin-bottom: 30px;
}

.ep_score_box {
	display: flex;
	justify-content: space-between;
}

.ep_item {
	background-color: #f0f0f0;
	border: 1px solid #d6d6d6;
	text-align: center;
	width: 64px;
	height: 32px;
	line-height: 32px;
	font-size: 14px;
	letter-spacing: -0.42px;
}

.ep_select {
	background-color: #DFCFF7;
	border: 1px solid #8354C8;
	color: #8354C8;
	font-weight: 600;
}

.ep_item img {
	width: 14px;
}

.ep_bottom_wapper {
	padding: 40px 10px 0px 10px;
}

.ep_input {
	border: none;
	border-bottom: 1px solid #000000;
	font-size: 14px;
	width: 100%;
	padding: 5px 0px;
}

.ep_btn {
	background-color: #8354C8;
	width: 100%;
	height: 65px;
	line-height: 65px;
	text-align: center;
	color: #ffffff;
	font-size: 16px;
	font-weight: 600;
	margin-top: 50px;
}
</style>
</head>

<div id="evaluition_popup">
	<nav class="ep_wapper">
		<div class="ep_top_wapper">
			<p class="ep_small">메트로 아티스트 공연</p>
			<p class="ep_big">시민 만족도 조사</p>

			<p class="ep_question">
				지금 공연중인 아티스트에 대한 만족도는<br>몇 점인가요?
			</p>

			<div class="ep_score_box">
				<div class="ep_item ep_select" id="5">
					<img src="/img/common/ck2.svg"> 5점
				</div>
				<div class="ep_item" id="10">
					<img src="/img/common/ck1.svg"> 10점
				</div>
				<div class="ep_item" id="15">
					<img src="/img/common/ck1.svg"> 15점
				</div>
				<div class="ep_item" id="20">
					<img src="/img/common/ck1.svg"> 20점
				</div>
			</div>
		</div>
		<div class="ep_bottom_wapper">
			<p class="ep_question">메트로아티스트 공연 또는 서울 메트로에 대한 다양한 의견이나 건의사항들을
				작성, 제출해주시면 개선될 수 있도록 노력하겠습니다.(선택)</p>

			<input class="ep_input" type="text" data-role="none" id="ep_content" maxlength="100"
				placeholder="내용입력(최대 100자)">
			<input type="hidden" id="ep_sno">
		</div>
		<p class="ep_btn" id="ep_send">제출하기</p>
	</nav>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		var sno = sessionStorage.getItem('surveychk');
		$('#ep_sno').val(sno);
	});
	
	$(document).on('click', '.ep_item', function(){
		$target = $('.ep_item');
		$target.removeClass('ep_select');
		$target.find('img').attr('src', '/img/common/ck1.svg');
		
		$(this).addClass('ep_select');
		$(this).find('img').attr('src', '/img/common/ck2.svg');
	});
	
	$(document).on('click', '#ep_send', function(){
		var conf = confirm('제출 후 수정은 불가능합니다.\n정말 제출하시겠습니까?');
		if(!conf)return;
		
		var score = $('.ep_select').attr('id');
		var content = $('#ep_content').val();
		var sno = $('#ep_sno').val();
		
		$.ajax({
			type: "GET",//url: "JSON/test.json",
			cache: false,
			url: '/service/seoul_metro/set_evalution_score.jsp',
			data: {
				sno : sno,
				score : score,
				content: content
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			complete: function(){
				alert('제출되었습니다. 감사합니다.');
				sessionStorage.removeItem('surveychk');
				$('#metro_popup').hide();
			}
		});
	});
</script>
</html>