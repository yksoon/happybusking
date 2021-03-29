function go_rating_list() {
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
		} else {
			loadPage('rating_list/rating_list.jsp');
		}
	}
}

function rating_list_refresh() {
	loadPage('rating_list/rating_list.jsp');
}

function get_rating_list(team_no) {
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/rating_list/rating_list.jsp',
		data: {
			team_no : team_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			var DATA2 = $(ROOT).find('DATA2');
			
			$(DATA).each(function(i) {
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var TOTAL_RATY_STAR = $(this).find('TOTAL_RATY_STAR').text();
				
				$('#rl_team_name').html(TEAM_NAME);
				
				$('#raty_total').empty();
				
				//별점 추가
				$('#raty_total').raty({
					readOnly : true,
					score : TOTAL_RATY_STAR
				});
				
				$('#raty_total_score').html(TOTAL_RATY_STAR+'점');
				
				$('#as_account_list').empty();
				
				$('#rating_list_bottom').empty();
				
				$(DATA2).each(function() {
					var TEAM_NO = $(this).find('TEAM_NO').text();
					var PF_NO = $(this).find('PF_NO').text();
					var PF_IMG = $(this).find('PF_IMG').text();
					var PF_INTRO = $(this).find('PF_INTRO').text();
					var PF_DATE = $(this).find('PF_DATE').text();
					var WEEK = $(this).find('WEEK').text();
					var PF_TIME = $(this).find('PF_TIME').text();
					var PF_PLACE = $(this).find('PF_PLACE').text();
					var RATY_STAR = $(this).find('RATY_STAR').text();
					var PF_AF_BE = $(this).find('PF_AF_BE').text();
					var PF_CANCLE = $(this).find('PF_CANCLE').text();
					var CODE_AREA = $(this).find('CODE_AREA').text();
					
					//var p_img = '/upload/team/team' + TEAM_NO + '/' + PF_IMG;
					
					var new_img = 'upload/images/team/team' + TEAM_NO + "/" + PF_IMG;
	                
				     var imgSrc = getImagePromise(new_img).then(value => {
						$('#img'+PF_NO).attr('src', value);
				     });
					
					var p_date_week_time = PF_DATE + '(' + WEEK + ') ' + PF_TIME;
					
					
					
					var rating_list_bottom = '<div class="ui-grid-a rl_bottom_content">'+
												'<div class="ui-block-a rl_bc_img">'+
							  						'<img id="img'+PF_NO+'">'+
							  					'</div>'+
								  				'<div class="ui-block-b rl_bc_content">'+
								  					'<div class="ui-grid-b">'+
								  						'<div class="ui-block-a rl_bc_header">'+PF_INTRO+'</div>'+
								  						'<div class="ui-block-b rl_bc_body">'+
								  							'<div class="ui-grid-a">'+
								  								'<div class="ui-block-a">'+p_date_week_time+'</div>'+
								  								'<div class="ui-block-b">'+CODE_AREA+' '+PF_PLACE+'</div>'+
								  							'</div>'+
								  						'</div>'+
								  						'<div class="ui-block-c rl_bc_footer" id="rl_bc_footer_'+PF_NO+'">'+
								  						'</div>'+
								  						'</div>'+
								  					'</div>'+
								  				'</div>';
					
					$('#rating_list_bottom').append(rating_list_bottom);
					
					if(PF_AF_BE == 1){
						//이미 끝난 공연일 경우
						var star_content = '<div class="raty" id="raty_'+PF_NO+'"></div>'+
  											'<div class="raty_score"><a>'+RATY_STAR+'</a></div>';
						
						$('#rl_bc_footer_'+PF_NO).append(star_content);
						
						//별점 추가
						$('#raty_'+PF_NO).raty({
							readOnly : true,
							score : RATY_STAR
						});
					}
					else{
						//예정중인 공연일 경우
						if(PF_CANCLE == 0){
							//취소 안된 공연
							var cancle_btn = '<div class="rl_cancel_btn" onclick="perform_cancle('+PF_NO+')">공연취소</div>';
							$('#rl_bc_footer_'+PF_NO).append(cancle_btn);
						}
						else{
							//취소 된 공연
							var cancle_btn = '<div class="rl_cancel_text">취소 된 공연</div>';
							$('#rl_bc_footer_'+PF_NO).append(cancle_btn);
						}
					}
				});
				
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
		
	});	
}