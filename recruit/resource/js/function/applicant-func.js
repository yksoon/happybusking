const getApplicantList = (no, start, sort) => {
	sessionStorage.removeItem('al-data-cnt');
	let TITLE = sessionStorage.getItem('ml-title');
	$('#al-title').html(TITLE);
	
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/recruit/resource/service/fa/get_applicant_list.jsp',
		data: {
			no: no,
			start: start,
			sort: sort
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#al-list').empty();
			
			
			const thead = '<tr>' +
							'<th class="ft-gray ft-12 ft-bold" style="width: 15%;">번호</th>'+
							'<th class="ft-gray ft-12 ft-bold" style="width: 25%;">장르</th>'+
							'<th class="ft-gray ft-12 ft-bold">팀명</th>'+
							'<th class="ft-gray ft-12 ft-bold" style="width: 20%;">유튜브</th>'+
						'</tr>';		
			
			$('#al-list').append(thead);
			
			if(DATA.length === 0){
				$('#al-all-count').html(0);
				
				const tbody = '<td colspan="4" class="bg-white ft-lgray ft-12 no-list">신청자가 없습니다.</td>';
				$('#al-list').append(tbody);
			}
			
			$(DATA).each(function(i){
				let KID = $(this).find('KID').text();
				let KGENRE = $(this).find('KGENRE').text();
				let KTEAM = $(this).find('KTEAM').text();
				let KURL = $(this).find('KURL').text();
				let ALLCNT = $(this).find('ALLCNT').text();
				let CNT = $(this).find('CNT').text();
				
				const cnt = parseInt(start) + i + 1;
				
				const tbody = '<tr id="'+KID+'">'+
									'<td class="bg-white  ft-12 al-number">'+cnt+'</td>'+
									'<td class="bg-white  ft-12 al-genre">'+KGENRE+'</td>'+
									'<td class="bg-white  ft-12 ft-bold under-line al-tname">'+KTEAM+'</td>'+
									'<td class="bg-white al-youtube" id="'+KURL+'"><img src="/recruit/resource/img/common/youtube.jpg"/></td>'+
								'</tr>';
				
				$('#al-list').append(tbody);
				
				$('#al-all-count').html(ALLCNT);
				
				sessionStorage.setItem('al-data-cnt', CNT);
			});
		}
	});
}

const getApplicantDetail = (id) => {
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/recruit/resource/service/fa/get_applicant_detail.jsp',
		data: {
			no: id
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				let KID = $(this).find('KID').text();
				let KGENRE = $(this).find('KGENRE').text();
				let KNAME = $(this).find('KNAME').text();
				let KBIRTH = $(this).find('KBIRTH').text();
				let KADDR = $(this).find('KADDR').text();
				let KEMAIL = $(this).find('KEMAIL').text();
				let KTEL = $(this).find('KTEL').text();
				let KTEAMNO = $(this).find('KTEAMNO').text();
				let KTEAM = $(this).find('KTEAM').text();
				let KINFO = $(this).find('KINFO').text();
				let KURL = $(this).find('KURL').text();
				let SCORING = $(this).find('SCORING').text();
				let KCOUNTMIN = $(this).find('KCOUNTMIN').text();
				let KCOUNTMAX = $(this).find('KCOUNTMAX').text();
				let SCORE = $(this).find('SCORE').text();
				
				
				const count = KCOUNTMIN + '회 ~ ' + KCOUNTMAX + '회';
				const area = KADDR.slice(0, 2);
				
				$('#ad-title').html(KTEAM);
				$('#name').html(KNAME);
				$('#tname').html(KTEAM);
				$('#tel').html(KTEL);
				$('#genre').html(KGENRE);
				$('#birth').html(KBIRTH);
				$('#count').html(count);
				$('#email').html(KEMAIL);
				$('#area').html(area);
				$('#info').html(KINFO);
				$('#url').html(KURL);
				
				if(SCORING === 'Y'){
					$('#score').val(SCORE);
					$('#score-apply').html('점수 수정');
				}
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
	});
}

const handlerScoreAplly = () => {
	const score = $('#score').val();
	
	if(score === ''){
		alert('점수를 입력해주세요.');
		$('#score').focus();
		return;
	} else if (parseInt(score) > 100) {
		alert('최대 점수는 100점 입니다.');
		$('#score').val('100');
		$('#score').focus();
		return;
	}
	
	const id = getParam('id');
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/recruit/resource/service/fa/update_applicant_score.jsp',
		data: {
			id: id,
			score: score
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		},
		complete: function(){
			alert('점수가 등록되었습니다.');
			history.go(-1);
		}
	});
}