$(document).on('pageinit', '#perform_reg', function() {
	$('#perform_intro').textinput("option", "autogrow", false);
	var user_no = $('#user_no').val();
	
	//속한 팀 전체 리스트 불러오기
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/get_team_select.jsp',
		data: {
			user_no : user_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			$(DATA).each(function(i) {
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var TEAM_NO = $(this).find("TEAM_NO").text();
				
				var pr_team = '<option value="'+TEAM_NO+'">'+TEAM_NAME+'</option>';
				$('#pr_team').append(pr_team);
				//$('#sc_area li:firstchild').css('font-weight', 'bold');
				
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
	});

	//오늘 날짜 가져오기
	var Now = new Date();
	
	var year = Now.getFullYear();
	var month = Now.getMonth() + 1;
	var day = Now.getDate();
	var last_day = (new Date(year, month, 0)).getDate();
	var hour = Now.getHours();
	var min = Now.getMinutes();
	
	
	for(var i = year; i < year+3; i++){
		var pr_year = '<option value="'+i+'">'+i+'년</option>';
		$('#pr_sYear').append(pr_year);
		$('#pr_eYear').append(pr_year);
	}
	
	for(var i = 1; i <= 12; i++){
		if((i+"").length == 1){
			var pr_month = '<option value="0'+i+'">0'+i+'월</option>';
		}
		else{
			var pr_month = '<option value="'+i+'">'+i+'월</option>';
		}
		$('#pr_sMonth').append(pr_month);
		$('#pr_eMonth').append(pr_month);
	}
	
	for(var i = 1; i <= last_day; i++){
		if((i+"").length == 1){
			var pr_day = '<option value="0'+i+'">0'+i+'일</option>';
		}
		else{
			var pr_day = '<option value="'+i+'">'+i+'일</option>';
		}
		$('#pr_sDay').append(pr_day);
		$('#pr_eDay').append(pr_day);
		
	}
	
	for(var i = 0; i <= 23; i++){ 
		if((i+"").length == 1){
			var pr_Hour = '<option value="0'+i+'">0'+i+'시</option>';
		}
		else{
			var pr_Hour = '<option value="'+i+'">'+i+'시</option>';
		}
		$('#pr_sHour').append(pr_Hour);
		$('#pr_eHour').append(pr_Hour);
	}
	
	for(var i = 0; i <= 59; i++){
		if((i+"").length == 1){
			var pr_Min = '<option value="0'+i+'">0'+i+'분</option>';
		}
		else{
			var pr_Min = '<option value="'+i+'">'+i+'분</option>';
		}
		$('#pr_sMin').append(pr_Min);
		$('#pr_eMin').append(pr_Min);
	}
	
	$('#pr_sYear').val(year).trigger('change');
	$('#pr_sMonth').val(pad(month, 2)).trigger('change');
	$('#pr_sDay').val(pad(day, 2)).trigger('change');
	$('#pr_eYear').val(year).trigger('change');
	$('#pr_eMonth').val(pad(month, 2)).trigger('change');
	$('#pr_eDay').val(pad(day, 2)).trigger('change');
	$('#pr_sHour').val(pad(hour, 2)).trigger('change');
	$('#pr_eHour').val(pad(hour, 2)).trigger('change');
	$('#pr_sMin').val(pad(min, 2)).trigger('change');
	$('#pr_eMin').val(pad(min, 2)).trigger('change');
});

$(document).on('pageshow', '#perform_reg', function(){
	getKakaoMap('37.6547557', '127.0605938');
});

$(document).on('change', '#pr_sMonth, #pr_sYear', function(){
	var year = $('#pr_sYear').val();
	var month = $('#pr_sMonth').val();
	var last_day = (new Date(year, month, 0)).getDate();
	$('#pr_sDay').empty();
	
	for(var i = 1; i <= last_day; i++){
		if((i+"").length == 1){
			var pr_day = '<option value="0'+i+'">0'+i+'일</option>';
		}
		else{
			var pr_day = '<option value="'+i+'">'+i+'일</option>';
		}
		$('#pr_sDay').append(pr_day);
	}
});

$(document).on('change', '#pr_eMonth, #pr_eYear', function(){
	var year = $('#pr_eYear').val();
	var month = $('#pr_eMonth').val();
	var last_day = (new Date(year, month, 0)).getDate();
	$('#pr_eDay').empty();
	
	for(var i = 1; i <= last_day; i++){
		if((i+"").length == 1){
			var pr_day = '<option value="0'+i+'">0'+i+'일</option>';
		}
		else{
			var pr_day = '<option value="'+i+'">'+i+'일</option>';
		}
		$('#pr_eDay').append(pr_day);
	}
});

//공연 프로필 등록 div 클릭시 사진첩으로 이동
$(document).on('click', '#perform_reg_img', function() {
	const no = $('#pr_team').val();
	
	if(no===null || no==='null' || no === ''){
		alert('출연팀 이름을 먼저 선택해주세요.');
		return;
	}
	 
	$('#perform_img').click();
});

$(document).on('change', '#pr_team', function(){
	$('#img_name').val('');
	$('#img_preview').attr('src', '');
});

$(document).on('change', '#perform_img', function(){
	if($('#pr_team').val() === ''){
		alert('팀을 먼저 선택해주세요.');
		return;
	}
	if($(this).val() === '') return;
	readURL(this, 3, 4);
});

$(document).on('click', '#perform_reg_btn', function() {
	var perform_img = $('#img_name').val();
	var team_no = $('#pr_team').val();
	var perform_name = changeQuotes($('#perform_name').val());
	var perform_intro = changeQuotes($('#perform_intro').val());
	var prc_latlng = $('#latlng').val(); 
	//YYYY-MM-DD
	var pr_sYear = $('#pr_sYear').val();
	var pr_sMonth = $('#pr_sMonth').val();
	var pr_sDay = $('#pr_sDay').val();
	var perform_sDate = pr_sYear + '-' + pr_sMonth + '-' + pr_sDay;
	
	var pr_eYear = $('#pr_eYear').val();
	var pr_eMonth = $('#pr_eMonth').val();
	var pr_eDay = $('#pr_eDay').val();
	var perform_eDate = pr_eYear + '-' + pr_eMonth + '-' + pr_eDay;
	//HH:MM
	var pr_sHour = $('#pr_sHour').val();
	var pr_sMin = $('#pr_sMin').val();
	var perform_sTime = pr_sHour + ':' + pr_sMin;
	
	var pr_eHour = $('#pr_eHour').val();
	var pr_eMin = $('#pr_eMin').val();
	var perform_eTime = pr_eHour + ':' + pr_eMin;
	///////
	var perform_genre = $('#select_genre').val();
	var main_genre = $('#main_genre').val();
	var text_genre = $('#text_genre').val();
	var perform_addr = changeQuotes($('#address').val());
	var perform_place_type = changeQuotes($('#perform_place_type').val());
	var perform_place = changeQuotes($('#perform_place').val());
	var perform_traffic = changeQuotes($('#perform_traffic').val());
	
	var perform_area = perform_addr.substring(0,2);
	
	if(prc_latlng == ''){
		alert('해당 주소의 좌표값을 가져올 수 없습니다. 지도에서 직접 선택해주세요!');
	}
	
	if(parseInt(pr_sYear) == parseInt(pr_eYear)){
		if(parseInt(pr_sMonth) > parseInt(pr_eMonth)){
			alert('날짜를 확인해주세요');
			return;
		}
		else if(parseInt(pr_sMonth) == parseInt(pr_eMonth)){
			if(parseInt(pr_sDay) > parseInt(pr_eDay)){
				alert('날짜를 확인해주세요');
				return;
			}
		}
		if(parseInt(pr_sMonth) == parseInt(pr_eMonth) && parseInt(pr_sDay) == parseInt(pr_eDay)){
			if(parseInt(pr_sHour) > parseInt(pr_eHour)){
				alert('시간을 확인해주세요');
				return;
			}
			else if(parseInt(pr_sHour) == parseInt(pr_eHour)){
				if(parseInt(pr_sMin) > parseInt(pr_eMin)){
					alert('시간을 확인해주세요');
					return;
				}
			}
		}
	}

	if(perform_img == ''){
		alert('이미지를 등록해주세요.');
		$('#perform_img').focus();
		return;
	}
	if(team_no == 'null' || team_no == null || team_no==''){
		alert('팀 이름을 선택해주세요.');
		$('#pr_team').focus();
		return;
	}
	if(perform_name == ''){
		alert('공연명을 입력해주세요.');
		$('#perform_name').focus();
		return;
	}
	if(perform_intro == ''){
		alert('공연소개를 입력해주세요.');
		$('#perform_intro').focus();
		return;
	}
	if(main_genre == ''){
		alert('공연장르를 선택해주세요.');
		$('#perform_genre').focus();
		return;
	}
	if(perform_addr == ''){
		alert('주소를 입력해주세요.');
		$('#perform_addr').focus();
		return;
	}
	if(perform_place == ''){
		alert('장소유형을 입력해주세요.');
		$('#perform_place_type').focus();
		return;
	}
	if(perform_place_type == ''){
		alert('상세설명을 입력해주세요.');
		$('#perform_place').focus();
		return;
	}
	if(perform_traffic == ''){
		alert('교통편을 입력해주세요.');
		$('#perform_traffic').focus();
		return;
	}
	if(prc_latlng == ''){
		alert('해당 주소의 좌표값을 가져올 수 없습니다. 지도에서 직접 선택해주세요!');
		return;
	}
	
	var conf = confirm('등록한 공연은 수정할 수 없습니다.\n공연 일정을 등록하시겠습니까 ? ');
	if(!conf){
		return;
	}

	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/performance_register/perform_reg.jsp',
		//data : data,
		data : {
			perform_img: perform_img,
			perform_name: perform_name,
			team_no: team_no,
			perform_intro: perform_intro,
			perform_sDate: perform_sDate,
			perform_eDate: perform_eDate,
			perform_sTime: perform_sTime,
			perform_eTime: perform_eTime,
			perform_genre: perform_genre,
			main_genre: main_genre,
			text_genre: text_genre,
			perform_area: perform_area,
			perform_addr: perform_addr,
			perform_place: perform_place,
			perform_place_type: perform_place_type,
			perform_traffic: perform_traffic,
			perform_geocode: prc_latlng
		},
		dataType: "xml",
		timeout: 30000,
		beforeSend: function(){
			showLoading('show', '등록중입니다');
		},
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i) {
				var RESULT = $(DATA).find('RESULT').text();
				var MESSAGE = $(DATA).find('MESSAGE').text();
				
				if(RESULT == 'TRUE' || RESULT == 'true'){
					sessionStorage.setItem('pfrChk', 'Y');
					perform_reg_push_send(team_no, perform_sDate);
					
					alert(MESSAGE);
					go_rating_list();
				}
				else{
					alert(MESSAGE);
					return;
				}
			});
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			alert('잠시후 다시 시도해주세요.');
			return;
			//hideLoading();
		}, // end error
		complete: function(){
			showLoading('hide', '등록중입니다');
		}
	});

});

$(document).on('click', '#prc_map_btn', function(){
	var viewChk = $('#prc_map').css('display');
	if(viewChk == 'none'){
		$('#prc_map').show();
	} else {
		$('#prc_map').hide();
	}
	
});