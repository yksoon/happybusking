function go_artist_ranking() {
	loadPage('artist_ranking/artist_ranking.jsp');
}

var ranking_count;

function get_artist_ranking(user_no) {
	ranking_count = 0;
	
	var a_ranking_count = sessionStorage.getItem('a_ranking_count');
	var endCount = sessionStorage.getItem('aEndCount');
	
	if(a_ranking_count == null){
		a_ranking_count = 0;
		sessionStorage.setItem('a_ranking_count', a_ranking_count);
	}
	
	if(endCount == null){
		endCount = 20;
		sessionStorage.setItem('aEndCount', endCount);
	}
	
	var arankArea = sessionStorage.getItem('arankArea');
	var arankGenre = sessionStorage.getItem('arankGenre');
	
	if(arankArea == null){
		arankArea = '';
	}
	if(arankGenre == null){
		arankGenre = '';
	}
	
	$.ajax({ 
		type: "GET",
		cache: false,
		async: false,
		url: '/service/common/get_team_all_cnt.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var ALL_CNT = $(this).find('ALL_CNT').text();
				
				$('#Go_AllRanking').find('span').html('전체 ('+ALL_CNT+')');
			});

		}
	});
	
	
	var sort = sessionStorage.getItem('ars_sort');
	
	$.ajax({ 
		type: "GET",
		cache: false,
		async: false,
		url: '/service/artist_ranking/artist_ranking.jsp',
		data:{
			code_area : arankArea,
			code_genre : arankGenre,
			team_search: a_ranking_sc_temp,
			a_count : 0,
			endCount: endCount,
			sort: sort
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#a_ranking_content').empty();
			
			if(DATA.length == 0){
				$('#a_ranking_content').html('<p id="main_cont"></p>');
				$("#main_cont").text("검색 결과가 없습니다.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else if((DATA.length % 20) == 0){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "get_artist_reRanking()");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").css('display', 'inline-block');
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function(i) {
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var RATY_STAR = $(this).find('RATY_STAR').text();
				var CODE_GENRE = $(this).find('CODE_GENRE').text();
				var I_CNT = $(this).find('I_CNT').text();
				var TINTRO_IMG = $(this).find('TINTRO_IMG').text();
				var PF_DATE = $(this).find('PF_DATE').text();
				var BELONG = $(this).find('BELONG').text();
				var t_img = '/upload/team/team' + TEAM_NO + "/" + TINTRO_IMG;
				//RATY_STAR와 I_CNT의  NULL 값은 0으로 나옴
				
				ranking_count++;
				
				var belong_content;
                
                if(BELONG  == ''){
                	belong_content = '<p class="ait_text ait_perform" id="a_rank_t_a_ranking_' + ranking_count + '"></p>';
                } else {
                	belong_content = '<p class="ait_text ait_belong">' + BELONG + '</p>' +
										'<p class="ait_middle">&nbsp;|&nbsp;</p>' +
										'<p class="ait_text ait_perform" id="a_rank_t_a_ranking_' + ranking_count + '"></p>';
                }
				
				 var a_ranking_content = '<div class="artist_list_container" onclick="go_team_infoPage(\''+TEAM_NO+'\');">' +
											'<div class="alc_ranknum" id="ar_rank_'+ranking_count+'">' + ranking_count + '</div>' + 
											'<div class="alc_thumbnail">' + 
												'<img id="aimg'+TEAM_NO+'">' + 
											'</div>' +
											'<div class="alc_info_text">'+
												'<p class="ait_teamname">' + TEAM_NAME + '</p>' +
												'<p class="ait_text ait_genre">' + CODE_GENRE + '</p>' +
											 	belong_content +
											'</div>'+
											'<div class="alc_icon_b" id="a_ranking_like_img_'+ranking_count+'">' + 
											'</div>'+
										  '</div>';
				
				$('#a_ranking_content').append(a_ranking_content);
				
				if(ranking_count > 3){
					$('#ar_rank_'+ranking_count).css('color', '#2c2c2c');
					$('#ar_rank_'+ranking_count).css('font-weight' , 'normal');
				}
				
				if(I_CNT == 0){
					$('#a_ranking_like_img_'+ranking_count).append('<img src="/img/v2/ar_nolike__.svg">');
				}
				else{
					$('#a_ranking_like_img_'+ranking_count).append('<img src="/img/v2/ar_like__.svg">');
				}
				
				if(PF_DATE != ''){
					$('#a_rank_t_a_ranking_'+ranking_count).html(PF_DATE + ' 공연');
				}
				else{
					$('#a_rank_t_a_ranking_'+ranking_count).html('공연예정없음');
				}
				
				if(RATY_STAR > 0){
					//별점 추가
					$('#a_rank_t_raty_' + ranking_count).raty({
						readOnly : true,
						score : RATY_STAR
					});
					$('#a_rank_t_raty_' + ranking_count).append('<a>'+RATY_STAR)+'</a>';
				}
				
				 var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#aimg'+TEAM_NO).attr('src', value);
			     });
				
			});
			
		},error: function(xhr, message, errorThrown) {
		},
		complete: function(){
			$('#artist_ranking').css('padding-top', '185px');
			var scroll = sessionStorage.getItem('arankScroll');
			if(scroll == null){
				scroll = 0;
			}
			$('html,body').animate({scrollTop: scroll}, 'fast');
		}
	});	
}

function get_artist_reRanking() {
	var endCount = sessionStorage.getItem('aEndCount');
	var a_ranking_count = endCount;
	
	endCount = parseInt(endCount) + 20;
	sessionStorage.setItem('aEndCount', endCount);
	
	var arankArea = sessionStorage.getItem('arankArea');
	var arankGenre = sessionStorage.getItem('arankGenre');
	
	if(arankArea == null){
		arankArea = '';
	}
	if(arankGenre == null){
		arankGenre = '';
	}
	
	
	var sort = sessionStorage.getItem('ars_sort');
	
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/artist_ranking/artist_ranking.jsp',
		data:{
			code_area : arankArea,
			code_genre : arankGenre,
			team_search: a_ranking_sc_temp,
			a_count : a_ranking_count,
			sort: sort
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				a_ranking_count = parseInt(a_ranking_count)-20;
				sessionStorage.setItem('a_ranking_count', a_ranking_count);
				$("#main_cont").hide();
				return;
			} else if(DATA.length == 20){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "get_artist_reRanking()");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").css('display', 'inline-block');
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function(i) {
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var RATY_STAR = $(this).find('RATY_STAR').text();
				var CODE_GENRE = $(this).find('CODE_GENRE').text();
				var I_CNT = $(this).find('I_CNT').text();
				var TINTRO_IMG = $(this).find('TINTRO_IMG').text();
				var PF_DATE = $(this).find('PF_DATE').text();
				var BELONG = $(this).find('BELONG').text();
				var t_img = '/upload/team/team' + TEAM_NO + "/" + TINTRO_IMG;
				
				//RATY_STAR와 I_CNT의  NULL 값은 0으로 나옴
				
				ranking_count ++;
				
				var belong_content;
                
                if(BELONG  == ''){
                	belong_content = '<p class="ait_text ait_perform" id="a_rank_t_a_ranking_' + ranking_count + '"></p>';
                } else {
                	belong_content = '<p class="ait_text ait_belong">' + BELONG + '</p>' +
										'<p class="ait_middle">&nbsp;|&nbsp;</p>' +
										'<p class="ait_text ait_perform" id="a_rank_t_a_ranking_' + ranking_count + '"></p>';
                }
				
				 var a_ranking_content = '<div class="artist_list_container" onclick="go_team_infoPage(\''+TEAM_NO+'\');">' +
											'<div class="alc_ranknum" id="ar_rank_'+ranking_count+'">' + ranking_count + '</div>' + 
											'<div class="alc_thumbnail">' + 
												'<img id="aimg'+TEAM_NO+'">' + 
											'</div>' +
											'<div class="alc_info_text">'+
												'<p class="ait_teamname">' + TEAM_NAME + '</p>' +
												'<p class="ait_text ait_genre">' + CODE_GENRE + '</p>' +
											 	belong_content +
											'</div>'+
											'<div class="alc_icon_b" id="a_ranking_like_img_'+ranking_count+'">' + 
											'</div>'+
										  '</div>';
				
				$('#a_ranking_content').append(a_ranking_content);
				
				if(ranking_count > 3){
					$('#ar_rank_'+ranking_count).css('color', '#2c2c2c');
					$('#ar_rank_'+ranking_count).css('font-weight' , 'normal');
				}
				
				if(I_CNT == 0){
					$('#a_ranking_like_img_'+ranking_count).append('<img src="/img/v2/ar_nolike__.svg">');
				}
				else{
					$('#a_ranking_like_img_'+ranking_count).append('<img src="/img/v2/ar_like__.svg">');
				}
				
				if(PF_DATE != ''){
					$('#a_rank_t_a_ranking_'+ranking_count).html(PF_DATE + ' 공연');
				}
				else{
					$('#a_rank_t_a_ranking_'+ranking_count).html('공연예정없음');
				}
				
				if(RATY_STAR > 0){
					//별점 추가
					$('#a_rank_t_raty_' + ranking_count).raty({
						readOnly : true,
						score : RATY_STAR
					});
					$('#a_rank_t_raty_' + ranking_count).append('<a>'+RATY_STAR)+'</a>';
				}

				
				 var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#aimg'+TEAM_NO).attr('src', value);
			     });
			});
			
		},error: function(xhr, message, errorThrown) {
		}
	});	
}