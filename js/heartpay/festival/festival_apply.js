const MAX_COUNT = 20;

$(document).on('pageinit', '#insert_koica', function(){
	getFestivalName();
	
	$('#ttype').hide();
	$('#tinfo').textinput("option", "autogrow", false);
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/get_team_select.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				return;
			}
			
			$(DATA).each(function(){
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				
				$('#team-select').append('<option value="'+TEAM_NO+'">' + TEAM_NAME + '</option>');
			});
		}
	});
	
	$('#countmin').empty();
	$('#countmin').append('<option selected="selected" disabled value="">최소 횟수</option>');
	for(let i=1; i<=MAX_COUNT; i++){
		$('#countmin').append('<option value="'+i+'">'+i+'회</option>');
	}
	
	$('#countmin').selectmenu().selectmenu('refresh', true);
});

$(document).on('change', '#team-select', function(){
	const no = $(this).val();
	
	if(tno === ''){
		alert('팀을 선택해주세요.');
		return;
	} else {
		$.ajax({
			type: "GET",
			cache: false,
			url: '/service/festival/get_one_team.jsp',
			data: {
				tno: no
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success: function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				if(DATA.length == 0){
					return;
				}
				
				$(DATA).each(function(){
					var TEAM_NAME = $(this).find('TEAM_NAME').text();
					var TEAM_INTRO = $(this).find('TEAM_INTRO').text();
					var CODE_GENRE = $(this).find('CODE_GENRE').text();
					var PHONE = $(this).find('PHONE').text();
					var EMAIL = $(this).find('EMAIL').text();
					
					$('#tel').val(PHONE);
					$('#email').val(EMAIL);
					$('#tname').val(TEAM_NAME);
					$('#tinfo').val(TEAM_INTRO);
					$('#tgenre').val(CODE_GENRE);
				});
			}
		});
	}
});

/*$(document).on('change', '#area-select', function(){
	const str = $(this).val();
	
	if(str === '메트로아티스트' || blankChk(str) === '메트로아티스트'){
		$('#fa_count_box').show(); 
	} else {
		$('#fa_count_box').hide();
	}
});*/

$(document).on('keyup', '#birth', function(){
	let str = $(this).val();
	
	$(this).val(birthFormat(str));
});

$(document).on('change', '#countmin', function(){
	const value = $(this).val();
	
	$('#countmax').empty();
	$('#countmax').append('<option selected="selected" disabled value="">최대 횟수</option>');
	
	for(let i=value; i<=MAX_COUNT; i++){
		$('#countmax').append('<option value="'+i+'">'+i+'회</option>');
	}
	
	$('#countmax').selectmenu().selectmenu('refresh', true);
});

$(document).on('change', 'input[name="si_state"]', function(){
	var str = $(this).val();
	if(str == '기타'){
		$('#ttype').val('');
		$('#ttype').show();
	} else {
		$('#ttype').val(str);
		$('#ttype').hide();
	}
});

$(document).on('click', '#insert_koica_btn', function(){
	var tno = $('#team-select').val();
	var area = $('#area-select').val();
	var name = changeQuotes($('#name').val());
	var birth = changeQuotes($('#birth').val());
	var postcode = changeQuotes($('#postcode').val());
	var address = changeQuotes($('#address').val());
	var detailaddr = changeQuotes($('#detailaddr').val());
	var email = changeQuotes($('#email').val());
	var tel = changeQuotes($('#tel').val());
	var tname = changeQuotes($('#tname').val());
	var tgenre = changeQuotes($('#tgenre').val());
	var	ttype = changeQuotes($('#ttype').val());
	var tinfo = changeQuotes($('#tinfo').val());
	var turl = changeQuotes($('#turl').val());
	
	var countmin = $('#countmin').val();
	var countmax = $('#countmax').val();

	festivalApplyChk(tno, area);
	if(!faChk){
		alert('이미 접수되었습니다.');
		return
	}

	if(area == '' || area == null){
		alert('신청하실 공연을 선택해주세요.');
		return;
	} else if(tno == '' || tno == null){
		alert('신청하실 팀을 선택해주세요.');
		return;
	} else if(blankChk(name) == ''){
		alert('이름을 입력해주세요.');
		$('#name').focus();
		return;
	} else if(blankChk(birth) == ''){
		alert('생일을 입력해주세요.');
		$('#birth').focus();
		return;
	} else if(blankChk(postcode) == ''){
		alert('주소를 검색해주세요.');
		$('#address').focus();
		return;
	} else if(blankChk(address) == ''){
		alert('주소를 검색해주세요.');
		$('#address').focus();
		return;
	} else if(blankChk(detailaddr) == ''){
		alert('상세주소를 입력해주세요.');
		$('#detailaddr').focus();
		return;
	} else if(blankChk(email) == ''){
		alert('이메일을 입력해주세요.');
		$('#email').focus();
		return;
	} else if(blankChk(tel) == ''){
		alert('연락처를 입력해주세요.');
		$('#tel').focus();
		return;
	} else if(blankChk(tname) == ''){
		alert('공연 팀명을 입력해주세요.');
		$('#tname').focus();
		return;
	} else if(blankChk(tgenre) == ''){
		alert('장르를 입력해주세요.');
		$('#tgenre').focus();
		return;
	} else if(blankChk(ttype) == ''){
		alert('팀구성을 입력해주세요.');
		return;
	} else if(blankChk(tinfo) == ''){
		alert('팀소개를 입력해주세요.');
		$('#tinfo').focus();
		return;
	} else if(blankChk(turl) == ''){
		alert('공연영상 URL을 입력해주세요.');
		$('#turl').focus();
		return;
	} else if(birth.length != 10){
		alert('생년월일을 정확히 입력해주세요.');
		$('#birth').focus();
		return;
	}
	
	if(countmin===null || countmin === '') {
		alert('최소 월 공연 활동 횟수를 선택해주세요.');
		$('#countmin').focus();
		return;
	} else if(countmax ===null || countmax === '') {
		alert('최대 월 공연 활동 횟수를 선택해주세요.');
		$('#countmax').focus();
		return;
	}
	
	if(!$('#k_info_checkbox').prop('checked')){
		alert('개인정보 처리 및 취급방침에 동의해주세요.');
		return;
	}
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/festival/insert_festival_apply.jsp',
		data : {
			area: area,
			name: name,
			birth: birth,
			postcode: postcode,
			address: address,
			detailaddr: detailaddr,
			email: email,
			tel: tel,
			tname: tname,
			tgenre: tgenre,
			ttype: ttype,
			tinfo: tinfo,
			turl: turl,
			countmin: countmin,
			countmax: countmax,
			tno: tno
		},
		dataType: "xml",
		timeout: 30000,
		beforeSend: function(){
			$.mobile.loading( 'show', { text: '접수중입니다.', textVisible: true, theme: 'b', html: "" });
		},
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				return;
			}
			
			$(DATA).each(function(i) {
				var RESULT = $(this).find('RESULT').text();

				if(RESULT == 'false'){
					$.mobile.loading( 'hide', { text: '접수중입니다.', textVisible: true, theme: 'b', html: "" });
					alert('잠시후 다시 시도해주세요.');
					return;
				} else {
					$.mobile.loading( 'hide', { text: '접수중입니다.', textVisible: true, theme: 'b', html: "" });
					alert('접수가 완료되었습니다.');
					toHome();
				}
			});
		}, // end success
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		}, // end error
		complete: function(){
		}
	});
});