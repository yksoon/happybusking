//공연의뢰 신청 페이지 
$(document).on('pageshow', '#perform_request', function() {
	$('#perform_rq_eq_sup').textinput("option", "autogrow", false);
	$('#perform_rq_eq_sup').val('');
	$('#perform_rq_msg').textinput("option", "autogrow", false);
	$('#perform_rq_msg').val('');
	
	$('#perform_rq_btn').hide();
	$('#peform_req_insertForm').hide();
	$('#prqFinishBtn').hide();
	$('#peform_req_addDateForm').empty();

	//오늘 날짜 가져오기
	var Now = new Date();
	
	var year = Now.getFullYear();
	var month = Now.getMonth() + 1;
	var day = Now.getDate();
	var last_day = (new Date(year, month, 0)).getDate();
	var hour = Now.getHours();
	var min = Now.getMinutes();
	
	
	for(var i = year; i < year+3; i++){
		var prq_year = '<option value="'+i+'">'+i+'년</option>';
		$('#prq_Year').append(prq_year);
	}
	
	for(var i = 1; i <= 12; i++){
		if((i+"").length == 1){
			var prq_month = '<option value="0'+i+'">0'+i+'월</option>';
		}
		else{
			var prq_month = '<option value="'+i+'">'+i+'월</option>';
		}
		$('#prq_Month').append(prq_month);
	}
	
	for(var i = 1; i <= last_day; i++){
		if((i+"").length == 1){
			var prq_day = '<option value="0'+i+'">0'+i+'일</option>';
		}
		else{
			var prq_day = '<option value="'+i+'">'+i+'일</option>';
		}
		$('#prq_Day').append(prq_day);
		
	}
	
	for(var i = 0; i <= 23; i++){ 
		if((i+"").length == 1){
			var prq_Hour = '<option value="0'+i+'">0'+i+'시</option>';
		}
		else{
			var prq_Hour = '<option value="'+i+'">'+i+'시</option>';
		}
		$('#prq_sHour').append(prq_Hour);
		$('#prq_eHour').append(prq_Hour);
	}
	
	for(var i = 0; i <= 59; i++){
		if((i+"").length == 1){
			var prq_Min = '<option value="0'+i+'">0'+i+'분</option>';
		}
		else{
			var prq_Min = '<option value="'+i+'">'+i+'분</option>';
		}
		$('#prq_sMin').append(prq_Min);
		$('#prq_eMin').append(prq_Min);
	}
	
	//$('#prq_Year').val(year).trigger('change');
	
	$('#prq_Year').val(year).trigger('change');
	$('#prq_Month').val(pad(month, 2)).trigger('change');
	$('#prq_Day').val(pad(day, 2)).trigger('change');
	$('#prq_sHour').val(pad(hour, 2)).trigger('change');
	$('#prq_eHour').val(pad(hour, 2)).trigger('change');
	$('#prq_sMin').val(pad(min, 2)).trigger('change');
	$('#prq_eMin').val(pad(min, 2)).trigger('change');
	
	tno = tno + "";
	var tno_array = tno.split(',');
	
	
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/perform_request/perform_request_list.jsp";
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data: {
			team_no : tno_array[0],
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				
				return;
			}
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				
				TEAM_NAME = "'" + TEAM_NAME + "'";
				
				if(tno_array.length == 1){
					$('#perform_req_teamName').html(TEAM_NAME);
				} else {
					$('#perform_req_teamName').html(TEAM_NAME + '외 ' + (tno_array.length - 1) + '팀');
				}
				
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });				
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error 
	});
	

});

$(document).on('change', '#prq_Year, #prq_Month', function(){
	var year = $('#prq_Year').val();
	var month = $('#prq_Month').val();
	
	var last_day = (new Date(year, month, 0)).getDate();
	$('#prq_Day').empty();
	
	for(var i = 1; i <= last_day; i++){
		if((i+"").length == 1){
			var prq_day = '<option value="0'+i+'">0'+i+'일</option>';
		}
		else{
			var prq_day = '<option value="'+i+'">'+i+'일</option>';
		}
		$('#prq_Day').append(prq_day);
	}
});



//날짜 추가 시
$(document).on('click', '#prqAddBtn', function(){
	var prq_Year = $('#prq_Year option:selected').val();
	var prq_Month = $('#prq_Month option:selected').val();
	var prq_Day = $('#prq_Day option:selected').val();
	
	var prq_sHour = $('#prq_sHour option:selected').val();
	var prq_sMin = $('#prq_sMin option:selected').val();
	var prq_eHour = $('#prq_eHour option:selected').val();
	var prq_eMin = $('#prq_eMin option:selected').val();
	
	var start_date = prq_Year + prq_Month + prq_Day + prq_sHour + prq_sMin;
	var end_date = prq_Year + prq_Month + prq_Day + prq_eHour + prq_eMin;
	
	
/*	var start_day = prq_sYear + prq_sMonth + prq_sDay
	var end_day = prq_eYear + prq_eMonth + prq_eDay*/
		
	
	var start_day = new Date(prq_Year, prq_Month, prq_Day, prq_sHour, prq_sMin);
    var end_day = new Date(prq_Year, prq_Month, prq_Day, prq_eHour, prq_eMin);
	
	
	
	var Now = new Date();
	
	var year = Now.getFullYear();
	var month = Now.getMonth() + 1;
	var day = Now.getDate();
	var hour = Now.getHours();
	var minute = Now.getMinutes();
	
	var current_day = new Date(year, month, day, hour, minute);
	
	
/*	if(start_day.getTime() <= current_day.getTime() || end_day.getTime() <= current_day.getTime()){
		infoTxtBox("현재날짜 기준으로 공연의뢰 신청할 수 없습니다 날짜를 확인해주세요");
		return;		
	}	*/
	if(start_day.getTime() < current_day.getTime() || end_day.getTime() < current_day.getTime()){
		infoTxtBox("현재날짜 기준으로 공연의뢰 신청할 수 없습니다 날짜를 확인해주세요");
		return;		
	}	
	
	var gap_time = time_gap(start_date, end_date);
	
	if(gap_time == 0 || gap_time < 0){
		infoTxtBox("공연시작 시간과 공연종료 시간을 제대로 입력해주세요");
		return;
	}
	
	
	var dateLength = $('.prq_pDate').length;

	var status = 'N';
	
	for(var i=0; i<dateLength; i++){
		var text = $('.prq_pDate').eq(i).text();
		 		
		var result = time_overlap(text, start_date, end_date);

		if(result == true){
			infoTxtBox('추가하신 날짜랑 중복됩니다! 다시 추가해주세요');
			status = 'Y';
		}
		

	}
	
	if(status == 'Y'){
		return;
	}
	
	var perform_rq_Date = prq_Year + '-' + prq_Month + '-' + prq_Day;
	var perform_rq_sTime = prq_sHour + ':' + prq_sMin;
	var perform_rq_eTime = prq_eHour + ':' + prq_eMin;
	
	var html = '<div class="ui-grid-a">' +
			'<div class="ui-block-a">' +
				'<p class="prq_pDate">'+ perform_rq_Date + ' ' + perform_rq_sTime + '~' + perform_rq_eTime + '</p>' +
			'</div>' +
			'<div class="ui-block-b">' +
				'<p class="prq_pDateCancel">X</p>' +
			'</div>' +
		'</div>';
	
	$('#peform_req_addDateForm').append(html);
	$('#prqFinishBtn').show();
	
	$('#prqAddBtn').html('날짜 추가');
});

//해당 추가한 날짜 삭제
$(document).on('click', '.prq_pDateCancel', function(){
	var len = $('.prq_pDate').length;
	if(len == 1){
		$(this).closest('.ui-grid-a').remove();
		$('#prqAddBtn').html('날짜 등록');
		$('#prqFinishBtn').hide();
	}else{
		$(this).closest('.ui-grid-a').remove();
		$('#prqAddBtn').html('날짜 추가');
	}
});


//완료 버튼 클릭 시
$(document).on('click', '#prqFinishBtn', function(){
	$('.perform_req_dateForm').hide();
	$('#prq_dateAddBtnArea').hide();
	
	$('.prq_pDateCancel').hide();
	$('#peform_req_addDateForm .ui-block-a').css('width', '100%');
	$('#peform_req_addDateForm .ui-block-b').css('width', '0%');
	$('#peform_req_addDateForm .prq_pDate').css('border-right', '1px solid #dddddd');
	
	var html = '<span id="prqResetBtn">초기화</span>';
	$('#prq_btnArea').html(html);
	$('#peform_req_insertForm').show();
	
	$('#perform_rq_btn').show();

	getKakaoMap('37.6547557', '127.0605938');
});


//초기화 버튼 클릭 시
$(document).on('click', '#prqResetBtn', function(){
	
	confirmBox('초기화 시키면 기존에 입력했던 내용들이 사라집니다 초기화 시키시겠습니까?', goReset);
	function goReset(){
		$.mobile.changePage(
			  window.location.href,
			  {
			    allowSamePageTransition : true,
			    transition              : document.location.href,
			    showLoadMsg             : false,
			    reloadPage              : true
			  }
			);
	}
});



//공연 요청하기 버튼 클릭 시
$(document).on('click', '#perform_rq_btn', function(){
	var name = changeQuotes($('#perform_rq_name').val());
	var hp = $('#perform_rq_hp').val();
	var alltime = $('#perform_rq_AllTime').html();
	var addr = $('#address').val();
	var zipcode = '';
	var detail_addr = changeQuotes($('#perform_rq_detail_addr').val());
	var perform_rq_msg = changeQuotes($('#perform_rq_msg').val());
	var eq_sup = changeQuotes($('#perform_rq_eq_sup').val());
	var geocode = $('#latlng').val();
	
	if(name == ""){
		alert("이름을 입력해주세요");
		$('#perform_rq_name').focus();
		return;
	}
	if(hp == ""){
		alert("휴대폰번호를 입력해주세요");
		$('#perform_rq_hp').focus();
		return;		
	}
	if(addr == ""){
		alert("주소를 입력해주세요");
		$('#perform_rq_addr').focus();
		return;				
	}
	if(detail_addr == ""){
		alert("상세주소를 입력해주세요");
		$('#perform_rq_detail_addr').focus();
		return;		
	}
	if(eq_sup == ''){
		alert('장비 지원 여부를 입력해주세요.');
		$('#perform_rq_eq_sup').focus();
		return;
	}
	if(!$('#performReq_checkbox').prop('checked')){
		infoTxtBox('공연의뢰 약관에 동의해주세요.');
		return;
	}
	
	
	var dateLen = $('.prq_pDate').length;
	
	var arrayDateValues = [];
	var alltimeValues ='';
	
	for(var i=0; i<dateLen; i++){
		//시간들 배열로저장
		var textDate = $('.prq_pDate').eq(i).text();
		
		arrayDateValues.push(textDate);
		
		
		//총 시간 배열로 저장
		var jbSplit = textDate.split(' ');
		
		var daySplit = jbSplit[0].split('-');
		var day = daySplit[0] + daySplit[1] + daySplit[2];
		
		var timeSplit = jbSplit[1].split('~');
		var Stime = timeSplit[0].replace(/:/gi,"");
		var Etime = timeSplit[1].replace(/:/gi,"");
		
		var sDate = day + Stime;
		var eDate = day + Etime;
		
		var gap_time = time_gap(sDate, eDate);
		
		if(i == 0){
			alltimeValues += gap_time;
		} else {
			alltimeValues = alltimeValues + ',' + gap_time;
		}
		
	}

	
	var selectindex = sessionStorage.getItem('selectindex');
	var tno_array;
	if(selectindex == null || selectindex == 'null'){
		tno_array = [tno];
	} else {
		tno_array = selectindex.split(',');
	}
	
	for(var i = 0; i < tno_array.length; i++){
		$.ajaxSettings.traditional = true;
		var formData = new FormData();
		formData.append('name', name);
		formData.append('hp', hp);
		formData.append('alltime', alltimeValues);
		formData.append('addr', addr);
		formData.append('zipcode', zipcode);
		formData.append('detail_addr', detail_addr);
		formData.append('geocode', geocode);
		formData.append('team_no', tno_array[i]);
		formData.append('arrayDate', arrayDateValues);
		formData.append('perform_rq_msg', perform_rq_msg);
		formData.append('eq_sup', eq_sup);
		
		
		var url = "/service/perform_request/perform_request_insert.jsp";
		
		$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: url,
		data : formData,
		processData: false,
		contentType: false,
		dataType: "xml",
		async: false,
		timeout: 30000,
		beforeSend: function(){
			$.mobile.loading( 'show', { text: '요청중입니다.', textVisible: true, theme: 'b', html: "" });
		},
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				return;
			}

			$(DATA).each(function(i) {
				
				//XML 컬럼들 
				var RESULT = $(this).find("RESULT").text();
				var MESSAGE = $(this).find("MESSAGE").text();
				
				if(RESULT == 'true'){
					alert(MESSAGE);
					
					//검색했던 세션 삭제
					sessionStorage.removeItem('tname');
					sessionStorage.removeItem('tgenre');
					sessionStorage.removeItem('tarea');
					sessionStorage.removeItem('tsmoney');
					sessionStorage.removeItem('temoney');
					sessionStorage.removeItem('ttype');
					sessionStorage.removeItem('selectindex');
					
					loadPage('perform_request/user_perform_requestList.jsp');
				} else {
					alert(MESSAGE);
					return;
				}
			});
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			alert("공연 요청에 실패했습니다.잠시후 다시 시도해주세요.\n해당 메시지가 계속 출력되면 1:1문의 또는 메일 문의 부탁드리겠습니다.");
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			return;
			//hideLoading();
		}, // end error
		complete: function(){
			$.mobile.loading( 'hide', { text: '요청중입니다.', textVisible: true, theme: 'b', html: "" });
		}
	});		
}
});

//유저쪽 공연의뢰 조회
$(document).on('pageinit', '#user_perform_requestList', function(){
	getUserPrSearchList();
});

//유저쪽 공연의뢰 취소
function userPrqCancel(Team_no, PF_REQUEST_NO){
	confirmBox('해당 공연의뢰를  취소 하시겠습니까?', deletePerformRequest);
	
	function deletePerformRequest(){
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/perform_request/user_perform_requestCancel.jsp";
	var data = "team_no=" + Team_no + "&pf_request_no=" + PF_REQUEST_NO;
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		data : data,
		url: url,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
				return;
			}
			
			$(DATA).each(function(i) {
				/* XML 컬럼들 */
				var RESULT = $(this).find("RESULT").text();
				var MESSAGE = $(this).find("MESSAGE").text();
				
				
				if(RESULT == "true"){	
					alert(MESSAGE);
					getUserPrSearchList();
				}else if(RESULT == "false"){
					alert(MESSAGE);
				}
				
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });	
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});		
	
	}		
}



//아티스트쪽 공연의뢰 응답 내역 조회
$(document).on('pageinit', '#artist_perform_requestList', function(){
	
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/perform_request/artist_perform_requestList.jsp";
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				$("#aPRqList_part").empty();
				$("#aPRqList_part").html('<div id="main_cont" class="noViewBtn">내용이 없습니다.</div>');
				return;
			}
			
			
			$('#aPRqList_part').empty();
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var PF_REQUEST_NO = $(this).find("PF_REQUEST_NO").text();
				var PF_REQUEST_GRP_NO = $(this).find("PF_REQUEST_GRP_NO").text();
				var PF_REQUEST_SDATE = $(this).find("PF_REQUEST_SDATE").text();
				var PF_REQUEST_STIME = $(this).find("PF_REQUEST_STIME").text();
				var PF_REQUEST_EDATE = $(this).find("PF_REQUEST_EDATE").text();
				var PF_REQUEST_ETIME = $(this).find("PF_REQUEST_ETIME").text();
				var PF_REQUEST_DETAIL_ADDR = $(this).find("PF_REQUEST_DETAIL_ADDR").text();
				var PF_REQUEST_REG_DATE = $(this).find("PF_REQUEST_REG_DATE").text();
				var PF_REQUEST_STATE = $(this).find("PF_REQUEST_STATE").text();
				var PF_REQUEST_PRICE = $(this).find("PF_REQUEST_PRICE").text();
				

				var prqShowState1 = "";
				var prqShowState2 = "";
				
				if(PF_REQUEST_STATE == "P"){
					prqShowState1 = '';
				}else if(PF_REQUEST_STATE == "Y"){
					prqShowState1 = '<span class="A_prqStateY">수락완료</span>';
				}else if(PF_REQUEST_STATE == "N"){
					prqShowState1 = '<span class="A_prqStateN">거절완료</span>';
				}
				
				var date = PF_REQUEST_SDATE + " ~ " + PF_REQUEST_EDATE;
				var time = PF_REQUEST_STIME + " ~ " + PF_REQUEST_ETIME;
				
				PF_REQUEST_PRICE = addComma(PF_REQUEST_PRICE);
				
				var html = 
				'<p class="prqShowIsTeam">' + TEAM_NAME + '<span class="prqShowIsDate">' + PF_REQUEST_REG_DATE + '</span></p>' +
				'<div class="ui-grid-b prqListContentCss" onclick="perform_request_detailList('+ TEAM_NO + "," + PF_REQUEST_NO +',' + "'A'" + ');">' +
					'<div class="ui-block-a">' +	
						'<p>공연기간</p>' +
						'<p>공연시간</p>' +
						'<p>공연장소</p>' +	
						'<p>금액</p>' +				
						'<div>'+ prqShowState1 +'</div>' +
					'</div>' +
					'<div class="ui-block-b">' +
						'<p>' + date + '</p>' +
						'<p>' + time + '</p>' +
						'<p>' + PF_REQUEST_DETAIL_ADDR + '</p>' +
						'<p class="prqListPriceCss">' + PF_REQUEST_PRICE + '</p>' +
						'<div>' + prqShowState2 + '</div>' +				
					'</div>' +
					'<div class="ui-block-c">' +
						'<img style="width: 40%;" src="/img/common/show_btn.svg">' +
					'</div>' +
				'</div>';
				
				$('#aPRqList_part').append(html);
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });				
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});	
});


//공연 의뢰 약관 관련
$(document).on('click', '#performReq_checkbox_btn', function() {
	$('#performReq_checkbox').trigger('click');
});

$(document).on('click', '#performReq_checkboxView', function() {
	$("#perform_req_terms").popup( "option" , "dismissible" , false);
	$("#perform_req_terms" ).popup( "option", "overlayTheme", "b" );
	$("#perform_req_terms" ).popup( "option", "positionTo", "window" );
	$('#perform_req_terms').popup('open');
});

$(document).on('click', '#perform_req_terms_close', function() {
	$('#perform_req_terms').popup('close');
});


//지도에서 선택하기 버튼 클릭시
$(document).on('click', '#prq_map_btn', function(){
	var viewChk = $('#prq_map').css('display');
	if(viewChk == 'none'){
		$('#prq_map').show();
	} else {
		$('#prq_map').hide();
	}
});