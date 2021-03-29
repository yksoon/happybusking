const MetroArtistFunction = {
	GetMetroArtistList: function(search, start){
		let th = '<tr>' +
				'<th class="bg_r_gray ft_16 ft_l_black mi_name">팀명</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black mi_intro">팀소개</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black mi_genre">장르</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black">주활동지역</th>' +
			'</tr>';
		$('#metroartist_table').empty();
		$('#metroartist_table').append(th);
		
		$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/cooperation/seoulmetro/adminpage/resource/service/metroartist/get_metroartist_list.jsp',
		data: {
			search : search,
			start : start
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$('#metroartist_table').append( '<tr><td colspan="4">검색 결과가 없습니다</td></tr>');
				return;
			}
			
			$(DATA).each(function(){
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var TEAM_INTRO = $(this).find('TEAM_INTRO').text();
				var GENRE = $(this).find('GENRE').text();
				var CODE_AREA = $(this).find('CODE_AREA').text();
				var CNT = $(this).find('CNT').text();
				
				let td = '<tr class="metroartist_item" id="'+TEAM_NO+'">' +
							'<td class="ft_15 cursorpointer mi_name">'+TEAM_NAME+'</td>' +
							'<td class="ft_15 cursorpointer mi_intro">'+TEAM_INTRO+'</td>' +
							'<td class="ft_15 cursorpointer mi_genre">'+GENRE+'</td>' +
							'<td class="ft_15 cursorpointer">'+CODE_AREA+'</td>' +
						'</tr>';
				
				$('#metroartist_table').append(td);
				
				totaldata = CNT;
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
		});
	},
	GetApplyManageList: function(search, start){
		let th = '<tr>' +
				'<th class="bg_r_gray ft_16 ft_l_black ai_name">신청자</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ai_team">팀명</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ai_count">월 공연 횟수</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ai_genre">장르</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ai_state">상태</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ai_date">신청일</th>' +
			'</tr>';
		$('#applymanage_table').empty();
		$('#applymanage_table').append(th);
		
		$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/cooperation/seoulmetro/adminpage/resource/service/metroartist/get_applymanage_list.jsp',
		data: {
			search : search,
			start : start
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$('#applymanage_table').append( '<tr><td colspan="5">검색 결과가 없습니다</td></tr>');
				return;
			}
			
			$(DATA).each(function(){
				var KID = $(this).find('KID').text();
				var KNAME = $(this).find('KNAME').text();
				var KTEAM = $(this).find('KTEAM').text();
				var KGENRE = $(this).find('KGENRE').text();
				var KDATE = $(this).find('KDATE').text();
				var KAPPLY = $(this).find('KAPPLY').text();
				var CNT = $(this).find('CNT').text();
				var KCOUNTMIN = $(this).find('KCOUNTMIN').text();
				var KCOUNTMAX = $(this).find('KCOUNTMAX').text();
				
				var KCOUNT = KCOUNTMIN + '회 ~ ' + KCOUNTMAX + '회';
				
				var state = '';
				
				switch(KAPPLY){
					case 'W' : state = '대기'; break;
					case 'N' : state = '거절'; break;
					case 'Y' : state = '수락'; break;
					default: state = '에러'; break;
				}
				
				let td = '<tr class="applymanage_item" id="'+KID+'">' +
							'<td class="ft_15 cursorpointer ai_name">'+KNAME+'</td>' +
							'<td class="ft_15 cursorpointer ai_team">'+KTEAM+'</td>' +
							'<td class="ft_15 cursorpointer ai_count">'+KCOUNT+'</td>' +
							'<td class="ft_15 cursorpointer ai_genre">'+KGENRE+'</td>' +
							'<td class="ft_15 cursorpointer ai_state">'+state+'</td>' +
							'<td class="ft_15 cursorpointer ai_date">'+KDATE+'</td>' +
						'</tr>';
				
				$('#applymanage_table').append(td);
				
				totaldata = CNT;
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
		});
	},
	GetScheduleManageList: function(search, start){
		let th = '<tr>' +
				'<th class="bg_r_gray ft_16 ft_l_black si_place">장소</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black si_team">팀명</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black si_date">공연일</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black si_time">공연시간</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black si_attend">출석여부</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black si_cancel">취소여부</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black si_regdate">신청일</th>' +
			'</tr>';
		$('#schedulemanage_table').empty();
		$('#schedulemanage_table').append(th);
		
		$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/cooperation/seoulmetro/adminpage/resource/service/metroartist/get_schedulemanage_list.jsp',
		data: {
			search : search,
			start : start
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$('#schedulemanage_table').append( '<tr><td colspan="7">검색 결과가 없습니다</td></tr>');
				return;
			}
			
			$(DATA).each(function(){
				var NO = $(this).find('NO').text();
				var DATE = $(this).find('DATE').text();
				var STIME = $(this).find('STIME').text();
				var ETIME = $(this).find('ETIME').text();
				var ATTENDANCE = $(this).find('ATTENDANCE').text();
				var CANCEL = $(this).find('CANCEL').text();
				var REGDATE = $(this).find('REGDATE').text().split('.')[0];
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var PNAME = $(this).find('PNAME').text();
				var CNT = $(this).find('CNT').text();
				
				var fulltime =  STIME + ' ~ ' + ETIME;
				var attend = '';
				
				switch(ATTENDANCE){
					case 'N': attend = '미출석'; break;
					case 'Y': attend = '출석'; break;
					default: attend = '에러'; break;
				}
				
				var cc;
				
				switch(CANCEL){
					case 'N': cc  = '<select class="ft_15 ft_blue si_cencel_change"><option selected="selected" value="N">승인</option><option value="Y">취소</option></select>'; break;
					case 'Y': cc  = '<select class="ft_15 ft_l_gray_c si_cencel_change"><option value="N">승인</option><option selected="selected" value="Y">취소</option></select>'; break;
					default: cc  = '<select class="ft_15 si_cencel_change"><option selected="selected" disabled="disabled">에러</option></select>'; break;
				}
				
				let td = '<tr class="schedulemanage_item" id="'+NO+'">' +
							'<td class="ft_15 cursorpointer si_place">'+PNAME+'</td>' +
							'<td class="ft_15 cursorpointer si_team">'+TEAM_NAME+'</td>' +
							'<td class="ft_15 cursorpointer si_date">'+CommonFunction.DateFormatChange(DATE)+'</td>' +
							'<td class="ft_15 cursorpointer si_time">'+fulltime+'</td>' +
							'<td class="ft_15 cursorpointer si_attend">'+attend+'</td>' +
							'<td class="ft_15 cursorpointer si_cancel">'+cc+'</td>' +
							'<td class="ft_15 cursorpointer si_regdate">'+REGDATE+'</td>' +
						'</tr>';
				
				$('#schedulemanage_table').append(td);
				
				totaldata = CNT;
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
		});
	},
	GetServeyResultsList: function(search, start){
		let th = '<tr>' +
				'<th class="bg_r_gray ft_16 ft_l_black ei_name">공연팀명</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ei_date">공연일</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ei_time">공연시간</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ei_score">점수</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ei_content">의견</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ei_regdate">작성일</th>' +
			'</tr>';
		$('#serveyresults_table').empty();
		$('#serveyresults_table').append(th);
		
		$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/cooperation/seoulmetro/adminpage/resource/service/metroartist/get_serveyresults_list.jsp',
		data: {
			search : search,
			start : start
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$('#serveyresults_table').append( '<tr><td colspan="6">검색 결과가 없습니다</td></tr>');
				return;
			}
			
			$(DATA).each(function(){
				var NO = $(this).find('NO').text();
				var SCORE = $(this).find('SCORE').text();
				var CONTENT = $(this).find('CONTENT').text();
				var REGDATE = $(this).find('REGDATE').text().split('.')[0];
				var DATE = $(this).find('DATE').text();
				var STIME = $(this).find('STIME').text();
				var ETIME = $(this).find('ETIME').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var CNT = $(this).find('CNT').text();
				
				var fulltime =  STIME + ' ~ ' + ETIME;
				
				let td = '<tr class="evalutionresults_item" id="'+NO+'">' +
							'<td class="ft_15 cursorpointer ei_name">'+TEAM_NAME+'</td>' +
							'<td class="ft_15 cursorpointer ei_date">'+CommonFunction.DateFormatChange(DATE)+'</td>' +
							'<td class="ft_15 cursorpointer ei_time">'+fulltime+'</td>' +
							'<td class="ft_15 cursorpointer ei_score">'+SCORE+'</td>' +
							'<td class="ft_15 cursorpointer ei_content" title="'+CONTENT+'">'+CONTENT+'</td>' +
							'<td class="ft_15 cursorpointer ei_regdate">'+REGDATE+'</td>' +
						'</tr>';
				
				$('#serveyresults_table').append(td);
				
				totaldata = CNT;
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
		});
	},
	GetEvalutionResultsList: function(search, start, date){
		let th = '<tr>' +
				'<th class="bg_r_gray ft_16 ft_l_black ri_name">팀명</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ri_att">공연횟수</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ri_scan">공사기여도</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ri_score">설문평가</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ri_wg">실무진평가</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ri_cancel">공연취소</th>' +
				'<th class="bg_r_gray ft_16 ft_l_black ri_total">총점</th>' +
			'</tr>';
		$('#evaluationresults_table').empty();
		$('#evaluationresults_table').append(th);
		
		$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/cooperation/seoulmetro/adminpage/resource/service/metroartist/get_evalutionresults_list.jsp',
		data: {
			search : search,
			start : start,
			date: date
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$('#evaluationresults_table').append( '<tr><td colspan="7">검색 결과가 없습니다</td></tr>');
				return;
			}
			
			var MAX_ATT = 30;
			var MAX_SCAN = 30;
			var MAX_SCORE = 20;
			
			$(DATA).each(function(){
				var NO = $(this).find('NO').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var ATT_CNT = $(this).find('ATT_CNT').text();				//공연횟수
				var SCAN_CNT = $(this).find('SCAN_CNT').text();				//공사기여도
				var SCORE = $(this).find('SCORE').text();					//설문평가
				var WORKING_GROUP = '0';									//실무진평가 (추후 추가)
				var CANCEL_CNT = $(this).find('CANCEL_CNT').text();			//공연취소 (마이너스)
				var CNT = $(this).find('CNT').text();		
				
				ATT_CNT = parseInt(ATT_CNT) * 6;
				if(ATT_CNT > MAX_ATT) ATT_CNT = MAX_ATT;
				
				if(parseInt(SCAN_CNT) > MAX_SCAN) SCAN_CNT = MAX_SCAN;
				
				if(SCORE == '') SCORE = 0;
				else if(parseInt(SCORE) > MAX_SCORE) SCORE = MAX_SCORE;
				
				CANCEL_CNT = parseInt(CANCEL_CNT) * -10;
				
				var TOTAL = parseInt(ATT_CNT) + parseInt(SCAN_CNT) + parseInt(SCORE) + parseInt(WORKING_GROUP) + parseInt(CANCEL_CNT); //총점
				
				let td = '<tr class="evalutionresults_item" id="'+NO+'">' +
							'<td class="ft_15 cursorpointer ri_name">'+TEAM_NAME+'</td>' +
							'<td class="ft_15 cursorpointer ri_att">'+ATT_CNT+'</td>' +
							'<td class="ft_15 cursorpointer ri_scan">'+SCAN_CNT+'</td>' +
							'<td class="ft_15 cursorpointer ri_score">'+SCORE+'</td>' +
							'<td class="ft_15 cursorpointer ri_wg">'+WORKING_GROUP+'</td>' +
							'<td class="ft_15 cursorpointer ri_cancel">'+CANCEL_CNT+'</td>' +
							'<td class="ft_15 cursorpointer ri_regdate">'+TOTAL+'</td>' +
						'</tr>';
				
				$('#evaluationresults_table').append(td);
				
				totaldata = CNT;
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
		});
	},
	GetMetroArtistDetail: function(tno){
		$.ajax({
			type: "GET",
			cache: false,
			async: false,
			url: '/cooperation/seoulmetro/adminpage/resource/service/metroartist/get_metroartist_detail.jsp',
			data: {
				tno : tno
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				if(DATA.length == 0){
					alert('존재하지 않는 팀입니다.');
					history.go(-1);
					return;
				}
				
				$(DATA).each(function(){
					var TEAM_NO = $(this).find('TEAM_NO').text();
					var TEAM_NAME = $(this).find('TEAM_NAME').text();
					var TEAM_INTRO = $(this).find('TEAM_INTRO').text();			
					var GENRE = $(this).find('GENRE').text();		
					var CODE_AREA = $(this).find('CODE_AREA').text();				
					var KURL = $(this).find('KURL').text();			
					var KTEL = $(this).find('KTEL').text();		
					var EMAIL = $(this).find('EMAIL').text();		
					var BIRTH = $(this).find('BIRTH').text();		
					
					var KCOUNTMIN = $(this).find('KCOUNTMIN').text();			
					var KCOUNTMAX = $(this).find('KCOUNTMAX').text();		
					
					var COUNT = KCOUNTMIN + '회 ~ ' + KCOUNTMAX + '회';	
					
					$('#md_tname').html(TEAM_NAME);
					$('#md_phone').html(KTEL);
					$('#md_genre').html(GENRE);
					$('#md_area').html(CODE_AREA);
					$('#md_content').html(TEAM_INTRO);
					$('#md_video').html(KURL);
					$('#md_birth').html(EMAIL);
					$('#md_email').html(BIRTH);
					$('#md_count').html(COUNT);
				});
			},
			error: function(x, h, r){
				console.log(x);
				console.log(h);
				console.log(r);
			}
			});
	},
	GetApplyManageDetail: function(n){
		$.ajax({
			type: "GET",
			cache: false,
			async: false,
			url: '/cooperation/seoulmetro/adminpage/resource/service/metroartist/get_applymanage_detail.jsp',
			data: {
				n : n
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				if(DATA.length == 0){
					alert('존재하지 않는 팀입니다.');
					history.go(-1);
					return;
				}
				
				$(DATA).each(function(){
					var KID = $(this).find('KID').text();
					var KNAME = $(this).find('KNAME').text();
					var KTEL = $(this).find('KTEL').text();			
					var KTEAMNO = $(this).find('KTEAMNO').text();	
					var KTEAM = $(this).find('KTEAM').text();			
					var KGENRE = $(this).find('KGENRE').text();				
					var KURL = $(this).find('KURL').text();			
					var KAPPLY = $(this).find('KAPPLY').text();		
					var KINFO = $(this).find('KINFO').text();	
					var BELONG = $(this).find('BELONG').text();	
					var CODE_AREA = $(this).find('CODE_AREA').text();
					var KBIRTH = $(this).find('KBIRTH').text();
					var EMAIL = $(this).find('EMAIL').text();
					
					var KCOUNTMIN = $(this).find('KCOUNTMIN').text();			
					var KCOUNTMAX = $(this).find('KCOUNTMAX').text();		
					
					var COUNT = KCOUNTMIN + '회 ~ ' + KCOUNTMAX + '회';
					
					
					$('#ad_name').html(KNAME);
					$('#ad_tname').html(KTEAM);
					$('#ad_phone').html(KTEL);
					$('#ad_genre').html(KGENRE);
					$('#ad_area').html(CODE_AREA);
					$('#ad_content').html(KINFO);
					$('#ad_video').html(KURL);
					$('#ad_birth').html(KBIRTH);
					$('#ad_email').html(EMAIL);
					
					$('#ad_teamno').val(KTEAMNO);
					$('#ad_belong').val(BELONG);
					$('#ad_count').html(COUNT);
				});
			},
			error: function(x, h, r){
				console.log(x);
				console.log(h);
				console.log(r);
			}
		});
	},
	SetApplyManageYes: function(kid, tno, belong){
		let conf = confirm('수락하시겠습니까?');
		if(!conf) return;
		
		$.ajax({
			type: "GET",
			cache: false,
			async: false,
			url: '/cooperation/seoulmetro/adminpage/resource/service/metroartist/set_applymanage_yes.jsp',
			data: {
				kid: kid, 
				tno: tno,
				belong: belong
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
			},
			error: function(x, h, r){
				console.log(x);
				console.log(h);
				console.log(r);
			},
			complete: function(){
				alert('수락되었습니다');
				history.go(-1);
			}
		});
	},
	SetApplyManageNo: function(kid){
		let conf = confirm('거절하시겠습니까?');
		if(!conf) return;
		
		$.ajax({
			type: "GET",
			cache: false,
			async: false,
			url: '/cooperation/seoulmetro/adminpage/resource/service/metroartist/set_applymanage_no.jsp',
			data: {
				kid: kid
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
			},
			error: function(x, h, r){
				console.log(x);
				console.log(h);
				console.log(r);
			},
			complete: function(){
				alert('거절되었습니다');
				history.go(-1);
			}
		});
	},
	SetScheduleApply: function(id, value){
		$.ajax({
			type: "GET",
			cache: false,
			async: false,
			url: '/cooperation/seoulmetro/adminpage/resource/service/metroartist/set_scheduleapply.jsp',
			data: {
				id: id,
				value: value
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
			},
			error: function(x, h, r){
				console.log(x);
				console.log(h);
				console.log(r);
			},
			complete: function(){
				history.go(0);
			}
		});
	}
};