function goTipboxList(){
	loadPage('tipbox/tipbox_list.jsp');
}

var scListCount;

function getTipboxList(){
	var scName = sessionStorage.getItem('scName');
	var scGenre = sessionStorage.getItem('scGenre');
	var scArea = sessionStorage.getItem('scArea');
	
	var scLimitEnd = sessionStorage.getItem('scLimitEnd');
	if(scLimitEnd == null){
		scLimitEnd = 20;
	}
	
	scListCount = 0;
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/tipbox/get_tipbox_list.jsp',
		data:{
			scName : scName,
			scGenre : scGenre,
			scArea : scArea,
			scLimit : '0',
			scLimitEnd : scLimitEnd
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#tbl_body').empty();

			
			if(DATA.length == 0){
				$("#main_cont").text("검색 결과가 없습니다.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").show();
				return;
			} else {
				$('#main_cont').hide();
			}
			
			$(DATA).each(function(i){
				scListCount++;
				
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var TINTRO_IMG = $(this).find('TINTRO_IMG').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var CODE_GENRE = $(this).find('CODE_GENRE').text();
				var RATY_STAR = $(this).find('RATY_STAR').text();
				var PF_SCHEDULE = $(this).find('PF_SCHEDULE').text();
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#mpimg'+TEAM_NO).attr('src', value);
			     });
				
				var html  = '<div class="ui-grid-c tbl_content" onclick="go_support_fromtipbox('+TEAM_NO+', \''+TEAM_NAME+'\');">';
					html += '<div class="ui-block-a tbl_c_rank">'+scListCount+'</div>';
					
					html += '<div class="ui-block-b tbl_c_image">'+
								'<img id="mpimg'+TEAM_NO+'">'+
							'</div>'+
							'<div class="ui-block-c tbl_c_body">'+
								'<div class="ui-grid-a">'+
									'<div class="ui-block-a">'+
										'<span class="tbl_c_tname">'+TEAM_NAME+'</span>'+
										'<div class="tbl_c_raty" id="tbl_c_raty'+TEAM_NO+'"></div>'+
									'<div class="ui-block-b">'+
										'<span class="tbl_c_genre">'+CODE_GENRE+'</span>'+
										'<span class="tbl_c_line">|</span>';
				
							if(PF_SCHEDULE == ''){
								html += '<span class="tbl_c_schedule">공연예정없음</span>';
							} else {
								html += '<span class="tbl_c_schedule">'+PF_SCHEDULE+' 공연</span>';
							}
										
							html +=	'</div>' +
									'</div>'+
								'</div>'+
							'</div>'+
							'<div class="ui-block-d tbl_c_btn_div">'+
								'<span class="tbl_c_btn">팁주기</span>'+
							'</div>'+
						'</div>';
				
				$('#tbl_body').append(html);
				
				
				//별점추가
				$('#tbl_c_raty' + TEAM_NO).raty({
					readOnly : true,
					score : RATY_STAR
				});
				$('#tbl_c_raty' + TEAM_NO).append('<a>'+RATY_STAR)+'</a>';
				
			});
		},
		error: function(a, b, c) {
			console.log(a, b, c);	
		},
		complete: function(){
			var scroll = sessionStorage.getItem('scScroll');
			if(scroll == null){
				$(window).scrollTop(0);
			} else {
				$('html,body').animate({scrollTop: scroll}, 'fast');
			}
		}
	});
}

function getMoreTipboxList(){
	var scName = sessionStorage.getItem('scName');
	var scGenre = sessionStorage.getItem('scGenre');
	var scArea = sessionStorage.getItem('scArea');
	
	var scLimit = sessionStorage.getItem('scLimit');
	
	if(scLimit == null){
		scLimit = 0;
	}
	
	scLimit = parseInt(scLimit) + 20;
	sessionStorage.setItem('scLimit', scLimit);
	sessionStorage.setItem('scLimitEnd', scLimit+20);
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/tipbox/get_tipbox_list.jsp',
		data:{
			scName : scName,
			scGenre : scGenre,
			scArea : scArea,
			scLimit : scLimit,
			scLimitEnd : '20'
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				$("#main_cont").text("검색 결과가 없습니다.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else {
				$('#main_cont').hide();
			}
			
			$(DATA).each(function(i){
				scListCount++;
				
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var TINTRO_IMG = $(this).find('TINTRO_IMG').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var CODE_GENRE = $(this).find('CODE_GENRE').text();
				var RATY_STAR = $(this).find('RATY_STAR').text();
				var PF_SCHEDULE = $(this).find('PF_SCHEDULE').text();
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#mpimg'+TEAM_NO).attr('src', value);
			     });
				
				var html  = '<div class="ui-grid-c tbl_content" onclick="go_support_fromtipbox('+TEAM_NO+', \''+TEAM_NAME+'\');">';
					html += '<div class="ui-block-a tbl_c_rank">'+scListCount+'</div>';
				
					html += '<div class="ui-block-b tbl_c_image">'+
								'<img id="mpimg'+TEAM_NO+'">'+
							'</div>'+
							'<div class="ui-block-c tbl_c_body">'+
								'<div class="ui-grid-a">'+
									'<div class="ui-block-a">'+
										'<span class="tbl_c_tname">'+TEAM_NAME+'</span>'+
										'<div class="tbl_c_raty" id="tbl_c_raty'+TEAM_NO+'"></div>'+
									'<div class="ui-block-b">'+
										'<span class="tbl_c_genre">'+CODE_GENRE+'</span>'+
										'<span class="tbl_c_line">|</span>';
				
							if(PF_SCHEDULE == ''){
								html += '<span class="tbl_c_schedule">공연예정없음</span>';
							} else {
								html += '<span class="tbl_c_schedule">'+PF_SCHEDULE+' 공연</span>';
							}
										
							html +=	'</div>' +
									'</div>'+
								'</div>'+
							'</div>'+
							'<div class="ui-block-d tbl_c_btn_div">'+
								'<span class="tbl_c_btn">팁주기</span>'+
							'</div>'+
						'</div>';
				
				$('#tbl_body').append(html);
				
				
				//별점추가
				$('#tbl_c_raty' + TEAM_NO).raty({
					readOnly : true,
					score : RATY_STAR
				});
				$('#tbl_c_raty' + TEAM_NO).append('<a>'+RATY_STAR)+'</a>';
				
			});
		},
		error: function(a, b, c) {
			console.log(a, b, c);	
		}
	});
}
