$(document).ready(function(){
	//alert('커피 교환권 추첨 결과\n행사 이벤트가 종료되었습니다.');
	
	//행사 순서 정해지면 주석 풀고 수정
	//timeCompare('201909191530', '201909181630')
	var teamNo = 1;
	if(timeCompare('1230', '1300')){
		teamNo = '900013';
		$('#now_team_name').text('메리플레인');
		$('#now_team_info').text('즐겁고 솔직하게 음악하는 유쾌한 어쿠스틱 2인조 메리플레인입니다.');
	} else if(timeCompare('1301', '1340')){
		teamNo = '900012';
		$('#now_team_name').text('마두금 연주자 김연준');
		$('#now_team_info').text('몽골의 전통악기 마두금을 연주하는 연주자');
	} else if(timeCompare('1341', '1410')){
		teamNo = '900014';
		$('#now_team_name').text('주노가');
		$('#now_team_info').text('싱어송라이터 주노가 입니다.');
	} else if(timeCompare('1411', '1450')){
		teamNo = '900011';
		$('#now_team_name').text('네오팝스탠다드 X오유');
		$('#now_team_info').text('‘팝의 새로운 기준’ 이라는 뜻을 담고 있는 네오팝스탠다드는 베이스 죵딘, 신디사이저 OK.T.O.P로 결성되어 2014년 디지털 싱글 ‘Good Time’을 발매하며 데뷔하였습니다. 현재까지 5장의 싱글을 발매하였고 각각의 싱글마다 서로 다른 스타일의 음악을 발표하며 팝으로 대표되는 대중음악의 다양한 장르들을 쉽고 대중적이면서도 결코 가볍지 않게 선보이려 노력하고 있습니다.');
	} else if(timeCompare('1451', '1530')){
		teamNo = '900015';
		$('#now_team_name').text('싱크루');
		$('#now_team_info').text('오직 노래를 위해 모인 사람들, 안녕하세요. 저희는 싱크루입니다.');
	} else {
		teamNo = '900015';
		$('#now_team_name').text('아몰랑밴드');
		$('#now_team_info').text('통기타를 사랑하는 광주전남통기타공연밴드 올드앤뉴를 지향하고 있습니다. 때에 따라 카혼이나 베이스등의 악기가 추가됩니다');
	}
	
	var teamUrl = 'https://www.happybusking.com/app/appresult.jsp?team_no=' + teamNo;
	$('#now_team_image').attr('src', './img/test/team/'+teamNo+'_1.jpg');
	$('#now_team_url').attr('onclick', 'location.href="'+teamUrl+'"');

	//$('#now_team_url').attr('onclick', 'location.href="https://www.happybusking.com"');
});

$(document).on('click', '#koica_share', function(){
	$('.popup_mask').show();
	$('.share_popup').show();
});

$(document).on('click', '.popup_mask', function(){
	$('.popup_mask').hide();
	$('.share_popup').hide();
});

$(document).on('click', '#sp_close', function(){
	$('.popup_mask').hide();
	$('.share_popup').hide();
});

$(document).on('click', '#sp_url_copy', function(){
	CopyUrlToClipboard();
});

function CopyUrlToClipboard(){
	var obShareUrl = document.getElementById("sp_url");

	obShareUrl.select();  // 해당 값이 선택되도록 select() 합니다
	document.execCommand("copy"); // 클립보드에 복사합니다.

	obShareUrl.blur(); // 선택된 것을 다시 선택안된것으로 바꿈니다.
	
	alert("URL이 클립보드에 복사되었습니다"); 
	$('.popup_mask').hide();
	$('.share_popup').hide();
}


function timeCompare(sdate, edate){
	var now = new Date();	//현재시간
	
	/*var year = now.getFullYear();
	var month = now.getMonth() + 1;
	if(String(month).length < 2) month = '0' + month;
	var date = now.getDate();
	if(String(date).length < 2) date = '0' + date;*/
	var hour = now.getHours();
	if(String(hour).length < 2) hour = '0' + hour;
	var min = now.getMinutes();
	if(String(min).length < 2) min = '0' + min;
	
	//var today = year + '' + month + '' + date + '' + hour + '' + min;
	var today = hour + '' + min;
	
	//console.log('sdate : ' + sdate);
	//console.log('edate : ' + edate);
	//console.log('today : ' + today);
	
	if((eval(today) > eval(sdate)) && ((eval(today) < eval(edate)))){
		return true;
	} else {
		return false;
	}
}