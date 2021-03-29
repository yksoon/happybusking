function goFestivalApply(){
	$('html').css('overflow', 'scroll');
	$('header').show();
	$('footer').show();
	$('#indexEventPopup').hide();
	
	if(!getFestivalName()) return;
	
	if(!teamChk()) return;
	else {
		loadPage('festival/festival_apply.jsp');	
	}
	
}

function getFestivalName(){
	var res = false;
	
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/festival/get_festival_name.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#area-select').empty();
			
			if(DATA.length == 0){
				alert('모집 진행중인 공연이 없습니다.');
				res = false;
			} else {
				$('#area-select').append('<option value="" selected disabled>공연 선택</option>');
				$('#area-select-button').find('span').text('공연 선택');
				res = true;
			}
			
			$(DATA).each(function(){
				var PBI_NO = $(this).find('PBI_NO').text();
				var PBI_TITLE = $(this).find('PBI_TITLE').text();
				
				var option = '<option value="'+PBI_NO+'">'+PBI_TITLE+'</option>';
				$('#area-select').append(option);
			});
		}
	});
	
	return res;
}

function teamChk(){
	let res = false;
	$.ajax({
		type: "GET",
		async: false,
		cache: false,
		url: '/service/common/get_team_select.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length === 0){
				let conf = confirm('팀 등록을 먼저 해야 신청서 작성이 가능합니다.\n팀 등록 페이지로 이동하시겠습니까?');
				if(!conf) return;
				else {
					go_team_create();
				}
			}
			
			$(DATA).each(function(){
				var TEAM_NO = $(this).find('TEAM_NO').text();
				sessionStorage.setItem('myTNO', TEAM_NO);
				res = true;
			});
		}
	});
	
	return res;
}

var faChk = true;
function festivalApplyChk(tno, area){
	$.ajax({
		type: "GET",
		async: false,
		cache: false,
		url: '/service/festival/get_festival_apply_chk.jsp',
		data: {
			tno: tno,
			area: area
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var CNT = $(this).find('CNT').text();
				
				if(CNT === '0') faChk = true;
				else faChk = false;
			});
		}
	});
}