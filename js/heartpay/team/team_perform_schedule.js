var sDate = '';		//선택한 날짜 저장
var dateCount = 0;	//날짜 선택한 갯수 카운트

$(document).on('click', '#ts_search_date', function() {	
	dateCount = 0;
	$("#ui-datepicker-div").removeClass('noneClass');
});


//아티스트 정보쪽에서 공연일정 페이지 클릭 시
$(document).on("click","#Go_PfsBtn", function(){
	team_info_pageNo = 2;

	var header_html = '<div class="ui-block-a" id="Go_AiBtn">'+
							'<div class="haeder_menu_div_base">'+
								'<span>소개</span>'+
							'</div>'+
						'</div>'+
						'<div class="ui-block-b" id="Go_MediaBtn">'+
							'<div class="haeder_menu_div_base">'+
								'<span>사진/동영상</span>'+
							'</div>'+
						'</div>'+
						'<div class="ui-block-c" id="Go_PfsBtn">'+
							'<div class="haeder_menu_div_on">'+
								'<span>공연일정</span>'+
							'</div>'+
						'</div>'+
						'<div class="ui-block-d" id="Go_ReviewBtn">'+
							'<div class="haeder_menu_div_base">'+
								'<span>공연후기</span>'+
							'</div>'+
						'</div>';

	$('.header_menu_container').html(header_html);
					
	var middle_content = '<div class="ui-grid-a" id="ti_intro_title">' +
							'<div class="ui-block-a">' +
								'<p>공연일정</p>' +
							'</div>' +
							'<div class="ui-block-b">' +
								'<span id="ts_all_schedule">전체보기</span>' +
							'</div>' +
						'</div>';	
	
	$('#team_middle').html(middle_content);
	
	$('.pd_reply_div').hide();
	
	reviewCount = 0;
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/team/team_perform_schedule.jsp";
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data : {
			team_no : tno
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			var DATA2 = $(ROOT).find('DATA2');
			
			$("#team_info_list").empty();
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var CNT = $(this).find("CNT").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var TEAM_INTRO = $(this).find("TEAM_INTRO").text();
				var TINTRO_IMG = $(this).find("TINTRO_IMG").text();
				
				//var t_img = '/upload/team/team'+ TEAM_NO +'/'+TINTRO_IMG;
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
						$("#ti_bandImg").css('background', 'url("' + value + '")');
						$("#ti_bandImg").css({'background-repeat': 'no-repeat', 'background-position': 'center', 'background-size': 'cover'});
			     });
				
				$('#ti_bandName').html(TEAM_NAME);
				$('#ti_bandInterestCount').html(CNT);
				$('#ti_bandIntro').html(TEAM_INTRO);
				
				if(DATA2.length == 0){
					$("#main_cont").text("해당 팀의 공연이 없습니다.");
					$("#main_cont").attr("onclick", "");
					$("#main_cont").removeClass("moreViewBtn");
					$("#main_cont").addClass("noViewBtn");
					$("#main_cont").css('display', 'inline-block');
					return;
				} else {
					$("#main_cont").hide();
				}
				
				$(DATA2).each(function(i) {
					var PF_NO = $(this).find("PF_NO").text();
					var PF_INTRO = $(this).find("PF_INTRO").text();
					var PF_DATE = $(this).find("PF_DATE").text();
					var PF_TIME = $(this).find("PF_TIME").text();
					var CODE_AREA = $(this).find("CODE_AREA").text();
					var PF_DETAIL_CONTENT = $(this).find("PF_DETAIL_CONTENT").text();
					var PF_IMG = $(this).find("PF_IMG").text();
					var WEEK = $(this).find("WEEK").text();
					var PF_PLACE = $(this).find("PF_PLACE").text();
					var PF_CANCLE = $(this).find('PF_CANCLE').text();
					
					//var p_img = '/upload/team/team'+ TEAM_NO + '/' + PF_IMG;
					
					var new_img = 'upload/images/team/team' + TEAM_NO + "/" + PF_IMG;
	                
				     var imgSrc = getImagePromise(new_img).then(value => {
						$('#pimg'+i).attr('src', value);
				     });
					
					var PF_INTRO_AREA = CODE_AREA +' '+ PF_PLACE ;
					var PF_DATE_WEEK_TIME = PF_DATE + '&#40;' + WEEK + '&#41;' + '&nbsp;' + PF_TIME;
					
					//공연이 지났는지 안지났는지 여부
					var PF_DATE_CHK = $(this).find('PF_DATE_CHK').text();
					
					var pfscBtn = '';
					
					if(PF_CANCLE == 1){
						pfscBtn = '<div class="perform_cancle_btn">공연취소</div>';
					}
					else if(PF_DATE_CHK == 0){
						pfscBtn = '<div class="perform_ing_btn">공연예정</div>';
					}
					else{
						pfscBtn = '<div class="perform_end_btn">공연종료</div>';
					}
					
					var content = '';
					
					content = '<div class="ui-grid-b perform_list" onclick="detail_perform_no('+PF_NO+')">'+
									'<div class="ui-block-a pl_image">'+
										'<img id="pimg'+i+'">'+
									'</div>'+
									'<div class="ui-block-b pl_content_contianer" style="">'+
										'<div class="ui-grid-b pc_cc_box">'+
											'<div class="ui-block-a" style="width: 100%;">'+
												'<div class="ui-grid-a">'+
													'<div class="ui-block-a" >'+
														pfscBtn+			
													'</div>'+
													'<div class="ui-block-b" style="width: 100%; ">'+
														'<p class="pl_cc_box_title style="">'+PF_INTRO+'</p>'+
													'</div>'+
												'</div>'+
											'</div>'+
											'<div class="ui-block-b" style="width: 100%;">'+
												'<a class="pl_cc_box_text">'+ PF_INTRO_AREA +'</a>'+
												'<a class="pl_cc_box_text">'+ PF_DATE_WEEK_TIME + '</a>'+
											'</div>'+
											'<div class="ui-block-c pl_cc_box_detail_content">'+
												PF_DETAIL_CONTENT +
											'</div>'+
										'</div>'+
									'</div>'+
									'<div class="ui-block-c pl_cc_btn">'+
										'<img src="/img/common/show_btn.svg">'+
									'</div>'+
								'</div>';
					
					var html = content;
					
					$('#team_info_list').append(html);
					
				});
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
	$("#main_cont").css('display', 'inline-block');
});


//공연일정 전체보기 클릭시
$(document).on('click', '#ts_all_schedule', function() {
	//현재 보고있는 팀 이름을 공연일정 검색 변수에 저장
	var team_name = $('#ti_bandName').text();
	sessionStorage.setItem('pfIndex', '1');
	sessionStorage.setItem('pfSearch', team_name);
	go_perform_schedule();
});