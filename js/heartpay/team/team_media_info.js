$(document).on('click', '#Go_MediaBtn', function(){
	team_info_pageNo = 4;
	
	var header_html = '<div class="ui-block-a" id="Go_AiBtn">'+
						'<div class="haeder_menu_div_base">'+
							'<span>소개</span>'+
						'</div>'+
					'</div>'+
					'<div class="ui-block-b" id="Go_MediaBtn">'+
						'<div class="haeder_menu_div_on">'+
							'<span>사진/동영상</span>'+
						'</div>'+
					'</div>'+
					'<div class="ui-block-c" id="Go_PfsBtn">'+
						'<div class="haeder_menu_div_base">'+
							'<span>공연일정</span>'+
						'</div>'+
					'</div>'+
					'<div class="ui-block-d" id="Go_ReviewBtn">'+
						'<div class="haeder_menu_div_base">'+
							'<span>공연후기</span>'+
						'</div>'+
					'</div>';
	
	$('.header_menu_container').html(header_html);
	
	var middle_content = '<div class="tmi_middle_container">'+
						 '<div class="tmi_middle_title tmi_middel_select" id="tmi_picture">사진</div>'+
						 '<div class="tmi_middle_title" id="tmi_video">동영상</div>'+
						 '</div>';
						 
	$('#team_middle').html(middle_content);
	
	$('#tmi_picture').click();
	
	$('.pd_reply_div').hide();
});

$(document).on('click', '#tmi_picture', function(){
	$('.tmi_middle_title').removeClass('tmi_middel_select');
	$(this).addClass('tmi_middel_select');
	
	getTeamPicture(tno);
});

$(document).on('click', '#tmi_video', function(){
	$('.tmi_middle_title').removeClass('tmi_middel_select');
	$(this).addClass('tmi_middel_select');
	
	getTeamVideo(tno);
});

//
$(document).on('click', '.tmi_picture_img', function(){
	documentScroll = '0px';

	var imgSrc = $(this).attr('src');
	$('#team_img_popup').append('<img id="tip_picture_img"/>');
	$('#tip_picture_img').attr('src', imgSrc);
	
	//var popupPosition = $(this).attr('id');
	
	$('#tip_picture_img').css('position', 'fixed');
	$('#tip_picture_img').css('top', '50%');
	$('#tip_picture_img').css('left', '50%');
	$('#tip_picture_img').css('transform', 'translate(-50%, -50%)');

	
	$("#team_img_popup").show();
});

$(document).on('click', '#tip_picture_img', function(){
	$('#tip_picture_img').remove();
	$("#team_img_popup").hide();
});