
function goScheduleApply(){
	if(userLogin_chk() == false){
		alert('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
			return;
		} else {
			if(!metroArtistChk()){
				alert('메트로 아티스트만 이용 가능합니다.');
				return;
			} else {
				loadPage('seoul_metro/schedule_apply.jsp');
			}
		}
	}
}

function goScheduleList(){
	if(userLogin_chk() == false){
		alert('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
			return;
		} else {
			if(!metroArtistChk()){
				alert('메트로 아티스트만 이용 가능합니다.');
				return;
			} else {
				loadPage('seoul_metro/schedule_list.jsp');
			}
		}
	}
}

function makeScheduleApplyCalendar(){
	$('#pb-calendar').remove();
	$('.sci_calendar_box').html('<div class="pb-calendar" id="pb-calendar"></div>');
	
	var current_yyyymm = moment().format("YYYYMM");
	
	$('#pb-calendar').pb_calendar({
		'day_selectable': true,
	
		'callback_selected_day': function(data){
			scheduleApplyCalendarSelect(data);
		},
		'callback_changed_month': function(data){
			scheduleApplyCalendarChange(data);
		},
		
		'min_yyyymm': null,
		'max_yyyymm': null,
		
		'next_month_button': '<i class="fas fa-chevron-right"></i>',
		'prev_month_button': '<i class="fas fa-chevron-left"></i>',
		
		schedule_list: function(callback, yyyymm){
			var date = new Date(yyyymm);
			var year = date.getFullYear();
			var month = setPad(1 + date.getMonth(), 2);
			
			current_yyyymm = year + month;
			
			var temp_schedule_list = {};
			
			temp_schedule_list = scheduleApplyAvailability(current_yyyymm);
			
			callback(temp_schedule_list);
		},
		schedule_dot_item_render: function(dot_item_el, schedule_data){
			dot_item_el.addClass(schedule_data['style'], true);
			return dot_item_el;
		}
	});
	
	var dayTarget = $('.calendar-head-frame').find('.row-dayname').find('.col-dayname');
	scheduleApplyCalendarDayKR(dayTarget);
	scheduleApplyCalendarMonthKR();
}
//
//날짜 선택시
var CNTMONTH;
var MAXCNTMONTH;		//월 공연 횟수 제한
function scheduleApplyCalendarSelect(data){
	var target = $('div[data-day-yyyymmdd='+data+']').find('.schedule-dot-list').find('span');
	
	$('.col').removeClass('pb_calendar_select');
	target.parents('.col').addClass('pb_calendar_select');
	
	var tergetClass = target.attr('class').split(' ');
	if(tergetClass[1] == 'pb_calendar_red'){
		//신청 마감된 경우
		alert('신청 마감되었습니다\n다른 날짜에 신청해주세요.');
		scheduleApplicationTimeSelectReset($('#sci_stime'));
		scheduleApplicationTimeSelectReset($('#sci_etime'));
	} else {
		//마감되지 않은 경우
		var id = $('#sap_area_select').find('.sas_on').attr('id');
		
		//var beforedate = prevMonth(data);		이전달 공연 막아야되는 경우 주석 해제
		var beforedate = '';
		getScheduleTime(id, data, beforedate);
		
		if(parseInt(CNTMONTH) >= MAXCNTMONTH){
			var pmonth = $('.year-month-frame').find('.month').text();
			var place = $('#sap_area_select').find('.sas_on').text();
			alert(pmonth+' '+place+'에 '+MAXCNTMONTH+'회 이상 공연을 신청 하셨습니다.\n다른 장소를 선택해주세요');
			scheduleApplicationTimeSelectReset($('#sci_stime'));
			scheduleApplicationTimeSelectReset($('#sci_etime'));
			$('.col').removeClass('pb_calendar_select');
		}
	}
}

//월 변경시
function scheduleApplyCalendarChange(data){
	scheduleApplyCalendarMonthKR();
}

//일정 신청 가능여부 DB연동
var MAX_CNT;
function scheduleApplyAvailability(yyyymm){
	var year = yyyymm.substring(0, 4);
	var month = parseInt(yyyymm.substring(4, 6));
	
	var lastDay = new Date(year, month, 0).getDate();
	
	var temp_schedule_list = {};
	
	var id = $('#sap_area_select').find('.sas_on').attr('id');
	var styleText;

	var performAvailability = getPerformAvailability(id);
	for(var i = 1; i <= lastDay; i++){
		var idx = yyyymm+setPad(i, 2);
		
		var dday = ddayExon(idx);
		
		if(dday < 0) styleText = 'pb_calendar_red';
		else {
			if(typeof performAvailability[idx] == undefined || typeof performAvailability[idx] == 'undefined') styleText = 'pb_calendar_green';
			else styleText = 'pb_calendar_red';
		}
		
		temp_schedule_list[idx] = [
			{'ID' : idx+i, style : styleText}
		];
	}
	
	return temp_schedule_list;
}

//요일 한글로 변경
function scheduleApplyCalendarDayKR(dayTarget){
	var str;
	
	for(var i = 0; i < dayTarget.length; i++){
		str = dayTarget.eq(i).text();
		switch(str){
			case 'SUN' : str = '일'; break;
			case 'MON' : str = '월'; break;
			case 'TUE' : str = '화'; break;
			case 'WED' : str = '수'; break;
			case 'THU' : str = '목'; break;
			case 'FRI' : str = '금'; break;
			case 'SAT' : str = '토'; break;
			default: str = ''; break;
		}
		
		dayTarget.eq(i).text(str);
	}
}

//월 한글로 변경
function scheduleApplyCalendarMonthKR(){
	var target = $('.year-month-frame').find('.month');
	var str = target.text();
	switch(str){
		case 'Jan' : str = '1월'; break;
		case 'Feb' : str = '2월'; break;
		case 'Mar' : str = '3월'; break;
		case 'Apr' : str = '4월'; break;
		case 'May' : str = '5월'; break;
		case 'Jun' : str = '6월'; break;
		case 'Jul' : str = '7월'; break;
		case 'Aug' : str = '8월'; break;
		case 'Sep' : str = '9월'; break;
		case 'Oct' : str = '10월'; break;
		case 'Nov' : str = '11월'; break;
		case 'Dec' : str = '12월'; break;
		default: str = ''; break;
	}
	target.text(str);
}

//공연 신청 가능 팀 목록 가져오기
function getPerformRegTime(){
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		async: false,
		url: '/service/seoul_metro/get_perform_reg_team.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#sap_team_select').empty();
			
			$(DATA).each(function(i){
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				
				var html;
				
				if(i == 0) html = '<div class="sts_item sas_on" id="'+TEAM_NO+'">'+TEAM_NAME+'</div>';
				else html = '<div class="sts_item" id="'+TEAM_NO+'">'+TEAM_NAME+'</div>';
				
				
				$('#sap_team_select').append(html);
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
	});
}

//공연 신청 가능 장소 목록 가져오기
function getPerformPlace(){
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		async: false,
		url: '/service/seoul_metro/get_perform_place.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#sap_area_select').empty();
			
			$(DATA).each(function(i){
				var NO = $(this).find('NO').text();
				var NAME = $(this).find('NAME').text();
				
				var html;
				
				if(i == 0) html = '<div class="sas_item sas_on" id="'+NO+'">'+NAME+'</div>';
				else html = '<div class="sas_item" id="'+NO+'">'+NAME+'</div>';
				
				
				$('#sap_area_select').append(html);
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		},
		complete: function(){
			//달력 생성
			makeScheduleApplyCalendar();
		}
	});
}

//공연 신청 가능 여부 가져오기
function getPerformAvailability(id){
	var performAvailavility = {};
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		async: false,
		url: '/service/seoul_metro/get_perform_availability.jsp',
		data: {
			pno: id
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i){
				var DATE = $(this).find('DATE').text();
				var CNT = $(this).find('CNT').text();
				MAX_CNT = $(this).find('MAX_CNT').text();
				
				performAvailavility[DATE] = CNT;
				
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
	});
	return performAvailavility;
}

var timeArray = new Array();

//공연 신청 가능 시간 가져오기
function getScheduleTime(id, date, beforedate){
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		async: false,
		url: '/service/seoul_metro/get_schedule_time.jsp',
		data: {
			pno: id,
			date: date,
			beforedate: beforedate
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			timeArray = new Array();
			
			$('#sci_stime').empty();
			$('#sci_stime').html('<option selected="selected" disabled="disabled" value="">공연 시작 시간</option>');
			
			$('#sci_etime').empty();
			$('#sci_etime').html('<option selected="selected" disabled="disabled" value="">공연 종료 시간</option>');
			
			
			$(DATA).each(function(i){
				var STIME = $(this).find('STIME').text();
				var ETIME = $(this).find('ETIME').text();
				CNTMONTH = $(this).find('CNTMONTH').text();
				MAXCNTMONTH = $(this).find('MAXCOUNT').text();
				var STIMECONCAT = $(this).find('STIMECONCAT').text();
				var ETIMECONCAT = $(this).find('ETIMECONCAT').text();
				
				var stimeNum, etimeNum;
				
				stimeNum = parseInt(STIME.split(':')[0]);
				etimeNum = parseInt(ETIME.split(':')[0]);
				
				for(var i=stimeNum; i <= etimeNum; i++){
					STIME = setPad(i, 2) + ':' + '00';
					timeArray.push(STIME);
				}
				
				var stimeconcatArray, etimeconcatArray = new Array();
				var stimeconcatNum, etimeconcatNum;
				
				stimeconcatArray = STIMECONCAT.split(',');
				etimeconcatArray = ETIMECONCAT.split(',');
				
				for(var i=0; i<stimeconcatArray.length; i++){
					stimeconcatNum = parseInt(stimeconcatArray[i]);
					etimeconcatNum = parseInt(etimeconcatArray[i]);
					
					for(var j=stimeconcatNum; j<=etimeconcatNum; j++){
						var removeTime = setPad(j, 2) + ':' + '00';
						
						var idx = timeArray.indexOf(removeTime);
						if(idx > -1) timeArray.splice(idx, 1); 
					}
				}
				
				var html ='';
				
				for(var i=0; i < timeArray.length; i++){
					STIME = timeArray[i];
					html = '<option value="'+STIME+'">'+STIME+'</option>';
					$('#sci_stime').append(html);
				}
				
				$('#sci_stime').selectmenu('refresh');
				$('#sci_etime').selectmenu('refresh');
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
	});
}

//공연 일정 등록
function scheduleApplicationReg(){
	var tno = $('#sap_team_select').find('.sas_on').attr('id');
	var pno = $('#sap_area_select').find('.sas_on').attr('id');
	var date = $('.pb_calendar_select').attr('data-day-yyyymmdd');
	var stime = $('#sci_stime').val();
	var etime = $('#sci_etime').val();
	
	if(typeof date == undefined || typeof date == 'undefined'){
		alert('신청가능한 날짜를 선택해주세요.');
		return;
	} else if(stime == null || stime == 'null' || stime == ''){
		alert('공연 시작 시간을 선택해주세요.');
		return;
	} else if(etime == null || etime == 'null' || etime == ''){
		alert('공연 종료 시간을 선택해주세요.');
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		async: false,
		url: '/service/seoul_metro/insert_schedule.jsp',
		data :{
			tno: tno,
			pno: pno,
			date: date,
			stime: stime,
			etime: etime
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var RES = $(this).find('RES').text();
				
				if(RES == '1'){
					alert('신청이 완료되었습니다.');
					goScheduleList();
				} else {
					alert('처리가 지연되고있습니다. 잠시후 다시 시도해주세요.\n해결되지 않는 경우 해피버스킹으로 문의주시면 빠른처리 도와드리겠습니다.');
					return;
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

//공연 신청 목록 가져오기
function getScheduleApplicationList(){
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		async: false,
		url: '/service/seoul_metro/get_schedule_list.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			$('#slp_list').empty();
			
			if(DATA.length == 0){
				$('#slp_list').html('<div class="noViewBtn">공연 신청 내역이 없습니다.</div>');
			}
			
			
			$(DATA).each(function(i){
				var NO = $(this).find('NO').text();
				var DATE = $(this).find('DATE').text();
				var STIME = divistionMorningAfternoon($(this).find('STIME').text());
				var ETIME = divistionMorningAfternoon($(this).find('ETIME').text());
				var TEAMNAME = $(this).find('TEAMNAME').text();
				var PNAME = $(this).find('PNAME').text();
				var CANCEL = $(this).find('CANCEL').text();
				
				var date = DATE.substr(0, 4)+'년 '+DATE.substr(4, 2)+'월 '+DATE.substr(6, 2)+'일';
				var dday, cancelAvailability;
				
				dday = ddayExon(DATE);
				if(CANCEL == 'Y'){
					//이미 취소된 경우
					cancelAvailability = '<p class="slpi_btn slpi_wait">취소완료</p>' +
										'<p class="slpi_btn slpi_nocancel">취소불가</p>';
				} else {
					//취소되지 않은 경우
					if(dday > 2) {
						//3일 이전
						cancelAvailability = '<p class="slpi_btn slpi_apply">승인완료</p>' +
											'<p class="slpi_btn slpi_cancel" id="'+NO+'">신청취소</p>';
					}
					else {
						//3일 이후
						cancelAvailability = '<p class="slpi_btn slpi_apply">승인완료</p>' +
											'<p class="slpi_btn slpi_nocancel">취소불가</p>';
					}
				}
				
				
				var html = '<div class="slp_item">' +
								'<div class="slpi_title">' +
									'<p class="slpit_left">'+TEAMNAME+'</p>'+
									'<p class="slpit_right">'+PNAME+'</p>'+
								'</div>'+
								'<p class="slpi_date">'+date+'</p>'+
								'<p class="slpi_content">'+STIME+' - '+ETIME+'</p>'+
								'<div class="slpi_btn_box">'+
									cancelAvailability +
								'</div>'+
							'</div>';
				
				$('#slp_list').append(html);
			});
		},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
		}
	});
}

function scheduleApplicationCancel(no){
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		async: false,
		url: '/service/seoul_metro/set_schedule_cencel.jsp',
		data: {
			no: no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var RES = $(this).find('RES').text();
				
				if(RES == '1') alert('취소되었습니다.');
				else alert('처리가 지연되고있습니다. 잠시후 다시 시도해주세요.\n해결되지 않는 경우 해피버스킹으로 문의주시면 빠른처리 도와드리겠습니다.');
			});
					},
		error: function(x, h, r){
			console.log(x);
			console.log(h);
			console.log(r);
			alert('처리가 지연되고있습니다. 잠시후 다시 시도해주세요.\n해결되지 않는 경우 해피버스킹으로 문의주시면 빠른처리 도와드리겠습니다.');
		},
		complete: function(){
			getScheduleApplicationList();
		}
	});
}

//공연신청 시간 초기화
function scheduleApplicationTimeSelectReset(target){
	target.empty();
	target.html('<option selected="selected" disabled="disabled" value="">날짜를 먼저 선택해주세요</option>');
	target.selectmenu('refresh');
}