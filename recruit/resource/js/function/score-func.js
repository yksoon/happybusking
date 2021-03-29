const sendTeamChk = () => {
	const chkTeam = sessionStorage.getItem('team-score');
	
	if(chkTeam === null || chkTeam === 'null' || chkTeam === '') return;
	else {
		const chk = chkTeam.split(',');
		const cnt = chk.length;
		
		for(var i=0; i<cnt; i++){
			$('#'+chk[i]).find('.sl-checkbox').prop('checked', true);
		}
		
		$('.sl-select-count').html(cnt);
	}
}

const allSend = () => {
	const chkTeam = sessionStorage.getItem('team-score');
	const mlTitle = sessionStorage.getItem('ml-title');
	const body = '신청하신 [' + mlTitle + ']에 선발되셨습니다.';
	
	if(chkTeam === null || chkTeam === 'null' || chkTeam === ''){
		alert('통보할 팀을 선택해주세요.');
		return;
	} else {
		showLoading('통보중입니다.');
		
		const chk = chkTeam.split(',');
		const cnt = chk.length;
		
		for(var i=0; i<cnt; i++){
			oneSend(chk[i], body);
		}

		sessionStorage.removeItem('team-score');
		hideLoading();
		alert('선발 결과를 통보했습니다.');
	}
}

const getApplicantScoreList = (no, start, sort) => {
	sessionStorage.removeItem('sl-data-cnt');
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/recruit/resource/service/fa/get_applicant_score_list.jsp',
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
			
			$('#sl-list').empty();
			
			
			const thead = '<tr>' +
							'<th class="ft-gray ft-12 ft-bold" style="width: 15%;">선택</th>'+
							'<th class="ft-gray ft-12 ft-bold" style="width: 15%;">점수</th>'+
							'<th class="ft-gray ft-12 ft-bold">팀명</th>'+
							'<th class="ft-gray ft-12 ft-bold" style="width: 20%;">유튜브</th>'+
						'</tr>';		
			
			$('#sl-list').append(thead);
			
			if(DATA.length === 0){
				const tbody = '<td colspan="4" class="bg-white ft-lgray ft-12 no-list">채점결과가 없습니다.</td>';
				$('#sl-list').append(tbody);
			}
			
			$(DATA).each(function(){
				let KID = $(this).find('KID').text();
				let KGENRE = $(this).find('KGENRE').text();
				let KTEAM = $(this).find('KTEAM').text();
				let KURL = $(this).find('KURL').text();
				let TITLE = $(this).find('TITLE').text(); 
				let SCORE = $(this).find('SCORE').text();
				let CNT = $(this).find('CNT').text();
				
				$('#sl-title').html(TITLE);
				
				const tbody = '<tr id="'+KID+'">'+
									'<td class="bg-white ft-12 sl-check">'+
										'<input type="checkbox" class="sl-checkbox" name="sl-check" data-role="none" id="c'+KID+'"/>'+
										'<label class="sl-check-label" data-role="none" for="c'+KID+'"></label>' +
									'</td>'+	
									'<td class="bg-white  ft-12 sl-score"><img class="sl-star" src="/recruit/resource/img/common/score-purple.png"/>'+SCORE+'</td>'+
									'<td class="bg-white  ft-12 ft-bold under-line sl-tname">'+KTEAM+'</td>'+
									'<td class="bg-white sl-youtube" id="'+KURL+'"><img src="/recruit/resource/img/common/youtube.jpg"/></td>'+
								'</tr>';
				
				$('#sl-list').append(tbody); 
				
				sessionStorage.setItem('sl-data-cnt', CNT);
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
	});
}
