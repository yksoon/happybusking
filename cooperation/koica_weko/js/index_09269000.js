$(document).ready(function(){
	//행사 순서 정해지면 주석 풀고 수정
	//timeCompare('201909191530', '201909181630')
	var teamNo = 1;
	if(timeCompare('201911161330', '201911161400')){
		teamNo = '1911131844174408';
		$('#now_team_name').text('싱어송라이터 황예린');
		$('#now_team_info').text('보이스코리아1출신 싱어송라이터 노래하는 황예린 입니다.');
	} else if(timeCompare('201911161401', '201911161500')){
		teamNo = '900011';
		$('#now_team_name').text('라꼬');
		$('#now_team_info').text('행사공연가수 or MC등등 여러가지로 다재다증한 싱어송라이터 입니다. 관객들과 소통하는 수준높은 공연으로 찾아 뵙도록 하겠습니다 감사합니다^^ ');
	} else if(timeCompare('201911161501', '201911161600')){
		teamNo = '1911130455199120';
		$('#now_team_name').text('기타치는 푸우');
		$('#now_team_info').text('안녕하세요 기타치는 푸우 장호성입니다ㅎ 유쾌하면서도 감동적인 곡을 들려드리려고 노력하고 있습니다.. 잘 부탁드립니다ㅎ');
	} else {
		teamNo = '1911131844174408';
		$('#now_team_name').text('싱어송라이터 황예린');
		$('#now_team_info').text('보이스코리아1출신 싱어송라이터 노래하는 황예린 입니다.');
	}
	
	var teamUrl = 'https://www.happybusking.com/app/appresult.jsp?team_no=' + teamNo;
	$('#now_team_image').attr('src', './img/test/team/'+teamNo+'.jpg');
	$('#now_team_url').attr('onclick', 'location.href="'+teamUrl+'"');

	var el = document.querySelector('#imagebox_1');
	var el2 = document.querySelector('#imagebox_2');
	var el3 = document.querySelector('#imagebox_3');
	new PinchZoom.default(el, {
		draggableUnzoomed: false,
		maxZoom: 3
	});
	new PinchZoom.default(el2, {
		draggableUnzoomed: false,
		maxZoom: 3
	});
	new PinchZoom.default(el3, {
		draggableUnzoomed: false,
		maxZoom: 3
	});
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

function setPinchZoom(el){
	new PinchZoom.default(el, {
		draggableUnzoomed: false,
		maxZoom: 3
	});
}

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
	
	var year = now.getFullYear();
	var month = now.getMonth() + 1;
	if(String(month).length < 2) month = '0' + month;
	var date = now.getDate();
	if(String(date).length < 2) date = '0' + date;
	var hour = now.getHours();
	if(String(hour).length < 2) hour = '0' + hour;
	var min = now.getMinutes();
	if(String(min).length < 2) min = '0' + min;
	
	var today = year + '' + month + '' + date + '' + hour + '' + min;
	//var today = hour + '' + min;
	
	//console.log('sdate : ' + sdate);
	//console.log('edate : ' + edate);
	//console.log('today : ' + today);
	
	if((eval(today) > eval(sdate)) && ((eval(today) < eval(edate)))){
		return true;
	} else {
		return false;
	}
}