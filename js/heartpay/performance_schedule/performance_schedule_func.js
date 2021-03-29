function go_perform_schedule() {
	loadPage('performance_schedule/performance_schedule.jsp');
}

function go_perform_cancle() {
	loadPage('performance_schedule/perform_cancle_msg.jsp');
}

function go_perform_sc_genre(index) {
	perform_sc_index = index;
	loadPage('performance_schedule/performance_schedule.jsp');
}

function schedule_load() {
	var sDate = $('#ts_search_date').val();
	var team_name = $('#sc_search_date').val();
	
	var eLimit = sessionStorage.getItem('scLimit');
	if(eLimit == null){
		eLimit = 10;
		sessionStorage.setItem('scLimit', eLimit);
	}
	
	var search = sessionStorage.getItem('pfSearch');
	var searchDate = sessionStorage.getItem('pfSearchDate');
	var searchArea = sessionStorage.getItem('pfSearchArea');
	var searchGenre = sessionStorage.getItem('pfSearchGenre');
	
	$.ajax({
		type: "GET",
		url: "/service/performance_schedule/performance_schedule.jsp",
		contentType: "application/xml; charset=utf-8",
		data:{
			sLimit: 0,
			eLimit: eLimit,
			code_area:searchArea,
			code_genre:searchGenre,
			team_name:search,
			sDate:searchDate
		},
		dataType: "xml",
		success: function (result) {
			var ROOT = $(result).find("ROOT");
			var DATA = $(ROOT).find("DATA");	
			
			$('#perform_sc_content').empty();
			
			if(DATA.length == 0){
				$("#perform_sc_content").html('<p id="main_cont">조건에 해당하는 공연이 없습니다.</p>');
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
				
			}

			$(DATA).each(function(i) {
				var PF_NO = $(this).find("PF_NO").text();
				var PF_IMG = $(this).find("PF_IMG").text();
				var PF_INTRO = $(this).find("PF_INTRO").text();
				var PF_DATE = $(this).find("PF_DATE").text();
				var PF_TIME = $(this).find("PF_TIME").text();
				var CODE_AREA = $(this).find("CODE_AREA").text();
				var PF_PLACE = $(this).find("PF_PLACE").text();
				var PF_LATLNG = $(this).find("PF_LATLNG").text();
				var PF_ADDR = $(this).find("PF_ADDR").text();
				var PF_DETAIL_CONTENT = $(this).find("PF_DETAIL_CONTENT").text();
				var PF_CANCLE = $(this).find("PF_CANCLE").text();
				var WEEK = $(this).find("WEEK").text();
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var CODE_GENRE = $(this).find("CODE_GENRE").text();
				
				// var p_img = '/upload/team/team'+ TEAM_NO + '/' + PF_IMG;
				
				var PF_DATE_WEEK_TIME = PF_DATE + '&#40;' + WEEK + '&#41;' + '&nbsp;' + PF_TIME;
				
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				
				var PF_DATE_CHK = $(this).find("PF_DATE_CHK").text();
				
				var psc_status = '';
				
				if(PF_CANCLE == 1){
					psc_status = '<div class="psl-img-background">취소</div>';
				}
				else if(PF_DATE_CHK == 0){
					psc_status = '<div class="psl-img-background">종료</div>';
				}
				else{
					psc_status = '';
				}
				
				perform_sc_content = '<div class="ps-contaner" onclick="detail_perform_no('+PF_NO+')">'+
										'<div class="ps-left">'+
											'<div class="psl-img">'+
												psc_status+
												'<img id="pimg'+PF_NO+'">'+
											'</div>'+
											'<div class="psl-text">'+
												'<p class="psl-title">'+TEAM_NAME+'</p>'+
												'<p class="psl-date">일시: '+PF_DATE_WEEK_TIME+'</p>'+
												'<p class="psl-place">장소: '+CODE_AREA + ' ' + PF_PLACE+'</p>'+
												'<p class="psl-genre">'+CODE_GENRE+'</p>'+
											'</div>'+
										'</div>'+
										'<div class="ps-right">'+
											'<img src="/img/common/show_btn.svg">'+
										'</div>'+
									'</div>';	
				
			$('#perform_sc_content').append(perform_sc_content);
			
			
			var new_img = 'upload/images/team/team' + TEAM_NO + "/" + PF_IMG;
		     var imgSrc = getImagePromise(new_img).then(value => {
				$('#pimg'+PF_NO).attr('src', value);
		     });
			});
		},
		error: function(request, statuis, error) {
		},
		complete: function(){
			var scroll = sessionStorage.getItem('pfScroll');
			if(scroll == null) scroll = 0;
			
			console.log(scroll)
			
			$('html,body').animate({scrollTop: scroll}, 'fast');
		}
	});
}

function scheduleMoreView() {
	var sDate = $('#ts_search_date').val();
	var team_name = $('#sc_search_date').val();
	
	var sLimit = sessionStorage.getItem('scLimit');
	
	var search = sessionStorage.getItem('pfSearch');
	var searchDate = sessionStorage.getItem('pfSearchDate');
	var searchArea = sessionStorage.getItem('pfSearchArea');
	var searchGenre = sessionStorage.getItem('pfSearchGenre');
	
	$.ajax({
		type: "GET",
		url: "/service/performance_schedule/performance_schedule.jsp",
		contentType: "application/xml; charset=utf-8",
		data:{
			sLimit: sLimit,
			eLimit: '10',
			code_area:searchArea,
			code_genre:searchGenre,
			team_name:search,
			sDate:searchDate
		},
		dataType: "xml",
		success: function (result) {
			var ROOT = $(result).find("ROOT");
			var DATA = $(ROOT).find("DATA");	
			
			if(DATA.length >= 10){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "scheduleMoreView()");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").css('display', 'inline-block');
			} else {
				$("#main_cont").hide();
			}

			$(DATA).each(function(i) {
				var PF_NO = $(this).find("PF_NO").text();
				var PF_IMG = $(this).find("PF_IMG").text();
				var PF_INTRO = $(this).find("PF_INTRO").text();
				var PF_DATE = $(this).find("PF_DATE").text();
				var PF_TIME = $(this).find("PF_TIME").text();
				var CODE_AREA = $(this).find("CODE_AREA").text();
				var PF_PLACE = $(this).find("PF_PLACE").text();
				var PF_LATLNG = $(this).find("PF_LATLNG").text();
				var PF_ADDR = $(this).find("PF_ADDR").text();
				var PF_DETAIL_CONTENT = $(this).find("PF_DETAIL_CONTENT").text();
				var PF_CANCLE = $(this).find("PF_CANCLE").text();
				var WEEK = $(this).find("WEEK").text();
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var CODE_GENRE = $(this).find("CODE_GENRE").text();
				
				// var p_img = '/upload/team/team'+ TEAM_NO + '/' + PF_IMG;
				
				var PF_DATE_WEEK_TIME = PF_DATE + '&#40;' + WEEK + '&#41;' + '&nbsp;' + PF_TIME;
				
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				
				var PF_DATE_CHK = $(this).find("PF_DATE_CHK").text();
				
				var psc_status = '';
				
				if(PF_CANCLE == 1){
					psc_status = '<div class="psl-img-background">취소</div>';
				}
				else if(PF_DATE_CHK == 0){
					psc_status = '<div class="psl-img-background">종료</div>';
				}
				else{
					psc_status = '';
				}
				
				perform_sc_content = '<div class="ps-contaner" onclick="detail_perform_no('+PF_NO+')">'+
										'<div class="ps-left">'+
											'<div class="psl-img">'+
												psc_status+
												'<img id="pimg'+PF_NO+'">'+
											'</div>'+
											'<div class="psl-text">'+
												'<p class="psl-title">'+TEAM_NAME+'</p>'+
												'<p class="psl-date">일시: '+PF_DATE_WEEK_TIME+'</p>'+
												'<p class="psl-place">장소: '+CODE_AREA + ' ' + PF_PLACE+'</p>'+
												'<p class="psl-genre">'+CODE_GENRE+'</p>'+
											'</div>'+
										'</div>'+
										'<div class="ps-right">'+
											'<img src="/img/common/show_btn.svg">'+
										'</div>'+
									'</div>';	
				
			$('#perform_sc_content').append(perform_sc_content);
			
			
			var new_img = 'upload/images/team/team' + TEAM_NO + "/" + PF_IMG;
		     var imgSrc = getImagePromise(new_img).then(value => {
				$('#pimg'+PF_NO).attr('src', value);
		     });
			});
		},
		error: function(a, b, c) {
			console.log(a, b, c);	
		},
		complete: function(){
			var sLimit = sessionStorage.getItem('scLimit');
			sLimit = parseInt(sLimit) + 10;
			sessionStorage.setItem('scLimit', sLimit);
		}
	
	});
}

function perform_cancle_push_send(pf_no) {
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/pushService/performCanclePush.jsp',
		data: {
			pf_no : pf_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
		}
	});
}