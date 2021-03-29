$(document).ready(function(){
	addItemSlide('seoul_place');
	//addItemSlide('partners_product'); // 기업상품 아이콘 슬라이드
	//addItemSlide('partners_best_product');
	//addItemSlide('seoul_news');
	//addItemSlide('event_festival');

	//상세페이지 헤더 스와이프시
	/*$('#siw_header').swipe({
		swipe: function(event, direction){
			switch(direction){
				case 'down':
					$('.sub_index').animate({
						top: '100%'
					}, 300, function(){
						$('body').css('overflow-y', 'auto');
						$('html').css('overflow-y', 'auto');
						$('.sub_index_background').hide();
						$('.siw_content').hide();
						$('.sub_index_wapper').removeClass('white_background');
					});
					break;
				case 'up':
					$('body').css('overflow-y', 'hidden');
					$('html').css('overflow-y', 'hidden');
					$('.sub_index').animate({
						top: '0'
					}, 100);
					break;
			}
		},
		maxTimeThreshold:1000,
        threshold:null,
        triggerOnTouchEnd:false
	});*/
	
	var teamNo, teamName, teamInfo;
	
	if(timeCompare('201911201200', '201911201400')){
		teamNo = '1909072402523943';
		teamName = '다이스찬';
		teamInfo = '주사위 및 저글링 퍼포먼스';
		startPage(teamNo, teamName, teamInfo);
	} else if(timeCompare('201911231200', '201911231400')){
		teamNo = '900020';
		teamName = '루나틱(Lunatic)';
		teamInfo = '인녕하세요 혼성댄스팀 루나틱입니다!페이스북페이지와 유튜브채널 들어와주셔서 구독과 팔로우 많은 관심 부탁드리겟습니다!';
		startPage(teamNo, teamName, teamInfo);
	} else if(timeCompare('201911231401', '201911231600')){
		teamNo = '900006';
		teamName = 'Aiwei(에이웨이)';
		teamInfo = '안녕하세요 저희는 여성댄스팀  에이웨이입니다 ~청순&amp;섹시&amp;큐티 여러 매력이 흘러 넘치고  각 멤버들의 매력도  다양합니다 !홍대에서 버스킹을 주로 하고 각 초청해주시는 공연에 다녀옵니다.많은 사랑 부탁드립니다 !!!';
		startPage(teamNo, teamName, teamInfo);
	} else if(timeCompare('201911231601', '201911231700')){
		teamNo = '1911122150444439';
		teamName = '레이디비';
		teamInfo = 'Kpop 여성댄스팀 레이디비입니다.섹시, 큐트 모든 이미지를 소화하는 매력 넘치는 팀입니다. 최근 활동으론 홍대에서 버스킹으로 이름을 알리고 있습니다.';
		startPage(teamNo, teamName, teamInfo);
	} else if(timeCompare('201911241200', '201911241400')){
		teamNo = '1911201132201342';
		teamName = '로켓단';
		teamInfo = '우리가 누구냐고 물으신다면 대답해드리는게 인지상정!!';
		startPage(teamNo, teamName, teamInfo);
	} else if(timeCompare('201911301200', '201911301400')){
		teamNo = '900990';
		teamName = '카이로스';
		teamInfo = '안녕하세요 연합댄스팀 카이로스 입니다.페이스북에 연합댄스팀 카이로스-Kairos 치면 나오니깐 좋아요 많이 눌러주세요!';
		startPage(teamNo, teamName, teamInfo);
	} else if(timeCompare('201911301401', '201911301600')){
		teamNo = '1911122150444439';
		teamName = '레이디비';
		teamInfo = 'Kpop 여성댄스팀 레이디비입니다.섹시, 큐트 모든 이미지를 소화하는 매력 넘치는 팀입니다. 최근 활동으론 홍대에서 버스킹으로 이름을 알리고 있습니다.';
		startPage(teamNo, teamName, teamInfo);
	} else if(timeCompare('201912011400', '201912011600')){
		teamNo = '1911290903414782';
		teamName = '그레이스';
		teamInfo = '홍대 버스킹 팀 그레이스입니다! 페이스북 페이지 "그레이스" 검색 후 공연소식받아가세요~';
		startPage(teamNo, teamName, teamInfo);
	}  else {
		//공연 외 시간
		startPage('', '', '');
	}
	
	makeMap('37.549287', '126.920328', 'index_map');
});

function startPage(teamNo, teamName, teamInfo){
	if(teamNo != ''){
		//공연중인 경우
		$('.iwcic_title').show();
		$('#iwcic_title_text').text('지금 공연중인 버스커는?');
		$('#now_team_name').text(teamName);
		$('#now_team_info').text(teamInfo);
		var teamUrl = 'https://www.happybusking.com/app/appresult.jsp?team_no=' + teamNo;
		$('#now_team_image').attr('src', './img/test/team/'+teamNo+'.jpg');
		$('#now_team_url').attr('onclick', 'location.href="'+teamUrl+'"');
		$('#iwc_background').hide();
	} else {
		//공연중이 아닌 경우
		$('.iwcic_title').hide();
		$('#iwcic_title_text').text('');
		$('#now_team_name').text('해피버스킹 앱 다운로드');
		$('#now_team_info').text('');
		$('#iwc_background').show();
		
		var teamUrl;
		if(navigator.userAgent.match(/iPad/i) || navigator.userAgent.match(/iPhone|iPod/i)){
			//애플
			teamUrl = 'https://itunes.apple.com/kr/app/해피버스킹/id1436945374?mt=8';
		} else {
			teamUrl = 'https://play.google.com/store/apps/details?id=com.happybusking';
		}
		
		$('#now_team_url').attr('onclick', 'location.href="'+teamUrl+'"');
	}
}

//아이서울유 파트너스부분 클릭시
/*$(document).on('click', '.ip_item', function(){
	$('.iseoulu_partners').show();
	$('body').css('overflow-y', 'hidden');
	$('html').css('overflow-y', 'hidden');
	$('.sub_index').animate({
		top: '10%'
	}, 300, function(){
		$('.siw_content').scrollTop('0');
	});
});*/

//파트너스 기업 상품 음식 클릭시
/*$(document).on('click', '.pp_item', function(){
	$('.sub_index_background').show();
	$('.sub_index_wapper').addClass('white_background');
	$('.siwc_body').hide();
	
	var idChk = $(this).attr('id');
	if(idChk == 'iseoulu_partners_food'){
		$('#siwch_name').html('음식');
		$('.siwc_filter').val('food');
	} else if(idChk == 'iseoulu_partners_music'){
		$('#siwch_name').html('음악');
		$('.siwc_filter').val('music');
	} else if(idChk == 'iseoulu_partners_fashion'){
		$('#siwch_name').html('패션');
		$('.siwc_filter').val('fashion');
	} else if(idChk == 'iseoulu_partners_exhibit'){
		$('#siwch_name').html('전시');
		$('.siwc_filter').val('exhibit');
	} else if(idChk == 'iseoulu_partners_cosmetics'){
		$('#siwch_name').html('화장품');
		$('.siwc_filter').val('cosmetics');
	}
	$('.'+idChk).show();
	
	$('.iseoulu_partners_product').show();
	$('body').css('overflow-y', 'hidden');
	$('html').css('overflow-y', 'hidden');
	$('.sub_index').animate({
		top: '10%'
	}, 300, function(){
		$('.siw_content').scrollTop('0');
	});
});*/


/*function subIndexScrollEvent(){
	var subIndexScroll = $('.iseoulu_partners').scrollTop();
	var subIndexScroll2 = $('.iseoulu_partners_product').scrollTop();
	
	if(subIndexScroll > 0 || subIndexScroll2 > 0){
		$('.sub_index').animate({
			top: '0'
		}, 100);
	}
}*/

//파트너스 기업상품 베스트 아이템 클릭시
$(document).on('click', '.siwcb_item', function(){
	location.href='/cooperation/iseoulu/view/product/pdetail.jsp';
});

function addItemSlide(str){
	var carousel = $('#'+str);
	carousel.itemslide(
	{
		left_sided: true,
		disable_clicktoslide: true
	});
	carousel.reload();
}

//url 주소로 파라미터 값 받기
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
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
	
	if((eval(today) >= eval(sdate)) && ((eval(today) <= eval(edate)))){
		return true;
	} else {
		return false;
	}
}