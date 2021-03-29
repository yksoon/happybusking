//////////////////////////일정 신청 페이지/////////////////////////////////////////////
$(document).on('pageinit', '#schedule_apply_page', function(){
	getPerformRegTime();
	getPerformPlace();
});

$(document).on('click', '.sas_item', function(){
	$('.sas_item').removeClass('sas_on');
	$(this).addClass('sas_on');
	
	makeScheduleApplyCalendar();
	
	scheduleApplicationTimeSelectReset($('#sci_stime'));
	scheduleApplicationTimeSelectReset($('#sci_etime'));
});

$(document).on('click', '.sts_item', function(){
	$('.sts_item').removeClass('sas_on');
	$(this).addClass('sas_on');
});

$(document).on('change', '#sci_stime', function(){
	$target = $('#sci_etime');
	$target.empty();
	$target.html('<option selected="selected" disabled="disabled" value="">종료 시간을 선택해주세요</option>');
	
	var value = $(this).val();
	var idx = timeArray.indexOf(value);
	
	var idxNum = parseInt(timeArray[idx].split(':')[0]);
	var etimeTempNum, etimeTempNum2;
	var etimeTemp;
	
	var etimeArray = new Array();
	
	if(idx === timeArray.length-1){
		var etime = setPad(idxNum+1, 2) + ':' + '00';
		etimeArray.push(etime);
	} else {
		for(var i=idx; i<timeArray.length; i++){
			etimeTempNum = parseInt(timeArray[i].split(':')[0]);
			
			etimeTemp = setPad(etimeTempNum+1, 2) + ':' + '00';
			if(idxNum === etimeTempNum || etimeTempNum2+1 === etimeTempNum){
				etimeArray.push(etimeTemp);
			} else {
				break;
			}
			
			etimeTempNum2 = etimeTempNum;
		}
	}
	
	console.log(etimeArray);
	
	var html, ETIME = '';
	for(var i=0; i<etimeArray.length; i++){
		ETIME = etimeArray[i];
		html = '<option value="'+ETIME+'">'+ETIME+'</option>';
		$target.append(html);
	}
	
	$target.selectmenu('refresh');
});
//////////////////////////////////////////////////////////////////////////////////////


/////////////////////////일정 목록 페이지////////////////////////////////////////////////
$(document).on('pageinit', '#schedule_list_page', function(){
	getScheduleApplicationList();
});

$(document).on('click', '.slpi_cancel', function(){
	var target = $(this).parents('.slp_item');
	var no = $(this).attr('id');
	var date = target.find('.slpi_date').text();
	var time = target.find('.slpi_content').text();
	
	var conf = confirm(date + ' ' + time + '\n공연을 정말 취소하시겠습니까?');
	if(conf){
		scheduleApplicationCancel(no);
	} else {
		return;
	}
});

$(document).on('click', '#insert_schedule_apply', function(){
	scheduleApplicationReg();
});