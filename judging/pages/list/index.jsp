<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	@import url(https://cdn.jsdelivr.net/gh/theeluwin/NotoSansKR-Hestia@master/stylesheets/NotoSansKR-Hestia.css);
	*{	
		font-family: 'Noto Sans Korean', sans-serif;
		padding: 0;
		margin: 0;
		letter-spacing: -0.25px;
		color:#333;
		font-weight:300;
		line-height:1.6;
	}
	
	.index-title{
		padding: 12px;
	    background-color: #ffffff; 
	    position: relative;
		box-shadow: 0px 3px 4px 1px #eee;
	}
	
	.index-title > p{
	    text-align: center;
	    font-weight: 600;
	    font-size: 1.8rem;
	}
	
	#l-logo {
	    position: absolute;
	    top: 5px;
	    left: 1%;
	}
	
	#r-logo {
	    position: absolute;
	    top: 11px;
	    right: 1%;
	}
	
	.index-name{
		padding: 10px;
		font-weight: 300;
		text-align: right;
		border-top: 1px solid #fff;
		color:#666;
	}
	.index-name > span {
	    margin: 0 5% 0 5%;
	}
	
	#list, #header{
		width: 100%;
	    table-layout: auto;
	    border-spacing: 0;
	    border-collapse: collapse;
	}
	
	#header{
		position: fixed;
		top: 0;
		display: none;
	}
	
	button{
		background-color:#8354c8;
		color:#fff;
		border-color:#8354c8;
		border-radius:4px;
		box-shadow:none;
		border: none;
	}
	

	th{
		background-color: #EEEFF3;
	}
	
	th, td{
		border: 1px solid #EAEBED;
		word-break: keep-all;
	}
	
	td{
		text-align: center;
		padding: 5px 0px;
	}
	
	td > input{
		width: 100%;
	    border: none;
	    font-size: 18px;
	    text-align: center;
	}
	
	.youtube img{
		width: 30px;
		cursor: pointer;
	}
	
	.video img{
		width: 20px;
		cursor: pointer;
	}
	
	#info-container{
		display: inline-block;
	    background-color: #ffffff;
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    width: 40vw;
	    text-align: left;
	    border-radius: 15px;
    }
    
    #info-container p{
    	padding: 2% 5%;
	    text-align: center;
	    background-color: #eaebed;
	    font-weight: 600;
	    border-radius: 15px 15px 0px 0px;
    }
    
    #info{
	    padding: 5%;
	    white-space: pre-line;
	    overflow-x: hidden;
	    overflow-y: scroll;
	    height: 40vh;
    }
    
    
	
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}
	
	.score{
		width: 115px;
	}
	
	.scoretd > button {
		width: 20px;
	}
	
	.popup{
		width: 100vw;
	    height: 100vh;
	    position: fixed;
	    top: 0;
	    left: 0;
	    background-color: rgba(0, 0, 0, 0.5);
	    display: none;
	}
	
	#video-popup video{
		position: relative;
	    left: 50%;
	    top: 50%;
	    max-width: 80vw;
   	 max-height: 70vh;
	    transform: translate(-50%, -50%);
	}
	
	#loading-popup #loading{
		width: 10%;
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    border-radius: 15px;
	}
	
	#save-alarm{
		position: fixed;
	    display: none;
	    background-color: #000000;
	    color: #ffffff;
	    top: 50%;
	    left: 80%;
	    transform: translate(-50%, -50%);
	    padding: 0.5% 4%;
	    border-radius: 5px;
	    box-shadow: 1px 1px 5px 2px #bbbbbb;
	    font-size: 13px;	
	}
	
	.close {
	    position: absolute;
	    width: 3%;
		top: 10%;
    	right: 10%;
	    background-color: #ffffff;
	    border-radius: 13px;
	}
	
	#apply, #result,  #print, #name2{
	    padding: 5px 15px;
	    font-size: 20px;
	    float: right;
	    margin-top: 15px;
	    margin-right: 50px;
	}
	
	.totalscore{
		font-weight: 600;
	}
	
	.l-gray{
		color: #444444;
	}
	
	td > button{
		padding: 1px 10px;
	}
</style>
<title>해피버스킹 - 서울메트로 심사</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body onload="onLoad();">
	<nav class="index-wrapper">
		<nav class="popup" id="loading-popup">
			<img id="loading" src="/judging/resource/img/loading.gif" />
		</nav>
		<div class="index-title">
			<img id="l-logo" src="/judging/resource/img/logo_left.png" />
			<p>2020년 제12기 메트로아티스트 선발 심사표</p>
			<img id="r-logo" src="/judging/resource/img/logo_right.png" />
		</div> 							
		<p class="index-name" id="name"></p>
		<table id="header">
		<tr id="htitle1">
			<th rowspan="2" style="min-width: 32px;">연번</th>
			<th rowspan="2" style="min-width: 62px;">대구분</th>
			<th rowspan="2" style="min-width: 162px;">소구분</th>
			<th rowspan="2" style="min-width: 169px;">아티스트명</th>
			<th rowspan="2" style="min-width: 62px;">심사영상</th>
			<th rowspan="2" style="min-width: 47px;">유튜브</th>
			<th colspan="3" style="min-width: 75px;">평가항목</th>
			<th rowspan="2" style="min-width: 32px;">총계</th>
			<th rowspan="2" style="min-width: 63px;">비고</th>
		</tr>
		<tr id="htitle1">
			<th class="l-gray" style="min-width: 116px;">대중성 (40)</th>
			<th class="l-gray" style="min-width: 116px;">전문성 (30)</th>
			<th class="l-gray" style="min-width: 116px;">적합성 (30)</th>
		</tr>
		</table>
		
		<table id="list">
		</table>
		
		<button id="apply">제출</button>
		<button id="result">심사결과 보기</button>
		<select id="name2">
			<option value="나인호">나인호</option>
			<option value="김병철">김병철</option>
			<option value="강율우">강율우</option>
			<option value="윤영준">윤영준</option>
			<option value="박일">박일</option>
		</select>
		<button id="print">심사표 다운로드</button>
		
		<nav class="popup" id="video-popup">
		</nav>
		
		<nav class="popup" id="teaminfo-popup">
			<img class="close" src="/judging/resource/img/close.png">
			<div id="info-container">
				<p>팀 소개</p>
				<div id="info">
				</div>
			</div>
		</nav>
		
		<nav id="save-alarm">
			저장되었습니다.
		</nav>
	</nav>
</body>
<script type="text/javascript">
	function onLoad(){ 
		window.addEventListener('scroll', function(){
			let scroll = $(window).scrollTop();
			
			if(scroll >= 140) $('#header').show();
			else $('#header').hide();
		});
		
		window.addEventListener('resize', function(){
			headerResizing();
		});
		
		$('#loading-popup').show();
		
		const name = sessionStorage.getItem('name');
		if(name === null || name === 'null' || name ==''){
			alert('로그인이 필요합니다.');
			location.href='http://116.126.142.192:8094/judging/';
			return;
		}
		$('#name').html('심사위원 성명 : ' + name + '<span>(인)</span>');
		if(name != '이용대'){
			$('#name2').hide();
			$('#result').hide();
			$('#print').hide();
		}
		
		getFestivalApplyList(); 
	}
	
	function headerResizing(){
		const $target1 = $('#title1').find('th');
		const $target2 = $('#title2').find('th');
		
		const $target1_ = $('#htitle1').find('th');
		const $target2_ = $('#htitle2').find('th');
		
		
		let width;
		
		$target1.each(function(i){
			width = $target1.eq(i).css('width');
			
			$target1_.eq(i).css('width', width);
		});
	}
	
	function getFestivalApplyList(){
		$('#list').empty();
		
		const tableHeader = '<tr id="title1">'+
								'<th rowspan="2" style="width: 40px;">연번</th>'+
								'<th rowspan="2" style="width: 65px;">대구분</th>'+
								'<th rowspan="2" style="width: 774px;">소구분</th>'+
								'<th rowspan="2" style="width: 330px;">아티스트명</th>'+
								'<th rowspan="2" style="width: 100px;">심사영상</th>'+
								'<th rowspan="2" style="width: 75px;">유튜브</th>'+
								'<th colspan="3">평가항목</th>'+
								'<th rowspan="2" style="width: 90px;">총계</th>'+
								'<th rowspan="2" style="width: 90px;">비고</th>'+
							'</tr>'+
							'<tr id="title2">'+
								'<th class="l-gray" style="width: 115px;">대중성 (40)</th>'+
								'<th class="l-gray" style="width: 115px;">전문성 (30)</th>'+
								'<th class="l-gray" style="width: 115px;">적합성 (30)</th>'+
							'</tr>';
		
		$('#list').append(tableHeader);
		headerResizing();
		
		$.ajax({
	        type: "GET",
	        async: false,
	        cache: false,
	        url: '/judging/resource/service/get_festival_apply_list.jsp',
	        contentType: "application/xml; charset=utf-8",
	        dataType: "xml",
	        timeout: 30000,
	        success: function(data) {
	        	var ROOT = $(data).find('ROOT');
	        	var DATA = $(ROOT).find('DATA');
	        	
	        	$(DATA).each(function(i){
	        		let idx = i+1;
	        		let KID = $(this).find('KID').text();
	        		let KTEAM = $(this).find('KTEAM').text();
	        		let KMGENRE = $(this).find('KMGENRE').text();
	        		let KGENRE = $(this).find('KGENRE').text();
	        		let KINFO = $(this).find('KINFO').text();
	        		let KURL = $(this).find('KURL').text();
	        		let KTEAMNO = changeLineBreak($(this).find('KTEAMNO').text());
	        		let KGREAT = $(this).find('KGREAT').text();
	        		let KVIDEO = $(this).find('KVIDEO').text();
	        		
	        		let urlChk = KURL.split('://')[0];
	        		let youtube = '';
	        		
	        		if(urlChk === 'https' || urlChk === 'http') youtube = '<td class="youtube" id="'+KURL+'"><img src="/judging/resource/img/youtube.jpg"></td>';
	        		else youtube = '<td></td>';
	        		
	        		let video = '/judging/resource/video/'+KVIDEO+'.mp4';
	        		
	        		let tr = '';
	        		
	        		if(KGREAT === '1'){
		        		tr = '<tr class="great" id="'+KID+'">' +
									'<td id="key">'+'<div id="teaminfo" style="display: none;">'+KINFO+'</div>'+idx+'</td>' +
									'<td id="mcategory">'+KMGENRE+'</td>'+
									'<td id="scategory">'+KGENRE+'</td>'+
									'<td class="teamname" id="teamname">'+KTEAM+'</td>'+
									'<td class="video" id="'+video+'"><img src="/judging/resource/img/play.png"></td>'+
									youtube+
									'<td class="scoretd"><input type="number" class="score" id="score1" value="40" readonly/></td>'+
									'<td class="scoretd"><input type="number" class="score" id="score2" value="30" readonly/></td>'+
									'<td class="scoretd"><input type="number" class="score" id="score3" value="30" readonly/></td>'+ 
									'<td class="totalscore">100</td>'+
									'<td><button id="save" style="display: none;" >저장</button><span style=" font-size: 13px;">11기우수팀</span></td>'+		
									'<input type="hidden" id="teamno" value="'+KTEAMNO+'"/>'+
								'</tr>';	
								
	        		} else {
	        			tr = '<tr id="'+KID+'">' + 
									'<td id="key">'+'<div id="teaminfo" style="display: none;">'+KINFO+'</div>'+idx+'</td>' +
									'<td id="mcategory">'+KMGENRE+'</td>'+
									'<td id="scategory">'+KGENRE+'</td>'+
									'<td class="teamname" id="teamname">'+KTEAM+'</td>'+
									'<td class="video" id="'+video+'"><img src="/judging/resource/img/play.png"></td>'+
									youtube+
									'<td class="scoretd"><input type="number" class="score" id="score1" placeholder="0"/></td>'+
									'<td class="scoretd"><input type="number" class="score" id="score2" placeholder="0"/></td>'+
									'<td class="scoretd"><input type="number" class="score" id="score3" placeholder="0"/></td>'+ 
									'<td class="totalscore">0</td>'+
									'<td><button id="save">저장</button></td>'+		
									'<input type="hidden" id="teamno" value="'+KTEAMNO+'"/>'+
								'</tr>';
	        		}
							
	        		$('#list').append(tr);
	        	});
	        },
	        error: function(x, h, r){
	        	console.log(x, h, r);
	        },
	        complete: function(){
	    		getScoreList();
	        }
		});
	}
	
	function getScoreList(){
		const name = sessionStorage.getItem('name');
		$.ajax({
	        type: "GET",
	        async: false,
	        cache: false,
	        url: '/judging/resource/service/get_score_list.jsp',
	        data:{
	        	name: name
	        },
	        contentType: "application/xml; charset=utf-8",
	        dataType: "xml",
	        timeout: 30000,
	        success: function(data) {
	        	var ROOT = $(data).find('ROOT');
	        	var DATA = $(ROOT).find('DATA');
	        	
	        	$(DATA).each(function(){
	        		let NO = $(this).find('NO').text();
	        		let SCORE1 = $(this).find('SCORE1').text();
	        		let SCORE2 = $(this).find('SCORE2').text();
	        		let SCORE3 = $(this).find('SCORE3').text();
	        		let TOTALSCORE = $(this).find('TOTALSCORE').text();
	        		
	        		
	        		let target = $('#'+NO);
	        		
	        		target.find('#score1').val(SCORE1);
	        		target.find('#score2').val(SCORE2);
	        		target.find('#score3').val(SCORE3);
	        		target.find('.totalscore').html(TOTALSCORE);
	        	});
	        },
	        error: function(x, h, r){
	        	console.log(x, h, r);
	        },
	        complete: function(data){
	        	$('#loading-popup').hide();
	        	
	        	const $target = $('.great');
	        	
	        	$target.each(function(i){
	        		$target.eq(i).find('#save').click();
	        	});
	        }
		});
	}
	
	$(document).on('keyup', '.score', function(){
		const thisScore = $(this).val();
		const thisId = $(this).attr('id');
		if(thisScore < 0) $(this).val(0);
		if(thisId === 'score1'){
			if(thisScore > 40) $(this).val(40);
		} else {
			if(thisScore > 30) $(this).val(30);
		}
		
		const target = $(this).parents('tr').find('.score');
		
		let score = 0;
		let totalscore = 0;
		
		target.each(function(i){
			score = parseInt(target[i].value);
			if(Number.isNaN(score)) score = 0;
			
			totalscore += score;
		}); 
		
		$(this).parents('tr').find('.totalscore').html(totalscore);
	});

	/* $(document).on('click', '.plus', function(){
		const $target = $(this).parents('.scoretd').find('.score');
		const thisId = $target.attr('id'); 
		
		let score = parseInt($target.val());
		let totalscore = 0;
		
		//+버튼
		score += 5;
		
		if(thisId === 'score1'){
			if(score > 40) score = 40;
		} else {
			if(score > 30) score = 30;
		}
		
		$target.val(score);
		
		const $targetArr = $(this).parents('tr').find('.score');
		
		$targetArr.each(function(i){
			score = parseInt($targetArr[i].value);
			if(Number.isNaN(score)) score = 0;
			
			totalscore += score;
		}); 
		
		$(this).parents('tr').find('.totalscore').html(totalscore);
	});
	
	$(document).on('click', '.minus', function(){
		const $target = $(this).parents('.scoretd').find('.score');
		const thisId = $target.attr('id'); 
		
		let score = parseInt($target.val());
		let totalscore = 0;

		score -= 5;
		
		if(score <= 0) score = 0;
		
		$target.val(score);
		
		const $targetArr = $(this).parents('tr').find('.score');
		
		$targetArr.each(function(i){
			score = parseInt($targetArr[i].value);
			if(Number.isNaN(score)) score = 0;
			
			totalscore += score;
		}); 
		
		$(this).parents('tr').find('.totalscore').html(totalscore);
	}); */
	
	$(document).on('click', '.teamname', function(){
		const info = $(this).parents('tr').find('#teaminfo').html();
		
		console.log(info);
		
		$('#info').html(info);
		$('#teaminfo-popup').show();
		
		/* const no = $(this).parents('tr').attr('id');
		const url = 'https://happybusking.com/cooperation/seoulmetro/adminpage/view/metroartist/applymanage_detail.jsp?n='+no;
		
		window.open(url, '_blank'); */
	});
	
	$(document).on('click', '.youtube', function(){
		const url = $(this).attr('id');
		
		window.open(url, '_blank');
	});
	
	$(document).on('click', '.video', function(){
		const url = $(this).attr('id');
		
		$('#video-popup').empty();
		
		const html ='<img class="close" src="/judging/resource/img/close.png">' + 
					'<video controls autoplay id="videotag">' + 
				 	  '<source id="video-src" src="'+url+'" type="video/mp4">'+ 
					'</video>';
		
		$('#video-popup').html(html);			
		$('#video-popup').show();
	});
	 
	
	$(document).on('click', '.popup, .close, #videotag', function(){
		$('#videotag').each(function(){this.pause()});
		$('.popup').hide();
	});
	
	$('#video-popup').bind('hide', function(){
		$('#videotag').each(function(){this.pause()});
		$('.popup').hide();
	});
	
	$(document).on('click', '#save', function(){
		$('#save-alarm').fadeIn('500');
		
		const target = $(this).parents('tr');
		
		const no = target.attr('id');
		const tno = target.find('#teamno').val();
		const name = sessionStorage.getItem('name');
		const mcategory = target.find('#mcategory').text();
		const scategory = target.find('#scategory').text();
		let score1 = target.find('#score1').val();
		let score2 = target.find('#score2').val();
		let score3 = target.find('#score3').val();
		const totalscore = target.find('.totalscore').text();
		
		score1 = (score1 === '') ? '0' : score1; 
		score2 = (score2 === '') ? '0' : score2; 
		score3 = (score3 === '') ? '0' : score3; 
		
		$.ajax({
			type: "GET",
			cache: false,
			url: '/judging/resource/service/set_judging_list.jsp',
			data: {
				no : no,
				tno : tno,
				name : name,
				mcategory : mcategory,
				scategory : scategory,
				score1 : score1,
				score2 : score2,
				score3 : score3,
				totalscore : totalscore,
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			complete : function(data){
				setTimeout(function(){
					$('#save-alarm').fadeOut('500');
					//alert('저장되었습니다.');
				}, 500);
			}
		});
	});
	
	$(document).on('click', '#apply', function(){
		alert('제출이 완료되었습니다.');
	});
	
	$(document).on('click', '#result', function(){
		const url = 'http://www.bizworks.co.kr/avg_sum.php';
		window.open(url, '_blank');
	});
	
	$(document).on('click', '#print', function(){
		const name = $('#name2').val();
		const url = 'http://www.bizworks.co.kr/avg_sum.php?Judge=' + name;
		window.open(url, '_blank');
	});
	
	//DB SELECT시 줄바꿈
	function changeLineBreak(str){
		str = str.replace(/(?:\r\n|\r|\n)/g, '<br/>');
		return str;
	}
</script>
</html>